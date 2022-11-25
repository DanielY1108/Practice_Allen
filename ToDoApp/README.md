# ToDoApp

## UIKIT
## code

### 버튼 연결

### 1. 커스텀 델리게이트

TVCell

    protocol ButtonDelegate: AnyObject {
        func cellBtnTapped()
    }

    class MainTableViewCell: UITableViewCell {
        weak var delegate: ButtonDelegate?
     }

    extension MainTableViewCell {
		
        func setupBtn() {
            self.updateButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
            print(#function)
        }

        @objc func btnTapped() {
            print(#function)

            delegate?.cellBtnTapped()
        }
VC

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
	
            cell.delegate = self	
            cell.contentView.isUserInteractionEnabled = false
        
       return cell
       }

    extension MainViewController: ButtonDelegate {
        func cellBtnTapped() {
            print(#function)
        }
    }


### 2.  클로저 타입
  
TVCell

    class MainTableViewCell: UITableViewCell {
        var updateButtonPressed: ((MainTableViewCell) -> Void)?
     }

    extension MainTableViewCell {

        func setupBtn() {
            self.updateButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
            print(#function)
        }

        @objc func btnTapped() {
            print(#function)
            updateButtonPressed?(self)
        }
    }
 
VC

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell

        cell.contentView.isUserInteractionEnabled = false
	  // 클로저를 실행
        cell.updateButtonPressed = { [weak self] (senderCell) in
            print(#function)

        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        self?.navigationController?.show(detailVC, sender: indexPath)
        }     
    return cell
    }
