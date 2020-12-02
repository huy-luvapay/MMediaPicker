
import Photos

@objc public class MMediaPicker: NSObject, TLPhotosPickerViewControllerDelegate {
    
    private var completion: (([PHAsset]) -> Void)? = nil
    
    private var cancel: (() -> Void)? = nil
    
    @objc public static let shared: MMediaPicker = {
        let instance = MMediaPicker()
        return instance
    }()
    
    @objc public func presentObjc(in viewController: UIViewController, selectedColor: UIColor, maxSelectCount: Int, isOnlySelectPhoto: Bool, languageEng: Bool, completion: @escaping ([PHAsset]) -> Void, cancel: (() -> Void)?) {
        self.present(in: viewController, selectedColor: selectedColor, maxSelectCount: maxSelectCount, isOnlySelectPhoto: isOnlySelectPhoto, languageEng: languageEng, completion: completion, cancel: cancel)
    }
    
    public func present(in viewController: UIViewController, selectedColor: UIColor? = nil, maxSelectCount: Int? = nil, isOnlySelectPhoto: Bool? = nil, languageEng: Bool = true, completion: @escaping ([PHAsset]) -> Void, cancel: (() -> Void)? = nil) {
        if(languageEng) {
            Bundle.setLanguageFrameworkMMediaPicker("en")
        } else {
            Bundle.setLanguageFrameworkMMediaPicker("vi")
        }
        self.cancel = cancel
        self.completion = completion
        let vc = CustomBlackStylePickerViewController(customColor: selectedColor ?? .black)
        vc.delegate = self
        vc.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            //self?.showExceededMaximumAlert(vc: picker)
        }
        var configure = TLPhotosPickerConfigure()
        configure.usedCameraButton = false
        configure.numberOfColumn = 4
        configure.maxSelectedAssets = maxSelectCount
        vc.configure = configure
        vc.selectedAssets = []
        //vc.logDelegate = self
        
        if(isOnlySelectPhoto == true) {
            configure.mediaType = .image
        }
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true, completion: nil)
        
    }
    
    //MARK: TLPhotosPickerViewControllerDelegate
    
    public func dismissPhotoPicker(withPHAssets: [PHAsset]) {
       
    }
    public func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        var assets = [PHAsset]()
        for item in withTLPHAssets {
            if(item.limitedPermission == false) {
                if let phAsset = item.phAsset {
                    assets.append(phAsset)
                }
            }
        }
        completion?(assets)
        completion = nil
    }
    public func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        return true
    }
    public func dismissComplete() {
    }
    public func photoPickerDidCancel() {
        self.cancel?()
        self.cancel = nil
        
    }
    public func canSelectAsset(phAsset: PHAsset) -> Bool {
        return true
    }
    public func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        
    }
    public func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        
    }
    public func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        
    }
    
}




class CustomPhotoPickerViewController: TLPhotosPickerViewController {
    override func makeUI() {
        super.makeUI()
        self.customNavItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: nil, action: #selector(customAction))
    }
    @objc func customAction() {
        self.cancelButtonTap()
        /*
        self.delegate?.photoPickerDidCancel()
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.dismissComplete()
            self?.dismissCompletion?()
        }
        */
    }
    /*
    override func maxCheck() -> Bool {
        let imageCount = self.selectedAssets.filter{ $0.phAsset?.mediaType == .image }.count
        let videoCount = self.selectedAssets.filter{ $0.phAsset?.mediaType == .video }.count
        if imageCount > 3 || videoCount > 1 {
            return true
        }
        return false
    }*/
}



class CustomBlackStylePickerViewController: TLPhotosPickerViewController {
    
    
    private var isShowLimitedAccessAlert: Bool = true
    
    var customColor: UIColor = .black
    
    init(customColor: UIColor) {
        self.customColor = customColor
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updatePresentLimitedLibraryButton() {
        super.updatePresentLimitedLibraryButton()
        /*
        if #available(iOS 14.0, *), self.photoLibrary.limitMode && self.configure.preventAutomaticLimitedAccessAlert {
            if(self.isShowLimitedAccessAlert) {
                self.limitButtonTap()
                self.isShowLimitedAccessAlert = false
            }
        }
        */
    }
    
    override func makeUI() {
        super.makeUI()
        self.customNavItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: nil, action: #selector(customAction))
        self.view.backgroundColor = self.customColor
        if(self.customColor == UIColor.black) {
            self.navigationBar.barStyle = .black
            self.collectionView.backgroundColor = self.customColor
        } else {
            self.navigationBar.barStyle = .blackOpaque
            self.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
            self.collectionView.backgroundColor = .white
        }
        self.titleLabel.textColor = .white
        self.subTitleLabel.textColor = .white
        self.navigationBar.tintColor = .white
        self.popArrowImageView.image = TLBundle.podBundleImage(named: "pop_arrow")?.colorMask(color: .white)
        self.albumPopView.popupView.backgroundColor = self.customColor
        self.albumPopView.tableView.backgroundColor = .white
    }
    
    @objc func customAction() {
        //self.dismiss(animated: true, completion: nil)
        self.cancelButtonTap()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! TLCollectionTableViewCell
        cell.backgroundColor = .white
        cell.titleLabel.textColor = .black
        cell.subTitleLabel.textColor = .black
        cell.tintColor = self.customColor
        return cell
    }
}


extension String {
    
    
    public func localizedString() -> String {
        return NSLocalizedString(self, bundle: TLBundle.bundle() , comment: "")
    }
}
