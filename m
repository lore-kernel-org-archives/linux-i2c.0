From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: I2C device tree driver compatible strings
Date: Sun, 12 Apr 2015 09:55:05 +0200
Message-ID: <CAMuHMdXM4H3FDDd8Z07ugAAPMQLfDhPC+V2FKs1bKbOtSw1AOg@mail.gmail.com>
References: <20150411213614.63632aff@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150411213614.63632aff@north>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CC linux-i2c

On Sat, Apr 11, 2015 at 9:36 PM, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> w=
rote:
> Hello,
>
> sc16is7xx declares two device id tables, one with OF ids:
>
> static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] =3D=
 {
>         { .compatible =3D "nxp,sc16is740",        .data =3D &sc16is74=
x_devtype, },
>         { .compatible =3D "nxp,sc16is741",        .data =3D &sc16is74=
x_devtype, },
>         { .compatible =3D "nxp,sc16is750",        .data =3D &sc16is75=
0_devtype, },
>         { .compatible =3D "nxp,sc16is752",        .data =3D &sc16is75=
2_devtype, },
>         { .compatible =3D "nxp,sc16is760",        .data =3D &sc16is76=
0_devtype, },
>         { .compatible =3D "nxp,sc16is762",        .data =3D &sc16is76=
2_devtype, },
>         { }
> };
> MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);
>
> and one with i2c ids:
>
> static const struct i2c_device_id sc16is7xx_i2c_id_table[] =3D {
>         { "sc16is74x",  (kernel_ulong_t)&sc16is74x_devtype, },
>         { "sc16is750",  (kernel_ulong_t)&sc16is750_devtype, },
>         { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
>         { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },
>         { "sc16is762",  (kernel_ulong_t)&sc16is762_devtype, },
>         { }
> };
> MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
>
> I declare my device in DT under I2C controller as
>>       compatible =3D "nxp,sc16is740";
> However, the driver does not get loaded automatically because its
> i2c id table contains "sc16is74x" instead of "sc16is740".
>
> I have three questions:
>
> (1) What is the relation between i2c_device_id and of_device_id strin=
gs
>     and why does the driver define both?
>
> (2) What are the rules for loading i2c drivers based on DT and why is=
 the
>     driver not loaded even though its compatible with one of the OF i=
ds?
>
> (3) Is it OK for the driver to define incompatible strings or should =
I
>     correct them like this (keeping the old entry for backwards
>     compatibility):
>
> diff --git a/drivers/tty/serial/sc16is7xx.c
> b/drivers/tty/serial/sc16is7xx.c index eaf0008a39cb..efe286d00174 100=
644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1219,6 +1219,8 @@ static int sc16is7xx_i2c_remove(struct i2c_clie=
nt
> *client)
>  static const struct i2c_device_id sc16is7xx_i2c_id_table[] =3D {
>         { "sc16is74x",  (kernel_ulong_t)&sc16is74x_devtype, },
> +       { "sc16is740",  (kernel_ulong_t)&sc16is74x_devtype, },
> +       { "sc16is741",  (kernel_ulong_t)&sc16is74x_devtype, },
>         { "sc16is750",  (kernel_ulong_t)&sc16is750_devtype, },
>         { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
>         { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },
>
>
> Thanks,
> Kuba
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
