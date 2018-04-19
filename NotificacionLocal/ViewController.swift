import UIKit
import UserNotifications
class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       UNUserNotificationCenter.current().delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }

    @IBAction func lanzar(_ sender: UIButton) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let action = UNNotificationAction(identifier: "action", title: "CAMBIAR COLOR", options: [])
        
        let borrar = UNNotificationAction(identifier: "borrar", title: "BORRAR", options: [])
        
        let categoria = UNNotificationCategory(identifier: "categoria", actions: [action, borrar], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categoria])
        
        let contenido = UNMutableNotificationContent()
        contenido.title = "Hora de programar nuestra app"
        contenido.subtitle = "subtitulo de la notificación"
        contenido.body = "Crearemos una app donde utilizaremos notificaciones"
        contenido.sound = UNNotificationSound.default()
        contenido.categoryIdentifier = "categoria"
        
        if let path = Bundle.main.path(forResource: "imagen", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do{
                let imagen = try UNNotificationAttachment(identifier: "imagen", url: url, options: nil)
                contenido.attachments = [imagen]
            }catch{
                print("no cargo la imagen")
            }
        }
        
        
        
        let request = UNNotificationRequest(identifier: "notificacion1", content: contenido, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("fallo la notificacion", error)
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "action"{
            self.view.backgroundColor = UIColor.blue
        } else if response.actionIdentifier == "borrar" {
            print("se borro la notificacion")
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notificacion1"])
        }
    }
    
}

