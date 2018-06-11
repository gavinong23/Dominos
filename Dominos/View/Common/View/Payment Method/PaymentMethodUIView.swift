import UIKit

class PaymentMethodUIView: UIView {
    
 
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    @IBOutlet weak var cardHolderNameTextField: UITextField!
    
    @IBOutlet weak var expirationDateTextField: UITextField!
    
    @IBOutlet weak var ccvTextField: UITextField!
    
    @IBOutlet weak var saveCardSwitch: UISwitch!
    
    
    @IBOutlet weak var creditCardView: UIView!
    
    @IBOutlet weak var codView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        
        Bundle.main.loadNibNamed(R.nib.paymentMethodUIView.name, owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showPaymentView(paymentType: EnumPaymentType){
        switch paymentType{
            case .cc:
                self.creditCardView.isHidden = false
                self.codView.isHidden = true
            case .cod:
                self.creditCardView.isHidden = true
                self.codView.isHidden = false
            
        }
    }
    
    
}
