{ div, table, thead, tr, th, tbody, td, tfoot, a, i } = React.DOM

namespace 'Appname.Admin', (exports) ->
  exports.AdminIndex = React.createClass
    getInitialState: ->
      {
        admins: [],
        pageInfo: {},
        form_messages: []
      }
  
    componentWillMount: ->
      Appname.Admin.AdminIndexStore.listen(@onChange)
      Appname.Admin.AdminIndexActions.initData(@props)

      Appname.Admin.RouterStore.listen(@onUrlChange)
  
      page = Appname.Admin.RouterStore.getRouteData().query.page
      adminsService = new Appname.Admin.AdminsService
      adminsService.fetchAdmins(page)
  
    componentWillUnmount: ->
      Appname.Admin.AdminIndexStore.unlisten(@onChange)
      Appname.Admin.RouterStore.unlisten(@onUrlChange)
  
    onChange: (state)->
      @setState(state)
  
    onUrlChange: (state)->
      if state.routeData.pathname == "/admins"
        adminService = new Appname.Admin.AdminsService
        adminService.fetchAdmins(state.routeData.query.page || 1)
  
  
    onPageChanged: (data)->
      query = Appname.Admin.RouterStore.getRouteData().query
      pathname = Appname.Admin.RouterStore.getRouteData().pathname
      state = Appname.Admin.RouterStore.getRouteData().state
  
      Appname.Admin.RouterStore.getMainRouter().push({
        query: $.extend({}, query, {page: data.currentPage}),
        pathname: pathname,
        state: state
      })

    onNew: ->
      Appname.Admin.RouterStore.getMainRouter().push({
        pathname: 'admins/new'
      })
  
    render: ->
      div className: 'admin-page-index',
        div className: 'ui right aligned grid action-box',
          div className: 'sixteen wide column',
            div className: 'ui button action-box__new-btn', onClick: @onNew, 'New admin'
        _.map @state.form_messages, (message) =>  
          FormMessageItem({key: message.id, content: message.content})
        table className: 'ui celled table',
          thead {},
            tr {},
              th {}, 'Id'
              th {}, 'Email'
              th {}, 'Created at'
          tbody {},
            _.map @state.admins, (admin) =>  
              tr {key: admin.id},
                td {}, admin.id
                td {}, admin.email
                td {}, admin.created_at
          tfoot {},
            tr {},
              th colSpan: '3',
                Pager($.extend({}, @state.pageInfo, {onPageChanged: @onPageChanged}))
  
