//
//  SJLanguageManager.swift
//  LIST&SEEK
//
//  Created by Arun SJ on 04/10/18.
//  Copyright © 2018 Arun SJ. All rights reserved.
//

import Foundation


public let SJLocalisedString = SJLanguageManager();


public struct SJLocale {
    public var fileName:String?;
    public var countryName:String?;
    public var languageCode:String?;
    public var countryCode:String?;
    
    public init(_ _fileName:String, _countryName:String, _languageCode:String, _countryCode:String) {
        fileName        = _fileName;
        countryName     = _countryCode;
        languageCode    = _languageCode;
        countryCode     = _countryCode;
    }
}

open class SJLanguageManager{
    
    var K_DEFAULTS_KEY_SETLANGUAGE_ONCE = "Set.Language.Once";
    var K_DEFAULTS_KEY_LANGUAGE_CODE = "LanguageCode";
    var K_DEFAULTS_KEY_LANGUAGE_FILE_NAME_WITH_CODE = "Language.file.Name.And.Code";
    
    var availableLocales:[SJLocale] = [SJLocale]();
    
    public subscript(key:String)-> String{
        get{
            return getTranslation(key);
        }
    }
    
    public func addLocalisedLanguage(local:SJLocale) -> Void {
        availableLocales.append(local);
    }
    
    public func isLanguageSetOnce() -> Bool {
        return (UserDefaults.standard.bool(forKey: K_DEFAULTS_KEY_SETLANGUAGE_ONCE)) ? true : false;
    }
    
    public func setLanguageLoadedOnce() -> Void {
        UserDefaults.standard.set(true, forKey: K_DEFAULTS_KEY_SETLANGUAGE_ONCE);
        UserDefaults.standard.synchronize();
    }
    
    public func reSetLanguageLoadedOnce() -> Void {
        UserDefaults.standard.set(false, forKey: K_DEFAULTS_KEY_SETLANGUAGE_ONCE);
        UserDefaults.standard.synchronize();
    }
    
    public func setLanguage(local:SJLocale) -> Void {
        UserDefaults.standard.set(local.languageCode, forKey: K_DEFAULTS_KEY_LANGUAGE_CODE);
        
        UserDefaults.standard.set(local.fileName, forKey: K_DEFAULTS_KEY_LANGUAGE_FILE_NAME_WITH_CODE);
        UserDefaults.standard.synchronize();
    }
    
    public func setLanguage(code:String) -> Void {
        UserDefaults.standard.set(code, forKey: K_DEFAULTS_KEY_LANGUAGE_CODE);
        UserDefaults.standard.synchronize();
    }
    
    /*
     
     
     -(void)setDefaultLanguage{
     if(SYSTEM_VERSION_GREATER_THAN(@"14.3")) {
     return;
     }
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     //    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
     
     /*
     * Check the user defaults to find whether a localisation has been set before.
     * If it hasn't been set, (i.e. first run of the app), select the locale based
     * on the device locale setting.
     */
     
     // Check whether the language code has already been set.
     if ((![userDefaults stringForKey:DEFAULTS_KEY_LANGUAGE_CODE]) && (![self isLanguageSetOnce])) {
     
     NSLog(@"No language set - trying to find the right setting for the device locale.");
     
     NSLocale *currentLocale = [NSLocale currentLocale];
     
     // Iterate through available localisations to find the matching one for the device locale.
     for (Locale *localisation in self.availableLocales) {
     
     if ([localisation.languageCode caseInsensitiveCompare:[currentLocale objectForKey:NSLocaleLanguageCode]] == NSOrderedSame) {
     
     [self setLanguageWithLocale:localisation];
     break;
     }
     }
     
     // If the device locale doesn't match any of the available ones, just pick the first one.
     if ((![userDefaults stringForKey:DEFAULTS_KEY_LANGUAGE_CODE]) && (![self isLanguageSetOnce])) {
     
     NSLog(@"Couldn't find the right localisation - using default.");
     [self setLanguageWithLocale:self.availableLocales[0]];
     }
     }
     else {
     
     NSLog(@"The language has already been set :)");
     }
     }
     */
    
    public func setDefaultLanguage() -> Void {
        let userDefault = UserDefaults.standard;
        
        if userDefault.string(forKey: K_DEFAULTS_KEY_LANGUAGE_CODE) == nil && !isLanguageSetOnce(){
            
            let currentLocale:NSLocale = NSLocale.current as NSLocale;
            
            let LocaleLanguageCode:String = (currentLocale.languageCode);
            for localisation in availableLocales{
                if(localisation.languageCode == LocaleLanguageCode){
                    setLanguage(local: localisation);
                    break;
                }
            }
            
            if userDefault.string(forKey: K_DEFAULTS_KEY_LANGUAGE_CODE) == nil && !isLanguageSetOnce(){
                if(availableLocales.count>0){
                    setLanguage(local: availableLocales[0]);
                }
            }
        }else{
            //print("The language has already been set :)");
        }
    }
    
    public func getSelectedLocale() -> SJLocale? {
        var selectedLocale:SJLocale? = nil;
        
        guard var languageCode:String = UserDefaults.standard.string(forKey: K_DEFAULTS_KEY_LANGUAGE_CODE)else {
            return nil;
        }
        
        languageCode = languageCode.lowercased();
        
        for local in availableLocales {
            if(local.languageCode?.lowercased() == languageCode){
                selectedLocale = local;
                break;
            }
        }
        
        return selectedLocale;
    }
    
    open func getTranslation(_ key:String!) -> String {
        let languageName:String = UserDefaults.standard.string(forKey: K_DEFAULTS_KEY_LANGUAGE_FILE_NAME_WITH_CODE) ?? "English(EN)";
        //"English(EN)"//"Arabic(AR)";
        
        guard let bundlePath:String = Bundle.main.path(forResource: "Base", ofType: "lproj")else{
            return ConstantString.k_EMPTY;
        };
        
        guard let languageBundle:Bundle = Bundle(path: bundlePath) else{
            return ConstantString.k_EMPTY;
        }
        
        var translatedString:String = languageBundle.localizedString(forKey: key, value: ConstantString.k_EMPTY, table: languageName)
        
        if(translatedString == key){
            translatedString = languageBundle.localizedString(forKey: key, value: ConstantString.k_EMPTY, table: availableLocales[0].fileName);
        }
        
        if(translatedString.count < 1){
            
            translatedString = NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: key, comment: key);
        }
        return translatedString;
    }
    
    /*
     NSString* getLanguageBasedCellIdentifier(NSString* strIdentifier){
     
     BOOL status = NO;
     Locale * objLocalLanguage = [[SJLanguageManager sharedLanguageManager] getSelectedLocale];
     if([objLocalLanguage.languageCode caseInsensitiveCompare:@"ar"] == NSOrderedSame){
     status = TRUE;
     }
     
     if(!status)
     return [NSString stringWithFormat:@"%@",strIdentifier];
     else
     return [NSString stringWithFormat:@"%@-ar",strIdentifier];
     }
     
     */
    
    public func CellIdentifier(_ strIdentifier:String) -> String {
        var status = false;
        guard let objLocalLanguage:SJLocale = getSelectedLocale()else{
            return strIdentifier;
        }
        if(objLocalLanguage.languageCode?.lowercased() == "ar"){
            status = true;
        }
        
        if(!status){
            return strIdentifier;
        }else{
            return strIdentifier+"-ar";
        }
    }
}
