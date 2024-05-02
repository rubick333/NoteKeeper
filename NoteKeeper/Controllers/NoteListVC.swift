import UIKit

class NoteListVC: UIViewController {
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var cnstViewSearchHeight: NSLayoutConstraint!
    @IBOutlet weak var txtFieldSearchBar: UISearchBar!
    
    @IBOutlet weak var tblViewNoteList: UITableView!
    
    lazy var noteManager:NoteManager = NoteManager()
    lazy var arrNote:[Note] = [Note](){
        didSet{
            reloadTblView()
        }
    }
    lazy var arrSearchNote:[Note] = [Note](){
        didSet{
            reloadTblView()
        }
    }
    
    var showSearchView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateDummyData()
        hideKeyboardWhenTappedAround()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    func generateDummyData(){
        let note1 = Note(id: UUID(), noteTitle: "Title1", noteDescription: "Description1", noteCategory: "Category1", noteCreationDate: Date(), noteModificationDate: nil, noteAttachment: nil, noteLock: false)
        let note2 = Note(id: UUID(), noteTitle: "Title2", noteDescription: "Description2", noteCategory: "Category2", noteCreationDate: Date(), noteModificationDate: nil, noteAttachment: nil, noteLock: false)
        let note3 = Note(id: UUID(), noteTitle: "Title3", noteDescription: "Description3", noteCategory: "Category3", noteCreationDate: Date(), noteModificationDate: nil, noteAttachment: nil, noteLock: false)
        let arr:[Note] = [note1,note2,note3]
        arr.forEach { note in
            noteManager.createNote(note: note)
        }
    }
    
    //MARK: UITableView Helper Methods
    private func reloadTblView(){
        DispatchQueue.main.async { [weak self] in
            self?.tblViewNoteList.reloadData()
        }
    }
    
    //MARK: UIHelper Methods
    private func showHideSearchView(){
        showSearchView = !showSearchView
        DispatchQueue.main.async { [weak self] in
            self?.view.endEditing(true)
            self?.cnstViewSearchHeight.constant = self?.showSearchView ?? false ? 56 : 0
            self?.viewSearch.isHidden = !(self?.showSearchView ?? false)
            self?.txtFieldSearchBar.isHidden = !(self?.showSearchView ?? false)
        }
    }
    
    //MARK: Helper Methods
    private func fetchNotes(){
        guard let arrNote = noteManager.fetchNotes() else { return }
        self.arrNote = arrNote
        self.arrSearchNote = arrNote
    }
    
    private func delete(indexPath:IndexPath){
        let note = arrNote[indexPath.row]
        let result = noteManager.deleteNote(note: note)
        if(result){
            arrNote.remove(at: indexPath.row)
            fetchNotes()
        }else{
            self.showToast(message: "Unable to delete the note", font: .systemFont(ofSize: 12))
        }
    }
    
    //MARK: Redirection methods
    private func redirectToAddNoteVC(editNote:Bool? = false,note:Note? = nil){
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNoteVC") as! AddNoteVC
        vc.editNote = editNote ?? false
        vc.note = note
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: IBActions
    @IBAction func btnActionSearch(_ sender: UIBarButtonItem) {
        showHideSearchView()
    }
    
    @IBAction func btnActionAdd(_ sender: UIBarButtonItem) {
        redirectToAddNoteVC()
    }
    
}

//MARK: UITableViewDataSource & UITableViewDelegate Methods
extension NoteListVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = arrSearchNote[indexPath.row]
        cell.setData(note: note)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let btnEdit = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, _ in
            guard let note = self?.arrSearchNote[indexPath.row] else {
                self?.showToast(message: "Unable to edit the note", font: .systemFont(ofSize: 12))
                return
            }
            self?.redirectToAddNoteVC(editNote: true,note: note)
        }
        
        let btnDelete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let _ = self?.arrSearchNote[indexPath.row] else {
                self?.showToast(message: "Unable to delete the note", font: .systemFont(ofSize: 12))
                return
            }
            self?.delete(indexPath:indexPath)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [btnDelete,btnEdit])
        return swipeConfiguration
        
    }
    
}

extension NoteListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arrSearchNote = arrNote.filter{ ($0.noteTitle?.lowercased().prefix(searchText.count))! == searchText.lowercased() }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrSearchNote = arrNote
    }
}
