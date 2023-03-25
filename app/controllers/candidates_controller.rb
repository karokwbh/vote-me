class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
  end

  def show
    @candidate = Candidate.find_by(id: params[:id])
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      flash[:notice] = "Candidate created!"
      redirect_to '/candidates'
    else
      # 並不是執行上面的 def new
      # 而是借template new.html.erb 重新刷新
      # 剛好new.html.erb是使用@candidate 所以資料會保存
      render :new
    end
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end
end