module FakeGeo
  class << self

    def geo_deviation
      scale = 0.2
      r = rand(1000) / (1000.0 / scale)
      r -= scale / 2
      r
    end

    def set_stub
      Geocoder.configure(lookup: :test)
      Geocoder::Lookup::Test.set_default_stub(
        [
          {
            'latitude'     => Settings.mapview.default_latitude  + geo_deviation,
            'longitude'    => Settings.mapview.default_longitude + geo_deviation,
          }
        ]
      )
    end

  end
end

namespace :FosterFork do

  desc 'add fake users for testing'
  task add_fake_users: :environment do |_t, _args|
    ActiveRecord::Base.transaction do
      ApplicationMailer.delivery_method = :test

      100.times do
        FakeGeo::set_stub
        password = Faker::Internet.password

        u = User.create(name: Faker::Name.name,
                        email: Faker::Internet.email,
                        newsletter: Faker::Boolean.boolean,
                        phone: Faker::PhoneNumber.phone_number,
                        zip: Faker::Address.zip_code,
                        country: Settings.countries.shuffle.first,
                        password: password,
                        confirmed_at: Time.now,
                        terms: "1")
        puts "Created user: #{u.name} <#{u.email}>, password: #{password}"
      end
    end
  end

  desc 'add fake categories for testing'
  task add_fake_categories: :environment do |_t, _args|
    ActiveRecord::Base.transaction do
      names = 10.times.collect { Faker::Hacker.adjective }.sort.uniq

      names.each do |name|
        Category.create!(name: name,
                         color: "#" + Faker::Color.hex_color[1..6])
        puts "Created category: #{name}"
      end
    end
  end

  desc 'add fake projects for testing'
  task add_fake_projects: :environment do |_t, _args|

    ActiveRecord::Base.transaction do
      100.times do
        FakeGeo::set_stub

        p = Project.create!(owner: User.all.shuffle.first,
                            category: Category.all.shuffle.first,
                            recurrence: Project::RECURRENCE_TYPES.shuffle.first,
                            title: Faker::Lorem.sentence.chomp('.').truncate(80),
                            abstract: Faker::Hipster.paragraph(3),
                            description: Faker::Hipster.paragraph(100),
                            address: Faker::Address.street_address,
                            city: Faker::Address.city,
                            zip: Faker::Address.zip_code,
                            country: Settings.countries.shuffle.first,
                            date: Faker::Time.forward(100),
                            public: Faker::Boolean.boolean(0.8),
                            approved: Faker::Boolean.boolean(0.8),
                            active: Faker::Boolean.boolean(0.9))
        puts "Created project: #{p.title} owned by <#{p.owner.email}>"
      end
    end
  end

  desc 'add fake tags for testing'
  task add_fake_tags: :environment do |_t, _args|
    ActiveRecord::Base.transaction do
      names = 10.times.collect { Faker::Hacker.adjective }.sort.uniq

      names.each do |name|
        t = Tag.create!(name: name,
                    color: "#" + Faker::Color.hex_color[1..6])
        puts "Created tag: #{name}"

        10.times do
          t.projects << Project.all.shuffle.first
        end
      end
    end
  end

  desc 'add fake abuse_reports for testing'
  task add_fake_abuse_reports: :environment do |_t, _args|
    ActiveRecord::Base.transaction do
      before_count = AbuseReport.count

      100.times do
        c = AbuseReport.create!(project: Project.all.shuffle.first)
        if rand(10) > 5
          c.reporter = User.all.shuffle.first
        end

        if rand(10) > 5
          c.reason = Faker::Hacker.say_something_smart
        end

        c.save!
      end

      puts "Created #{AbuseReport.count - before_count} abuse reports"
    end
  end

  desc 'add fake participations for testing'
  task add_fake_participations: :environment do |_t, _args|
    ActiveRecord::Base.transaction do
      before_count = Participation.count

      500.times do
        Participation.where(project: Project.all.shuffle.first,
                            user: User.all.shuffle.first).first_or_create
      end

      puts "Created #{Participation.count - before_count} participations"
    end
  end

  desc 'add fake messages for testing'
  task add_fake_messages: :environment do |_t, _args|
    ApplicationMailer.delivery_method = :test

    ActiveRecord::Base.transaction do
      300.times do
        p = Project.all.shuffle.first
        m = Message.create!(project: p,
                            user: p.owner,
                            title: Faker::Lorem.sentence.chomp('.').truncate(60),
                            content: Faker::Hipster.paragraph(3))
        m.update_attribute(:updated_at, Faker::Time.backward(100))
      end

      puts "Created 300 new messages"
    end
  end

  desc 'add fake comments for testing'
  task add_fake_comments: :environment do |_t, _args|
    ApplicationMailer.delivery_method = :test

    ActiveRecord::Base.transaction do
      500.times do
        c = Comment.create!(message: Message.all.shuffle.first,
                            user: User.all.shuffle.first,
                            content: Faker::Hipster.paragraph(3))
        c.update_attribute(:updated_at, Faker::Time.backward(100))
      end

      puts "Created 500 new comments"
    end
  end

  desc 'add fake data for testing'
  task add_fake_data: [ :add_fake_users,
                        :add_fake_categories,
                        :add_fake_projects,
                        :add_fake_abuse_reports,
                        :add_fake_participations,
                        :add_fake_messages,
                        :add_fake_comments ]
end
