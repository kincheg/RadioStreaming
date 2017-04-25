//
//  ViewController.swift
//  RadioStreaming
//
//  Created by kin on 07.03.17.
//  Copyright © 2017 kin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var playerItem: AVPlayerItem!
    var player: AVPlayer!
    var nameSound = ""
    
    let url = ["http://online-kissfm.tavrmedia.ua/KissFM", "http://icecast.radiohitfm.cdnvideo.ru/hit.mp3", "http://ep128server.streamr.ru:8030/ep128", "http://cast.radiogroup.com.ua:8000/europaplus", "http://media.brg.ua:8010/;stream.nsv?64", "http://195.234.215.152:8000/bestfm_mp3", "http://cast.loungefm.com.ua/loungefm", "http://185.65.245.34:8000/kiev"]
    
    let imagesStation = [UIImage(named: "kiss-fm.jpg"),UIImage(named: "hitfmua.jpg"),UIImage(named: "europa_plus.jpg"),UIImage(named: "nrg.jpg"),UIImage(named: "djfm.jpg"),UIImage(named: "best-fm.jpg"),UIImage(named: "lounge.jpg"),UIImage(named: "ec.jpg")]
    
    var buttonIsVisible = [true, true, true, true, true, true, true, true]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
            
        catch{
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return url.count
        
       
    }
    /////
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellTB
        
        cell.imageCell.image = imagesStation[indexPath.row]
        cell.button.isHidden = buttonIsVisible[indexPath.row]
        
        
       return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
        //tableView.deselectRow(at: indexPath, animated: true)
        buttonIsVisible = [Bool](repeatElement(true, count: 8))
        buttonIsVisible[indexPath.row] = !buttonIsVisible[indexPath.row]
        if playerItem != nil {
            playerItem.removeObserver(self, forKeyPath: "timedMetadata", context: nil)
        }
//        do {
//            try playerItem.removeObserver(self, forKeyPath: "timedMetadata", context: nil)
//            print("The observer was deleted")
//        } catch {
//            print("There is no observer")
//        }
        play(url[(indexPath as NSIndexPath).row])
        let cell = tableView.cellForRow(at: indexPath) as! CellTB
        if player.rate == 0.0 {
            
            //cell.button.isHidden = false
            cell.button.isHidden = buttonIsVisible[indexPath.row]
            cell.button.setImage(UIImage(named: "Pause.png"), for:UIControlState.normal)
            tableView.reloadData()
            playStopSound()
            
            
            
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! CellTB
//        cell.button.isHidden = true
//        
//    }
    
    func play(_ url:String)  {
        //playerItem = AVPlayerItem(url: NSURL(string: "http://online-kissfm.tavrmedia.ua/KissFM") as! URL)
         playerItem = AVPlayerItem(url: NSURL(string: url ) as! URL)
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: .new, context: nil)
        player = AVPlayer(playerItem: playerItem)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath != "timedMetadata" { return }
        
        let data: AVPlayerItem = object as! AVPlayerItem
        
        for item in data.timedMetadata! as [AVMetadataItem] {
            
            let str =  item.value?.description
            //print(item.value)
            //let encod = NSMutableString(string: str!) as CFMutableString
            
            let convert = str?.data(using: String.Encoding.isoLatin1)
            let utf = String(data: convert!, encoding: String.Encoding.utf8)
            
            //let utf = String(data: utfData, encoding: NSUTF8StringEncoding)
            //print (convert)
            print(utf!)
            nameSound = utf!
            //CFStringTransform(encod, nil, kCFStringTransformToUnicodeName as CFString, false)
            //print(encod)
            //CFStringTransform(encod, nil, kCFStringTransformStripCombiningMarks, false)
            
            
            
        }
        
    }
    
    @IBAction func buttonPlay(_ sender: UIButton) {
        playStopSound()
        let playerButton = sender as UIButton
        
        if player.rate == 1.0 {
            
            playerButton.setImage(UIImage(named: "Pause.png"), for:UIControlState.normal)
            
            
        }else if player.rate == 0.0 {
            
            playerButton.setImage(UIImage(named:"Play.png"),for:UIControlState.normal)
            
            
        }
    }
    
    
    func playStopSound()  {
        if (player.rate != 0.0 && player.error == nil ) {
            notPlayGif()
            player.pause()
            print("pause play \(player.rate)")
        }else  {
            
            
            player.play()
            playGif()
            print("play sound \(player.rate)")
            
        }
    }
    
      func playGif() {
        let gif = UIImage.gif(name: "gif")
        imageView.image = gif
        
    }
    
    
    func notPlayGif()  {
        let noGif = UIImage(named: "music.gif")
        imageView.image = noGif
        
    }
    
    
    }
