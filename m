From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch v2] MPC Adapter: read class attribute from device tree
Date: Wed, 22 Apr 2009 10:23:12 -0400
Message-ID: <9e4733910904220723u68392662vb854188c1dec02fd@mail.gmail.com>
References: <49EEC50A.4050707@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EEC50A.4050707-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 22, 2009 at 3:19 AM, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org> wr=
ote:
> For MPC adapter there is no class assigned as it is done in other
> adapters. This way no new-style client will ever be instantiated, if =
not
> noted in device tree or forced. With this patch class assignment is r=
ead
> from device tree.
> If class assignment is not set in device tree .class stays default (0=
)
>
> Necessary device tree entry:
> linux,i2c-class =3D <1>; /* I2C_CLASS_HWMON (iic.h) */

When this patch makes it over to the device tree police they are going
to reject it. They will never allow OS specific entries into the cross
platform device tree standard.

>
> Based on kernel 2.6.29
>
> Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Sang, Wolfram <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mp=
c.c
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -318,7 +318,8 @@ static int __devinit fsl_i2c_probe(struct of_devi=
ce
> *op, const struct of_device_
> =A0{
> =A0 =A0 =A0 =A0int result =3D 0;
> =A0 =A0 =A0 =A0struct mpc_i2c *i2c;
> -
> + =A0 =A0 =A0 int *of_val;
> +
> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> @@ -354,6 +355,10 @@ static int __devinit fsl_i2c_probe(struct of_dev=
ice
> *op, const struct of_device_
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
>
> =A0 =A0 =A0 =A0i2c->adap =3D mpc_ops;
> + =A0 =A0 =A0 of_val =3D of_get_property(op->node, "linux,i2c-class",=
 NULL);
> + =A0 =A0 =A0 if(of_val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->adap.class =3D *of_val;
> +
> =A0 =A0 =A0 =A0i2c_set_adapdata(&i2c->adap, i2c);
> =A0 =A0 =A0 =A0i2c->adap.dev.parent =3D &op->dev;
>
>
>
> --
> Michael Lawnick
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
