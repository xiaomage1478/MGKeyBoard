

Pod::Spec.new do |s|

  s.name         = "MGKeyBoard"
  s.version      = "1.0.1"
  s.summary      = "This is a custom keyboard."
  s.homepage     = "https://github.com/xiaomage1478/MGKeyBoard"
  s.license      = "MIT"
  s.author       = { "xiaomage" => "martin1478@163.com" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/xiaomage1478/MGKeyBoard.git", :tag => "#{s.version}" }

  s.source_files = "MGKeyBoard/MGKeyBoard/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"
  s.resources = "MGKeyBoard/MGKeyBoard/resource/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  s.requires_arc = true

end
