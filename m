From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-bit: Add pre- and post-xfer hooks
Date: Sat, 13 Mar 2010 11:52:06 -0500
Message-ID: <a728f9f91003130852x2640fa44l6da686d01a43e7e7@mail.gmail.com>
References: <20100313174757.4a9f40d7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100313174757.4a9f40d7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 13, 2010 at 11:47 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wro=
te:
> Drivers might have to do random things before and/or after I2C
> transfers. Add hooks to the i2c-algo-bit implementation to let them d=
o
> so.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
> ---
> Alex, compared to the first version I sent, I have removed the second
> parameter of the hooks. You did not use it, I'm not really sure why
> anybody would, and if one really needs the private data, it can be
> reached from the i2c_adapter struct itself. So I'd rather start simpl=
e,
> and add parameters only if a clear need appears over time. You'll hav=
e
> to update your patch to the radeon driver accordingly.

No problem.  I'll update my radeon patches next week.

Alex

>
> Michael, I seem to recall you wanted something like that a couple yea=
rs
> ago?
>
> =A0drivers/i2c/algos/i2c-algo-bit.c | =A0 =A09 +++++++++
> =A0include/linux/i2c-algo-bit.h =A0 =A0 | =A0 =A02 ++
> =A02 files changed, 11 insertions(+)
>
> --- linux-2.6.34-rc1.orig/drivers/i2c/algos/i2c-algo-bit.c =A0 =A0 =A0=
2010-03-13 16:26:30.000000000 +0100
> +++ linux-2.6.34-rc1/drivers/i2c/algos/i2c-algo-bit.c =A0 2010-03-13 =
16:41:05.000000000 +0100
> @@ -522,6 +522,12 @@ static int bit_xfer(struct i2c_adapter *
> =A0 =A0 =A0 =A0int i, ret;
> =A0 =A0 =A0 =A0unsigned short nak_ok;
>
> + =A0 =A0 =A0 if (adap->pre_xfer) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D adap->pre_xfer(i2c_adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0bit_dbg(3, &i2c_adap->dev, "emitting start condition\n=
");
> =A0 =A0 =A0 =A0i2c_start(adap);
> =A0 =A0 =A0 =A0for (i =3D 0; i < num; i++) {
> @@ -570,6 +576,9 @@ static int bit_xfer(struct i2c_adapter *
> =A0bailout:
> =A0 =A0 =A0 =A0bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n"=
);
> =A0 =A0 =A0 =A0i2c_stop(adap);
> +
> + =A0 =A0 =A0 if (adap->post_xfer)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adap->post_xfer(i2c_adap);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> --- linux-2.6.34-rc1.orig/include/linux/i2c-algo-bit.h =A02010-03-13 =
16:26:30.000000000 +0100
> +++ linux-2.6.34-rc1/include/linux/i2c-algo-bit.h =A0 =A0 =A0 2010-03=
-13 17:23:03.000000000 +0100
> @@ -36,6 +36,8 @@ struct i2c_algo_bit_data {
> =A0 =A0 =A0 =A0void (*setscl) (void *data, int state);
> =A0 =A0 =A0 =A0int =A0(*getsda) (void *data);
> =A0 =A0 =A0 =A0int =A0(*getscl) (void *data);
> + =A0 =A0 =A0 int =A0(*pre_xfer) =A0(struct i2c_adapter *);
> + =A0 =A0 =A0 void (*post_xfer) (struct i2c_adapter *);
>
> =A0 =A0 =A0 =A0/* local settings */
> =A0 =A0 =A0 =A0int udelay; =A0 =A0 =A0 =A0 =A0 =A0 /* half clock cycl=
e time in us,
>
>
> --
> Jean Delvare
>
