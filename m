From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: RFC: I2C bus fault recovery and I2C reset
Date: Mon, 28 Nov 2011 10:51:59 +0100
Message-ID: <4ED359BF.3070409@gmx.de>
References: <20111124120207.3e78e34b@archvile> <4ECF6DA0.5080006@gmx.de> <20111128084811.5f57c8bf@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111128084811.5f57c8bf@archvile>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Jander <david.jander-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darius Augulis <darius.augulis-Ft0m5Q12RQ9xBelEqimL3w@public.gmane.org>, giometti-k2GhghHVRtY@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 28.11.2011 08:48, schrieb David Jander:
> 
> Hi Micheal,
> 
> On Fri, 25 Nov 2011 11:27:44 +0100
> Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wrote:
>> Am 24.11.2011 12:02, schrieb David Jander:
>>> For many peripherals in order to support this, a special function would be
>>> needed, that reconfigures the SDA/SCL pins as GPIO and manually toggles
>>> SCL a few times. This would probably need to be implemented in
>>> board-support-/platform code...?
>>
>> Needs to be part of recover function which in turn is part of driver code.
> 
> In the case of the i.MX I2C peripheral, and probably in the case of a few
> others, there is no way of doing this, except for switching I2C i/o pins to
> GPIO via the iomux and toggling the GPIO pin that corresponds to SCL "by
> hand", while watching the GPIO pin that corresponds to SDA.

So only one problem up to here: may the i2c adapter code have reserved
access to iomux? If its the only user -> move control into adpater
driver, reserve the H/W-access and you are done. If not, then you have a
shared device -> make a driver for iomux registers that serializes
access, possibly with reservation functions, export them and reference
from adapter code.

>>> In my specific situation, there was no way of recovering other than
>>> power-cycling the device, which is completely unacceptable, specially for
>>> an industrial control system. A temporary bus-lockup with automatic
>>> recovery via a proper I2C bus reset OTOH, wouldn't have any significant
>>> impact even if occurring sporadically.
>>> Individually resetting I2C slaves is also not a real solution because it
>>> may not be possible to determine which is the I2C slave that misbehaved.
>>
>> Most I2C slaves haven't got any reset line.
> 
> Even worse.... that means the bus will never come back, even if you reset the
> machine!!! Only a power-cycle would save you.
> 
Correct.

>>> Any idea on how to solve this problem?
>>> Should each driver implement support for it and implement optional callback
>>> functions in platform-data?
>>
>> IMHO this typically is adapter driver's job. It strongly depends on
>> particular H/W whether controller can return information on busy/blocked
>> bus and whether it is able to manually toggle the clock line. On single
>> master systems, the driver code should automatically try to recover when
>> not being able to send start flag. On multi master systems the situation
>> is more complex.
> 
> I agree. There might be a few platforms where there is no solution to this,
> other than hardwiring a separate GPIO line to SCL...

or by wiring Vcc of unresetable I2C devices to a controllable on-board
power supply/relays.

-- 
KR
Michael
