From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver
	 "i2c-gpio"
Date: Tue, 14 Dec 2010 15:14:13 +0100
Message-ID: <4D0789C5020000AA00008346@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <20101130182150.3bbc8f01@endymion.delvare>
 <4CF62AFD020000AA000080E3@center.bmk-electronics.de>
 <20101202172322.43ea4698@endymion.delvare>
 <4CFCB095020000AA00008187@center.bmk-electronics.de>
 <20101206112557.3dc8ffe3@endymion.delvare>
 <4D025397020000AA00008248@center.bmk-electronics.de>
 <20101211172336.35c434ef@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101211172336.35c434ef-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Samstag, 11. Dezember
2010 um
17:23 in Nachricht <20101211172336.35c434ef-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>:
> Hi Matthias,
>=20
> On Fri, 10 Dec 2010 16:21:43 +0100, Matthias Zacharias wrote:
>> Hi Jean,
>>=20
>> >>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Montag, 6.
Dezember
>> 2010 um 11:25 in Nachricht
<20101206112557.3dc8ffe3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
>> > I know that. My question was, did you try an alternative way? For
>> > example you could use the i2cget command line tool (part of
>> > i2c-tools) for user-space access. It would be interesting to see
if
>> > it makes a difference.
>>=20
>> I don't get the i2c-tools compiled for my armv5l platform. So can't
try
>> to work with these tools. Do you know how to get the i2c-tools
working
>> on an ARM9 microcontroller.
>=20
> How do you expect me to help you here? You did not provide any hint
at
> what is failing. I don't have any ARM platform at hand.
>=20
>> I think it's a problem of setting the right configuration.
>=20
> "Setting the right configuration" is awfully vague. What do you
mean?
> If you have trouble building i2c-tools, please start a new
discussion
> thread for that with all the details and I'll look into it.
>=20
I'll start a new thread for compiling the i2c-tools on ARM platforms

