class HealthcheckController < ActionController::Metal
  def show
    self.response_body = "OK"
  end
end
