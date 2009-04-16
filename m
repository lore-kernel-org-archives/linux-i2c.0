From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Thu, 16 Apr 2009 15:55:55 +0200
Message-ID: <20090416155555.1c8c0a34@hyperion.delvare>
References: <49E6F4F9.3060705@gmx.de>
	<20090416092012.GB3052@pengutronix.de>
	<49E7101E.6070806@gmx.de>
	<20090416114701.GD3052@pengutronix.de>
	<49E7344C.2060704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E7344C.2060704-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 16 Apr 2009 15:36:12 +0200, Michael Lawnick wrote:
> Wolfram Sang said the following:
> >> Could you please elaborate?
> > 
> > Instead of probing you specify the devices on the i2c-bus in the dts. Example
> > for the pcm032 looks like this (from the kernel-tree):
> > 
> > i2c@3d40 {
> > 	#address-cells = <1>;
> > 	#size-cells = <0>;
> > 	compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> > 	reg = <0x3d40 0x40>;
> > 	interrupts = <2 16 0>;
> > 	fsl5200-clocking;
> > 
> > 	rtc@51 {
> > 		compatible = "nxp,pcf8563";
> > 		reg = <0x51>;
> > 	};
> > 	eeprom@52 {
> > 		compatible = "at24,24c32";
> > 		reg = <0x52>;
> > 	};
> > };
> > 
> > Boards which relied on probing need to have such child nodes added.
> 
> Ok, that doesn't help :-(
> I hoped you show me a way how to set the class of adapter. My clients
> are loaded with insmod, so dts has no effect (or is this wrong?)

No, you don't load "clients" with insmod. You load i2c device drivers
with insmod. This is in no way incompatible with what Wolfram is
suggesting. "Clients" (or i2c devices) can (and in general should)
exist independent of their driver being loaded or not.

> The current situation is:
> I can't see a method beside force to instantiate a client at runtime.

That's right, but why do you insist on instantiating them at runtime?

> But force bypasses clients detect method and is deprecated anyway if I
> got Jean right.

I confirm that the force module parameters are planed for removal
(although I can really call them deprecated in the absence of a
replacement at this time - I know there's a patch from you pending my
review.)

> Currently I'm lost. Jean NACKs all attempts to do detected client
> instantiations at runtime, you do a NACK on making adapter working
> properly by indicating to patches that have no more relevance.
> 
> Can't anybody help me?

The question is: why every other user of i2c-mpc is apparently able to
declare i2c devices through dts and you aren't?

-- 
Jean Delvare
