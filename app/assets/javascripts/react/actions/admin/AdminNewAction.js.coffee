class AdminNewActions
  constructor: ->
    @generateActions(
      'initData',
      'updateFormMessage'
    )

  create: (admin)->
    adminsService = new Appname.Admin.AdminsService
    adminsService.createAdmin(admin)
    return admin

namespace 'Appname.Admin', (exports) ->
  exports.AdminNewActions = alt.createActions(AdminNewActions)
