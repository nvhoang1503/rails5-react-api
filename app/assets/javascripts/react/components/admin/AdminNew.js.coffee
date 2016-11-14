{ div, form, label, input, button, p} = React.DOM

namespace 'Appname.Admin', (exports) ->
  exports.AdminNew = React.createClass
    getInitialState: ->
      {
        admin: {
          email: '',
          password: '',
          password_confirmation: ''
        },
        form_messages: []
      }

    onSave: (e)->
      e.preventDefault()
      Appname.Admin.AdminNewActions.create(@state.admin)

    handleChange: (e)->
      name = e.target.name
      @state.admin = $.extend({}, @state.admin,  {"#{ name }": e.target.value} )
      @setState @state

    componentWillMount: ->
      Appname.Admin.AdminNewStore.listen(@onChange)
  
    componentWillUnmount: ->
      Appname.Admin.AdminNewStore.unlisten(@onChange)
  
    onChange: (state)->
      @setState(state)

    render: ->
      div className: 'admin-page-new',
        _.map @state.form_messages, (message) =>  
          FormMessageItem({key: message.id, content: message.content})
        form className: 'ui form',
          div className: 'field',
            label {}, "Email"
            input {type: "text", name: 'email', placeholder: "email", value: @state.admin.email, onChange: @handleChange}
          div className: 'field',
            label {}, "Password"
            input {type: "password", name: 'password', placeholder: "password", value: @state.admin.password, onChange: @handleChange}
          div className: 'field',
            label {}, "Password confirmation"
            input {type: "password", name: 'password_confirmation', placeholder: "password confirmation", value: @state.admin.password_confirmation, onChange: @handleChange}
          button className: 'ui button', onClick: @onSave, "Save"
