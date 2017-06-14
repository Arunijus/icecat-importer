require 'rake'
require 'csv'

# LOCALES = ['en', 'lt', 'lv', 'et']

namespace :icecat_categories do # rake task
  task :import => :environment do # galima paduoti paramsus.
    csv_text = File.read(Rails.root + 'lib/docs/categories_en.txt')
    csv = CSV.parse(csv_text, :headers => true)
    progress_bar = ProgressBar.new(csv.length)
    csv.each do |row|
      row_hash = row.to_hash
      category_name = row_hash["category_name"]
      category_id = row_hash["category_id"]
      Category.create(:name => category_name,
                      :foreign_id => category_id,
                      :is_visible => 1,
                      :uuid => SecureRandom.uuid)
      progress_bar.increment
    end
    progress_bar = ProgressBar.new(csv.length)
    csv.each do |row|
      row_hash = row.to_hash
      parent_id = row_hash["parent_id"]
      category_id = row_hash["category_id"]
      @child = Category.find_by foreign_id: category_id
      @parent = Category.find_by foreign_id: parent_id
      @child.update_attribute(:parent_id, @parent.id)
      progress_bar.increment
    end


  end
end
