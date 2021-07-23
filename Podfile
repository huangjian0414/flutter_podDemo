# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


flutter_application_path = '../flutter_pod/flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

#true使用flutter项目导入，false使用framework导入
$debug_flutter_enabled = true

target 'flutter_podDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
   
   if $debug_flutter_enabled
     install_all_flutter_pods(flutter_application_path)
   else
     pod 'flutter_pod', :path => '../flutter_pod'
#     pod 'flutter_pod',:git =>'https://github.com/huangjian0414/flutter_pod',:tag => '1.0.0'
   end
  
end