>> > You really want a bidirectional SCL on the master side, otherwise
>> > reliability cannot be guaranteed. In fact, i2c-algo-bit with no
SCL
>> > read callback is not I2C-compliant. It's just a hack because
>> > sometimes we have no other way, but in real systems you really
don't
>> > want to do that. Maybe I should make i2c-algo-bit complain when
SCL
>> > read callback is missing, to make it more obvious.
>> >=20
>> > So please fix this, set a proper callback for SCL read. This
alone
>> > might fix your problem.
>>
>> I remove the SCL Output only setting and as open drain line.
>=20
> Good.
>=20
>> Then I take some screenshots with the I2C analyzer. using series
>> resistors on the SMBus I could visualize which of the devices
connected
>> to the SMBus throws the SCL or the SDA. The higher logic-Low-level
is
>> thrown by the SMBus slave and the lower from the SMBus-master.
>=20
> My electronics knowledge is fairly limited, I didn't even know this
was
> possible. So I(ll trust you ;)
>=20
>> I drop these screenshots on my Dropbox:
>> http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46=20
>=20
> Interesting. I see that you included both traces from the MLX90614
and
> traces from the EEPROM, and both exhibit the problem. This, and the
fact
> that the clock line can be stuck both high and low, clearly points
at
> the master.
>=20
> If EEPROM access still works fine, this is probably because the
EEPROM
> is more tolerant to clock stalls.
>=20
> If I read the screenshots correctly, the problem only happens when
SCL
> stalls high, not low, and only for the MLX90614, right?
>=20
> This would match the timeouts documented in the MLX90614 datasheet:
> only 50 =C2=B5s when SCL is high. This matches the SMBus specificatio=
n,
BTW,
> while I2C doesn't have any such timeout.
>=20
>> Where are the these callback functions located? In i2c-algo-bits,
>> i2c-core, or i2c-gpio?
>=20
> Your code (user-space or kernel driver) calls into i2c-core, which
> calls i2c-algo-bit. The functions in i2c-algo-bit ultimately call
into
> i2c-gpio, which forwards the requests directly to the low-level GPIO
> code.
>=20
> Such timing problems can't be caused by i2c-core, which is way too
high
> level. i2c-gpio is only a middle man between the software
bit-banging
> logic (i2c-algo-bit) and the physical level (gpio), so I doubt
anything
> can be wrong there. If something is actually wrong in i2c-gpio, it
> would be in the initial setup (i2c_gpio_probe), not the callbacks. I
> definitely hope that you already double-checked that the setup data
for
> i2c-gpio is correct (including pdata->sda_is_open_drain and
> pdata->scl_is_op
en_drain).
>=20
> So the suspects are i2c-algo-bit and the low-level GPIO code.
>=20
> For i2c-algo-bit, as I already said, the known issue is that the bus
is
> software-driven, and the code driving the bus can be preempted by an
> interrupt. I already suggested that you should check what interrupts
> are happening on your system during the I2C transfers.
>=20
> The low-level GPIO code is suspect too. i2c-algo-bit assumes that
> setting SDA or SCL is very fast, and reading them too. If any of the
> callbacks takes a significant amount of time, then the timing
> assumptions made by i2c-algo-bit will tear apart. Unfortunately I am
not
> familiar with GPIOs, and I have no idea how to accurately measure
how
> long the GPIO callbacks last.
>=20
> Actually, what I see on your analyzer screenshots could be caused by
> either of these two problems.
>=20
>> (...)
>> When printk output  is called and as well in the debug output
>> functions, the SCL signal is strechted until the output function
has
>> finished to send data to the console on ttyS0.
>=20
> This is correct. But in your case, the problem happens even without
> printk being ever called, right? So that's not the problem.
>=20
> Here is a patch I came up with, which I would like you to try. It
blocks
> interrupts while SCL is high. Please use your I2C analyzer again
with
> this patch applied. What I expect is that you will still see
stretched
> clocks, but only when SCL is low. The timeout of the MLX90614 is
much
> higher when SCL is low, so I hope that the clock stretching will be
> properly handled this time and the MLX90614 will work fine.
>=20
> ---
>  drivers/i2c/algos/i2c-algo-bit.c |   17 +++++++++++++++++
>  include/linux/i2c-algo-bit.h     |    3 +++
>  2 files changed, 20 insertions(+)
>=20
> ---
linux-2.6.27.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-12-11
16:09:18.000000000=20
> +0100
> +++ linux-2.6.27/drivers/i2c/algos/i2c-algo-bit.c	2010-12-11
16:52:30.000000000=20
> +0100
> @@ -30,6 +30,7 @@
>  #include <linux/sched.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> +#include <linux/spinlock.h>
> =20
> =20
>  /* ----- global defines
----------------------------------------------- */
> @@ -164,15 +165,18 @@ static int i2c_outb(struct i2c_adapter *
>  	int sb;
>  	int ack;
>  	struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data;
> +	unsigned long flags;
> =20
>  	/* assert: scl is low */
>  	for (i =3D 7; i >=3D 0; i--) {
>  		sb =3D (c >> i) & 1;
>  		setsda(adap, sb);
>  		udelay((adap->udelay + 1) / 2);
> +		spin_lock_irqsave(&adap->lockscl, flags);
>  		if (sclhi(adap) < 0) { /* timed out */
>  			bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
>  				"timeout at bit #%d\n", (int)c, i);
> +			spin_unlock_irqrestore(&adap->lockscl, flags);
>  			return -ETIMEDOUT;
>  		}
>  		/* FIXME do arbitration here:
> @@ -182,11 +186,14 @@ static int i2c_outb(struct i2c_adapter *
>  		 * the whole (combined) message and *NOT* issue STOP.
>  		 */
>  		scllo(adap);
> +		spin_unlock_irqrestore(&adap->lockscl, flags);
>  	}
>  	sdahi(adap);
> +	spin_lock_irqsave(&adap->lockscl, flags);
>  	if (sclhi(adap) < 0) { /* timeout */
>  		bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
>  			"timeout at ack\n", (int)c);
> +		spin_unlock_irqrestore(&adap->lockscl, flags);
>  		return -ETIMEDOUT;
>  	}
> =20
> @@ -198,6 +205,7 @@ static int i2c_outb(struct i2c_adapter *
>  		ack ? "A" : "NA");
> =20
>  	scllo(adap);
> +	spin_unlock_irqrestore(&adap->lockscl, flags);
>  	return ack;
>  	/* assert: scl is low (sda undef) */
>  }
> @@ -210,19 +218,23 @@ static int i2c_inb(struct i2c_adapter *i
>  	int i;
>  	unsigned char indata =3D 0;
>  	struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data;
> +	unsigned long flags;
> =20
>  	/* assert: scl is low */
>  	sdahi(adap);
>  	for (i =3D 0; i < 8; i++) {
> +		spin_lock_irqsave(&adap->lockscl, flags);
>  		if (sclhi(adap) < 0) { /* timeout */
>  			bit_dbg(1, &i2c_adap->dev, "i2c_inb: timeout at
bit "
>  				"#%d\n", 7 - i);
> +			spin_unlock_irqr
estore(&adap->lockscl, flags);
>  			return -ETIMEDOUT;
>  		}
>  		indata *=3D 2;
>  		if (getsda(adap))
>  			indata |=3D 0x01;
>  		setscl(adap, 0);
> +		spin_unlock_irqrestore(&adap->lockscl, flags);
>  		udelay(i =3D=3D 7 ? adap->udelay / 2 : adap->udelay);
>  	}
>  	/* assert: scl is low */
> @@ -385,16 +397,20 @@ static int sendbytes(struct i2c_adapter=20
>  static int acknak(struct i2c_adapter *i2c_adap, int is_ack)
>  {
>  	struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data;
> +	unsigned long flags;
> =20
>  	/* assert: sda is high */
>  	if (is_ack)		/* send ack */
>  		setsda(adap, 0);
>  	udelay((adap->udelay + 1) / 2);
> +	spin_lock_irqsave(&adap->lockscl, flags);
>  	if (sclhi(adap) < 0) {	/* timeout */
>  		dev_err(&i2c_adap->dev, "readbytes: ack/nak
timeout\n");
> +		spin_unlock_irqrestore(&adap->lockscl, flags);
>  		return -ETIMEDOUT;
>  	}
>  	scllo(adap);
> +	spin_unlock_irqrestore(&adap->lockscl, flags);
>  	return 0;
>  }
> =20
> @@ -603,6 +619,7 @@ static int i2c_bit_prepare_bus(struct i2
>  	}
> =20
>  	/* register new adapter to i2c module... */
> +	spin_lock_init(&bit_adap->lockscl);
>  	adap->algo =3D &i2c_bit_algo;
> =20
>  	adap->timeout =3D 100;	/* default values, should	*/
> --- linux-2.6.27.orig/include/linux/i2c-algo-bit.h	2008-04-17
04:49:44.000000000=20
> +0200
> +++ linux-2.6.27/include/linux/i2c-algo-bit.h	2010-12-11
16:53:22.000000000 +0100
> @@ -24,6 +24,8 @@
>  #ifndef _LINUX_I2C_ALGO_BIT_H
>  #define _LINUX_I2C_ALGO_BIT_H
> =20
> +#include <linux/spinlock.h>
> +
>  /* --- Defines for bit-adapters
---------------------------------------	*/
>  /*
>   * This struct contains the hw-dependent functions of bit-style
adapters to
> @@ -36,6 +38,7 @@ struct i2c_algo_bit_data {
>  	void (*setscl) (void *data, int state);
>  	int  (*getsda) (void *data);
>  	int  (*getscl) (void *data);
> +	spinlock_t lockscl;
> =20
>  	/* local settings */
>  	int udelay;		/* half clock cycle time in us,

Thanks for your patch. It is working very well.=20
But one problem is left:
    see "101214_1058_MLX_I2C_patched_0001.bmp" in my dropbox
(http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46)

If between the read command (0x5a.0x6) and the answer (0x5a <3x
data_bytes) the timeout condition:  SCL =3D High for 43=C2=B5s match, t=
he
MLX90614 go thru reset and returns an invalid value (0xFFFF).

Where can I place the call for "spin_lock_irqsave" and
"spin_unlock_irqrestore" to block this timeout situation.

best regards
Matthias Zacharias


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
