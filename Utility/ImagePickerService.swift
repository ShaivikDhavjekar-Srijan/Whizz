import Foundation
import UIKit
import MobileCoreServices
import Photos
import CoreMedia


class  ImagePickerService:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    enum ImageSourceType {
        case ICamera
        case IPhotoGallery
    }
    
    public typealias pickerSelection = (_ selectedData: UIImage) -> ()
    
    fileprivate var completionBlock: pickerSelection?
    private weak var presentationController: UIViewController?
    
    private let camera = "Camera"
    private let photoLibrary = "Photo Library"
    private let cancel = "Cancel"
    private let settings = "Settings"
    private let cameraAccessError = "Camera access required for capturing photos!"
    private let photoLibraryAccessError = "Photo Library access required for picking photos!"
    
    
    public init(presentationController: UIViewController) {
        super.init()
        
        self.presentationController = presentationController
    }
    
    func pickImage(completionHandler:@escaping pickerSelection){
        self.completionBlock = completionHandler
        
        let photoAlertController: UIAlertController = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        
        let pictureCameraAction: UIAlertAction = UIAlertAction(title: camera, style: .default) { action -> Void in
            self.openCamera()
        }
        let libraryAction: UIAlertAction = UIAlertAction(title: photoLibrary, style: .default) { action -> Void in
            self.openPhotoGallery()
        }
        
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)
        
        photoAlertController.addAction(pictureCameraAction)
        photoAlertController.addAction(libraryAction)
        photoAlertController.addAction(cancelActionButton)
        photoAlertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        if let controller = presentationController {
            photoAlertController.popoverPresentationController?.sourceView = controller.view
            photoAlertController.popoverPresentationController?.sourceRect = controller.view.bounds
            controller.present(photoAlertController,
                                            animated: true,
                                            completion: nil)
        }
    }
    
    @MainActor private func captureImage(sourceType:ImageSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) && sourceType == .ICamera {
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        imagePicker.mediaTypes = ["public.image"]
        NavigationStyle.setNavBarColor(color: .themeColor, isTranslucent: false)
        if let controller = self.presentationController {
            controller.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        NavigationStyle.setNavBarColor(color: .themeColor, isTranslucent: true)
        var image:UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        }
        else if let editedImage = info[.originalImage] as? UIImage {
            image = editedImage
        }
        if let pickImage = image {
            self.completionBlock!(pickImage)
        }
        if let controller = presentationController {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        NavigationStyle.setNavBarColor(color: .themeColor, isTranslucent: true)
        DispatchQueue.main.async {
            if let controller = self.presentationController {
                controller.dismiss(animated: true, completion: nil)
            }
        }
    }
}
// MARK: Camera Permission Methods
extension ImagePickerService {
    func openCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
                guard accessGranted == true else {
                    Task {
                    self.alertAccessNeeded(message: self.cameraAccessError)
                    }
                    return
                }
                Task {
                    self.captureImage(sourceType: .ICamera)
                }
            })
        case .authorized:
            self.captureImage(sourceType: .ICamera)
        case .restricted, .denied:
            self.alertAccessNeeded(message: self.cameraAccessError)
        @unknown default:
            self.alertAccessNeeded(message: self.cameraAccessError)
        }
    }
    
    func openPhotoGallery() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.captureImage(sourceType: .IPhotoGallery)
            //handle authorized status
        case .denied, .restricted :
            self.alertAccessNeeded(message: self.photoLibraryAccessError)
            //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { status in
                switch status {
                case .authorized:
                    Task {
                        self.captureImage(sourceType: .IPhotoGallery)
                    }
                    // as above
                default :
                    Task {
                    self.alertAccessNeeded(message: self.photoLibraryAccessError)
                    }
                }
            }
        case .limited:
            break
        @unknown default:
            self.alertAccessNeeded(message: self.photoLibraryAccessError)
        }
    }
    
    @MainActor func alertAccessNeeded(message:String) {
        let alert = UIAlertController(
            title: "Swiko",
            message:message  ,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { action -> Void in
            if let controller = self.presentationController {
                controller.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(UIAlertAction(title: settings, style: .default, handler: { (alert) -> Void in
            _ = OpenInService.OpenUrlInSafari(strURL: UIApplication.openSettingsURLString)
            if let controller = self.presentationController {
                controller.dismiss(animated: true, completion: nil)
            }
        }))
        if let controller = self.presentationController {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
