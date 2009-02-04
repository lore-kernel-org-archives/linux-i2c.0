From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c,algo: cleanup i2c-algo-pcf.c
Date: Wed, 4 Feb 2009 09:34:02 +0100
Message-ID: <20090204093402.08ddb2e8@hyperion.delvare>
References: <4984688B.2090805@gmail.com>
	<20090201114121.6448a3c9@hyperion.delvare>
	<498760F7.6020005@gmail.com>
	<20090202225309.359e77d6@hyperion.delvare>
	<49883938.9010104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49883938.9010104-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 03 Feb 2009 13:31:52 +0100, Roel Kluin wrote:
> Jean Delvare wrote:
> > On Mon, 02 Feb 2009 22:09:11 +0100, Roel Kluin wrote:
> >> Also I noted that in wait_for_pin() on a timeout, dependent on the
> >> status, still a handle_lab(adap, status) and return -EINTR may occ=
ur,
> >> which I think are wrong.
> >=20
> > Depends on the hardware implementation. If I2C_PCF_LAB can be set w=
hile
> > I2C_PCF_PIN is set then indeed this is wrong. But I suspect the
> > hardware is such that I2C_PCF_LAB can't be set without I2C_PCF_PIN
> > being clear. You'd have to check the PCF8584 datasheet to make sure=
=2E
>=20
> Regardless of the hardware implementation, if there is a timeout, tha=
t
> is a reason to return -ETIMEDOUT, we can test later if not. That is t=
he
> sensible order in my opinion.

This can be argued the other way around just as well: if there is a
lost arbitration condition, it should be handled, regardless of the
timeout condition.

I you don't have a PCF8584-based adapter to test, and aren't going to
read the datasheet to see how the device is supposed to behave, and
have no proof that the current code is buggy, than please don't touch
it.

> (...)
> cleanup whitespace, fix comments and remove the unused STUB_I2C.
>=20
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

It seems you have been a bit overzealous. I now get the following
warning when building the i2c-algo-pcf driver:

drivers/i2c/algos/i2c-algo-pcf.c: In function =E2=80=98pcf_xfer=E2=80=99=
:
drivers/i2c/algos/i2c-algo-pcf.c:377: warning: suggest explicit braces =
to avoid ambiguous =E2=80=98else=E2=80=99
drivers/i2c/algos/i2c-algo-pcf.c:387: warning: suggest explicit braces =
to avoid ambiguous =E2=80=98else=E2=80=99

> @@ -313,24 +299,26 @@ static int pcf_doAddress(struct i2c_algo_pcf_da=
ta *adap,
>  	unsigned char addr;
> =20
>  	addr =3D msg->addr << 1;
> +
>  	if (flags & I2C_M_RD)
>  		addr |=3D 1;
>  	if (flags & I2C_M_REV_DIR_ADDR)
>  		addr ^=3D 1;
> +
>  	i2c_outb(adap, addr);
> =20
>  	return 0;
>  }

Not sure why you want to add blank lines there.

All the rest looks OK to me. Please fix at least the warnings and
resubmit.

--=20
Jean Delvare
