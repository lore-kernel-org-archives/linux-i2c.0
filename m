From: Robert Norris <robn-4vTceeIZeJ0AvxtiuMwx3w@public.gmane.org>
Subject: Re: PROBLEM: modprobe hang at startup (3.8.x, 3.9.x, IBM x3550)
Date: Thu, 16 May 2013 13:44:55 +1000
Message-ID: <20130516034455.GA19452@pyro.melbourne.osa>
References: <1368408152.29197.140661229821177.2C1CC406@webmail.messagingengine.com>
 <20130514231626.GA12961@pyro.melbourne.osa>
 <20130515112044.753bb7bb@endymion.delvare>
 <20130515112741.GA23766@pyro.melbourne.osa>
 <20130515214923.036dabdb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130515214923.036dabdb-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 15, 2013 at 09:49:23PM +0200, Jean Delvare wrote:
> >     Interrupt: pin B routed to IRQ 0
> 
> Hmm, this "IRQ 0" is quite odd. I'm wondering if this could be the
> reason for this hang. Was it with the i2c-i801 driver loaded, or
> blacklisted? Please check if it makes a difference.

That was without the driver loaded (blacklisted). After loading (with
interrupts enabled) we get:

    Interrupt: pin B routed to IRQ 20

> Do you see the same (and more generally, this issue) on one, some or
> all of your x3550 servers?

The issue has occured on at least three x3550s (we have 11). I haven't
tested more, because knowingly crashing production machines sucks.

This appears to be the case on other machines. With the module
blacklisted (never loaded), lspci shows IRQ 0. After load, IRQ 20.
(tested on 3.4 and 3.9).

> Are you using IPMI on these machines?

Yes, but only for monitoring/sensors, if that makes a difference.

> I would appreciate if you could test the following:
> * Blacklist i2c-i801 and ics932s401 so that none of them get
>   auto-loaded.

Done.

> * Manually load i2c-i801 with interrupts enabled, and see what
>   happens.

Returned immediately:

[   60.527140] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt

> * If no hang happens, load i2c-dev, find the i801 bus number with
>   i2cdetect -l (from the i2c-tools package - it should be 4 according
>   to what you reported so far but there is no guarantee that it won't
>   change across reboots.)

$ i2cdetect -l
i2c-0   i2c         Radeon i2c bit bus DVI_DDC          I2C adapter
i2c-1   i2c         Radeon i2c bit bus VGA_DDC          I2C adapter
i2c-2   i2c         Radeon i2c bit bus MONID            I2C adapter
i2c-3   i2c         Radeon i2c bit bus CRT2_DDC         I2C adapter
i2c-4   smbus       SMBus I801 adapter at 0440          SMBus adapter

> Then do a simple read from a random address
>   with:
>   # i2cget 4 0x50 0x00
>   (Adjust the bus number as needed.)
>   I am curious if this will hang as well or only when accessing the
>   clock chip at address 0x69.

Yep, that one hangs. The hung task handler picked it up after a few
minutes.

Cheers,
Rob.
