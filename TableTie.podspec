Pod::Spec.new do |s|
  s.name             = "TableTie"
  s.version          = "1.0.5"
  s.summary          = "A simple, generic way to populate a UITableView with data."
  s.description      = <<-DESC
                        TableTie provides generic implementations for UITableViewDelegate and UITableViewDataSource, which greatly simplifies the code for UITableView setup.
                        DESC
  s.homepage         = "https://github.com/vladimirkofman/TableTie"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Vladimir Kofman" => "vladimir@kofman.com" }
  s.social_media_url = "http://twitter.com/VladimirK"
  s.source           = { :git => "https://github.com/vladimirkofman/TableTie.git", :tag => "v1.0.5" }
  s.ios.deployment_target     = '9.0'
  s.requires_arc = true
  s.source_files     = 'TableTie/**/*.swift'
end
