{ div, a, i, span, label, input  } = React.DOM

namespace 'Appname.Admin', (exports) ->
  exports.Layout = React.createClass
    componentWillMount: ->
      Appname.Admin.RouterStore.listen(@onChange)
      Appname.Admin.RouterActions.initData(@props)
      Appname.Admin.RouterActions.updateRouteData({
        query: @props.location.query
        pathname: @props.location.pathname,
        state: @props.location.state
      })
  
      Appname.Admin.RouterActions.updateMainRouter(@props.router)
  
      @props.router.listen(@browserHistoryChanged)
  
    browserHistoryChanged: (ev)->
      Appname.Admin.RouterActions.updateRouteData({
        query: ev.query
        pathname: ev.pathname,
        state: ev.state
      })
  
    componentWillUnmount: ->
      Store.unlisten(@onChange)
      @props.router.unregisterTransitionHook(@browserHistoryChanged)
  
    onChange: (state)->
      # console.log('state changed')
      # console.log(state.routeData)
      @setState(state)
  
    render: ->
      div {},
        @props.children
