module Responder
  extend ActiveSupport::Concern

  def respond_on_create(object)
    respond_to do |format|
      if object.save
        format.html { redirect_to object, notice: 'Created!' }
        format.json { render :show, status: :created, location: object }
      else
        format.html { render :new }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end

  def respond_on_update(object, params)
    respond_to do |format|
      if object.update(params)
        format.html { redirect_to object, notice: 'Updated!' }
        format.json { render :show, status: :ok, location: object }
      else
        format.html { render :edit }
        format.json { render json: object.errors, status: :unprocessable_entity }
      end
    end
  end

  def respond_on_destroy(url)
    respond_to do |format|
      format.html { redirect_to url, notice: 'Destroyed!' }
      format.json { head :no_content }
    end
  end
end
