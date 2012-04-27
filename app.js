if (typeof AudioContext == "function") {
	var audioContext = new AudioContext();
} else if (typeof webkitAudioContext == "function") {
	var audioContext = new webkitAudioContext();
}

var source = audioContext.createBufferSource();
source.connect(audioContext.destination);

var xhr = new XMLHttpRequest();
xhr.open("GET", "techno.mp3", true);
xhr.responseType = "arraybuffer";
xhr.onload = function() {
	var buffer = audioContext.createBuffer(xhr.response, false);
	source.buffer = buffer;
	source.noteOn(0);
};
xhr.send();