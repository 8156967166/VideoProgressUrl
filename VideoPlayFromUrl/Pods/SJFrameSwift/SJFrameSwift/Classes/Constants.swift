//
//  Constants.swift
//  Pods
//
//  Created by Arun SJ on 18/02/19.
//

import Foundation

struct ConstantString {
    static let k_EMPTY:String = "";
    static let k_EMPTY_SINGLE_SPACE:String = " ";
    static let k_VALID_EMAIL:String         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

extension String{
    public var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
    
    public var isValidEmail:Bool {
        let emailRegEx = ConstantString.k_VALID_EMAIL
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

open class SJFrame{
    
    // Loader
    open var loaderViewBackgroundColor:UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.15)
    
    open var loaderBackgroundColor:UIColor = UIColor.white
    open var loaderShadowColor:UIColor = UIColor.lightGray
    open var loaderStrokeColor:UIColor = UIColor.red//(rgb: 0x38B1FF)
    
    open var loaderSize:Int = 70
    open var loaderIconSize:Int = 40
    open var loaderStrokeOffset:Int = 0
    open var loaderStrokeWidth:Int = 1
    
    
    // TextView
    
    open var textFieldToolbarTextColor:UIColor?
    
    
    //
    
    open var isHaveRTL:Bool = false;
    
    public static let settings = SJFrame()
    
    init() {
        
    }
    
    public func setLoaderSize(size:Int){
        self.loaderSize = size;
    }
    
    public func setLoaderIconSize(size:Int){
        self.loaderIconSize = size;
    }
    
    public func setloaderStrokeOffset(Offset:Int){
        self.loaderStrokeOffset = Offset;
    }
    
    public func setloaderStrokeWidth(width:Int){
        self.loaderStrokeWidth = width;
    }
    
    public func setisHaveRTL(_ status:Bool){
        self.isHaveRTL = status
    }
    
    
}

import SystemConfiguration


open class CheckInternet{
    
    open class func Connection() -> Bool{
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
}


extension SJViewController {
    func setAwakeFromNib() {
        if SJFrame.settings.isHaveRTL{
            forceUpdateRTL()
        }
    }
    
    public func forceUpdateRTL() {
        guard let lang = SJLocalisedString.getSelectedLocale(),let code =  lang.languageCode else {
            return;
        }
        
        if code.lowercased() == "ar"{
            navigationController?.view.semanticContentAttribute = .forceRightToLeft
            navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
            
        }else{
            navigationController?.view.semanticContentAttribute = .forceLeftToRight
            navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
        }
    }
}


extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
