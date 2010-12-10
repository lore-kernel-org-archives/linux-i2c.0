From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver  
	   "i2c-gpio"
Date: Fri, 10 Dec 2010 16:21:43 +0100
Message-ID: <4D025397020000AA00008248@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <20101130182150.3bbc8f01@endymion.delvare>
 <4CF62AFD020000AA000080E3@center.bmk-electronics.de>
 <20101202172322.43ea4698@endymion.delvare>
 <4CFCB095020000AA00008187@center.bmk-electronics.de>
 <20101206112557.3dc8ffe3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101206112557.3dc8ffe3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Montag, 6. Dezember
2010 um 11:25
in Nachricht <20101206112557.3dc8ffe3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
> Hi Matthias,
>=20
> On Mon, 06 Dec 2010 09:44:53 +0100, Matthias Zacharias wrote:
>> > On Wed, 01 Dec 2010 11:01:17 +0100, Matthias Zacharias wrote:
>> >> I can provide the sources for the MLX90614 driver, but I think
it
>> >> is not a good ideea to attach it to this E-Mail.
>> >=20
>> > If the source code is publicly visible somewhere, you can point
us
>> > to that location. If not, maybe this is the right time to publish
>> > it ;) Or you can send it to me privately.
>>=20
>> Where is a good place to publish the MLX90614 driver?
>=20
> The lm-sensors list would be a good place, as indicated in section
> "HARDWARE MONITORING" of file MAINTAINERS in the kernel source tree.
If
> you intend to get this driver in the upstream kernel tree, you'll
have
> to post it there sooner or later anyway (even though the device is
more
> of a temperature sensor than an actual hardware monitoring chip.)
>=20
>> > BTW, it would be very interesting to see if you can get a
MLX90614
>> > chip to work with this driver on another system with a different
>> > I2C or SMBus master.
>> Hi, jean
>> Any suggestion how to do that? I don't know how to get other
hardware
>> which has an accessible SMBus to connect the MLX90614 directly.
>=20
> Some boards have SMBus pins accessible to connect external devices.
> Otherwise you need a soldering iron and basic electronics skills and
> equipment.
>=20
>> >> (...)
>> >> I access the eeprom as generic i2c device (file pointer to
i2c-0)
>> >> without usage of any specific driver.
>> >=20
>> > Which system calls and transaction types are you using?
>>=20
>> The MLX90614 uses now only the i2c_smbus_xfer(..) transaction to
read
>> from the SMBus. But I think the MLX90614 driver must be extended to
be
>> able to write configuration data (Word) on SMBus device as well.
>=20
> My question was related to your access to the EEPROM access, not the
> MLX90614. Besides, i2c_smbus_xfer() is a generic function for all
SMBus
> transaction types, so you didn't completely answer my question.
Which
> SMBus transaction types are you asking i2c_smbus_xfer() for?
>=20

Only read_word() with PEC and write_word()=20

>> > Did you try accessing the MLX90614 the same way?
>>=20
>> The MLX90614 is accessed as a hwmon device using the new device
model
>=20
> I know that. My question was, did you try an alternative way? For
> example you could use the i2cget command line tool (part of
i2c-tools)
> for user-space access. It would be interesting to see if it makes a
> difference.
>=20

I don't get the i2c-tools compiled for my armv5l platform. So can't try
to work with these tools. Do you know how to get the i2c-tools working
on an ARM9 microcontroller. I think it's a problem of setting the right
configuration.

>> > (...)
>> > Err. I thought there was a kernel function for that, but
apparently
>> > I was wrong. Well this could be done in asm but I don't think you
want
>> > to try that.
>> >=20
>> > Maybe you can do something with spin_lock_irqsave() and
>> > spin_unlock_irqrestore() around the critical sections, I'm not
sure.
>>=20
>> I have no experience with spin_lock's, don't know how to use them.
If
>> you have a good example please point me to it.
>=20
> I don't have any experience with spin locks either (at least none of
> the driver I wrote ever used one) but with over 4000 calls to this
> function throughout the kernel source tree, it shouldn't be
difficult
> to find an example you can follow.
>=20

