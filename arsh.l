# arsh -- the ARdour SHell
#
# The MIT Liscense (MIT)
#
# copyright 2015 (c) Erik Gustafson

[symbols 'arsh 'pico]

[setq *ArdourUrl "osc.udp://localhost:3819"]

[de callArdour (Str . @)
   (call 'oscsend
      *ArdourUrl
      (pack "/ardour" Str)
      (next)      
      (next)    # this is a giant hack.
      (next) ]  # there must be a way to splice (rest) into a function call.


# main loop
[de arshLoop ()
   (arshWelcome)
   (printsp '>)
   (while (read)
      [case @
         (("play" "p") (play))  # make 'car' of clause a list to define aliases.
         ("stop" (stop))
         (T (arshHelp)) ]   # hah!
      (printsp '>) ]

[de arshWelcome ()
   (println "Welcome to Arsh, the ARdour SHell") ]

[de arshHelp ()
   (println "You don't know what you're doing. Get some help.") ]


# osc messages 
[de play ()
   (callArdour "/transport_play") ]

[de stop ()
   (callArdour "/transport_stop") ]

[de ffwd ()
   (callArdour "/ffwd") ]

[de rwd ()
   (callArdour "/rewind") ]

[de start ()
   (callArdour "/goto_start") ]

[de end ()
   (callArdour "/goto_end") ]

[de recEnable ()
   (callArdour "/rec_enable_toggle") ]

[de nextMark ()
   (callArdour "/next_marker") ]

[de prevMark ()
   (callArdour "/prev_marker") ]

[de addMark ()
   (callArdour "/add_marker") ]

[de locate (Sample)
   (callArdour "/locate" "ii" Sample 0) ]
# track specific operations

[de mute (Track)
   (callArdour "/routes/mute" "ii" Track 1 ]

[de unmute (Track)
   (callArdour "/routes/mute" "ii" Track 0 ]

[de solo (Track)
   (callArdour "/routes/solo" "ii" Track 1 ]

[de unsolo (Track)
   (callArdour "/routes/solo" "ii" Track 0 ]
