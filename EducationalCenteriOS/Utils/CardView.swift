import UIKit

// Marcamos esta clase para que se pueda ver en el Inspector de Atributos de Storyboard (IBInspectable)
@IBDesignable
class CardView: UIView {
    
    // Estos atributos se pueden editar directamente en Storyboard!
    @IBInspectable var cornerRadius: CGFloat = 10.0
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.25
    @IBInspectable var shadowRadius: CGFloat = 3.0
    
    override func layoutSubviews() {
        // Asegúrate de llamar a super
        super.layoutSubviews()
        
        // 1. Aplicar Esquinas Redondeadas
        layer.cornerRadius = cornerRadius
        
        // 2. Aplicar Sombra (Elevación)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false // Es crucial para que la sombra sea visible
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath.cgPath // Optimiza el renderizado de la sombra
    }
}
