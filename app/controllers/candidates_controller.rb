class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]

  def index
    @candidates = Candidate.all
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to '/candidates', notice: 'Candidate created!'
    else
      # 並不是執行上面的 def new
      # 而是借template new.html.erb 重新刷新
      # 剛好new.html.erb是使用@candidate 所以資料會保存
      render :new
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to '/candidates', notice: 'Candidate updated!'
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to '/candidates', notice: 'Candidate deleted!'
  end

  def vote
    # VoteLog.create(candidate: @candidate, ip_address: request.remote_ip)
    @candidate.vote_logs.create(ip_address: request.remote_ip)
    redirect_to '/candidates', notice: 'Voted!'
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end

  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
end