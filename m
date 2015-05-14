From: "Stevens, Nick" <Nick.Stevens-i7dp0qKlBMg@public.gmane.org>
Subject: i2c bus driver for FTDI MPSSE
Date: Thu, 14 May 2015 19:44:29 +0000
Message-ID: <20150514194351.GA10672@nick.stevens-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Content-ID: <4D949BA34FA0ED468C54C8CEEE844A2D-i7dp0qKlBMg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Recently I've been working on I2C device drivers for a number of devices
on an embedded platform (specifically the Microchip line of A2Ds), and
I'm planning to submit patches with my changes. However, my development
is on an older system running Linux 3.10, and I'd really like to test my
drivers with a more recent kernel. Getting a PC running a recent kernel
release is straightforward, but I've found that there aren't a lot of
great options for pluggable I2C busses on the PC (the USB Tiny is about
the only one).

That leads to my question - FTDI makes a number of USB interface chips
with their Multi-Protocol Synchronous Serial Engine (MPSSE) component,
which supports I2C. Kernel support for using the MPSSE as an I2C bus
seems like it would provide a really convenient way to test I2C drivers
on a PC, especially since the FTDI chips are easily available in
multiple form factors from multiple vendors.  Has anyone explored this?
Are there obvious obstacles that I'm not thinking of? Would this be
useful to anyone else?

Thanks!
Nick--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
