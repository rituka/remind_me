class TasksController < ApplicationController
  
  def index
    @tasks = Task.find :all
  end
  
  def show
    
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(params[:task])
    if @task.save
      flash[:message] = "Added the reminder successfully."
      redirect_to tasks_path()
    else
      flash.now[:message] = "Uhh...The task can not be set. Check all the details again."
      render :action => :new
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
end
