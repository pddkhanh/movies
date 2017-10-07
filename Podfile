# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Movies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for Movies

  pod 'SwiftyJSON'
  pod 'CocoaLumberjack/Swift'
  pod 'Swinject'

  # ReactiveX
  pod 'RxSwift' 
  pod 'RxCocoa'  
  pod 'RxAlamofire'
  pod 'RxSwiftExt'
  pod 'RxDataSources'

  # UI
  pod 'NVActivityIndicatorView'
  pod 'Toaster'
  pod 'SDWebImage', '~> 4.0'
  
  target 'MoviesTests' do
    inherit! :search_paths
    # Pods for testing

    pod 'RxBlocking'
    pod 'RxTest'

    pod 'Quick'
    pod 'Nimble'
    pod 'Mockingjay'
  end

end
