//
//  VoucherViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 03/08/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var dateHourLabel: UILabel!
    @IBOutlet weak var authenticationLabel: UILabel!
    @IBOutlet weak var descriptionTargetLabel: UILabel!

    weak var coordinator: DetailCoordinator?
    var model: DetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        erase()
        model?.loadDetail()
    }

    @IBAction func share(_ sender: Any) {
        if let sender = sender as? UIView {
            showShare(sender: sender)
        }
    }

    func erase() {
        descriptionLabel.text = ""
        targetLabel.text = ""
        bankLabel.text = ""
        authenticationLabel.text = ""
        valueLabel.text = ""
        dateHourLabel.text = ""
    }

    // Transformando a view wm imagem
    func takeDetailStatement() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, view.isOpaque, 1.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    @objc func showShare(sender: UIView) {
        guard let image = takeDetailStatement() else {
            showErrorShare()
            return
        }

        guard let url = storeImagePhone(image: image) else {
            showErrorShare()
            return
        }

        let activityView = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        activityView.popoverPresentationController?.sourceView = sender
        self.present(activityView, animated: true, completion: nil)

    }
    // O método salvar imagem --- Onde a imagem é armazenada
    private func storeImagePhone(image: UIImage) -> URL? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let imagePath = dirPath + "snapshot.png"
        let imageUrl = URL(fileURLWithPath: imagePath)

        do {
            try image.pngData()?.write(to: imageUrl)
            return imageUrl
        } catch {
            return nil
        }
    }
    // O método de mensagem de erro.
    private func showErrorShare() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error! Algo está errado.",
                message: "Por favor tente novamente!",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    private func prepareDetail() {
        descriptionLabel.text = model?.statement?.description
        targetLabel.text = model?.statement?.destinationName
        bankLabel.text = model?.statement?.bankName ?? model?.statement?.myBank
        authenticationLabel.text = model?.statement?.authentication
        descriptionTargetLabel.text = model?.statement?.typeTarget
        valueLabel.text = Formatter.formatCurrency(value: model?.statement?.amount ?? 0)
        dateHourLabel.text = Formatter.formatDate(
            string: model?.statement?.createdAt ?? "",
            from: .long,
            to: .longBrDateTime
        )
    }

}

extension DetailViewController: DetailModelDelegate {
    func didUpShowDetail() {
        DispatchQueue.main.async { [weak self] in
            self?.prepareDetail()
        }
    }

    func didShowError(message: String) {
        print(message)
    }

}
