import bb.cascades 1.0
import bb.multimedia 1.0

Page {
    Container {
        id : root
        function logToConsole(message) {
            message = "\n**************\n" + message + "\n**************\n";
            console.log(message);
        }
        layout: DockLayout {}
        
        ImageView {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            imageSource: "asset:///images/background.png"
        }
        
        Label {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Top
            
            text: qsTr("Motley fool money")
            textStyle {
                base: SystemDefaults.TextStyles.BigText
                color: Color.Gray
            }
        }
        
        
        //! [0]
        ImageButton {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            
            defaultImageSource: player.mediaState == MediaState.Started ? "asset:///images/pause_button.png": "asset:///images/play_button.png" 
            
            
            onClicked: {
                if (player.mediaState == MediaState.Started)
                { nowPlaying.pause()
                    root.logToConsole("Pause button clicked. Media playback paused.") }
                    
                    else
                    { nowPlaying.acquire()
                    root.logToConsole("Play button clicked. Media playback resuming..") }
            }
        
        }
        // defines the play-pause button
        
        ImageButton {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center
            
            defaultImageSource: "asset:///images/stop.png"
            
            onClicked: {
                if (player.mediaState == MediaState.Started)
                {
                    nowPlaying.revoke()
                    root.logToConsole("Media playback stopped.")   	
                }
            
            
            }
            
            rightPadding: 200.0
            rightMargin: 50
        
        } // defines the stop button.
        ProgressBar {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            
            duration: nowPlaying.duration
            position: nowPlaying.position
            // leftPadding: 130.0
            // rightPadding: 5.0
        }
        
        //! [1]
    }
    
    attachedObjects: [
        //! [2]
        MediaPlayer {
            id: player
            
            sourceUrl: "http://feedproxy.google.com/~r/MotleyFoolMoney/~5/tU4mIwXmpSk/02_25_2011_Motley_Fool_Money.mp3"
            //sourceUrl: "asset:///music/tailtoddle_lo.mp3"
        },
        //! [2]
        
        //! [3]
        NowPlayingConnection {
            id: nowPlaying
            
            duration: player.duration
            position: player.position
            iconUrl: "asset:///images/music.png"
            mediaState: player.mediaState
            
            onAcquired: {
                root.logToConsole("onAcquired")
                player.play()
                
                nowPlaying.mediaState = MediaState.Started
                nowPlaying.metaData = player.metaData
            }
            
            onPause: {
                player.pause()
                root.logToConsole("onPause")
                nowPlaying.mediaState = MediaState.Paused
            }
            
            onPlay: {
                root.logToConsole("onPlay")
                player.play()
            }
            
            onRevoked: {
                root.logToConsole("onRevoked")
                player.stop()
                nowPlaying.mediaState = MediaState.Stopped
            }
        }
    //! [3]
    
    
    ]


}


