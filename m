From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Tue, 07 Apr 2009 14:17:46 +0200
Message-ID: <49DB446A.2000705@gmx.de>
References: <49CB43E0.2050503@gmx.de>	<49CCA82F.90106@gmx.de>	<20090327134034.754908b5@hyperion.delvare>	<49CCD0FC.9030500@gmx.de>	<20090327145726.13c99aed@hyperion.delvare>	<20090327150716.094666d1@hyperion.delvare>	<49D4B14B.50405@gmx.de> <20090407121550.7d15bfae@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090407121550.7d15bfae-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

although you are very busy, I hope you can spend a little more time.

Jean Delvare said the following:
> Hi Michael,
> 
> Sorry for the late answer, I am pretty busy with the 2.6.30 merge
> window.
> 
> ... The whole point of the sysfs entries you are adding is to let the
> user instantiate I2C devices (at the device driver model level) for
> physical devices which can _not_ be detected. 

I see, that's _your_ motivation. You want a user 'force' method.

...
> I hear you, "what about hot-plugged devices, they won't be detected"?
> For one thing, these need to be behind a mux or gate, which we don't
> support at the moment, so discussing this now doesn't make much sense.

No, sorry, here your are mistaken.
IMHO you recognize only a part of the problem: Even if separation is
done by a mux (what is not strictly necessary), it will be powered by
main system and its driver (i.e. adapters) loaded on boot. Still clients
may come up when system is already initialized and auto detection on the
sub buses has already completed.

> But at any rate I don't think that the files you are adding in sysfs
> are meant to address this particular issue.

Sorry, then you misunderstood me - it *is* this particular issue I need
to solve.
Please forget the thread about lm75a (vs. lm75), this was just a stone
on my way to a new running kernel. It took it, made a remark and threw
it aside. Nothing more. It is not related to the detect problem.

> If we want to be able to
> re-trigger detection on a given I2C segment (which currently only
> happens at I2C adapter creation time and when a new driver is
> registered) this would be done by a separate sysfs entry (say "detect",
> write 1 to re-trigger all detections on a given segment).

This solution will cause much useless traffic while the system is
already running and doing other hard work :-(

> But really
> I'd rather wait for Rodoflo's work to be merged first, depending on the
> implementation there may or may not be a practical need for this.

AFAICS has Rodolfo's work nothing to do with the problem above, as on
adapter creation an auto detection will (should) be triggered.

-- 
Michael Lawnick
