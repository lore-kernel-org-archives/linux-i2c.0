From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver  
	 "i2c-gpio"
Date: Mon, 06 Dec 2010 09:44:53 +0100
Message-ID: <4CFCB095020000AA00008187@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <20101130182150.3bbc8f01@endymion.delvare>
 <4CF62AFD020000AA000080E3@center.bmk-electronics.de>
 <20101202172322.43ea4698@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101202172322.43ea4698-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Donnerstag, 2.
Dezember 2010 um
17:23 in Nachricht <20101202172322.43ea4698-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>:
> Hi Matthias,
>=20
> On Wed, 01 Dec 2010 11:01:17 +0100, Matthias Zacharias wrote:
>> >>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> 30.11.2010 18:21 >>>
>> > It's difficult to answer here without seeing the source code of
the
>> > MLX90614 driver. What I can say is that values "near 0xFFFF" look
>> > like uncaught (negative) error codes carelessly cast to u16. So
you
>> > should ensure that your driver properly deals with errors
returned
>> > by the i2c layer (i2c_transfer and i2c_smbus_*). And if such
errors
>> > happen, you should print them so that you see what exactly is
going
>> > on and when.
>>=20
>> I can provide the sources for the MLX90614 driver, but I think it
is
>> not a good ideea to attach it to this E-Mail.
>=20
> If the source code is publicly visible somewhere, you can point us
to
> that location. If not, maybe this is the right time to publish it ;)
Or
> you can send it to me privately.

Where is a good place to publish the MLX90614 driver?
>=20
> BTW, it would be very interesting to see if you can get a MLX90614
chip
> to work with this driver on another system with a different I2C or
> SMBus master.

Any suggestion how to do that? I don't know how to get other hardware
which has an accessible SMBus to connect the MLX90614 directly.
>=20
>> > If the EEPROM works fine, it may depend on the transaction types.
I
>> > can't comment further because you didn't tell us which driver you
>> > were using (eeprom or at24). But it would be interesting to see
>> > which transactions fail, and if there is a pattern.
>>=20
>> I access the eeprom as generic i2c device (file pointer to i2c-0)
>> without usage of any specific driver.
>=20
> Which system calls and transaction types are you using?

The MLX90614 uses now only the i2c_smbus_xfer(..) transaction to read
from the SMBus. But I think the MLX90614 driver must be extended to be
able to write configuration data (Word) on SMBus device as well.

>=20
> Did you try accessing the MLX90614 the same way?

The MLX90614 is accessed as a hwmon device using the new device model
>=20
>> > Note that i2c-algo-bit is CPU-driven. It doesn't sleep, so it
>> > shouldn't be preempted by regular code, but nothing can be done
>> > against interrupts. I see that the MLX90614 has a very short
>> > timeout when SCL is high (45 to 55 us), so receiving an interrupt
>> > in this state could indeed be an issue. You may want to try
>> > disabling interrupts before raising SCL (except at the end of the
>> > transaction, of course) in i2c-algo-bit.
>>=20
>> Please give me an example how the disable interrupts as you
suggest.
>=20
> Err. I thought there was a kernel function for that, but apparently
I
> was wrong. Well this could be done in asm but I don't think you want
to
> try that.
>=20
> Maybe you can do something with spin_lock_irqsave() and
> spin_unlock_irqrestore() around the critical sections, I'm not sure.
>=20

I have no experience with spin_lock's, don't know how to use them. If
you have a good example please point me to it.

>> In the i2c-algo-bits there is used the "bit_dbg" makro to print
some
>> debug messages to ksys. Removing the makros wich where placed on
the
>> main execution line (not on for error messages) helps to get a
better
>> behavoir: SCL stretching occure on better reproducable
communication
>> times.
>=20
> Err, are you by any chance running a kernel built with
> CONFIG_I2C_DEBUG_ALGO=3Dy, and have set i2c_debug to 2 or more? This
> could explain your problems, at least in part. i2c-algo-bit is quite
> verbose in the kernel logs when debugging level is set to 2 or more,
> and writing the log to the disk is adding a lot of latency to the
> system.
>

Yes, I made some tests with CONFIG_I2C_DEBUG_ALGO=3Dy it it was a
disaster, notthing runs. I get only a bunch of errors but notthing
us
eful.

>=20
> Unfortunately this is one case where enabling debugging to better
> understand what is going on also affects what is going on. As you
have
> an external bus analyzer, it's better to not enable debugging in
> i2c-algo-bit, or at least not beyond level 1.
>=20
> When CONFIG_I2C_DEBUG_ALGO isn't set, bit_dbg() is a no-op so it
> certainly can't affect you in any way.
>=20
I don't know how the compiler do handle the bit_dbg() makro, but I can
see the difference if the bit_dbg() call where included in the code or
not,  also if  CONFIG_I2C_DEBUG_ALGO was not set.=20
>
>> > And, as Bill already underlined, you have to ensure that you're
>> > running the bus at the right frequency. The MLX90614 is an SMBus
>> > compliant device so it wants a clock between 10 and 100 kHz. This
>> > means a udelay value between 5 and 50.
>>=20
>> I checked the clock speed, It can be changed in the specified
limits
>> for MLX90614 with similar results in the data output.=20
>> Using an I2C analyzer I was able to see that SCL stretching occures
on
>> unpredictable times. If these SCL stretching is on specific point in
the
>> communication process or match the one of the SMbus timeout
conditions
>> (2 different timeout values) unpredictable data is output, with out
any
>> error from the I2C subsystem. Only the "i2c-adapter i2c-0:
sendbytes:
>> NAK bailout." message is correctly thrown.
>=20
> Question is whether the SCL line is stretched by the master or by
the
> slave. Both are allowed to do it to a certain point.
>=20
in the board settings I configure the SCL signal as output only to
avoid that SCL streching can be done by the SMBus slaves.
>
> Does stretching happen on SCL high, or SCL low, or both?
>=20
The streching occures on both levels at un predictable times
>
> If the stretching is done by the master, then you may search for
> interrupt sources on your system. Maybe you have a misbehaving
driver
> or device on your system which causes repeated and long
interruptions.
> Making these interruptions shorter (e.g. by moving the real work to
a
> workqueue) would then help.
>=20
I have no ideea how to find a missbehaving driver, if any?
>
>> I can provide screeshots which ilustrate the behavoir. How can I
make
>> these sceenshots available for you?
>=20
> Either put it on some publicly available web server if you have one
> at hand; or send them to me by mail privately.
>=20
I had an account @drop.io if it is still active I put the screenshots
there and point you that place.
>
>> > I presume Haavard left Atmel meanwhile. Not much we can do about
>> > that, except removing his address from the source tree (I will
>> > do.)
>> the last entry @vger.kernel.org was in 2007
>=20
> Not true. He posted until September 2010:
> http://marc.info/?l=3Dlinux-kernel&m=3D128498842805216&w=3D2=20
>=20
> Said post confirms that he left Atmel, BTW. Too bad he did not
remove
> or update his address in the tree at that time.

best regards
matthias

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
partly, is prohibited. Except in case of gross negli
gence or wilful
misconduct we accept no liability for any loss or damage caused by
software or e-mail viruses.
