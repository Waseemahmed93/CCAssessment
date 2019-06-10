



import UIKit

class Utility: NSObject {

    class func getDestinationPath(_ name: String, format:NSString = ".pdf") -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentsPath+"/"+name+(format as String)
        return path
    }


    
    
    class func getVehicleYearList()->Array<String>
    {
        
        var yearList = [String]()
        let date = Date()
        let calendar = Calendar.current
        
        var currentyear = calendar.component(.year, from: date)
        currentyear = currentyear + 1
        /* current year to 30 year back */
        let year = currentyear - 30
        while currentyear  > year {
            
            currentyear = currentyear - 1
            
            yearList.append(String(currentyear))
            
        }
        
        return yearList
        
    }
    
    class func getlicenceTypeOfuser() -> Array<Any>
    {
        return ["Class A","Class B","Class C"]
    }
    
    class func showAlertwithOkButton(message: String, controller: AnyObject){
        
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
        }
        
        alertController.addAction(action1)
        
        controller.present(alertController, animated: true, completion: nil)
        
    }
    
    
    class func getTimeFromNSDate(unixTime: Double) -> String? {
        
        //let date : Date? = Date.init(timeIntervalSinceNow: unixTime)
        let date : NSDate? = NSDate(timeIntervalSince1970: unixTime/1000)
        
        let formatter = DateFormatter()
        if self.isDateDifferenceOneDay((date! as Date), end: Date()) {
            formatter.dateFormat = "dd/MM/YY"
        } else {
            formatter.dateFormat = "hh:mm a"
        }
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: NSTimeZone.local.secondsFromGMT()) as TimeZone
        var strDate: String? = nil
        if let aDate = date {
            strDate = formatter.string(from: aDate as Date)
        }
        return strDate
    }
    
    class func isDateDifferenceOneDay(_ startDate: Date?, end endDate: Date?) -> Bool {
        var components: DateComponents?
        var days: Int
       // var hour: Int
       // var minutes: Int
        if let aDate = startDate, let aDate1 = endDate {
            //components = Calendar.current.components([.day, .hour, .minute], from: aDate, to: aDate1, options: [])
            components = Calendar.current.dateComponents([.day, .hour, .minute], from: aDate, to: aDate1)
        }
        days = components?.day ?? 0
        //hour = components?.hour ?? 0
       // minutes = components?.minute ?? 0
        if days > 0 {
            return true
        }
        return false
    }
    class func getTimeStringFromUnixTime(unixTime: Double) -> Date {
        let date = Date.init(timeIntervalSinceNow: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "dd/MM/YYYY hh:mm a"
        dateFormatter.timeZone = NSTimeZone() as TimeZone?
        let localDateStr = dateFormatter.string(from: date)
        let localDate = dateFormatter.date(from: localDateStr)
        return localDate!
    }
    class func getDateInString(_ date : Date, format : String)->String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
    
    class func getTimeInString(_ date : Date)->String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "hh:mm a"
        
        return formatter.string(from: date)
    }
    
    
    class func getTodayTimeInString(_ date : Date)->String{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "hh:mm a"
        
        return "Today " + formatter.string(from: date)
    }
    
    class func getTimeStamp(from date: Date?) -> NSNumber? {
        let milliseconds = Int64((date?.timeIntervalSince1970)! * 1000.0)
        let timeStampObj = Int(milliseconds)
        return timeStampObj as NSNumber
    }

    class func getDateTimeInFormat(_ date : Date, format : String)->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    class func showAlert(_ title: String, message: String, controller : UIViewController ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func getEventIntresetActivity()->[String]{
        
        var eventActivity : [String]!
        eventActivity = ["Active(Fitness,Hiking,Running)","Interests(Painting,Programming)","Entertainment(concerts,movie,game)","Social(bar-b-ques)","Recreational Sports(pick-up games & sports)"]
        
        return eventActivity
    }
    
    class func isNewVersionSupported()->Bool{
        var flag = false
        if #available(iOS 11, *) {
            flag = true
        } else {
            flag = false
        }
        return flag
    }
    
    class func formatPhoneNumber(textField: UITextField,range: NSRange, string: String) -> Bool{
        let phoneNumberFormatChars = ["(",")"," ","-"]
        var phoneNumber : String = (textField.text! as NSString).replacingCharacters(in: range, with: string) as String
        var phoneNumberArray = Array(phoneNumber.characters)
        for char in phoneNumberFormatChars {
            phoneNumberArray = phoneNumberArray.filter { String($0) != char }
        }
        if phoneNumberArray.count == 10 {
            phoneNumber = "(" + phoneNumberArray[0..<3].map { String($0) }.joined() + ") "
            phoneNumber += phoneNumberArray[3..<6].map { String($0) }.joined() + "-"
            phoneNumber += phoneNumberArray[6..<10].map { String($0) }.joined()
        }else{
            phoneNumber = phoneNumberArray.map { String($0) }.joined()
        }
        textField.text = phoneNumber
        return false
    }
    
    class func getMapStaticImageFromCoordinates(lat:String,long:String) -> String
    {
        var staticMapUrl: String = "http://maps.google.com/maps/api/staticmap?markers=color:blue|\(lat),\(long)&\("zoom=13&size=\(2 * Int(235.0))*\(2 * Int(57))")&sensor=true"
        let Width = 235.0
        let Height = 150.0
        
        let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
        let latlong = lat + ", " + long
        
        let mapUrl  = mapImageUrl + latlong
        
        let size = "&size=" +  "\(Int(Width))" + "x" +  "\(Int(Height))"
        let positionOnMap = "&markers=size:mid|color:red|" + latlong
        let staticImageUrl = mapUrl + size + positionOnMap
        
        if let staticMapURL : String = (staticImageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ){
            return staticMapURL
        }
        return ""
    }
    
    class func getImage(imageName: String) -> UIImage{
        if let image = UIImage(named: imageName) {
            return image
        }  else {
            return UIImage()
        }
    }
    
    
    class func setUserType(type:String){
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.setValue(type, forKey: "userState")
        userDefaults.synchronize()
    }
    
    
    class func saveDeviceToken(_ token: String) {
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "device_token") != nil {
            userDefaults.removeObject(forKey: "device_token")
        }
        userDefaults.set(token, forKey: "device_token")
        userDefaults.synchronize()
    }
    
    
    class func goToApplicationSettings(){
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
    
    class func createSingleChatGroupName(_ currentUserID: String?, recipientUserID: String?) -> String? {
        let userID = currentUserID?.replacingOccurrences(of: "u", with: "")
        let rUserID = recipientUserID?.replacingOccurrences(of: "u", with: "")
        let sorted = ([userID!, rUserID!] as NSArray).sortedArray(comparator: { string1, string2 in
            return ((string1 as? String)?.compare((string2 as? String) ?? "", options: .numeric, range: nil, locale: .current))!
        })
        //    NSArray *sorted = [@[userID,rUserID] sortedArrayUsingSelector:@selector(compare:) ];
        var uID: String? = nil
        if let anObject = sorted.first {
            uID = "u\(anObject)"
        }
        var rID: String? = nil
        if let anObject = sorted.last {
            rID = "u\(anObject)"
        }
        return "\(uID ?? "")_\(rID ?? "")"
    }
    

    
    class func getDeviceToken() -> String {
        
        if let token = UserDefaults.standard.value(forKey: "device_token") {
            return token as! String
        }
        return "2786892729asdasdasdsdadasda"
    }
    
    class func getDeviceType() -> String {
        return "ios"
    }
    
    class func getCurrentTimeStampValue() -> String {
        
        let date = NSDate()
        
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "MM-dd-yyyy hh:mm a"
        let strTime: String = objDateformat.string(from: date as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        
        
        return strTimeStamp
    }
    
    
    class func getStateIDFromStateName(plistfileName:String,stateName:String) -> String
{
    //var stateID = Int()
    if let path = Bundle.main.path(forResource: plistfileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            let stateArray = jsonResult as! [[String:Any]]
            
            print("jsonResult: ",jsonResult)
            for stateInfoDic:[String:Any] in stateArray
            {
                if stateInfoDic["name"] as! String == stateName
                {
                    return String(stateInfoDic["id"] as! Int)
                }
            }

        } catch {
            // handle error
        }
    }
    return ""
}
    class func getJsonFile(fileName:String) -> Array<Any>{
        
        var jsonArray = Array<Any>()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                jsonArray = jsonResult as! Array<Any>
                print("jsonResult: ",jsonResult)
//                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//                    // do stuff
//                }
            } catch {
                // handle error
            }
        }
        return jsonArray
}

    
    class func getCityJsonFile(stateId:String,fileName:String) -> Array<Any>{
        
        
        var jsonArray = Array<Any>()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //jsonArray = jsonResult as! Array<Any>
               // as! Dictionary<String,Any>
               
                for object:Dictionary<String,Any> in jsonResult as! Array<[String:Any]>
                {
                   
                    if stateId == String(object["state_id"] as! Int)
                    {
                        jsonArray.append(object)
                    }
                }
                
               
          
                //                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                //                    // do stuff
                //                }
            } catch {
                // handle error
            }
        }
        return jsonArray
    }
    
    
    class func dateFormaterChangedToDay(dateString:String) -> String
    {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM-dd-yyyy"
        let date: NSDate? = dateFormatterGet.date(from: dateString) as NSDate?
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE"
        
        var formatedDateString : String = ""
        
        if (date != nil){
            formatedDateString = dateFormatterPrint.string(from: date! as Date)
        }
        return formatedDateString
    }
    
    class func dateFormater(clientFormat: String, serverFormat:String, dateString:String)->String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = serverFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = clientFormat
        
        let date: NSDate? = dateFormatterGet.date(from: dateString) as NSDate?
        
        var formatedDateString : String = ""
        
        if (date != nil){
            formatedDateString = dateFormatterPrint.string(from: date! as Date)
        }
        return formatedDateString
    }
    
    class func getTimeStampDate(byDate:Date)->(String) {
        var dateString = ""
        let currentDate = Date()
        let diffMinutes = currentDate.timeIntervalSince(byDate)/60
        let diffHours = diffMinutes/60
        if diffHours >= 24  {
            // dateString = getDateInString(byDate, format: "dd, MMMM yyyy HH:mm:a")
            dateString = genratrTimeStringForEndRide(dateTime: byDate)
           // dateString = getDateInString(byDate, format: "MMM d, yyyy HH:mm")
            
        }
        else{
            dateString = getTimeInString(byDate)
        }
        
        return dateString
    }
    
    
    class func getTimeFromStringAndConvertToDate(dateTime:String)-> (Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        //  dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let date = dateFormatter.date(from: dateTime)
        print("date",date as Any)
        return date!
    }
    
    
    class func genratrDateTimeForEndRide(dateTime:String)-> (Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let date = dateFormatter.date(from: dateTime)
        let string = dateFormatter.string(from: date!)
        print("date",string as Any)
        return date!
    }
    
    class func genratrTimeStringForEndRide(dateTime:Date)-> (String)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a "
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let string = dateFormatter.string(from: dateTime)
        
        return string
    }
    
    
    class func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "MM-dd-yyyy hh:mm a"
        //  objDateformat.timeZone = (NSTimeZone(abbreviation: "UTC") as! TimeZone)
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        
        return strTimeStamp
    }
    
    
    class func changeTimestamptoDate(timeStampvalue:Double)-> String
    {
        let date = Date(timeIntervalSince1970: timeStampvalue)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        //print("strdate",strDate)
        return strDate
    }
    
    
    class func getTimeStampsForAds(byDate:Double)->(String){
        var dateString = ""
        let date = Date(timeIntervalSince1970: byDate)
        let currentDate = Date()
        let diffMinutes = currentDate.timeIntervalSince(date)/60
        let diffHours = diffMinutes/60
    
            
            dateString = getDateInString(date, format: "EEEE")
            
    
        
        return dateString
    }
    
    class func getTimeStamps(byDate:Double)->(String){
        var dateString = ""
        let date = Date(timeIntervalSince1970: byDate)
        let currentDate = Date()
        let diffMinutes = currentDate.timeIntervalSince(date)/60
        let diffHours = diffMinutes/60
        
        
        if diffHours >= 24 && diffHours <= 48 {
            
            
            dateString = "Yesterday / " +  getDateInString(date, format: "hh:mm a")
            
        }
        else if diffHours >= 48  {
            
            
            dateString = getDateInString(date, format: "MM-dd-yyyy hh:mm a")
            
        }
        else{
            dateString = getTodayTimeInString(date)
        }
        
        return dateString
    }
    
    class func dayDifferenceFromDate(timestamp : Double) -> String
    {
        var dateString = ""
        let calendar = NSCalendar.current
        let date = NSDate(timeIntervalSince1970: timestamp)
        if calendar.isDateInYesterday(date as Date) { return "Yesterday / " +  getDateInString(date as Date, format: "hh:mm a") }
        else if calendar.isDateInToday(date as Date) { return  getTimeInString(date as Date) }
        else if calendar.isDateInTomorrow(date as Date) { return "Tomorrow / " +  getDateInString(date as Date, format: "hh:mm a") }
        else {
            
            dateString = getDateInString(date as Date, format: "MM-dd-yyyy hh:mm a")
            return dateString
        }
    }
    
    class func getTimpeStampForupComingRide(byDate:Double)->(String){
        
        var dateString = ""
        let date = Date(timeIntervalSince1970: byDate)
        let currentDate = Date()
        let diffMinutes = currentDate.timeIntervalSince(date)/60
        let diffHours = diffMinutes/60
        print("diffHours:",diffHours)
        // if diffHours >= 24 && diffHours <= 0  {
        
        
        dateString = getDateInString(date, format: "MM-dd-yyyy hh:mm a")
        
        //        }
        //
        //        else{
        //            dateString = getTimeInString(date)
        //        }
        
        return dateString
        
    }
    
    
    class func timestampToDifferenceInWaitingTime(byDate:Double)->(Bool){
        
        let date = Date(timeIntervalSince1970: byDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss" //Specify your format that you want
        
        let now = Date()
        
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: date, to: now)
        var isgreaterThen = Bool()
        if differenceOfDate.minute! > 4
        {
            isgreaterThen = true
        }
        else
        {
            isgreaterThen = false
        }
        return isgreaterThen
    }
    
    
    
    class func timestampToWaitingTime(byDate:Double)->(String){
        
        let date = Date(timeIntervalSince1970: byDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss" //Specify your format that you want
        
        let now = Date()
        
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: date, to: now)
        
        var waitingTime:String = ""
        var hour:String = ""
        var mintus:String = ""
        var second:String = ""
        
        if differenceOfDate.hour ?? 0 > 9 {
            hour = String(differenceOfDate.hour as! Int)
        }
        else
        {
            hour = "0" + String(differenceOfDate.hour as! Int)
        }
        
        if differenceOfDate.minute ?? 0 > 9 {
            mintus = String(differenceOfDate.minute as! Int)
        }
        else
        {
            mintus = "0" + String(differenceOfDate.minute as! Int)
        }
        
        if differenceOfDate.second ?? 0 > 9 {
            second = String(differenceOfDate.second as! Int)
        }
        else
        {
            second = "0" + String(differenceOfDate.second as! Int)
        }
        
        
        
        if differenceOfDate.hour ?? 0 > 0 {
            waitingTime = hour +  ":" + mintus + ":" + second
        }
        else
        {
            waitingTime = mintus + ":" + second
        }
        return waitingTime
        
    }
    
    
//    class func getCurrentTimeStampValue() -> String {
//
//        let date = NSDate()
//
//        let objDateformat: DateFormatter = DateFormatter()
//        objDateformat.dateFormat = "MM-dd-yyyy hh:mm a"
//        let strTime: String = objDateformat.string(from: date as Date)
//        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
//        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
//        let strTimeStamp: String = "\(milliseconds)"
//
//
//        return strTimeStamp
//    }

    
   class func usStandardPhoneformat(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
            //($1) $2
            
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
            //($1) $2-$3
        }
        
        return number
    }

}
