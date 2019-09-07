Pod::Spec.new do |s|
  s.name = "Constraint"
  s.version = "0.1.0"
  s.summary = "Small module for performing basic autolayout constraint operations in application code"
  s.description = "AutoLayout operations are almost always performed in the Interface Builder. However, sometimes it is necessary to perform some constraint operations in application code. This module alleviates the pain of using the NSLayoutConstraint APIs manually."
  s.homepage = "https://github.com/mtfourre/Constraint"
  s.license = { :type => "Unlicense", :file => "LICENSE" }
  s.author = { "Michael Fourre" => "mtfourre@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = '10.0'
  s.source = { :git => 'https://github.com/mtfourre/Constraint.git' }
  s.source_files = "*.swift"
end
