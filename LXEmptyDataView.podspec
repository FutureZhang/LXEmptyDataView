Pod::Spec.new do |s|
  s.name             = 'LXEmptyDataView'
  s.version          = '0.1.0'
  s.summary          = 'iOS UITableView、UICollectionView、UIView等出现空数据、加载失败......时的占位视图UI。'
  s.description      = 'iOS开发中，当UITableView、UICollectionView、UIView等出现空数据、加载失败时等等的占位视图UI界面。'
  s.homepage         = 'https://github.com/FutureZhang/LXEmptyDataView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FutureZhang' => '18337128698@163.com' }
  s.source           = { :git => 'https://github.com/FutureZhang/LXEmptyDataView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'LXEmptyDataView/Classes/**/*'
  s.frameworks = 'UIKit'
  # s.public_header_files = 'Pod/Classes/**/*.h'
end
