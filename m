From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: dln2: set the device tree node of the adapter
Date: Mon, 30 Mar 2015 08:09:10 +0100
Message-ID: <20150330070910.GD457@x1>
References: <1427470630-13378-1-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427470630-13378-1-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Mar 2015, Octavian Purdila wrote:

> This patch makes sure the platform device tree node is inherited by
> the adapter device. This allows the DLN2 bus to work with i2c devices
> defined in the device tree.
>=20
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-dln2.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-d=
ln2.c
> index b3fb86a..db1e20a 100644
> --- a/drivers/i2c/busses/i2c-dln2.c
> +++ b/drivers/i2c/busses/i2c-dln2.c
> @@ -210,6 +210,7 @@ static int dln2_i2c_probe(struct platform_device =
*pdev)
>  	dln2->adapter.class =3D I2C_CLASS_HWMON;
>  	dln2->adapter.algo =3D &dln2_i2c_usb_algorithm;
>  	dln2->adapter.dev.parent =3D dev;
> +	dln2->adapter.dev.of_node =3D dev->of_node;
>  	i2c_set_adapdata(&dln2->adapter, dln2);
>  	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d"=
,
>  		 "dln2-i2c", dev_name(pdev->dev.parent), dln2->port);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
