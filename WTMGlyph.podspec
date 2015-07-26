Pod::Spec.new do |s|
  s.name     = 'WTMGlyph'
  s.version  = '0.1'
  s.summary  = 'This is an iOS implementation of the N Dollar Gesture Recognizer.'
  s.homepage = 'https://github.com/britg/MultistrokeGestureRecognizer-iOS'
  s.author   = { 'Brit Gardner' => 'brit@britg.com' }
  s.license  = { :type => 'MIT', :file => 'LICENSE' }

  s.platform = :ios
  s.source   = { :git => 'https://github.com/britg/MultistrokeGestureRecognizer-iOS.git', :tag => "v#{s.version}" }

  s.source_files = 'WTMGlyph/*.{h,m}', 'WTMGlyph/Experimental/*.{h,m}', 'WTMGlyph/Extensions/*.{h,m}', 'WTMGlyph/JSON/*.{h,m}'
  s.prefix_header_file = 'WTMGlyph/WTMGlyph-Prefix.pch'
  s.requires_arc = true
end