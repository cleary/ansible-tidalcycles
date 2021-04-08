// https://github.com/v7b1/mi-UGens

(
  SynthDef(\braids, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,timbre=0.5,color=0.5,model=0|
    var envLength = sustain*(end-begin)/speed;
    var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
    var env = Env.asr;
    var volume = IEnvGen.ar(env, line);
    var sig;

    freq = max(0, freq * speed * (1 + (accelerate * line)));
    sig = MiBraids.ar(pitch: freq.cpsmidi, timbre: timbre, color: color, model: model);

    Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
  }).add;
);

(
  SynthDef(\omi, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0|
    var envLength = sustain*(end-begin)/speed;
    var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
    var env = Env.asr;
    var volume = IEnvGen.ar(env, line);
    var sig;

    freq = max(0, freq * speed * (1 + (accelerate * line)));
    sig = MiOmi.ar(pit: freq.cpsmidi);

    Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
  }).add;
);

(
  SynthDef(\plaits, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,
      timbre=0.5,engine=0,harm=0.5,morph=0.5,level=1,lpgdecay=0,lpgcolour=0|
    var envLength = sustain*(end-begin)/speed;
    var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
    var env = Env.asr;
    var volume = IEnvGen.ar(env, line);
    var sig;

    freq = max(0, freq * speed * (1 + (accelerate * line)));
    sig = MiPlaits.ar(
      pitch: freq.cpsmidi,
      timbre: timbre,
      harm: harm,
      engine: engine,
      morph: morph,
      level: level,
      decay: lpgdecay,
      lpg_colour: lpgcolour,
    );

    Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
  }).add;
);

(
  SynthDef(\tides, {|out=0,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,tidesshape=0.5,slope=0.5,tidessmooth=0.5,shift=0.5,mode=2|
    var envLength = sustain*(end-begin)/speed;
    var line = Line.ar(begin, end, envLength, doneAction: Done.freeSelf);
    var env = Env.asr;
    var volume = IEnvGen.ar(env, line);
    var sig;

    freq = max(0, freq * speed * (1 + (accelerate * line)));
    sig = MiTides.ar(
      freq: freq,
      shape: tidesshape,
      slope: slope,
      smooth: tidessmooth,
      shift: shift,
      output_mode: mode,
      ramp_mode: 1,
      rate: 1
    );

    Out.ar(out, DirtPan.ar(sig * volume, ~dirt.numChannels, pan));
  }).add;
);

(
~dirt.addModule('elements', { |dirtEvent|
	dirtEvent.sendSynth('elements' ++ ~dirt.numChannels,
		[
      elementspitch: ~elementspitch,
      elementsstrength: ~elementsstrength,
      elementscontour: ~elementscontour,
      elementsbowlevel: ~elementsbowlevel,
      elementsblowlevel: ~elementsblowlevel,
      elementsstrikelevel: ~elementsstrikelevel,
      elementsflow: ~elementsflow,
      elementsmallet: ~elementsmallet,
      elementsbowtimb: ~elementsbowtimb,
      elementsblowtimb: ~elementsblowtimb,
      elementsstriketimb: ~elementsstriketimb,
      elementsgeom: ~elementsgeom,
      elementsbright: ~elementsbright,
      elementsdamp: ~elementsdamp,
      elementspos: ~elementspos,
      elementsspace: ~elementsspace,
      elementsmodel: ~elementsmodel,
      elementseasteregg: ~elementseasteregg,
			out: ~out
		]
	)
}, {~elementsstrength.notNil});
);

(
  SynthDef("elements" ++ ~dirt.numChannels, {|out,freq=440,sustain=1,pan=0,begin=0,end=1,speed=1,accelerate=0,
      elementspitch=48, elementsstrength=0.5, elementscontour=0.2, elementsbowlevel=0,elementsblowlevel=0, elementsstrikelevel=0,
      elementsflow=0.5, elementsmallet=0.5, elementsbowtimb=0.5, elementsblowtimb=0.5,
      elementsstriketimb=0.5, elementsgeom=0.25, elementsbright=0.5, elementsdamp=0.7, elementspos=0.2, elementsspace=0.3, elementsmodel=0,
      elementseasteregg=0|
    var signal = In.ar(out, ~dirt.numChannels);
    ReplaceOut.ar(out, MiElements.ar(
      blow_in: signal,
      strike_in: signal,
      gate: 1,
      pit: elementspitch,
      strength: elementsstrength,
      contour: elementscontour,
      bow_level: elementsbowlevel,
      blow_level: elementsblowlevel,
      strike_level: elementsstrikelevel,
      flow: elementsflow,
      mallet: elementsmallet,
      bow_timb: elementsbowtimb,
      blow_timb: elementsblowtimb,
      strike_timb: elementsstriketimb,
      geom: elementsgeom,
      bright: elementsbright,
      damp: elementsdamp,
      pos: elementspos,
      space: elementsspace,
      model: elementsmodel,
      easteregg: elementseasteregg
    ));
  }).add;
);

(
~dirt.addModule('mu', { |dirtEvent|
	dirtEvent.sendSynth('mu' ++ ~dirt.numChannels,
		[ mu: ~mu, out: ~out ]
	)
}, {~mu.notNil});
);

