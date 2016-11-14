class MenuStore
  @displayName: 'MenuStore'

  constructor: ->
    @bindActions(Appname.Admin.MenuActions)
    @user_session = {}

    @exportPublicMethods(
      {
        getUserSession: @getUserSession
      }
    )

  onInitData: (props)->
    @user_session = props.user_session


  getUserSession: ()->
    @getState().user_session

namespace 'Appname.Admin', (exports) ->
  exports.MenuStore = alt.createStore(MenuStore)
