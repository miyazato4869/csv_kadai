class CsvController < ApplicationController
  def index
    upload_file = params[:upload_file]
  end
  
  def create
    if params[:upload_file].present?
      upload_file = params[:upload_file].tempfile

      # ファイルの内容によってはEncodingErrorが出ますので適宜調整してください
      CSV.foreach(upload_file.path, headers: true, encoding: 'cp932') do |row|

        # recruiting_idがあった場合はレコードを呼び出す、ない場合は新しく作成
        recruiting = Recruiting.find_by(recruiting_id: row["求人ID"]) || Recruiting.new
        recruiting.attributes = convert_csv_to_hash(row)
        recruiting.save
      end
      redirect_to root_path
    end
  end

  private

  # csvの欲しいデータがある列とDBのカラムを指定してデータを入れます。
  def convert_csv_to_hash(row)
    params = {
      recruiting_id: row['求人ID'],
      title: row['求人名(募集職種)'],
      salary: row['給与'],
      office_hours: row['勤務時間'],
      skills: row['必須スキル'],
      place: row['勤務地']
    }
    return params
  end
end