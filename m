From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Sat, 25 Feb 2012 11:19:51 +0800
Message-ID: <CAGsJ_4zRHsfYPfPBv423T3smc11_yKxEq_O205M8W7t8nmzR=g@mail.gmail.com>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com> <CAM=Q2ct7EHht06uCHVpR_HoO39WZjO2+N6DhxuMthRQRQBRnyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2ct7EHht06uCHVpR_HoO39WZjO2+N6DhxuMthRQRQBRnyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

hi Shubhrajyoti,

2012/2/17 Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hello,
>
> On Wed, Feb 8, 2012 at 8:58 PM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>>
>> SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainlin=
e
>> 3.0.
>> There are two I2C controllers on primaII, features include:
>> * Two I2C controller modules are on chip
>> * RISC I/O bus read write register
>> * Up to 16 bytes data buffer for issuing commands and writing data
>> =C2=A0at the same time
>> * Up to 16 commands, and receiving read data 16 bytes at a time
>> * Error INT report (ACK check)
>> * No-ACK bus protocols (SCCB bus protocols)
>>
>> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>
>> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
>> ---
>> =C2=A0-v6:
>> =C2=A0fix/cleanup lots of minor issues pointed out by wolfram;
>> =C2=A0add OF property clock-frequency to support freq setting by DT;
>> =C2=A0add lost devicetree binding document;
>>
>> =C2=A0Documentation/devicetree/bindings/i2c/sirf-i2c.txt | =C2=A0 19=
 +
>> =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 +
>> =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0drivers/i2c/busses/i2c-sirf.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0459 +++++++++++++++++=
+++
>> =C2=A04 files changed, 489 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 Documentation/devicetree/bindings/i2c/sirf-=
i2c.txt
>> =C2=A0create mode 100644 drivers/i2c/busses/i2c-sirf.c
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/sirf-i2c.txt b/Do=
cumentation/devicetree/bindings/i2c/sirf-i2c.txt
>> new file mode 100644
>> index 0000000..7baf9e1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
> <snip>
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_stat & SI=
RFSOC_I2C_STAT_NACK)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_err(&siic->adapter.dev, "ACK not received\n");
> Could we send stop here?

no. when the interrupt happens and goes into the irq, the whole i2c hw
sequence has finished.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_err(&siic->adapter.dev, "I2C error\n");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 complete(&siic->d=
one);
> <Snip>
>
>> +static int i2c_sirfsoc_resume(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platform_=
device(dev);
>> + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_=
drvdata(pdev);
>> + =C2=A0 =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_da=
ta;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 clk_enable(siic->clk);
>> + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSO=
C_I2C_CTRL);
> Could you explain why is a reset needed.
> Or am I missing something.

this is helping the i2c controller restore to a stable status. this
reset is not always needed, but it is sure that it can help to fix
some unstable issues of hardware if they do exist.

>
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
>> +
>> +static const struct dev_pm_ops i2c_sirfsoc_pm_ops =3D {
>> + =C2=A0 =C2=A0 =C2=A0 .suspend =3D i2c_sirfsoc_suspend,
>> + =C2=A0 =C2=A0 =C2=A0 .resume =3D i2c_sirfsoc_resume,
> Could we use simple dev_pm ops here?

i guess you mean SIMPLE_DEV_PM_OPS. the only problem is i2c bus driver
doesn't need entries like:
 .freeze =3D suspend_fn, \
 .thaw =3D resume_fn, \
 .poweroff =3D suspend_fn, \
 .restore =3D resume_fn,

at least in our test, without these entries,  suspend to ram, suspend
to disk(hibernation) and poweroff have always worked well.

>
>> +};
>> +#endif
>> +
>> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitco=
nst =3D {
>> + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "sirf,prima2-i2c", },

-barry
