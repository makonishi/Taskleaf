class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "「#{@task.name}」を削除しました。"
  end

  def create
    # task_paramsで取得した値を引数として、インスタンスを作成する
    @task = current_user.tasks.new(task_params)

    if @task.save
      # showアクションを起動さ
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  private

  def task_params
    # ストロングパラメータを設定し、不正な情報を受け取らないようにする
    # paramsメソッドで、クライアント側から送られてきたパラメータを取得する
    # requireメソッドで、paramsで取得したパラメーターのオブジェクト名を指定する。
    # permitメソッドで、許可された値のみを取得する
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end
