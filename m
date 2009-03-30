From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Mon, 30 Mar 2009 11:23:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0903301057140.4455@axis700.grange>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de>
 <49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de>
 <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de>
 <Pine.LNX.4.64.0903282207480.9903@axis700.grange> <20090330084655.GO7861@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090330084655.GO7861-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sascha

On Mon, 30 Mar 2009, Sascha Hauer wrote:

> Hi Guennadi,
> 
> On Sat, Mar 28, 2009 at 10:36:50PM +0100, Guennadi Liakhovetski wrote:
> > On Wed, 25 Mar 2009, Wolfram Sang wrote:
> > 
> > > > Because I hurry to submit this, because merge window is open.
> > 
> > Ok, I waited for this driver, I really did, and I really prefer having one 
> > driver for as many hardware (SoC) variants as possible instead of having 
> > different drivers, and I really hoped its new version will work 
> > out-of-the-box in my setup (pcm037 with a mt9t031 camera). Unfortunately, 
> > it didn't. I've spent more than a full working day trying to get it to 
> > work, but I didn't succeed so far. It works with the on-board rtc, but it 
> > doesn't work with the camera, connected over a flex cable.
> > 
> > Attached to this email is a version of the i2c driver for i.mx31 that I've 
> > been using with my setup for about half a year now.
> 
> Then why didn't you send this driver half a year ago??

I did, and you were on cc and even reviewed it:

http://marc.info/?t=122608095600001&r=1&w=2

but then came a reply from Darius, saying he had a driver for i.MX1 ready. 
I then tested his version and pointed out at problems I had on i.MX31, but 
they were not resolved until now...

> > I adjusted it slightly 
> > to accept the same platform data, so, it is really a drop-in replacement 
> > for i2c-imx.c. Of course, you have to adjust or extend the Makefile. I 
> > actually added a new Kconfig entry for this driver, so I could easily 
> > compare them during the tests.
> > 
> > The source of "my" version does look more logical and more clean to me on 
> > quite a few occasions. So, maybe someone could give it a quick spin on 
> > other *mx* SoCs and see if we can use this one instead? You might have to 
> > replace {read,write}w with readb and writeb, so, it might be a good idea 
> > to abstract them into inlines or macros. Otherwise, I think, it might work 
> > for other CPUs straight away.
> > 
> > I just would like to avoid committing a driver and having to spend hours 
> > or days fixing it afterwards when a possibly more mature version exists.
> 
> I just had a quick look over this driver, some comments inline. I think
> your driver has some pros, but given the fact that we are in the middle
> of the merge window and this driver is not ready for direct inclusion
> I'd say that you are simply too late.

The comments that you provided are all correct and easily fixable. Just 
one correction - this is not "my" driver, I am not personally attached to 
it:-) I just want a _good_ _solid_ well-written driver, that's it.

But the main advantage that I see in "my" version of Freescale's driver is 
its internal design. E.g., look at the i2c_imx_xfer() resp. mxc_i2c_xfer() 
functions at how they start a transfer. "my" version does the following:

enable the module
check bus busy, if busy - disable again and abort (multiple masters?)
set the master bit and - _wait_ until the bus becomes busy
then set the transmit bit

the imx version does

wait for not busy - _before_ enabling the controller!
enable the controller and set master and transmit _and_ the TXAK (!) 
	bits immediately...

Well, as I said, I am not personally attached to any of these drivers, so, 
it's up to maintainers to decide how to procede. I'll reply to Darius' 
previous mail shortly.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
