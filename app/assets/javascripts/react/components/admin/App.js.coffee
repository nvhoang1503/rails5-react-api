{ div, a, i, span, label, input  } = React.DOM

Router = React.createFactory ReactRouter.Router
Route = React.createFactory ReactRouter.Route
IndexRoute = React.createFactory ReactRouter.IndexRoute
hashHistory = ReactRouter.hashHistory 


namespace 'Appname.Admin', (exports) ->
  exports.App = React.createClass
    render: ->
      Router {history: hashHistory},
        Route path: '/', component: ReactRouter.withRouter(Appname.Admin.Layout),
          IndexRoute component: Appname.Admin.Dashboard
          Route path: '/dashboard', component: Appname.Admin.Dashboard
          Route path: '/admins', component: ReactRouter.withRouter(Appname.Admin.AdminIndex)
          Route path: '/admins/new', component: Appname.Admin.AdminNew

