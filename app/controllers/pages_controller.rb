class PagesController < ApplicationController
  before_action :set_page, only: %i[ edit update destroy ]
  http_basic_authenticate_with name: "admin", password: "notsecure", except: [:permalink]

  def index
    @pages = Page.all
  end

  def permalink
    @page = Page.find_by(permalink: params[:permalink])

    if @page.nil?
      flash[:alert] = "Page not found."
      redirect_to pages_path
    end
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to pages_permalink_path(@page.permalink), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy!

    respond_to do |format|
      format.html { redirect_to pages_path, status: :see_other, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :permalink)
  end
end