(
  SynthDef("mu" ++ ~dirt.numChannels, {|out,mu=0|
    var signal = In.ar(out, ~dirt.numChannels);
    ReplaceOut.ar(out, MiMu.ar(signal, mu));
  }).add;
);

(
~dirt.addModule('rings', { |dirtEvent|
	dirtEvent.sendSynth('rings' ++ ~dirt.numChannels,
		[
			ringstrig: ~ringstrig,
			ringsfreq: ~ringsfreq,
			ringsstruct: ~ringsstruct,
			ringsbright: ~ringsbright,
			ringsdamp: ~ringsdamp,
			ringspos: ~ringspos,
			ringsmodel: ~ringsmodel,
			ringspoly: ~ringspoly,
			ringsinternal: ~ringsinternal,
			ringseasteregg: ~ringseasteregg,
			out: ~out
		]
	)
}, {~ringsbright.notNil});
);

(
SynthDef("rings" ++ ~dirt.numChannels, { |out, ringsfreq=440,ringsstruct=0,ringsbright=0,ringsdamp=0.5,ringspos=0,ringsmodel=0,ringspoly=0,ringsinternal=0,ringseasteregg=0,ringsbypass=0|
	var signal = In.ar(out, ~dirt.numChannels);
	signal = MiRings.ar(
    signal,
    trig: ringsinternal,
    pit: ringsfreq.cpsmidi,
    struct: ringsstruct,
    bright: ringsbright,
    damp: ringsdamp,
    pos: ringspos,
    model: ringsmodel,
    poly: ringspoly,
    intern_exciter: ringsinternal,
    easteregg: ringseasteregg
  );
  ReplaceOut.ar(out, signal)
}).add;

);

(
~dirt.addModule('ripples', { |dirtEvent|
	dirtEvent.sendSynth('ripples' ++ ~dirt.numChannels,
		[
			ripplescf: ~ripplescf,
			ripplesreson: ~ripplesreson,
			ripplesdrive: ~ripplesdrive,
			out: ~out
		]
	)
}, {~ripplescf.notNil});
);

(
SynthDef("ripples" ++ ~dirt.numChannels, { |out, ripplescf=0, ripplesreson=0, ripplesdrive=1|
	var signal = In.ar(out, ~dirt.numChannels);
	signal = MiRipples.ar(
    signal,
    cf: ripplescf,
    reson: ripplesreson,
    drive: ripplesdrive,
  );
  ReplaceOut.ar(out, signal)
}).add;

);


(
~dirt.addModule('warps', { |dirtEvent|
	dirtEvent.sendSynth('warps' ++ ~dirt.numChannels,
		[
			warpsalgo: ~warpsalgo,
			warpstimb: ~warpstimb,
			warpsosc: ~warpsosc,
			warpsfreq: ~warpsfreq,
			warpsvgain: ~warpsvgain,
			warpseasteregg: ~warpseasteregg,
			out: ~out
		]
	)
}, {~warpsalgo.notNil});
);

(
SynthDef("warps" ++ ~dirt.numChannels, { |out, warpsalgo=0, warpstimb=0, warpsosc=1, warpsfreq=440, warpsvgain=1, warpseasteregg=0|
	var signal = In.ar(out, ~dirt.numChannels);
	signal = MiWarps.ar(
    modulator: signal,
    algo: warpsalgo,
    lev1: 1,
    lev2: 1,
    timb: warpstimb,
    osc: warpsosc,
    freq: warpsfreq,
    vgain: warpsvgain,
    easteregg: warpseasteregg
  );
  ReplaceOut.ar(out, signal)
}).add;

);

(

(1..SuperDirt.maxSampleNumChannels).do { |numChannels|

  SynthDef("global_mi_verb" ++ numChannels, { |dryBus, effectBus, verbwet=0, verbtime=0, verbdamp=0, verbhp=0, verbfreeze=0, verbdiff=0.625, verbgain=0|
    var signal = In.ar(dryBus, ~dirt.numChannels);
    Out.ar(effectBus, MiVerb.ar(
      signal,
      verbtime,
      verbwet,
      verbdamp,
      verbhp,
      verbfreeze,
      verbdiff
    ) * verbgain);
  }, [\ir, \ir]).add;

  SynthDef("global_mi_clouds" ++ numChannels, { |dryBus, effectBus, cloudspitch=0, cloudspos=0, cloudssize=0, cloudsdens=0, cloudstex=0, cloudswet=0, cloudsgain=0, cloudsspread=0, cloudsrvb=0, cloudsfb=0, cloudsfreeze=0, cloudsmode=0, cloudslofi=0|
    var signal = In.ar(dryBus, ~dirt.numChannels);
    Out.ar(effectBus, MiClouds.ar(
      inputArray: signal,
      pit: cloudspitch,
      pos: cloudspos,
      size: cloudssize,
      dens: cloudsdens,
      tex: cloudstex,
      drywet: cloudswet,
      in_gain: cloudsgain,
      spread: cloudsspread,
      rvb: cloudsrvb,
      fb: cloudsfb,
      freeze: cloudsfreeze,
      mode: cloudsmode,
      lofi: cloudslofi
    ));
  }, [\ir, \ir]).add;
};

);
