class LogosController < ApplicationController
  def index
    @images = LogoService.get_logos(params) if params.present?
  end
end
