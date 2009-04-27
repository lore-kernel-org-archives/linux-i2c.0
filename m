From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Mon, 27 Apr 2009 12:17:58 +0200
Message-ID: <20090427121758.7965c48a@hyperion.delvare>
References: <49ED6AD3.2060808@gmx.de>
	<49ED6F03.5050107@grandegger.com>
	<49ED9132.9050806@gmx.de>
	<20090421095112.GB3100@pengutronix.de>
	<49EDC487.8010201@gmx.de>
	<20090424085256.GA26169@pengutronix.de>
	<49F19A11.3090700@gmx.de>
	<9e4733910904240838k5f425d7m849cd6b7fad19f27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910904240838k5f425d7m849cd6b7fad19f27-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Fri, 24 Apr 2009 11:38:04 -0400, Jon Smirl wrote:
> You're stuck because i2c hardware does not support hotplug. Since the
> hardware doesn't support hotplug there's no software support for it in
> the kernel. So you want to fall back to polled probing.
> 
> But probing is bad because it isn't standardized and coordinated, one
> device's probe can cause another device to destroy things (like set a
> voltage too high on a motherboard). Because of this probing can't be
> turned on in general.
> 
> It's possible to get to the i2c bus from user space. You could write a
> user space app that polls in your controlled environment. When you
> detect the new devices you can load the appropriate modules. Now you
> need to instantiate these new devices.
> 
> Jean, is it still possible to instantiate i2c devices from the module
> command line?

It is still possible if the driver implements the .detect() callback
(even without any address being probed by default) and uses one of the
I2C_CLIENT_INSMOD* macros. However, these macros are planned for
removal. Their replacement is the sysfs entries I have been discussing
with Michael in the past few weeks and for which he sent a patch for me
to review. This is still on my todo list, but I am very busy these
days :(

-- 
Jean Delvare
