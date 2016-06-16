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

    $.plot(div, Object.values(loop_data), {
            series: {
              lines: { show: true },
              points: { show: true }
            },
            xaxis: { mode: "time" },
            yaxis: {
              ticks: 10,
              tickDecimals: 0
            },
            grid: {
              backgroundColor: { colors: [ "#fff", "#eee" ] },
              borderWidth: {
                top: 1,
                right: 1,
                bottom: 2,
                left: 2
              }
            }
          })