module API
  module V1
    class SessionsApi < API::V1::BaseApi

      resource :sessions do
        helpers do
          def my_permitted_keys
            [:app_key]
          end
        end

        # Create new device session api
        desc 'Create new session'
        params do 
          # requires :secure_auth_key, type: String, desc: "Security authentication key"
          optional :device_type, type: String, desc: "Device Type"
          optional :device_id, type: String, desc: "Device Id"
          optional :device_name, type: String, desc: "Device Name"
          optional :device_token, type: String, desc: "Device Token"
        end
        post "create" do 
          headers['Device-Type']  = headers['Device-Type']  ||= params[:device_type]
          headers['Device-Id']    = headers['Device-Id']    ||= params[:device_id]
          headers['Device-Name']  = headers['Device-Name']  ||= params[:device_name]
          headers['Device-Token'] = headers['Device-Token'] ||= params[:device_token]
          checking = DeviceInfoService.device_checking(headers)
          if checking[:status] == true
            device_info = DeviceInfoService.create_new_session(headers)
            API::Entities::V1::DeviceInfoEntity.represent(device_info, device_info: {basic: true}).merge(status: 200, message: "The device is playing")
          else
            API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 404, message: "Permission deny", errors: checking[:errors])
          end 
        end

        # Reset new authentication token api
        desc 'Delete session'
        params do 
          requires :authentication_token, type: String, desc: "Authentication Token"
        end
        delete "reset" do 
          device_info_authenticate!
          current_device_info.reset_session
          API::Entities::V1::DeviceInfoEntity.represent(nil).merge(status: 200, message: "The device has been played off")
        end
      end
    end
  end
end