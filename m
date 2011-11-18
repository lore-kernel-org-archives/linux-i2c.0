From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Fri, 18 Nov 2011 14:04:33 +0800
Message-ID: <CAGsJ_4wedp6rqM0HuTEZHQ9D77drTp92Sbft10L6OWYg6sS=wA@mail.gmail.com>
References: <1321544354-3084-1-git-send-email-21cnbao@gmail.com> <CAM=Q2ct4AKfYSHSu1KwYcW4YZ20QAJsOuHc9fg=oD5Rj7StB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2ct4AKfYSHSu1KwYcW4YZ20QAJsOuHc9fg=oD5Rj7StB7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Shubhrajyoti,
Thanks for reviewing

2011/11/18 Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Zhiwu,
>
> On Thu, Nov 17, 2011 at 9:09 PM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
>>
>> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>>
>> SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainlin=
e
>> 3.0.
>> There are two I2C controllers on primaII, features include:
>> =E2=96=A0 Two I2C controller modules are on chip
>> =E2=96=A0 RISC I/O bus read write register
>> =E2=96=A0 Up to 16 bytes data buffer for issuing commands and writin=
g data
>> =C2=A0at the same time
>> =E2=96=A0 Up to 16 commands, and receiving read data 16 bytes at a t=
ime
>> =E2=96=A0 Error INT report (ACK check)
>> =E2=96=A0 No-ACK bus protocols (SCCB bus protocols)
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>> ---
>> =C2=A0-v3:
>> =C2=A0add lost clk_enable/disable in suspend/resume function while r=
eading/
>> =C2=A0writing i2c controller registers.
>> =C2=A0without this, suspend will hang.

forgot this fix was done by Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>. so he
should get a Signed-off-by.

>>
>> =C2=A0arch/arm/mach-prima2/pm.c =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0arch/arm/mach-prima2/prima2.c | =C2=A0 =C2=A01 +
>> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0| =C2=A0 =C2=A07 +
>> =C2=A0drivers/i2c/busses/Makefile =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0drivers/i2c/busses/i2c-sirf.c | =C2=A0438
>> +++++++++++++++++++++++++++++++++++++++++
>> =C2=A0drivers/i2c/busses/i2c-sirf.h | =C2=A0 61 ++++++
>> =C2=A06 files changed, 509 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-sirf.c
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-sirf.h
>>
>> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
>> index cb53160..26ebb57 100644
>> --- a/arch/arm/mach-prima2/pm.c
>> +++ b/arch/arm/mach-prima2/pm.c
>> @@ -9,6 +9,7 @@
>> =C2=A0#include <linux/kernel.h>
>> =C2=A0#include <linux/suspend.h>
>> =C2=A0#include <linux/slab.h>
>> +#include <linux/module.h>
>> =C2=A0#include <linux/of.h>
>> =C2=A0#include <linux/of_address.h>
>> =C2=A0#include <linux/of_device.h>
>> diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/pr=
ima2.c

>> +config I2C_SIRF
>> + =C2=A0 =C2=A0 =C2=A0 tristate "CSR SiRFprimaII I2C interface"
>> + =C2=A0 =C2=A0 =C2=A0 depends on ARCH_PRIMA2
>> + =C2=A0 =C2=A0 =C2=A0 help
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you say yes to this option, support=
 will be included for the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 CSR SiRFprimaII I2C interface.
>
> Since it is tristate the module ..

this is just a minor issue, if you like some changes, i can make it bet=
ter.

>
>>
>> +
>> =C2=A0config I2C_SIMTEC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Simtec Generic I2C interface"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0select I2C_ALGOBIT
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefi=
le
>> index fba6da6..c30db66 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_I2C_S3C2410) =C2=A0 =C2=A0 +=3D i2c-s=
3c2410.o
>> =C2=A0obj-$(CONFIG_I2C_S6000) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0+=3D i2c-s6000.o
>> =C2=A0obj-$(CONFIG_I2C_SH7760) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-sh7760.=
o
>> =C2=A0obj-$(CONFIG_I2C_SH_MOBILE) =C2=A0 =C2=A0+=3D i2c-sh_mobile.o
>> +obj-$(CONFIG_I2C_SIRF) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D i2c-sirf.o
>> =C2=A0obj-$(CONFIG_I2C_SIMTEC) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-simtec.=
o
>> =C2=A0obj-$(CONFIG_I2C_STU300) =C2=A0 =C2=A0 =C2=A0 +=3D i2c-stu300.=
o
>> =C2=A0obj-$(CONFIG_I2C_TEGRA) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0+=3D i2c-tegra.o
>> diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-=
sirf.c
>> new file mode 100644
>> index 0000000..2988124
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sirf.c
>> @@ -0,0 +1,438 @@
>> +/*
>> + * I2C bus driver for CSR SiRFprimaII
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc gr=
oup
>> company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/init.h>
>> +#include <linux/sched.h>
>
> Are all these files needed?

-#include <linux/init.h>
-#include <linux/sched.h>

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "Unable to get MEM resource\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 siic->base =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devm_ioremap(&pde=
v->dev, mem_res->start, (mem_res->end -
>> mem_res->start + 1));
>> + =C2=A0 =C2=A0 =C2=A0 if (siic->base =3D=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "IO remap failed!\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 siic->irq =3D platform_get_irq(pdev, 0);
>> + =C2=A0 =C2=A0 =C2=A0 if (!siic->irq) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 err =3D devm_request_irq(&pdev->dev, siic->ir=
q, i2c_sirfsoc_irq, 0,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name(&pdev->d=
ev), siic);
>> + =C2=A0 =C2=A0 =C2=A0 if (err)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 new_adapter->algo =3D &i2c_sirfsoc_algo;
>> + =C2=A0 =C2=A0 =C2=A0 new_adapter->algo_data =3D siic;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 new_adapter->dev.parent =3D &pdev->dev;
>> + =C2=A0 =C2=A0 =C2=A0 new_adapter->nr =3D pdev->id;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 strlcpy(new_adapter->name, "sirfsoc-i2c",
>> sizeof(new_adapter->name));
>> +
>> + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, new_adapter);
>> + =C2=A0 =C2=A0 =C2=A0 init_completion(&siic->done);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* Controller Initalisation */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSO=
C_I2C_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 while (readl(siic->base + SIRFSOC_I2C_CTRL) &=
 SIRFSOC_I2C_RESET)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_relax();
>> + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MAST=
ER_MODE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRF=
SOC_I2C_CTRL);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 siic->clk =3D clk;
>> + =C2=A0 =C2=A0 =C2=A0 siic->speed =3D SIRFSOC_I2C_DEFAULT_SPEED;
>> + =C2=A0 =C2=A0 =C2=A0 if (siic->speed < 100000)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval =3D
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (2 * ctrl_speed) / (2 * siic->speed * 11);
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval =3D ctrl_s=
peed / (siic->speed * 5);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 writel(regval, siic->base + SIRFSOC_I2C_CLK_C=
TRL);
>> + =C2=A0 =C2=A0 =C2=A0 if (regval > 0xFF)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(0xFF, siic=
->base + SIRFSOC_I2C_SDA_DELAY);
>> + =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(regval, si=
ic->base + SIRFSOC_I2C_SDA_DELAY);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 err =3D i2c_add_numbered_adapter(new_adapter)=
;
>> + =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&pdev->de=
v, "Can't add new i2c adapter\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(clk);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 dev_info(&pdev->dev, " I2C adapter ready to o=
perate\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +
>> +out:
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(clk);
>> +err_clk_en:
>> + =C2=A0 =C2=A0 =C2=A0 clk_unprepare(clk);
>> +err_clk_prep:
>> + =C2=A0 =C2=A0 =C2=A0 clk_put(clk);
>> +err_get_clk:
>
> We are not freeing any allocated memories?

you might want to read Jamie's earlier feedback in v1. that is why we
move to devm_alloc in v2.

>>
>> + =C2=A0 =C2=A0 =C2=A0 return err;
>> +}
>> +
>> +static int __devexit i2c_sirfsoc_remove(struct platform_device *pde=
v)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_=
drvdata(pdev);
>> + =C2=A0 =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_da=
ta;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSO=
C_I2C_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 i2c_del_adapter(adapter);
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 clk_unprepare(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 clk_put(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int i2c_sirfsoc_suspend(struct platform_device *pdev, pm_mes=
sage_t
>> msg)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_=
drvdata(pdev);
>> + =C2=A0 =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_da=
ta;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_enable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 siic->sda_delay =3D readl(siic->base + SIRFSO=
C_I2C_SDA_DELAY);
>> + =C2=A0 =C2=A0 =C2=A0 siic->clk_div =3D readl(siic->base + SIRFSOC_=
I2C_CLK_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int i2c_sirfsoc_resume(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_=
drvdata(pdev);
>> + =C2=A0 =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_da=
ta;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_enable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSO=
C_I2C_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MAST=
ER_MODE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRF=
SOC_I2C_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 writel(siic->clk_div, siic->base + SIRFSOC_I2=
C_CLK_CTRL);
>> + =C2=A0 =C2=A0 =C2=A0 writel(siic->sda_delay, siic->base + SIRFSOC_=
I2C_SDA_DELAY);
>> + =C2=A0 =C2=A0 =C2=A0 clk_disable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +#else
>> +#define i2c_sirfsoc_suspend =C2=A0 =C2=A0NULL
>> +#define i2c_sirfsoc_resume =C2=A0 =C2=A0 NULL
>> +#endif
>> +
>> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitco=
nst =3D
>> {
>> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "sirf,prima2-i2c", },
>> + =C2=A0 =C2=A0 =C2=A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sirfsoc_i2c_of_match);
>> +
>> +static struct platform_driver i2c_sirfsoc_driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "sirfso=
c_i2c",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_M=
ODULE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D=
 sirfsoc_i2c_of_match,
>> + =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 .probe =3D i2c_sirfsoc_probe,
>> + =C2=A0 =C2=A0 =C2=A0 .remove =3D __devexit_p(i2c_sirfsoc_remove),
>
> Could we move to pm ops ?

i prefer to keep the current way as most people are doing.

-barry
