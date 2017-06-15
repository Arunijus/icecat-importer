require 'rake'
require 'csv'

# LOCALES = ['en', 'lt', 'lv', 'et']

namespace :icecat_categories_closure do # rake task
  task :import => :environment do # galima paduoti paramsus.
    csv_text = File.read(Rails.root + 'lib/docs/closure_en.txt')
    csv = CSV.parse(csv_text, :headers => true)
    progress_bar = ProgressBar.new(csv.length)
    csv.each do |row|
      row_hash = row.to_hash
      ancestor = row_hash["ancestor"]
      descendant = row_hash["descendant"]
      depth = row_hash["depth"]
      CategoryClosure.create(:depth => depth,
                      :ancestor => ancestor,
                      :descendant => descendant)
      progress_bar.increment
    end
  end
end
