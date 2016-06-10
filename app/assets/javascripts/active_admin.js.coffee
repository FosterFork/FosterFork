#= require active_admin/base
#= require active_admin_pagedown/base
#= require active_admin_pagedown/default
#= require jquery.flot
#= require jquery.flot.time

jQuery ->
  $(".statistic-plot").each ->
    div = $(@)
    data = $(div).data("statistics")
    loop_data = {}

    for d in data
      do ->
        date = d['date']

        for k,v of d
          do ->
            if k != 'date'
              if !loop_data[k]
                loop_data[k] = { data: [] }

              loop_data[k]['data'].push([d['date'], v])

    console.log loop_data

    $.plot(div, Object.values(loop_data), {
  			xaxis: { mode: "time" }
  		})