#= require active_admin/base
#= require active_admin_pagedown/base
#= require active_admin_pagedown/default
#= require jquery.flot

jQuery ->
  $.plot("#plot", $("#plot").data("projects"))