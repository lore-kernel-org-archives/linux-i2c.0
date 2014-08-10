From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ddc/ci over i2c
Date: Sun, 10 Aug 2014 21:13:59 +0200
Message-ID: <20140810211359.5235156f@endymion.delvare>
References: <53BBC97B.5020805@minsoft.com>
	<20140709002017.4c2b332e@endymion.delvare>
	<53BD6E61.8070101@minsoft.com>
	<20140728125248.5bbc0f89@endymion.delvare>
	<53E6902B.9000104@minsoft.com>
	<20140810110528.1b5a825f@endymion.delvare>
	<53E74487.8020809@minsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E74487.8020809-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 10 Aug 2014 03:08:07 -0700, Sanford Rockowitz wrote:
> On 08/10/2014 02:05 AM, Jean Delvare wrote:
> > I suggest that you verify that the master properly handles clock
> > stretching (to give the slave the opportunity to slow down the
> > transfer.) Or simply lower the DDC bus clock speed and see if it helps.
>
> I'm using write() and read() on /dev/i2c-n to communicate with the 
> monitor.  Is there some way to control clock stretching or DDC bus clock 
> speed from userspace?

No, it is handled by the I2C bus driver in the kernel (or i2c-algo-bit
for bit-banged buses which rely on it.) I2C bus controllers and drivers
should always handle clock stretching as it is a fundamental part of
the specification, that's not something you need to be able to switch
on and off.

> I just built a custom kernel (first time in years), with the following 
> lines in config-local:
> 
> CONFIG_I2C_DEBUG_CORE=y
> CONFIG_I2C_DEBUG_BUS=y
> CONFIG_I2C_DEBUG_ALGO=y
> 
> I was puzzling over why I wasn't seeing any output in /var/log/messages 
> when your email came in.  I would have thought I'd  be overwhelmed by 
> output.

Not all code hot paths are verbose in debug mode, most likely you're
only walking paths where no debugging takes place. Also note that
CONFIG_I2C_DEBUG_BUS only affects drivers under drivers/i2c/busses and
drivers/i2c/muxes, so I'm certain it has no effect for anything
DDC-related.

>  But when communicating with the P2411H, I do see repeated lines 
> of the form:
> 
> Aug 10 02:55:34 banner kernel: [ 5006.692794] i2c i2c-0: sendbytes: NAK 
> bailout.

That one comes from i2c-algo-bit, so your driver is using software
bit-banging, which can be unreliable if the system is under stress. The
message above is an error message, not a debug message. A "NAK" from a
slave in the middle of a write means that somehow the slave did not
like what it received. It could be that the data was out of the
expected range, or too long, inconsistent, bad CRC, whatever. But of
course it could come from some data corruption on the bus, causing the
display to receive something different from what you sent.

-- 
Jean Delvare
SUSE L3 Support
