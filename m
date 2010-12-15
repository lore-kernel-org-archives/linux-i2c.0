From: "Matthias Zacharias" <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Subject: Antw: Re: Need help to fix some issues with the linux driver  
	 "i2c-gpio"
Date: Wed, 15 Dec 2010 13:46:26 +0100
Message-ID: <4D08C6B2020000AA0000835E@center.bmk-electronics.de>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
 <20101130182150.3bbc8f01@endymion.delvare>
 <4CF62AFD020000AA000080E3@center.bmk-electronics.de>
 <20101202172322.43ea4698@endymion.delvare>
 <4CFCB095020000AA00008187@center.bmk-electronics.de>
 <20101206112557.3dc8ffe3@endymion.delvare>
 <4D025397020000AA00008248@center.bmk-electronics.de>
 <20101211172336.35c434ef@endymion.delvare>
 <4D0789C5020000AA00008346@center.bmk-electronics.de>
 <20101214175828.0a62ce3f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101214175828.0a62ce3f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Thank you for the new patch.
I tried it and it works fine for our system with i2c_debug < 2. For
i2c_debug >=3D2 the debug outputs leads to timeout condition when addre=
ss
should be acknowledged.

I'll try to publish the "mlx90614" driver after doing some
optimizations. Are you interested to review this driver before, because
it is the first driver we try to publish?

Do plan to include your patch on the "i2c-algo-bit" into the lastest
kernel?
I had applied the patch and done my tests on the 2.6.25.4 kernel, with
a bunch of other patches needed for my system.=20

Thanks a lot for your fast and good support for fixing this issue we
had.

Best regards
Matthias Zacharias
matthias.zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org


>>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> schrieb am Dienstag, 14. Dezember
2010 um
17:58 in Nachricht <20101214175828.0a62ce3f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>:
> Hi Matthias,
>=20
> On Tue, 14 Dec 2010 15:14:13 +0100, Matthias Zacharias wrote:
>> Thanks for your patch. It is working very well.=20
>> But one problem is left:
>>     see "101214_1058_MLX_I2C_patched_0001.bmp" in my dropbox
>> (http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46=
)
>>=20
>> If between the read command (0x5a.0x6) and the answer (0x5a <3x
>> data_bytes) the timeout condition:  SCL =3D High for 43=C2=B5s match=
, the
>> MLX90614 go thru reset and returns an invalid value (0xFFFF).
>>=20
>> Where can I place the call for "spin_lock_irqsave" and
>> "spin_unlock_irqrestore" to block this timeout situation.
>=20
> Ah, I forgot the repeated start condition. The following updated
patch
> fixes this. I have also changed the code to no longer call scllo()
when
> the spinlock is held. That way we can release the spinlock (and thus
> enable interrupts again) faster, which lowers the system latency.
>=20
> So please give a try to this new patch, and report.
>=20
> * * * * *
>=20
> Candidate fix for SCL getting stretched when high resulting in
> slave timeouts.
>=20
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c |   33
+++++++++++++++++++++++++++++----
>  include/linux/i2c-algo-bit.h     |    3 +++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>=20
> ---
linux-2.6.27.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-12-14
17:34:48.000000000=20
> +0100
> +++ linux-2.6.27/drivers/i2c/algos/i2c-algo-bit.c	2010-12-14
17:34:50.000000000=20
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
> @@ -131,12 +132,17 @@ static void i2c_start(struct i2c_algo_bi
> =20
>  static void i2c_repstart(struct i2c_algo_bit_data *adap)
>  {
> +	unsigned long flags;
> +
>  	/* assert: scl is low */
>  	sdahi(adap);
> +	spin_lock_irqsave(&adap->lockscl, flags);
>  	sclhi(adap);
>  	setsda(adap, 0);
>  	udelay(adap->udelay);
> -	scllo(adap);
> +	setscl(adap, 0);
> +	spin_unlock_irqrestore(&adap->lockscl, flags);
> +	udelay(adap->udelay / 2);
>  }
> =20
> =20
> @@ -164,15 +170,18 @@ static int i2c_outb(struct i2c_adapter *
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
> @@ -181,12 +190,16 @@ static int i2c_outb(struct i2c_adapter *
>  		 * Report a unique code, so higher level code can retry
>  		 * the whole (combined) message and *NOT* issue STOP.
>  		 */
> -		scllo(adap);
> +		setscl(adap, 0);
> +	=09
spin_unlock_irqrestore(&adap->lockscl, flags);
> +		udelay(adap->udelay / 2);
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
> @@ -197,7 +210,9 @@ static int i2c_outb(struct i2c_adapter *
>  	bit_dbg(2, &i2c_adap->dev, "i2c_outb: 0x%02x %s\n", (int)c,
>  		ack ? "A" : "NA");
> =20
> -	scllo(adap);
> +	setscl(adap, 0);
> +	spin_unlock_irqrestore(&adap->lockscl, flags);
> +	udelay(adap->udelay / 2);
>  	return ack;
>  	/* assert: scl is low (sda undef) */
>  }
> @@ -210,19 +225,23 @@ static int i2c_inb(struct i2c_adapter *i
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
> +			spin_unlock_irqrestore(&adap->lockscl, flags);
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
> @@ -385,16 +404,21 @@ static int sendbytes(struct i2c_adapter=20
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
> -	scllo(adap);
> +	setscl(adap, 0);
> +	spin_unlock_irqrestore(&adap->lockscl, flags);
> +	udelay(adap->udelay / 2);
>  	return 0;
>  }
> =20
> @@ -603,6 +627,7 @@ static int i2c_bit_prepare_bus(struct i2
>  	}
> =20
>  	/* register new adapter to i2c module... */
> +	spin_lock_init(&bit_adap->lockscl);
>  	adap->algo =3D &i2c_bit_algo;
> =20
>  	adap->timeout =3D 100;	/* default values, should	*/
> --- linux-2.6.27.orig/include/linux/i2c-algo-bit.h	2010-12-14
17:34:49.000000000=20
> +0100
> +++ linux-2.6.27/include/linux/i2c-algo-bit.h	2010-12-14
17:35:30.000000000 +0100
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

This e-mail may contain confidential
 information. If you received this
e-mail in error, please contact the sender and delete this e-mail from
your computer, including your mailservers. Any dissemination, even
partly, is prohibited. Except in case of gross negligence or wilful
misconduct we accept no liability for any loss or damage caused by
software or e-mail viruses.
