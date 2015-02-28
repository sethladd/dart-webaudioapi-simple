// Copyright (c) 2015, Seth Ladd. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:web_audio';

main() async {

  var audioContext = new AudioContext();
  var gainNode = audioContext.createGain();
  HttpRequest req;

  // await statements can be wrapped in try/catch blocks

  try {
    req = await HttpRequest.request('ding.mp3', responseType: 'arraybuffer');
  } catch (e) {
    print('error getting mp3');
    return;
  }

  var audioBuffer = await audioContext.decodeAudioData(req.response);

  var button = querySelector('#play') as ButtonElement
    ..disabled = false
    ..onClick.listen((_) {
        var source = audioContext.createBufferSource();
        source.buffer = audioBuffer;
        source.connectNode(gainNode, 0, 0);
        gainNode.connectNode(audioContext.destination, 0, 0);
        source.start(0);
      });

  querySelector('#volume').onChange.listen((e) {
  	var volume = int.parse(e.target.value);
    var max = int.parse(e.target.max);
    var fraction = volume / max;
    gainNode.gain.value = fraction * fraction;
  });
}
