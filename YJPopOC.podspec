
Pod::Spec.new do |spec|

  spec.name         = "YJPopOC"
  spec.version      = "0.0.1"
  spec.summary      = "基础弹出功能"

  spec.description  = "开发中常用的弹出"

  spec.homepage     = "https://github.com/fyaojie"

  # s.license      = "MIT"
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  

  spec.author       = { "odreamboy" => "562925462@qq.com" }

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/fyaojie/YJPop.git", :tag => spec.version }

  spec.source_files  = "YJPopOC/**/*.{h,m}"
  spec.public_header_files = 'YJPopOC/**/*.{h}'

#  spec.resource_bundles = {
#    'YJPopOC' => ['YJPopOC/Assets/*.png']
#  }
  spec.resource = 'YJPopOC/YJPopOC.bundle'
  
end
