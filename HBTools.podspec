#
#  Be sure to run `pod spec lint HBTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "HBTools"
  s.version      = "1.2.0"
  s.summary      = "整合的一些自己用的工具类集合  v1.2.0  更新时间:2019年01月06日"

  s.description  = <<-DESC
              完成 自定义列表分栏 HBSegment
                   DESC

  s.homepage     = "https://github.com/hengbin/HBTools"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = { :type => 'MIT', :file =>     'LICENSE' }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "hengbin" => "Dchaoliu@163.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios
  s.platform     = :ios, "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/hengbin/HBTools.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "HBTools/HBTools/**/*.{h,m}"
  # s.public_header_files = 'HBTools/HBTools/HBTools.h'

  # s.Resources = "HBTools/source/*.png"
  s.resource_bundles = {
    'ImageLibrary' =>  'HBTools/source/'
  }

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.frameworks = 'UIKit','CoreFoundation','QuartzCore','CoreGraphics','CoreImage','CoreText','ImageIO','Accelerate'

  s.dependency "SDAutoLayout", "~> 2.2.1"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #



  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true

end
