OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '558350127520029', '04e8b4a6bff19a3d479dc47ffdfa31a8',{:client_options => {:ssl => {:verify => false}}}
end