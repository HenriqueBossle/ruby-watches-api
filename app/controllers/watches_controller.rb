
class WatchesController < ApplicationController
  before_action :set_watch, only: %i[show update destroy]

  # GET /watches
  def index
    @watches = Watch.all

    render json: @watches
  end

  # GET /watches/1
  def show
    render json: @watch
  end

  # POST /watches
  def create
    @watch = Watch.new(watch_params)

    if params[:image].present?
      result = Cloudinary::Uploader.upload(
        params[:image],
        folder: "ruby-watches"
      )

      @watch.image_url = result["secure_url"]
    end

    if @watch.save
      render json: @watch, status: :created, location: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watches/1
  def update
    if params[:image].present?
      result = Cloudinary::Uploader.upload(
        params[:image],
        folder: "ruby-watches"
      )

      @watch.image_url = result["secure_url"]
    end

    if @watch.update(watch_params)
      render json: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # DELETE /watches/1
  def destroy
    @watch.destroy!
  end

  private

  def set_watch
    @watch = Watch.find(params.expect(:id))
  end

  def watch_params
    params.expect(watch: [:brand, :model, :price])
  end
end
