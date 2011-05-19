From: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Adding the i2c-bit-platform bus
Date: Thu, 19 May 2011 04:09:07 +0300
Message-ID: <BANLkTikrDQvurec3U-chKOjK-F=PAh4vNA@mail.gmail.com>
References: <1305229085-14408-1-git-send-email-pavius@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305229085-14408-1-git-send-email-pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guys

Is there anything else that needs to be done with this on my side?

Thanks
Eran

On Thu, May 12, 2011 at 10:38 PM, Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> - Platform now passes a new platform structure, i2c_bit_platform_data=
,
> to the driver instead of passing i2c_algo_bit_data
>
> Signed-off-by: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 10 +++
> =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A01 +
> =C2=A0drivers/i2c/busses/i2c-bit-platform.c | =C2=A0120 +++++++++++++=
++++++++++++++++++++
> =C2=A0include/linux/i2c-bit-platform.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 3=
5 ++++++++++
> =C2=A04 files changed, 166 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/i2c/busses/i2c-bit-platform.c
> =C2=A0create mode 100644 include/linux/i2c-bit-platform.h
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 3a6321c..f6c6b8c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -365,6 +365,16 @@ config I2C_GPIO
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This is a very simple bitbanging I2=
C driver utilizing the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arch-neutral GPIO API to control th=
e SCL and SDA lines.
>
> +config I2C_BIT_PLATFORM
> + =C2=A0 =C2=A0 =C2=A0 tristate "I2c-bit-algo as platform device"
> + =C2=A0 =C2=A0 =C2=A0 select I2C_ALGOBIT
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 An I2C bus adapter which delegates the =
bit-algo callback registration
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 to the platform. Useful in cases where =
existing adapters such as
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c-gpio are too slow. Keep in mind tha=
t no resource locking of any kind
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 is performed by the adapter or algo, so=
 any such contention must be
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 handled by the platform.
> +
> =C2=A0config I2C_HIGHLANDER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Highlander FPGA SMBus interface"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SH_HIGHLANDER
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index 84cb16a..65bced4 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_I2C_CPM) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=
=3D i2c-cpm.o
> =C2=A0obj-$(CONFIG_I2C_DAVINCI) =C2=A0 =C2=A0 =C2=A0+=3D i2c-davinci.=
o
> =C2=A0obj-$(CONFIG_I2C_DESIGNWARE) =C2=A0 +=3D i2c-designware.o
> =C2=A0obj-$(CONFIG_I2C_GPIO) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D i2c-gpi=
o.o
> +obj-$(CONFIG_I2C_BIT_PLATFORM) +=3D i2c-bit-platform.o
> =C2=A0obj-$(CONFIG_I2C_HIGHLANDER) =C2=A0 +=3D i2c-highlander.o
> =C2=A0obj-$(CONFIG_I2C_IBM_IIC) =C2=A0 =C2=A0 =C2=A0+=3D i2c-ibm_iic.=
o
> =C2=A0obj-$(CONFIG_I2C_IMX) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D i2=
c-imx.o
> diff --git a/drivers/i2c/busses/i2c-bit-platform.c b/drivers/i2c/buss=
es/i2c-bit-platform.c
> new file mode 100644
> index 0000000..c1f4402
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-bit-platform.c
> @@ -0,0 +1,120 @@
> +/*
> + =C2=A0 =C2=A0i2c-bit-algo as platform device
> + =C2=A0 =C2=A0Delegates the bit-algo callback registration to the pl=
atform
> +
> + =C2=A0 =C2=A0Copyright (C) 2011 Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> +
> + =C2=A0 =C2=A0This program is free software; you can redistribute it=
 and/or modify
> + =C2=A0 =C2=A0it under the terms of the GNU General Public License a=
s published by
> + =C2=A0 =C2=A0the Free Software Foundation; either version 2 of the =
License, or
> + =C2=A0 =C2=A0(at your option) any later version.
> +*/
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-bit.h>
> +#include <linux/i2c-bit-platform.h>
> +#include <linux/slab.h>
> +
> +static int __devinit i2c_bit_platform_probe(struct platform_device *=
pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_bit_platform_data *pdata;
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_algo_bit_data *bit_data;
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adap;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (pdev->dev.platform_data =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENXIO;
> +
> + =C2=A0 =C2=A0 =C2=A0 pdata =3D pdev->dev.platform_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 adap =3D kzalloc(sizeof(struct i2c_adapter), G=
=46P_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (adap =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_alloc_ada=
p;
> + =C2=A0 =C2=A0 =C2=A0 bit_data =3D kzalloc(sizeof(struct i2c_algo_bi=
t_data), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (bit_data =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_alloc_bit=
_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 bit_data->data =3D pdata->data;
> + =C2=A0 =C2=A0 =C2=A0 bit_data->setsda =3D pdata->setsda;
> + =C2=A0 =C2=A0 =C2=A0 bit_data->setscl =3D pdata->setscl;
> + =C2=A0 =C2=A0 =C2=A0 bit_data->getsda =3D pdata->getsda;
> + =C2=A0 =C2=A0 =C2=A0 bit_data->getscl =3D pdata->getscl;
> + =C2=A0 =C2=A0 =C2=A0 bit_data->udelay =3D pdata->udelay;
> + =C2=A0 =C2=A0 =C2=A0 bit_data->timeout =3D pdata->timeout;
> +
> + =C2=A0 =C2=A0 =C2=A0 adap->owner =3D THIS_MODULE;
> + =C2=A0 =C2=A0 =C2=A0 adap->algo_data =3D bit_data;
> + =C2=A0 =C2=A0 =C2=A0 adap->class =3D I2C_CLASS_HWMON | I2C_CLASS_SP=
D;
> + =C2=A0 =C2=A0 =C2=A0 adap->dev.parent =3D &pdev->dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 snprintf(adap->name, sizeof(adap->name), "i2c-=
bit-platform%d",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pdev->id);
> + =C2=A0 =C2=A0 =C2=A0 adap->name[sizeof(adap->name) - 1] =3D '\0';
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* If "dev->id" is negative we consider i=
t as zero.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* The reason to do so is to avoid sysfs =
names that only make
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* sense when there are multiple adapters=
=2E
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 adap->nr =3D (pdev->id !=3D -1) ? pdev->id : 0=
;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_bit_add_numbered_bus(adap);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_add_bus;
> +
> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, adap);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> +err_add_bus:
> + =C2=A0 =C2=A0 =C2=A0 kfree(bit_data);
> +err_alloc_bit_data:
> + =C2=A0 =C2=A0 =C2=A0 kfree(adap);
> +err_alloc_adap:
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static int __devexit i2c_bit_platform_remove(struct platform_device =
*pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adap;
> +
> + =C2=A0 =C2=A0 =C2=A0 adap =3D platform_get_drvdata(pdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 i2c_del_adapter(adap);
> +
> + =C2=A0 =C2=A0 =C2=A0 kfree(adap->algo_data);
> + =C2=A0 =C2=A0 =C2=A0 kfree(adap);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct platform_driver i2c_bit_platform_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "=
i2c-bit-platform",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =C2=A0=3D T=
HIS_MODULE,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D i=
2c_bit_platform_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __deve=
xit_p(i2c_bit_platform_remove),
> +};
> +
> +static int __init i2c_bit_platform_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D platform_driver_register(&i2c_bit_plat=
form_driver);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "i=
2c-bit-platform: probe failed: %d\n", ret);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +subsys_initcall(i2c_bit_platform_init);
> +
> +static void __exit i2c_bit_platform_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&i2c_bit_platform_d=
river);
> +}
> +module_exit(i2c_bit_platform_exit);
> +
> +MODULE_AUTHOR("Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Thin platform adapter for i2c-bit-algo");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c-bit-platform.h b/include/linux/i2c-bit=
-platform.h
> new file mode 100644
> index 0000000..e3b601b
> --- /dev/null
> +++ b/include/linux/i2c-bit-platform.h
> @@ -0,0 +1,35 @@
> +/*
> + * i2c-bit-platform interface to platform code
> + *
> + * Copyright (C) 2011 Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef _LINUX_I2C_BIT_PLATFORM_H
> +#define _LINUX_I2C_BIT_PLATFORM_H
> +
> +/**
> + * struct i2c_bit_platform_data - Platform-dependent data for
> + * i2c-bit-platform
> + * @data: to be passed to callbacks, untouched
> + * @setsda: callback to set SDA line
> + * @setscl: callback to set SCL line
> + * @getsda: callback to get SDA line
> + * @getscl: callback to get SCL line
> + * @udelay: signal toggle delay. SCL frequency is (500 / udelay) kHz
> + * @timeout: clock stretching timeout in jiffies. If the slave keeps
> + * =C2=A0 =C2=A0 SCL low for longer than this, the transfer will tim=
e out.
> + */
> +struct i2c_bit_platform_data {
> + =C2=A0 =C2=A0 =C2=A0 void *data;
> + =C2=A0 =C2=A0 =C2=A0 void (*setsda) (void *data, int state);
> + =C2=A0 =C2=A0 =C2=A0 void (*setscl) (void *data, int state);
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0(*getsda) (void *data);
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0(*getscl) (void *data);
> + =C2=A0 =C2=A0 =C2=A0 int udelay;
> + =C2=A0 =C2=A0 =C2=A0 int timeout;
> +};
> +
> +#endif /* _LINUX_I2C_BIT_PLATFORM_H */
> --
> 1.7.0.4
>
