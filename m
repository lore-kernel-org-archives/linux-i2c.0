From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: RFC: I2C bus fault recovery and I2C reset
Date: Fri, 25 Nov 2011 11:27:44 +0100
Message-ID: <4ECF6DA0.5080006@gmx.de>
References: <20111124120207.3e78e34b@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111124120207.3e78e34b@archvile>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Jander <david.jander-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darius Augulis <darius.augulis-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am 24.11.2011 12:02, schrieb David Jander:
> 
> Hi all,
> 
> I was debugging an I2C bus connected to a i2c-imx peripheral as master, with
> several slaves connected to it, when I realized that this driver (and many
> (all?) others) cannot recover from a bus fault in a graceful manner.
> If, for instance, one slave device misses one (or more) clock pulses for
> whatever reason during a slave->master transmission (read), during a
> 0-data bit, this slave may eventually keep the SDA line active in low-state.
> Most I2C master peripherals, and particularly i2c-imx will not be able to
> continue operating. Any operation will just timeout with a "busy bus" error.
> The simplest and most often used way of recovering from such a situation is
> "resetting" the I2C bus, by toggling SCL a few times (maximum 9) until SDA is
> released again. After that a START sequence can successfully reset the state
> of any slave device.
> 
> One can argue whether it may or may not be accepted that this happens under
> normal circumstances, but it definitely can happen at any moment (heavy EMC
> interference, bad bus design, long bus, misbehaving slave... you name it), and
> IMHO a linux-driver should always have the ability to try to recover gracefully
> from such an event. Whether the system this bus takes part of can tolerate
> such a situation or not is not up to the driver to decide either... it should
> just try to recover.
> 
> This issue seems to have been discussed before in this thread:
> 
> http://article.gmane.org/gmane.linux.drivers.i2c/3010
> 
> The proposed solution back then was to issue a reset sequence "by hand" via a
> sysfs interface. This may be useful for debugging, but IMHO an I2C driver
> needs to do this automatically.

ACK

> For many peripherals in order to support this, a special function would be
> needed, that reconfigures the SDA/SCL pins as GPIO and manually toggles SCL a
> few times. This would probably need to be implemented in
> board-support-/platform code...?

Needs to be part of recover function which in turn is part of driver code.

> In my specific situation, there was no way of recovering other than
> power-cycling the device, which is completely unacceptable, specially for an
> industrial control system. A temporary bus-lockup with automatic recovery via a
> proper I2C bus reset OTOH, wouldn't have any significant impact even if
> occurring sporadically.
> Individually resetting I2C slaves is also not a real solution because it may
> not be possible to determine which is the I2C slave that misbehaved.

Most I2C slaves haven't got any reset line.

> Any idea on how to solve this problem?
> Should each driver implement support for it and implement optional callback
> functions in platform-data?

IMHO this typically is adapter driver's job. It strongly depends on
particular H/W whether controller can return information on busy/blocked
bus and whether it is able to manually toggle the clock line. On single
master systems, the driver code should automatically try to recover when
not being able to send start flag. On multi master systems the situation
is more complex.

JM2C
-- 
KR
Michael
