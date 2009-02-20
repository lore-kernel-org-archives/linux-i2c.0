From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Fri, 20 Feb 2009 13:53:00 +0100
Message-ID: <20090220135300.353cd53a@hyperion.delvare>
References: <gngvea$eqj$1@ger.gmane.org>
	<20090218173645.GD3049@pengutronix.de>
	<gnjplc$hqd$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <gnjplc$hqd$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 19 Feb 2009 15:17:13 +0100, Michael Lawnick wrote:
> Wolfram Sang said the following:
> > Hi Michael,
> > 
> >> Can someone give me explanations/links/msg ids?
> > 
> > Documentation/i2c/upgrading-clients
> > 
> After re-reading it, I have to state that this document doesn't answer
> the questions behind my original ones (which I wanted to answer myself
> by following helpful links):
> From which kernel version on should the 'new-binding' model work?

It started in kernel 2.6.22. But there were significant changes later
in kernels 2.6.25 and 2.6.26.

> How is attaching of a hot plugged i2c device achieved a) from kernel b)
> from user space.

The I2C bus doesn't support hot-plugging, so I am not sure what you
mean?

> For kernel space init I assume its a call to i2c_new_device(). Here I'm
> wondering where I should get the adapter info from.

Depends. i2c_new_device() is suitable for TV adapters for example. For
embedded boards, you'd rather declare all I2C devices with
i2c_register_board_info() and use fixed I2C bus numbers.

> For user space I'm completely lost (ioctl on /dev/i2cx?).

User-space access through i2c-dev is entirely unchanged.

If you mean creating I2C devices from user-space, the interface for
this doesn't exist yet. I have a simple one in mind, but I can never
find the time to work on it :/

That being said, this can be worked around using the old
I2C_CLIENT_INSMOD macros. These let you pass module parameters forcing
clients at a specific address.

> Our situation: main board is up and running, all drivers loaded.
> Now an extension board will be plugged in. It is detected by
> periodically polling via I2C for MUX. After detection the drivers e.g.

This is totally unsupported. I2C isn't an hot-pluggable bus.

(Not to mention that support for mux chips is currently missing, but at
least this is being worked on and fixable.)

> for temperature an MUX on the secondary board need to be attached to I2C
> subsystem. Instances of both drivers are already running for local
> devices, re-loading is only a bad option.

You shouldn't have to reload any driver.

> Do I really have to read and understand i2c-core.c and i2c-dev.c to find
> out?

i2c-dev most probably doesn't have anything to do with your problem.

What you are missing, as far as I can see, is proper mux support.
Rodolfo Giometti (Cc'd) is working on this, if you want to test his
patches (which I still didn't have the time to look at, sadly.)

-- 
Jean Delvare
