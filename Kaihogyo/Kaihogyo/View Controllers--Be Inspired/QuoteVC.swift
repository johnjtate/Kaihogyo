//
//  QuoteVC.swift
//  Kaihogyo
//
//  Created by John Tate on 10/30/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import CoreData

class QuoteVC: UIViewController, NSFetchedResultsControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var mountainImageView: UIImageView!
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var moreOnQuoteSourceButton: UIButton!
    @IBOutlet weak var anotherQuoteButton: UIButton!
    
    // MARK: - Properties
    var quoteURL: URL?
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set rounded corners
        mountainImageView.layer.cornerRadius = 10.0
        mountainImageView.layer.masksToBounds = true
        fetchedResultsController.delegate = self
        addInitialFiftyQuotes()
        fetchQuotes()
        // in the case that a quote needs to be corrected, the following three functions below can be toggled following corrections to load a corrected array of 50 quotes into the CoreData stack
//        purgeQuotes()
//        addInitialFiftyQuotes()
//        fetchQuotes()
        loadQuote()
    }
    
    let fetchedResultsController: NSFetchedResultsController<Quote> = {
        
        let fetchRequest: NSFetchRequest<Quote> = Quote.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func fetchQuotes() {
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
        }
    }
    
    // MARK: - Quote Helper Functions
    
    func loadQuote() {
        let quoteCount = fetchedResultsController.fetchedObjects?.count ?? 0
        guard quoteCount > 0 else { return }
        let index = Int.random(in: 0...quoteCount-1)
        let quote = fetchedResultsController.fetchedObjects?[index]
        
        quoteTextLabel.text = quote?.text ?? ""
        authorTextLabel.text = quote?.author ?? ""
        if let url = quote?.url {
            quoteURL = URL(string: url)
        }
    }
    
    // purges quotes
    func purgeQuotes() {
        let quoteCount = fetchedResultsController.fetchedObjects?.count ?? 0
        guard quoteCount > 0 else { return }
        for i in 0...quoteCount-1 {
            let quote = fetchedResultsController.fetchedObjects?[i]
            QuoteController.sharedController.remove(quote: quote!)
        }
    }
    
    // populates with initial 50 quotes
    func addInitialFiftyQuotes() {
        let quote1 = Quote.init(text: "Even if you run a slower than expected time, you succeed in any marathon when you finish.", author: "Hal Higdon", url: "https://www.halhigdon.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote1)
        let quote2 = Quote.init(text: "The miracle isn't that I finished.  The miracle is that I had the courage to start.", author: "John Bingham", url: "https://en.wikipedia.org/wiki/John_Bingham_(runner)", userAdded: false)
        QuoteController.sharedController.add(quote: quote2)
        let quote3 = Quote.init(text: "Most people run a race to see who is fastest.  I run a race to see who has the most guts.", author: "Steve Prefontaine", url: "https://en.wikipedia.org/wiki/Steve_Prefontaine", userAdded: false)
        QuoteController.sharedController.add(quote: quote3)
        let quote4 = Quote.init(text: "I often hear someone say I'm not a real runner.  We are all runners, some just run faster than others.  I never met a fake runner.", author: "Bart Yasso", url: "http://www.bartyasso.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote4)
        let quote5 = Quote.init(text: "The human spirit is indomitable.  No one can ever say you must not run faster than this or jump higher than that.  There will never be a time when the human spirit will not be able to better existing records.", author: "Sir Roger Bannister", url: "https://en.wikipedia.org/wiki/Roger_Bannister", userAdded: false)
        QuoteController.sharedController.add(quote: quote5)
        let quote6 = Quote.init(text: "There is magic in misery.  Just ask any runner.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote6)
        let quote7 = Quote.init(text: "As athletes we have ups and downs.  Unfortunately you can't pick the days they come on.", author: "Deena Kastor", url: "http://deenakastor.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote7)
        let quote8 = Quote.init(text: "Experience has taught me how important it is to just keep going, focusing on running fast and relaxes.  Eventually pain passes and the flow returns.  It's part of racing.", author: "Frank Shorter", url: "http://frankshorter.net/", userAdded: false)
        QuoteController.sharedController.add(quote: quote8)
        let quote9 = Quote.init(text: "Toeing the starting line of a marathon, regardless of the language you speak, the God you worship or the color of your skin, we all stand as equal.  Perhaps the world would be a better place if more people ran.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote9)
        let quote10 = Quote.init(text: "There's not one body type that equates to success.  Accept the body you have and be the best you can be with it.", author: "Mary Cullen", url: "https://en.wikipedia.org/wiki/Mary_Cullen", userAdded: false)
        QuoteController.sharedController.add(quote: quote10)
        let quote11 = Quote.init(text: "The obsession with running is really an obsession with the potential for more and more life.", author: "George Sheehan", url: "https://en.wikipedia.org/wiki/George_A._Sheehan", userAdded: false)
        QuoteController.sharedController.add(quote: quote11)
        let quote12 = Quote.init(text: "Mental will is a muscle that needs exercise, just like the muscles of the body.", author: "Lynn Jennings", url: "https://en.wikipedia.org/wiki/Lynn_Jennings", userAdded: false)
        QuoteController.sharedController.add(quote: quote12)
        let quote13 = Quote.init(text: "I breathe in strength and breathe out weakness,' is my mantra during marathons--it calms me down and helps me focus.", author: "Amy Cragg", url: "https://en.wikipedia.org/wiki/Amy_Cragg", userAdded: false)
        QuoteController.sharedController.add(quote: quote13)
        let quote14 = Quote.init(text: "I've always loved running…it was something you could do by yourself, and under your own power.  You could go in any direction, fast or slow as you wanted, fighting the wind if you felt like it, seeking out new sights just on the strength of your feet and the courage of your lungs.", author: "Jesse Owens", url: "https://en.wikipedia.org/wiki/Jesse_Owens", userAdded: false)
        QuoteController.sharedController.add(quote: quote14)
        let quote15 = Quote.init(text: "Don't dream of winning, train for it!", author: "Mo Farah", url: "https://en.wikipedia.org/wiki/Mo_Farah", userAdded: false)
        QuoteController.sharedController.add(quote: quote15)
        let quote16 = Quote.init(text: "Running allows me to set my mind free.  Nothing seems impossible.  Nothing unattainable.", author: "Kara Goucher", url: "http://www.karagoucher.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote16)
        let quote17 = Quote.init(text: "I think I get addicted to the feelings associated with the end of a long run.  I love feeling empty, clean, worn out, and sweat-purged.  I love that good ache of the muscles that have done me proud.", author: "Kristin Armstrong", url: "https://www.runnersworld.com/author/210913/kristin-armstrong/", userAdded: false)
        QuoteController.sharedController.add(quote: quote17)
        let quote18 = Quote.init(text: "Its very hard at the beginning to understand that the whole idea is not to beat the other runners.  Eventually, you learn that the competition is against the little voice inside you that wants you to quit.", author: "George Sheehan", url: "https://www.georgesheehan.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote18)
        let quote19 = Quote.init(text: "Nothing, not even pain, lasts forever.  If I can just keep putting one foot in front of the other, I will eventually get to the end.", author: "Kim Cowart", url: "http://www.kiminthegym.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote19)
        let quote20 = Quote.init(text: "You have to wonder at times what you're doing out there.  Over the years, I've given myself a thousand reasons to keep running, but it always comes back to where it started.  It comes down to self-satisfaction and a sense of achievement.", author: "Steve Prefontaine", url: "https://en.wikipedia.org/wiki/Steve_Prefontaine", userAdded: false)
        QuoteController.sharedController.add(quote: quote20)
        let quote21 = Quote.init(text: "That's the thing about running: your greatest runs are rarely measured by racing success.  They are moments in time when running allows you to see how wonderful you life is.", author: "Kara Goucher", url: "http://www.karagoucher.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote21)
        let quote22 = Quote.init(text: "Run when you can, walk if you have to, crawl if you must; just never give up.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote22)
        let quote23 = Quote.init(text: "It's just as important to remember that each footstrike carries you forward, not backward.  And every time you put on your running shoes you are different in some way than you were the day before.  This is all good news.", author: "John Bingham", url: "https://en.wikipedia.org/wiki/John_Bingham_(runner)", userAdded: false)
        QuoteController.sharedController.add(quote: quote23)
        let quote24 = Quote.init(text: "The real purpose of running isn't to win a race.  It's to test the limits of the human heart.", author: "Bill Bowerman", url: "https://en.wikipedia.org/wiki/Bill_Bowerman", userAdded: false)
        QuoteController.sharedController.add(quote: quote24)
        let quote25 = Quote.init(text: "Our running shoes have magic in them.  The power to transform a bad day into a good day; frustration into speed; self-doubt into confidence; chocolate cake into muscle.", author: "Mina Samuels", url: "https://www.minasamuels.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote25)
        let quote26 = Quote.init(text: "The point is whether or not I improved over yesterday.  In long-distance running the only opponent you have to beat is yourself, the way you used to be.", author: "Haruki Murakami", url: "http://www.harukimurakami.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote26)
        let quote27 = Quote.init(text: "Running is about finding your inner peace, and so is a life well-lived.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote27)
        let quote28 = Quote.init(text: "Crossing the starting line may be an act of courage, but crossing the finish line is an act of faith.  Faith is what keeps us going when nothing else will  Faith is the emotion that will give you victory over your past, the demons in your soul, and all of those voices that tell you what you can and cannot do and can and cannot be.", author: "John Bingham", url: "https://en.wikipedia.org/wiki/John_Bingham_(runner)", userAdded: false)
        QuoteController.sharedController.add(quote: quote28)
        let quote29 = Quote.init(text: "Some seek the comfort of their therapist's office, others head to the corner pub and dive into a pint, but I choose running as my therapy.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote29)
        let quote30 = Quote.init(text: "Struggling and suffering are the essence of a life worth living.  If you're not pushing yourself beyond the comfort zone, if you're not demanding more from yourself--expanding and learning as you go--you're choosing a numb existence.  You're denying yourself an extraordinary trip.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote30)
        let quote31 = Quote.init(text: "Pain is temporary.  Quitting lasts forever.", author: "Lance Armstrong", url: "https://lancearmstrong.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote31)
        let quote32 = Quote.init(text: "If you don’t have answers to your problems after a four-hour run, you ain't getting them.", author: "Christopher McDougall", url: "http://www.chrismcdougall.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote32)
        let quote33 = Quote.init(text: "If you are losing faith in human nature, go out and watch a marathon.", author: "Kathrine Switzer", url: "https://kathrineswitzer.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote33)
        let quote34 = Quote.init(text: "Ask nothing from your running, in other words, and you'll get more than you ever imagined.", author: "Christopher McDougall", url: "http://www.chrismcdougall.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote34)
        let quote35 = Quote.init(text: "It was being a runner that mattered, not how fast or how far I could run.  The joy was in the act of running and in the journey, not in the destination.", author: "John Bingham", url: "https://en.wikipedia.org/wiki/John_Bingham_(runner)", userAdded: false)
        QuoteController.sharedController.add(quote: quote35)
        let quote36 = Quote.init(text: "But you can't muscle through a five-hour run that way; you have to relax into it like easing your body into a hot bath, until it no longer resists the shock and begins to enjoy it.", author: "Christopher McDougall", url: "http://www.chrismcdougall.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote36)
        let quote37 = Quote.init(text: "Yes, I am round.  Yes, I am slow.  Yes, I run as though my legs are tied together at the knees.  But I am running.  And that is all that matters.", author: "John Bingham", url: "https://en.wikipedia.org/wiki/John_Bingham_(runner)", userAdded: false)
        QuoteController.sharedController.add(quote: quote37)
        let quote38 = Quote.init(text: "But I also realize that winning doesn't always mean getting first place; it means getting the best out of yourself.", author: "Meb Keflezighi", url: "https://en.wikipedia.org/wiki/Meb_Keflezighi", userAdded: false)
        QuoteController.sharedController.add(quote: quote38)
        let quote39 = Quote.init(text: "When I go to the Boston Marathon now, I have wet shoulders--women fall into my arms crying.  They're weeping for joy because running has changed their lives.  They feel they can do anything.", author: "Kathrine Switzer", url: "https://kathrineswitzer.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote39)
        let quote40 = Quote.init(text: "I could feel my anger dissipating as the miles went by--you can't run and stay mad!", author: "Kathrine Switzer", url: "https://kathrineswitzer.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote40)
        let quote41 = Quote.init(text: "Winning has nothing to do with racing.  Most days don't have races anyway.  Winning is about the struggle and effort and optimism, and never, ever, ever giving up.", author: "Amby Burfoot", url: "http://www.ambyburfoot.com/p/welcome.html", userAdded: false)
        QuoteController.sharedController.add(quote: quote41)
        let quote42 = Quote.init(text: "Every marathon I ran, I knew I had a faster one in me.", author: "Dick Beardsley", url: "http://www.dickbeardsley.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote42)
        let quote43 = Quote.init(text: "If you want to run, run a mile.  If you want to experience a different life, run a marathon.", author: "Emil Zatopek", url: "https://en.wikipedia.org/wiki/Emil_Z%C3%A1topek", userAdded: false)
        QuoteController.sharedController.add(quote: quote43)
        let quote44 = Quote.init(text: "I've learned that finishing a marathon isn't just an athletic achievement.  It's a state of mind; a state of mind that says anything is possible.", author: "John Hanc", url: "http://johnhanc.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote44)
        let quote45 = Quote.init(text: "The marathon is an opportunity for redemption.  Opportunity, because the outcome is uncertain.  Opportunity, because it is up to you, and only you to make it happen.", author: "Dean Karnazes", url: "https://en.wikipedia.org/wiki/Dean_Karnazes", userAdded: false)
        QuoteController.sharedController.add(quote: quote45)
        let quote46 = Quote.init(text: "There are no shortcuts in marathoning, so anyone who is a marathoner has worked hard.", author: "Jeffrey Horowitz", url: "https://runhorowitz.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote46)
        let quote47 = Quote.init(text: "When you run the marathon, you run against the distance, not against the other runners and not against the time.", author: "Haile Gebrselassie", url: "https://en.wikipedia.org/wiki/Haile_Gebrselassie", userAdded: false)
        QuoteController.sharedController.add(quote: quote47)
        let quote48 = Quote.init(text: "The more you frame the marathon as a stressful experience, the more negative messages you'll receive.  But it's just as easy to frame it as a positively challenging journey.", author: "Jeff Galloway", url: "http://www.jeffgalloway.com/", userAdded: false)
        QuoteController.sharedController.add(quote: quote48)
        let quote49 = Quote.init(text: "I dare you to train for a marathon, and not have it change your life.", author: "Susan Sidoriak", url: "https://www.shopsideporch.com/journal/2016/11/21/a-marathoner-photographer", userAdded: false)
        QuoteController.sharedController.add(quote: quote49)
        let quote50 = Quote.init(text: "So many people crossing the finish line of a marathon look as happy as when I won.  They have tears in their eyes.  The sport is full of winners.", author: "Gary Muhrcke", url: "https://en.wikipedia.org/wiki/Gary_Muhrcke", userAdded: false)
        QuoteController.sharedController.add(quote: quote50)
    }
    
    // MARK: - IBActions
    @IBAction func moreOnQuoteSourceButtonTapped(_ sender: Any) {
        guard let quoteURL = quoteURL else { return }
        if UIApplication.shared.canOpenURL(quoteURL) {
            UIApplication.shared.open(quoteURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func anotherQuoteButtonTapped(_ sender: Any) {
        loadQuote()
    }
}
