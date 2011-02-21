From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] i2c: xiic: Add OF support for Xilinx i2c bus interface
Date: Mon, 21 Feb 2011 09:10:11 -0700
Message-ID: <AANLkTi=czAa6TQsVvGRg+Uz0BMnriUL5==6ehEym8e3b@mail.gmail.com>
References: <1298290059-9552-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1298290059-9552-1-git-send-email-monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 21, 2011 at 5:07 AM, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> wrote:
> Add OF support to Xilinx i2c bus interface.
> It is used on Microblaze systems.
>
> Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>

Hi Michal,

Don't forget to cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org for i2c driver changes.

The majority of this patch isn't needed.  Platform drivers can easily
handle both dt and non-dt usage at runtime using the same .probe and
.remove hooks.  All you should need to do is add an of_match_table to
the existing platform driver and set the of node pointer like this:
i2c->adap.dev.of_node =3D of_node_get(op->dev.of_node);  You'll also
need to fix the probe routine to *not* bail if it doesn't get a
platform data pointer.  The dt support code takes care of populating
the platform_device resource structure so that the normal method of
obtaining base address and irq works.

g.


> ---
> =A0drivers/i2c/busses/i2c-xiic.c | =A0111 +++++++++++++++++++++++++++++++=
+++++++++-
> =A01 files changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index a9c419e..22951a3 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -2,6 +2,8 @@
> =A0* i2c-xiic.c
> =A0* Copyright (c) 2002-2007 Xilinx Inc.
> =A0* Copyright (c) 2009-2010 Intel Corporation
> + * Copyright (c) 2010-2011 Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
> + * Copyright (c) 2010-2011 PetaLogix
> =A0*
> =A0* This program is free software; you can redistribute it and/or modify
> =A0* it under the terms of the GNU General Public License version 2 as
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

#ifdef CONFIG_OF should no longer needed around the device tree
headers (if you find that it is, then it is a bug that should be
reported and fixed)

> +
> =A0#define DRIVER_NAME "xiic-i2c"
>
> =A0enum xilinx_i2c_state {
> @@ -426,7 +435,7 @@ static void xiic_process(struct xiic_i2c *i2c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xiic_wakeup(i2c, STATE_ERR=
OR);
>
> =A0 =A0 =A0 =A0} else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_=
HALF_MASK)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Transmit register/FIFO is empty or =BD e=
mpty */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Transmit register/FIFO is empty or 1/2 e=
mpty */
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clr =3D pend &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(XIIC_INTR_TX_EMPTY_MASK |=
 XIIC_INTR_TX_HALF_MASK);
> @@ -687,7 +696,7 @@ static struct i2c_adapter xiic_adapter =3D {
> =A0 =A0 =A0 =A0.algo =A0 =A0 =A0 =A0 =A0 =3D &xiic_algorithm,
> =A0};
>
> -
> +#ifndef CONFIG_OF
> =A0static int __devinit xiic_i2c_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct xiic_i2c *i2c;
> @@ -808,6 +817,104 @@ static struct platform_driver xiic_i2c_driver =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> +#else
> +static int __devinit xiic_i2c_of_probe(struct platform_device *op)
> +{
> + =A0 =A0 =A0 struct xiic_i2c *i2c;
> + =A0 =A0 =A0 int result =3D 0;
> +
> + =A0 =A0 =A0 i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
> + =A0 =A0 =A0 if (!i2c)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 i2c->dev =3D &op->dev; /* for debug and error output */
> +
> + =A0 =A0 =A0 spin_lock_init(&i2c->lock);
> + =A0 =A0 =A0 init_waitqueue_head(&i2c->wait);
> +
> + =A0 =A0 =A0 i2c->base =3D of_iomap(op->dev.of_node, 0);
> + =A0 =A0 =A0 if (!i2c->base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->dev, "failed to map controller=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_map;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c->irq =3D irq_of_parse_and_map(op->dev.of_node, 0);
> + =A0 =A0 =A0 if (i2c->irq) { /* no i2c->irq implies polling */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D request_irq(i2c->irq, xiic_isr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0, op->name, i2c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->dev, "failed t=
o attach interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_request;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, i2c);
> + =A0 =A0 =A0 i2c->adap =3D xiic_adapter;
> + =A0 =A0 =A0 i2c_set_adapdata(&i2c->adap, i2c);
> + =A0 =A0 =A0 i2c->adap.dev.parent =3D &op->dev;
> + =A0 =A0 =A0 i2c->adap.dev.of_node =3D of_node_get(op->dev.of_node);
> +
> + =A0 =A0 =A0 result =3D i2c_add_adapter(&i2c->adap);
> + =A0 =A0 =A0 if (result < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c->dev, "failed to add adapter\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_add;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(i2c->dev, "mapped to 0x%08X, irq=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (unsigned int)i2c->base, i2c->irq);
> +
> + =A0 =A0 =A0 xiic_reinit(i2c);
> + =A0 =A0 =A0 of_i2c_register_devices(&i2c->adap);
> +
> + =A0 =A0 =A0 return result;
> +
> +fail_add:
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, NULL);
> + =A0 =A0 =A0 free_irq(i2c->irq, i2c);
> +fail_request:
> + =A0 =A0 =A0 irq_dispose_mapping(i2c->irq);
> + =A0 =A0 =A0 iounmap(i2c->base);
> +fail_map:
> + =A0 =A0 =A0 kfree(i2c);
> + =A0 =A0 =A0 return result;
> +}
> +
> +static int __devexit xiic_i2c_of_remove(struct platform_device *op)
> +{
> + =A0 =A0 =A0 struct xiic_i2c *i2c =3D dev_get_drvdata(&op->dev);
> +
> + =A0 =A0 =A0 i2c_del_adapter(&i2c->adap);
> + =A0 =A0 =A0 xiic_deinit(i2c);
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, NULL);
> +
> + =A0 =A0 =A0 if (i2c->irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(i2c->irq, i2c);
> +
> + =A0 =A0 =A0 irq_dispose_mapping(i2c->irq);
> + =A0 =A0 =A0 iounmap(i2c->base);
> + =A0 =A0 =A0 kfree(i2c);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static struct of_device_id __devinitdata xilinx_iic_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-iic-2.00.a", },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_iic_of_match);
> +
> +static struct platform_driver xiic_i2c_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =3D xiic_i2c_of_probe,
> + =A0 =A0 =A0 .remove =A0=3D __devexit_p(xiic_i2c_of_remove),
> + =A0 =A0 =A0 .driver =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D xilinx_iic_of_match,
> + =A0 =A0 =A0 },
> +};
> +#endif

> +
> =A0static int __init xiic_i2c_init(void)
> =A0{
> =A0 =A0 =A0 =A0return platform_driver_register(&xiic_i2c_driver);
> --
> 1.5.5.6
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
