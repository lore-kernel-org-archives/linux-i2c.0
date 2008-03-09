From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Monitor's EDID not recognised
Date: Sun, 9 Mar 2008 15:45:10 +0100
Message-ID: <20080309154510.118194a0@hyperion.delvare>
References: <200803071923.32035.jeremy.william.murphy@gmail.com>
	<200803080039.55332.jeremy.william.murphy@gmail.com>
	<20080307150827.0cfa9b5c@hyperion.delvare>
	<200803091708.21053.jeremy.william.murphy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200803091708.21053.jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jeremy Murphy <jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 9 Mar 2008 17:08:20 +1100, Jeremy Murphy wrote:
> On Sat, 8 Mar 2008 01:08:27 am Jean Delvare wrote:
> >
> > BTW, note that you should NOT access the nvidia I2C buses created by
> > the binary nvidia X11 driver while not under X.
> 
> OK, thanks.  I did look for them outside of X, but they weren't there.

Err, that's exactly what I said. With the binary nvidia X11 driver, you
must be in the X session when trying to access the I2C buses, otherwise
it doesn't work.

> > * Get rid of the binary nvidia driver for a moment, and try the
> > nvidiafb driver. If it gets better, it suggests that the binary nvidia
> > driver is at fault. If you get the same noise, it has to be a hardware
> > issue.
> 
> There are no nVidia I2C buses visible with the nvidiafb driver, i2cdetect 
> reports only the SMBus.

Strange. Do you have i2c-algo-bit's option bit_test enabled by any
chance? "/sbin/modprobe -c | grep i2c.algo.bit" should tell.

> Here's a snippet from the X log, though:
> 
> (II) Loading sub module "i2c"
> (II) LoadModule: "i2c"(II) Module already built-in
> (II) Loading sub module "ddc"
> (II) LoadModule: "ddc"(II) Module already built-in
> (II) NV(0): I2C bus "DDC" initialized.
> (II) NV(0): Probing for analog device on output A...
> (--) NV(0):   ...found one
> (II) NV(0): Probing for analog device on output B...
> (--) NV(0):   ...can't find one
> (II) NV(0): Probing for EDID on I2C bus A...
> (II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
> (II) NV(0): I2C device "DDC:ddc2" removed.
> (II) NV(0):   ... none found
> (II) NV(0): Probing for EDID on I2C bus B...
> (II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
> (II) NV(0): I2C device "DDC:ddc2" removed.
> (II) NV(0):   ... none found
> (--) NV(0): CRTC 0 appears to have a CRT attached
> (II) NV(0): Using CRT on CRTC 0
> 
> Address 0xA0?  Should that be 0x50?

0xA0 == 0x50 << 1. I2C addresses are 7-bit values, but sometimes
software or documentation shifts them by one bit to the left because
that's how they go on the wire.

The important thing in the log above is that the nv X driver doesn't
see any EDID EEPROM either.

> > * Did you try another video cable? The I2C bus signal is carried over 2
> > dedicated pins on the VGA connector (12 and 15), if your cable happens
> > to not have them wired properly for some reason, this could explain
> > your problem.  
> 
> OK, I'll have to ask around for one.  Thanks for your help.

If you have another computer at hand which is known to retrieve the
EDID properly, you might also try swapping the monitors. This would
tell you right away whether the graphics adapter (or its driver), the
VGA cable, or the monitor itself is responsible for the problem.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
