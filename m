From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help to fix some issues with the linux driver "i2c-gpio"
Date: Tue, 30 Nov 2010 18:21:50 +0100
Message-ID: <20101130182150.3bbc8f01@endymion.delvare>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CF4DF5E020000AA0000808F-PZWwcLLCDcw8dQ1qNLwSjGRXbTvXh2ZWs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Matthias,

On Tue, 30 Nov 2010 11:26:22 +0100, Matthias Zacharias wrote:
> ** High Priority **

There is no such thing here. People on this list reply to help requests
on their free time. This is best effort, with zero guarantee.

> we have to use the linux driver "i2c-gpio" because the "i2c-at91" is
> marked as "BROKEN" and for our application it can as well not be used.
> 
> Here a brief description of the application:
> 
> AT91SAM9261 based embedded system running kernel 2.6.25.4, with Atmel
> and our own BSP patches. This system uses both SPI interfaces, one USART
> (for console),  MMC, Sound on SPI and SSC, digital poti for contrast
> control and the an chip Frambuffer for a monochrome LCD (QVGA).
> 
> On the TWI interface are attached: 
>     the AT24C04 SMB EEPROM,   (@ 0x50)
>     two LM84 Temperature sensors  (@ 0x18, 0x19)
>     and the Infrared temperature sensor MLX90614 manfactured by
> MELEXIS. (@ 0x5A)
> Note: The LM84 sensors are not yet operated by the linux kernel.
> 
> Now the description of the issue we have with the I2C subsystem:
> 
> 1. the EEPROM is working fine with "i2c-at91" and the "i2c-gpio"
> modules

So at least the i2c-gpio driver isn't totally broken on your hardware.

> 2. for IR-Sensor MLX90614, a hwmon class linux driver was implemented
> by Linutronix on our demand. This driver works fine but delivers
> sporadic the error message "i2c-adapter i2c-0: sendbytes: NAK bailout." 
> (this message is thrown by the  "i2c-algo-bit" driver), or invalid
> temperature values ( near 0xFFFF). The invalid temperature values and as
> well the error message appear as reponse on bus timeout situations which
> are not correctly handled by the linux driver. This we find out using a
> I2C analyzer. In our opinion these issues come while the i2c
> communication is disturbed by other tasks and/or interrupt service
> routines (ISR) which extend the SMB clock over the permitted timeouts,
> leaving the IR-Sensor in an undefined or erroneous state.

It's difficult to answer here without seeing the source code of the
MLX90614 driver. What I can say is that values "near 0xFFFF" look like
uncaught (negative) error codes carelessly cast to u16. So you should
ensure that your driver properly deals with errors returned by the i2c
layer (i2c_transfer and i2c_smbus_*). And if such errors happen, you
should print them so that you see what exactly is going on and when.

If the EEPROM works fine, it may depend on the transaction types. I
can't comment further because you didn't tell us which driver you were
using (eeprom or at24). But it would be interesting to see which
transactions fail, and if there is a pattern.

For your investigation, you may be interested in backporting (the
i2c-algo-bit-part of) the following patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=97140342e69d479a3ad82bfd4c154c0b08fe3eea

If you hit unexpected timeout conditions, you may want to try again
after backporting this fix:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0cdba07bb23cdd3e0d64357ec3d983e6b75e541f

More generally, you may want to change the timeout value and see if it
helps - although the default of 100 ms seem reasonable to me.

Note that i2c-algo-bit is CPU-driven. It doesn't sleep, so it shouldn't
be preempted by regular code, but nothing can be done against
interrupts. I see that the MLX90614 has a very short timeout when SCL
is high (45 to 55 us), so receiving an interrupt in this state could
indeed be an issue. You may want to try disabling interrupts before
raising SCL (except at the end of the transaction, of course) in
i2c-algo-bit.

And, as Bill already underlined, you have to ensure that you're running
the bus at the right frequency. The MLX90614 is an SMBus compliant
device so it wants a clock between 10 and 100 kHz. This means a udelay
value between 5 and 50.

> The address mentioned in the driver source "Haavard Skinnemoen
> <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>" invalid (unknown)

I presume Haavard left Atmel meanwhile. Not much we can do about that,
except removing his address from the source tree (I will do.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
