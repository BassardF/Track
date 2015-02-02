import UIKit
import CoreData


class ExercicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var exercices : [NSManagedObject]?
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var exerciceDAO : ExerciceDAO?
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciceDAO = ExerciceDAO(appDelegate: appDelegate)
        refreshExercices()
    }
    
    func refreshExercices (){
        exercices = exerciceDAO!.get()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func save(sender: UIButton) {
        exerciceDAO!.create(nameField.text)
        refreshExercices()
    }
    
    // tableview DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return exercices!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.text = exercices![indexPath.row].valueForKey("name") as String?
        
        return cell!
    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            exerciceDAO!.delete(exercices![indexPath.row])
            refreshExercices()
        }
    }

}

