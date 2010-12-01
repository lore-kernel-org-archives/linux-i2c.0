From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver
	 "i2c-gpio"
Date: Wed, 01 Dec 2010 11:01:17 +0100
Message-ID: <4CF62AFD020000AA000080E3@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <20101130182150.3bbc8f01@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101130182150.3bbc8f01-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,
=20
thank you for the fast reply.
=20
See further comments in your reply:

>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> 30.11.2010 18:21 >>>
Hi Matthias,

On Tue, 30 Nov 2010 11:26:22 +0100, Matthias Zacharias wrote:
>> ** High Priority **

> There is no such thing here. People on this list reply to help
requests
> on their free time. This is best effort, with zero guarantee.
=20
Ok, I know this, and am happy for getting your response  so quickly.

>> we have to use the linux driver "i2c-gpio" because the "i2c-at91"
is
>> marked as "BROKEN" and for our application it can as well not be
used.
>>=20
>> Here a brief description of the application:
>>=20
>> AT91SAM9261 based embedded system running kernel 2.6.25.4, with
Atmel
>> and our own BSP patches. This system uses both SPI interfaces, one
USART
>> (for console),  MMC, Sound on SPI and SSC, digital poti for
contrast
>> control and the an chip Frambuffer for a monochrome LCD (QVGA).
>>=20
>> On the TWI interface are attached:=20
>>     the AT24C04 SMB EEPROM,   (@ 0x50)
>>     two LM84 Temperature sensors  (@ 0x18, 0x19)
>>     and the Infrared temperature sensor MLX90614 manfactured by
>> MELEXIS. (@ 0x5A)
>> Note: The LM84 sensors are not yet operated by the linux kernel.
>>=20
>> Now the description of the issue we have with the I2C subsystem:
>>=20
>> 1. the EEPROM is working fine with "i2c-at91" and the "i2c-gpio"
>> modules

> So at least the i2c-gpio driver isn't totally broken on your
hardware.
=20
No it works, but with unpredictable results in the data output
(measured temperature)

>> 2. for IR-Sensor MLX90614, a hwmon class linux driver was
implemented
>> by Linutronix on our demand. This driver works fine but delivers
>> sporadic the error message "i2c-adapter i2c-0: sendbytes: NAK
bailout."=20
>> (this message is thrown by the  "i2c-algo-bit" driver), or invalid
>> temperature values ( near 0xFFFF). The invalid temperature values
and as
>> well the error message appear as reponse on bus timeout situations
which
>> are not correctly handled by the linux driver. This we find out
using a
>> I2C analyzer. In our opinion these issues come while the i2c
>> communication is disturbed by other tasks and/or interrupt service
>> routines (ISR) which extend the SMB clock over the permitted
timeouts,
>> leaving the IR-Sensor in an undefined or erroneous state.

> It's difficult to answer here without seeing the source code of the
> MLX90614 driver. What I can say is that values "near 0xFFFF" look
like
> uncaught (negative) error codes carelessly cast to u16. So you
should
> ensure that your driver properly deals with errors returned by the
i2c
> layer (i2c_transfer and i2c_smbus_*). And if such errors happen, you
> should print them so that you see what exactly is going on and when.

I can provide the sources for the MLX90614 driver, but I think it is
not a good ideea to attach it to this E-Mail.

> If the EEPROM works fine, it may depend on the transaction types. I
> can't comment further because you didn't tell us which driver you
were
> using (eeprom or at24). But it would be interesting to see which
> transactions fail, and if there is a pattern.

I access the eeprom as generic i2c device (file pointer to i2c-0)
without usage of any specific driver.

> For your investigation, you may be interested in backporting (the
> i2c-algo-bit-part of) the following patch:
>
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D97140342e69d479a3ad82bfd4c154c0b08fe3eea


> If you hit unexpected timeout conditions, you may want to try again
> after backporting this fix:
>
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D0cdba07bb23cdd3e0d64357ec3d983e6b75e541f


At first I'll try the suggested patches.

> More generally, you may want to change the timeout value and see if
it
> helps - although the default of 100 ms seem reasonable to me.
=20
changing the timeout value has no=20
visible effect on the systems
behavoir.

> Note that i2c-algo-bit is CPU-driven. It doesn't sleep, so it
shouldn't
> be preempted by regular code, but nothing can be done against
> interrupts. I see that the MLX90614 has a very short timeout when
SCL
> is high (45 to 55 us), so receiving an interrupt in this state could
> indeed be an issue. You may want to try disabling interrupts before
> raising SCL (except at the end of the transaction, of course) in
> i2c-algo-bit.

Please give me an example how the disable interrupts as you suggest.
In the i2c-algo-bits there is used the "bit_dbg" makro to print some
debug messages to ksys. Removing the makros wich where placed on the
main execution line (not on for error messages) helps to get a better
behavoir: SCL stretching occure on better reproducable communication
times.

> And, as Bill already underlined, you have to ensure that you're
running
> the bus at the right frequency. The MLX90614 is an SMBus compliant
> device so it wants a clock between 10 and 100 kHz. This means a
udelay
> value between 5 and 50.

I checked the clock speed, It can be changed in the specified limits
for MLX90614 with similar results in the data output.=20
Using an I2C analyzer I was able to see that SCL stretching occures on
unpredictable times. If these SCL stretching is on specific point in th=
e
communication process or match the one of the SMbus timeout conditions
(2 different timeout values) unpredictable data is output, with out any
error from the I2C subsystem. Only the "i2c-adapter i2c-0: sendbytes:
NAK bailout." message is correctly thrown.

I can provide screeshots which ilustrate the behavoir. How can I make
these sceenshots available for you?

>> The address mentioned in the driver source "Haavard Skinnemoen
>> <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>" invalid (unknown)

> I presume Haavard left Atmel meanwhile. Not much we can do about
that,
> except removing his address from the source tree (I will do.)
the last entry @vger.kernel.org was in 2007
--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html=20

best regards
Matthias Zacharias
matthias.zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org=20


=20


--------------------
BMK electronic solutions GmbH
Werner-von-Siemens-Str. 6, Eingang 18 f
D-86159 Augsburg
Tel. +49 (0) 821 / 207 88 - 700
=46ax +49 (0) 821 / 207 88 - 721
info-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org
Gesch=C3=A4ftsf=C3=BChrer: Dipl.-oec. Alois Kn=C3=B6ferle
Sitz: Augsburg
HR-Nr.: B21197
---------------------

Diese E-mail kann vertrauliche Informationen enthalten. Falls Sie diese
E-Mail irrt=C3=BCmlich erhalten haben, informieren Sie bitte unverz=C3=BC=
glich den
Absender und l=C3=B6schen Sie diese E-Mail von jedem Rechner, auch von =
den
Mailservern. Jede Verbreitung des Inhalts, auch die teilweise
Verbreitung, ist in diesem Fall untersagt. Au=C3=9Fer bei Vorsatz oder =
grober
=46ahrl=C3=A4ssigkeit schliessen wir jegliche Haftung f=C3=BCr Verluste=
 oder Sch=C3=A4den
aus, die durch Viren befallene Software oder E-Mails verursacht werden.

This e-mail may contain confidential information. If you received this
e-mail in error, please contact the sender and delete this e-mail from
your computer, including your mailservers. Any dissemination, even
partly, is prohibited. Except in case of gross negligence or wilful
misconduct we accept no liability for any loss or damage caused by
software or e-mail viruses.
