From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 11:59:36 +0200
Message-ID: <20090421115936.28656d09@hyperion.delvare>
References: <49ED6AD3.2060808@gmx.de>
	<49ED6F03.5050107@grandegger.com>
	<49ED9132.9050806@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49ED9132.9050806-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 21 Apr 2009 11:26:10 +0200, Michael Lawnick wrote:
> Wolfgang Grandegger said the following:
> > Hello,
> > 
> > sorry for jumping in late. I just recently subscribed to this list.
> > 
> > Michael Lawnick wrote:
> >> For MPC adapter there is no class assigned as it is done in other
> >> adapters. This way no new-style client will ever be instantiated. With
> >> this patch class assignment is read from device tree.
> >> Necessary entry:
> >> class = <1>; /* I2C_CLASS_HWMON (iic.h) */
> > 
> > Do we really need that? Probing is dangerous and not necessary. Does it
> > not work with a proper DTS entry? But maybe I have missed something?
> 
> Our current and our next system consists of two flavors of the same
> board with different devices. To minimize maintenance and testing we use
> a reduced kernel and load the needed modules at runtime. Furthermore we
> will have to handle hot-plugged I2C-devices. Whether this strategy is
> best could be discussed in another thread but is rather OT in this
> mailing list. Nevertheless loading modules at runtime is legal and
> generally supported by LINUX.

You apparently still have a hard time differentiating between devices
and drivers. Loading modules at runtime != instantiating devices at
runtime.

(And both can be done, but if you can't define your needs, we won't go
very far.)

> Defining all possible (I2C-)devices in DTS would give a mess. E.g. on
> one board there will be ~30 temperature sensors, on the other none.
> As every DTS entry will force a sysFs subdirectory there would be a
> bunch of functionless directories - rather ugly.

Why don't you define one DTS per board? I'm no embedded expert, but my
understanding is that this is what other developers/designers do.

> If probing of a device is dangerous, it can be defined in DTS anyway and
> the device driver can easily omit this part by early return.

This is correct.

> Because of the situation above I try to keep the ability of dynamic
> instantiation. Jean hesitates, I feel because he sees I2C solely in
> static manner.

Well there are 2 different issues here. First issue is relying on
probing when a DTS would do. Many developers have done that before, and
stopped doing it quickly, for a reason. We simply want to save you from
doing the same mistake.

Second issue is the warm-plugging of I2C devices. Linux doesn't support
this at this point, we are working on it (actually I am working on the
dependencies), but as long as support for basic multiplexing it isn't
there, there's little point in discussing more complex (dynamic)
schemes.

I had been explaining exactly this already, hadn't I?

-- 
Jean Delvare