>> > (...)
>> > When CONFIG_I2C_DEBUG_ALGO isn't set, bit_dbg() is a no-op so it
>> > certainly can't affect you in any way.
>> >=20
>> I don't know how the compiler do handle the bit_dbg() makro, but I
can
>> see the difference if the bit_dbg() call where included in the code
or
>> not,  also if  CONFIG_I2C_DEBUG_ALGO was not set.
>=20
> This is highl
y unlikely, unless you modified the driver source code.
> bit_dbg is defined with:
>=20
> #ifdef DEBUG
> #define bit_dbg(level, dev, format, args...) \
> 	do { \
> 		if (i2c_debug >=3D level) \
> 			dev_dbg(dev, format, ##args); \
> 	} while (0)
> #else
> #define bit_dbg(level, dev, format, args...) \
> 	do {} while (0)
> #endif /* DEBUG */
>=20
> And DEBUG is only set if CONFIG_I2C_DEBUG_ALGO=3Dy. So bit_dbg() is a
> no-op when CONFIG_I2C_DEBUG_ALGO isn't set.
>=20
> As a matter of fact, I just tried removing all calls to bit_dbg()
and
> i2c-algo-bit.o is unchanged, as I expected. So either you messed up
> your testing, or your compiler is seriously broken.
>=20
I'll do further tests to see what's going wrong.

>> > Question is whether the SCL line is stretched by the master or by
>> > the slave. Both are allowed to do it to a certain point.
>>
>> in the board settings I configure the SCL signal as output only to
>> avoid that SCL streching can be done by the SMBus slaves.
>=20
> Oh my! You shot yourself in the foot!
>=20
> How do you expect _slaves_ to change their behavior just because you
> said your I2C master to not pay attention to clock stretching? If
> slaves want to stretch the clock line, they will. The MLX90614
> datasheet isn't mentioning clock stretching, but that doesn't mean
the
> device is not doing exactly that.
>=20
> You really want a bidirectional SCL on the master side, otherwise
> reliability cannot be guaranteed. In fact, i2c-algo-bit with no SCL
read
> callback is not I2C-compliant. It's just a hack because sometimes we
> have no other way, but in real systems you really don't want to do
> that. Maybe I should make i2c-algo-bit complain when SCL read
callback
> is missing, to make it more obvious.
>=20
> So please fix this, set a proper callback for SCL read. This alone
> might fix your problem.
>=20
I remove the SCL Output only setting and as open drain line.

Then I take some screenshots with the I2C analyzer. using series
resistors on the SMBus I could visualize which of the devices connected
to the SMBus throws the SCL or the SDA. The higher logic-Low-level is
thrown by the SMBus slave and the lower from the SMBus-master. I drop
these screenshots on my Dropbox:
http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46

Where are the these callback functions located? In i2c-algo-bits,
i2c-core, or i2c-gpio?

>> > Does stretching happen on SCL high, or SCL low, or both?
>>
>> The streching occures on both levels at un predictable times.
>=20
> This would be on the master side then. Slaves can stretch the clock
> line by holding it down, but they can't prevent it from going down
if
> the master pulls it low, so they can't stretch the high part of the
> clock cycle.
>=20

>> > If the stretching is done by the master, then you may search for
>> > interrupt sources on your system. Maybe you have a misbehaving
>> > driver or device on your system which causes repeated and long
>> > interruptions. Making these interruptions shorter (e.g. by moving
>> > the real work to a workqueue) would then help.
>>
>> I have no ideea how to find a missbehaving driver, if any?
>=20
> This isn't trivial. You can try unloading each driver sequentially
and
> see if things get better when one driver is missing. You can also
check
> in /proc/interrupts if any value is increasing particularly fast, or
if
> you can find a correlation between SCL problems and a particular
> interrupt.
>=20
> Some kernel debug options might be helpful here, such as
> CONFIG_DETECT_SOFTLOCKUP and CONFIG_LATENCYTOP, and maybe others.
I'm
> not too familiar with this.

When printk output  is called and as well in the debug output
functions, the SCL signal is strechted until the output function has
finished to send data to the console on ttyS0.

best regards
Matthias
matthias.zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org


--------------------
BMK electronic solutions GmbH
Werner-von-Siemens-Str. 6, Eingang 18 f
D-86159 Augsburg
Tel. +49 (0) 821 / 207 88 - 700
=46ax +49 (0) 821=20
/ 207 88 - 721
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
