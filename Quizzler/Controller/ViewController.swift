import UIKit

class ViewController: UIViewController {
    
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var trueButton: UIButton!
  @IBOutlet weak var falseButton: UIButton!
  @IBOutlet weak var restartButton: UIButton!
  @IBOutlet weak var progressBar: UIProgressView!
  
  var quizBrain = QuizBrain()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }

  @IBAction func answerButtonPressed(_ sender: UIButton) {
    let correctAnswer = quizBrain.checkAnswer(sender.currentTitle!)
    
    if correctAnswer {
      sender.backgroundColor = UIColor.green
    } else {
      sender.backgroundColor = UIColor.red
    }
    
    quizBrain.nextQuestion()
    
    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
  
  }
  
  @IBAction func restartQuiz(_ sender: UIButton) {
    quizBrain.restartQuiz()
    restartButton.isEnabled = false
    restartButton.alpha = 0
    trueButton.isEnabled = true
    trueButton.alpha = 1
    falseButton.isEnabled = true
    falseButton.alpha = 1
    updateUI()
  }
  
  @objc func updateUI(){
    questionLabel.text = quizBrain.getNextQuestion()
    progressBar.progress = quizBrain.getProgress()
    trueButton.backgroundColor = UIColor.clear
    falseButton.backgroundColor = UIColor.clear
    restartButton.isEnabled = false
    restartButton.alpha = 0
    scoreLabel.text = "Score: \(quizBrain.getScore())/\(quizBrain.getNumberOfQuestions())"
    
    if quizBrain.quizFinished {
      questionLabel.text = "Quiz finished!\nResult:\(quizBrain.getScore())/\(quizBrain.getNumberOfQuestions())"
      questionLabel.textAlignment = NSTextAlignment.center
      scoreLabel.text = ""
      trueButton.isEnabled = false
      trueButton.alpha = 0
      falseButton.isEnabled = false
      falseButton.alpha = 0
      restartButton.isEnabled = true
      restartButton.alpha = 1
      restartButton.backgroundColor=UIColor.clear
    }
  }
  
}

