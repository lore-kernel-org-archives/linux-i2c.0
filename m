From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Tue, 7 Apr 2009 15:11:26 +0200
Message-ID: <20090407151126.276fec81@hyperion.delvare>
References: <49CB43E0.2050503@gmx.de>
	<49CCA82F.90106@gmx.de>
	<20090327134034.754908b5@hyperion.delvare>
	<49CCD0FC.9030500@gmx.de>
	<20090327145726.13c99aed@hyperion.delvare>
	<20090327150716.094666d1@hyperion.delvare>
	<49D4B14B.50405@gmx.de>
	<20090407121550.7d15bfae@hyperion.delvare>
	<49DB446A.2000705@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49DB446A.2000705-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Tue, 07 Apr 2009 14:17:46 +0200, Michael Lawnick wrote:
> Hi Jean,
> 
> although you are very busy, I hope you can spend a little more time.
> 
> Jean Delvare said the following:
> > Hi Michael,
> > 
> > Sorry for the late answer, I am pretty busy with the 2.6.30 merge
> > window.
> > 
> > ... The whole point of the sysfs entries you are adding is to let the
> > user instantiate I2C devices (at the device driver model level) for
> > physical devices which can _not_ be detected. 
> 
> I see, that's _your_ motivation.

Yes it is. Admittedly, the feature you are asking for is not one I
think a lot of people will be interested in, it seems pretty borderline
as far as the I2C standard is concerned, therefore I am trying to see
what other widely needed feature could be implemented, which would
incidentally cover your uncommon need.

> You want a user 'force' method.

[Nitpicking mode] Instantiate, not force. You're really only creating
a device, and then letting any interested driver bind to it if it feels
like it. Just like platform data can do on embedded platforms, except
that it comes from user-space.

But yes, there is no verification (or detection) step involved. The i2c
subsystem takes your word, assumes you know what you're doing, and
simply does what you asked for.

> > I hear you, "what about hot-plugged devices, they won't be detected"?
> > For one thing, these need to be behind a mux or gate, which we don't
> > support at the moment, so discussing this now doesn't make much sense.
> 
> No, sorry, here your are mistaken.
> IMHO you recognize only a part of the problem: Even if separation is
> done by a mux (what is not strictly necessary),

It is necessary. "Simple" hot-plug is a violation of the I2C standard.
You need a way to guarantee that no I2C traffic will be on-going when
the new device is connected, and for this you need at least an I2C gate
to isolate the bus segment in question from all masters on the bus.

>                                                 it will be powered by
> main system and its driver (i.e. adapters) loaded on boot. Still clients
> may come up when system is already initialized and auto detection on the
> sub buses has already completed.

This is where I am unclear. It might make sense to remove (in the
device driver model sense of the term) i2c segments which are being
modified, and restore them afterwards. That is, I2C segments hanging
off a mux would have 3 possible states, active, inactive and disabled.
The change from disabled to active or inactive would trigger device
detection, just as the mere addition of an i2c adapter currently does.

I don't think this is what Rodoflo did, but this would address your
problem as far as I can see.

> > But at any rate I don't think that the files you are adding in sysfs
> > are meant to address this particular issue.
> 
> Sorry, then you misunderstood me - it *is* this particular issue I need
> to solve.
> Please forget the thread about lm75a (vs. lm75), this was just a stone
> on my way to a new running kernel. It took it, made a remark and threw
> it aside. Nothing more. It is not related to the detect problem.
> 
> > If we want to be able to
> > re-trigger detection on a given I2C segment (which currently only
> > happens at I2C adapter creation time and when a new driver is
> > registered) this would be done by a separate sysfs entry (say "detect",
> > write 1 to re-trigger all detections on a given segment).
> 
> This solution will cause much useless traffic while the system is
> already running and doing other hard work :-(

Much useless traffic? It will cause way less traffic than when adding a
new i2c adapter (or bus segment) in the first place. All devices which
are already bound will be excluded from this detection round. This
should be most of them as I understand it. Most probably, only the
newly added device will receive I2C traffic.

Sure, we could extend the syntax so that you can ask for just one
address on one bus segment to be probed (maybe even by just one
driver). But what's the point? If you already know all this, then the
add_device sysfs interface is doing the job. And remember that the
device you just connected might not even be reliably detectable at all!

> > But really
> > I'd rather wait for Rodoflo's work to be merged first, depending on the
> > implementation there may or may not be a practical need for this.
> 
> AFAICS has Rodolfo's work nothing to do with the problem above, as on
> adapter creation an auto detection will (should) be triggered.

See my point above... The detection could happen at creation time _or_
at activation time. In the latter case Rodoflo's work becomes totally
relevant.

-- 
Jean Delvare
