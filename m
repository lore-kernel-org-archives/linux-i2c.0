From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: xiic: Add OF support for Xilinx i2c bus interface
Date: Tue, 22 Feb 2011 18:52:13 +0100
Message-ID: <4D63F7CD.5070307@monstr.eu>
References: <1298384530-14994-1-git-send-email-monstr@monstr.eu> <AANLkTi=FvafUgqMCF29cX7egviDwrfB=sViudLr+4Fsx@mail.gmail.com>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=FvafUgqMCF29cX7egviDwrfB=sViudLr+4Fsx-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Tue, Feb 22, 2011 at 7:22 AM, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org> wrot=
e:
>> Add OF support to Xilinx i2c bus interface.
>> It is used on Microblaze systems.
>>
>> Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
>=20
> Hi Michal, comments below...
>=20
>> ---
>>  drivers/i2c/busses/i2c-xiic.c |   46 ++++++++++++++++++++++++++++++=
++++------
>>  1 files changed, 39 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-=
xiic.c
>> index a9c419e..4166570 100644
>> --- a/drivers/i2c/busses/i2c-xiic.c
>> +++ b/drivers/i2c/busses/i2c-xiic.c
>> @@ -2,6 +2,8 @@
>>  * i2c-xiic.c
>>  * Copyright (c) 2002-2007 Xilinx Inc.
>>  * Copyright (c) 2009-2010 Intel Corporation
>> + * Copyright (c) 2010-2011 Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
>> + * Copyright (c) 2010-2011 PetaLogix
>=20
> This change is going to end up being pretty trivial.  It would be a
> little odd to claim copyright on such a tiny change; particularly whe=
n
> it just follows the pattern already established by other drivers.

agree - I forget to remove it - it was in my origin patch.

>=20
>>  *
>>  * This program is free software; you can redistribute it and/or mod=
ify
>>  * it under the terms of the GNU General Public License version 2 as
>> @@ -41,6 +43,13 @@
>>  #include <linux/io.h>
>>  #include <linux/slab.h>
>>
>> +#ifdef CONFIG_OF
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_i2c.h>
>> +#include <linux/of_address.h>
>> +#endif
>=20
> As previously mentioned; drop the #ifdef protection around these
> includes. It should be safe to include them unconditionally, and if i=
t
> isn't then it is a bug in the headers which should be fixed.  These
> includes should be part of the regular block of includes.

remove done

>=20
>> +
>>  #define DRIVER_NAME "xiic-i2c"
>>
>>  enum xilinx_i2c_state {
>> @@ -426,7 +435,7 @@ static void xiic_process(struct xiic_i2c *i2c)
>>                        xiic_wakeup(i2c, STATE_ERROR);
>>
>>        } else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HAL=
=46_MASK)) {
>> -               /* Transmit register/FIFO is empty or =BD empty */
>> +               /* Transmit register/FIFO is empty or 1/2 empty */
>>
>>                clr =3D pend &
>>                        (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_=
MASK);
>> @@ -691,10 +700,12 @@ static struct i2c_adapter xiic_adapter =3D {
>>  static int __devinit xiic_i2c_probe(struct platform_device *pdev)
>>  {
>>        struct xiic_i2c *i2c;
>> +#ifndef CONFIG_OF
>>        struct xiic_i2c_platform_data *pdata;
>> +       u8 i;
>> +#endif
>>        struct resource *res;
>>        int ret, irq;
>> -       u8 i;
>=20
> You can drop this hunk (see below).

done

>=20
>>        res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>        if (!res)
>> @@ -704,10 +715,6 @@ static int __devinit xiic_i2c_probe(struct plat=
form_device *pdev)
>>        if (irq < 0)
>>                goto resource_missing;
>>
>> -       pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platfo=
rm_data;
>> -       if (!pdata)
>> -               return -EINVAL;
>> -
>>        i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
>>        if (!i2c)
>>                return -ENOMEM;
>> @@ -730,7 +737,9 @@ static int __devinit xiic_i2c_probe(struct platf=
orm_device *pdev)
>>        i2c->adap =3D xiic_adapter;
>>        i2c_set_adapdata(&i2c->adap, i2c);
>>        i2c->adap.dev.parent =3D &pdev->dev;
>> -
>> +#ifdef CONFIG_OF
>> +       i2c->adap.dev.of_node =3D of_node_get(pdev->dev.of_node);
>> +#endif
>=20
> Drop the #ifdef here.  In devicetree/next of_node is no longer
> protected by a #ifdef.

ok, done

>=20
>>        xiic_reinit(i2c);
>>
>>        spin_lock_init(&i2c->lock);
>> @@ -748,9 +757,20 @@ static int __devinit xiic_i2c_probe(struct plat=
form_device *pdev)
>>                goto add_adapter_failed;
>>        }
>>
>> +       dev_info(&pdev->dev, "mapped to 0x%08X, irq=3D%d\n",
>> +                                       (unsigned int)i2c->base, irq=
);
>> +
>> +#ifndef CONFIG_OF
>> +       pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platfo=
rm_data;
>> +       if (!pdata)
>> +               return -EINVAL;
>> +
>>        /* add in known devices to the bus */
>>        for (i =3D 0; i < pdata->num_devices; i++)
>>                i2c_new_device(&i2c->adap, pdata->devices + i);
>> +#else
>> +       of_i2c_register_devices(&i2c->adap);
>> +#endif
>=20
> Do it this way instead:
>=20
> 	pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
> 	if (pdata) {
> 		/* add in known devices to the bus */
> 		for (i =3D 0; i < pdata->num_devices; i++)
> 		       i2c_new_device(&i2c->adap, pdata->devices + i);
> 	}
>=20
> 	of_i2c_register_devices(&i2c->adap);
>=20
> of_i2c_register_devices() is safe to call regardless of if CONFIG_OF
> is selected or not.  This driver should be written to handle both
> device tree and platform_data use cases at run time.

ok, done. I hope that it doesn't non OF version. I can't easily test it=
=2E

>=20
>>        return 0;
>>
>> @@ -799,12 +819,24 @@ static int __devexit xiic_i2c_remove(struct pl=
atform_device* pdev)
>>  /* work with hotplug and coldplug */
>>  MODULE_ALIAS("platform:"DRIVER_NAME);
>>
>> +#ifdef CONFIG_OF
>> +/* Match table for of_platform binding */
>> +static struct of_device_id __devinitdata xilinx_iic_of_match[] =3D =
{
>> +       { .compatible =3D "xlnx,xps-iic-2.00.a", },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, xilinx_iic_of_match);
>=20
> If you add the following, then you can drop the #ifdef around
> .of_match_table below...
>=20
> #else
> #define xilinx_iic_of_match NULL
>=20
>> +#endif
>> +
>>  static struct platform_driver xiic_i2c_driver =3D {
>>        .probe   =3D xiic_i2c_probe,
>>        .remove  =3D __devexit_p(xiic_i2c_remove),
>>        .driver  =3D {
>>                .owner =3D THIS_MODULE,
>>                .name =3D DRIVER_NAME,
>> +#ifdef CONFIG_OF
>> +               .of_match_table =3D xilinx_iic_of_match,
>> +#endif
>=20
> Drop the #ifdef and base this patch on devicetree/next

specifically this I was checking in the Linus tree to know if there is =
any ifdef.
devicetree/next branch is fine.

I have sent v3 based on your devicetree/next branch.

Thanks for your comments,
Michal

--=20
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/=
fdt/
Microblaze U-BOOT custodian
