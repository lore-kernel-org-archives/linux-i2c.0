From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: xiic: Add OF support for Xilinx i2c bus interface
Date: Tue, 22 Feb 2011 08:52:34 -0700
Message-ID: <AANLkTi=FvafUgqMCF29cX7egviDwrfB=sViudLr+4Fsx@mail.gmail.com>
References: <1298384530-14994-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298384530-14994-1-git-send-email-monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 22, 2011 at 7:22 AM, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> wrote:
> Add OF support to Xilinx i2c bus interface.
> It is used on Microblaze systems.
>
> Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>

Hi Michal, comments below...

> ---
> =A0drivers/i2c/busses/i2c-xiic.c | =A0 46 +++++++++++++++++++++++++++=
+++++++------
> =A01 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-x=
iic.c
> index a9c419e..4166570 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -2,6 +2,8 @@
> =A0* i2c-xiic.c
> =A0* Copyright (c) 2002-2007 Xilinx Inc.
> =A0* Copyright (c) 2009-2010 Intel Corporation
> + * Copyright (c) 2010-2011 Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
> + * Copyright (c) 2010-2011 PetaLogix

This change is going to end up being pretty trivial.  It would be a
little odd to claim copyright on such a tiny change; particularly when
it just follows the pattern already established by other drivers.

> =A0*
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> @@ -41,6 +43,13 @@
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
>
> +#ifdef CONFIG_OF
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_address.h>
> +#endif

As previously mentioned; drop the #ifdef protection around these
includes. It should be safe to include them unconditionally, and if it
isn't then it is a bug in the headers which should be fixed.  These
includes should be part of the regular block of includes.

> +
> =A0#define DRIVER_NAME "xiic-i2c"
>
> =A0enum xilinx_i2c_state {
> @@ -426,7 +435,7 @@ static void xiic_process(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xiic_wakeup(i2c, STATE=
_ERROR);
>
> =A0 =A0 =A0 =A0} else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR=
_TX_HALF_MASK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Transmit register/FIFO is empty or =BD=
 empty */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Transmit register/FIFO is empty or 1=
/2 empty */
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clr =3D pend &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(XIIC_INTR_TX_EMPTY_MA=
SK | XIIC_INTR_TX_HALF_MASK);
> @@ -691,10 +700,12 @@ static struct i2c_adapter xiic_adapter =3D {
> =A0static int __devinit xiic_i2c_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct xiic_i2c *i2c;
> +#ifndef CONFIG_OF
> =A0 =A0 =A0 =A0struct xiic_i2c_platform_data *pdata;
> + =A0 =A0 =A0 u8 i;
> +#endif
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0int ret, irq;
> - =A0 =A0 =A0 u8 i;

You can drop this hunk (see below).

>
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (!res)
> @@ -704,10 +715,6 @@ static int __devinit xiic_i2c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0if (irq < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto resource_missing;
>
> - =A0 =A0 =A0 pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.p=
latform_data;
> - =A0 =A0 =A0 if (!pdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> =A0 =A0 =A0 =A0i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> @@ -730,7 +737,9 @@ static int __devinit xiic_i2c_probe(struct platfo=
rm_device *pdev)
> =A0 =A0 =A0 =A0i2c->adap =3D xiic_adapter;
> =A0 =A0 =A0 =A0i2c_set_adapdata(&i2c->adap, i2c);
> =A0 =A0 =A0 =A0i2c->adap.dev.parent =3D &pdev->dev;
> -
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 i2c->adap.dev.of_node =3D of_node_get(pdev->dev.of_node=
);
> +#endif

Drop the #ifdef here.  In devicetree/next of_node is no longer
protected by a #ifdef.

> =A0 =A0 =A0 =A0xiic_reinit(i2c);
>
> =A0 =A0 =A0 =A0spin_lock_init(&i2c->lock);
> @@ -748,9 +757,20 @@ static int __devinit xiic_i2c_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto add_adapter_failed;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 dev_info(&pdev->dev, "mapped to 0x%08X, irq=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (unsigned int)i2c->base, irq);
> +
> +#ifndef CONFIG_OF
> + =A0 =A0 =A0 pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.p=
latform_data;
> + =A0 =A0 =A0 if (!pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0 =A0/* add in known devices to the bus */
> =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->num_devices; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_new_device(&i2c->adap, pdata->devi=
ces + i);
> +#else
> + =A0 =A0 =A0 of_i2c_register_devices(&i2c->adap);
> +#endif

Do it this way instead:

	pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
	if (pdata) {
		/* add in known devices to the bus */
		for (i =3D 0; i < pdata->num_devices; i++)
		       i2c_new_device(&i2c->adap, pdata->devices + i);
	}

	of_i2c_register_devices(&i2c->adap);

of_i2c_register_devices() is safe to call regardless of if CONFIG_OF
is selected or not.  This driver should be written to handle both
device tree and platform_data use cases at run time.

>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -799,12 +819,24 @@ static int __devexit xiic_i2c_remove(struct pla=
tform_device* pdev)
> =A0/* work with hotplug and coldplug */
> =A0MODULE_ALIAS("platform:"DRIVER_NAME);
>
> +#ifdef CONFIG_OF
> +/* Match table for of_platform binding */
> +static struct of_device_id __devinitdata xilinx_iic_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-iic-2.00.a", },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_iic_of_match);

If you add the following, then you can drop the #ifdef around
=2Eof_match_table below...

#else
#define xilinx_iic_of_match NULL

> +#endif
> +
> =A0static struct platform_driver xiic_i2c_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =3D xiic_i2c_probe,
> =A0 =A0 =A0 =A0.remove =A0=3D __devexit_p(xiic_i2c_remove),
> =A0 =A0 =A0 =A0.driver =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D DRIVER_NAME,
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D xilinx_iic_of_match=
,
> +#endif

Drop the #ifdef and base this patch on devicetree/next

> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.5.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
