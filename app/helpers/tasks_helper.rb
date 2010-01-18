module TasksHelper
  def statement(task)
    <<-EOS
    'somebody' asked you to remind him about /"#{task.description}/"
    EOS
  end
end
