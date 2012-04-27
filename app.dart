#import('dart:dom', prefix:'dom');
#import('dart:html');

main() {

  dom.AudioContext audioContext = new dom.AudioContext();
  dom.AudioBufferSourceNode source = audioContext.createBufferSource();
  dom.AudioGainNode gainNode = audioContext.createGainNode();

  source.connect(gainNode, 0, 0);
  gainNode.connect(audioContext.destination, 0, 0);

  dom.XMLHttpRequest xhr = new dom.XMLHttpRequest();
  xhr.open("GET", "techno.mp3", true);
  xhr.responseType = "arraybuffer";
  xhr.addEventListener('load', (e) {

    // asynchronous decoding
    audioContext.decodeAudioData(xhr.response, function(buffer) {
      source.buffer = buffer;
    
      var button = document.query("#play");
      button.disabled = false;
      button.on.click.add((e) {
        source.noteOn(0);
      });
    }, function() {
      print('Error decoding MP3 file');
    });
    
  });
  
  xhr.send();
  
  document.query("#volume").on.change.add((e) {
    var volume = Math.parseInt(e.target.value);
    var max = Math.parseInt(e.target.max);
    var fraction = volume / max;
    gainNode.gain.value = fraction * fraction;
  });

}