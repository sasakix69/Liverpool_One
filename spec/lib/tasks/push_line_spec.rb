require 'rake_helper'

describe 'push_line:push_line_message' do
  subject(:task) { Rake.application['push_line:push_line_message'] }

  it '試合時間10分前にラインメッセージが送信されること' do
    expect { task.invoke }.not_to raise_error
  end
end
