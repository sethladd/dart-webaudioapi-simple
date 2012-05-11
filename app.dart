#import('dart:html');

main() {

  AudioContext audioContext = new AudioContext();
  AudioGainNode gainNode = audioContext.createGainNode();

  XMLHttpRequest xhr = new XMLHttpRequest();
  xhr.open("GET", "button-3.mp3", true);
  xhr.responseType = "arraybuffer";
  xhr.on.load.add((e) {

    // asynchronous decoding
    audioContext.decodeAudioData(xhr.response, (buffer) {
      
      playSound() {
        AudioBufferSourceNode source = audioContext.createBufferSource();
        source.connect(gainNode, 0, 0);
        gainNode.connect(audioContext.destination, 0, 0);
        source.buffer = buffer;
        source.noteOn(0);
      }
    
      var button = document.query("#play");
      button.disabled = false;
      button.on.click.add((_) {
        playSound();
      });
    }, (error) {
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