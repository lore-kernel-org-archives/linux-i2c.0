From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
Date: Thu, 16 Feb 2012 22:24:00 +0530
Message-ID: <CAM=Q2ct7EHht06uCHVpR_HoO39WZjO2+N6DhxuMthRQRQBRnyw@mail.gmail.com>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328714915-12287-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Feb 8, 2012 at 8:58 PM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
>
> SiRFprimaII is the latest generation application processor from CSR=92=
s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> There are two I2C controllers on primaII, features include:
> * Two I2C controller modules are on chip
> * RISC I/O bus read write register
> * Up to 16 bytes data buffer for issuing commands and writing data
> =A0at the same time
> * Up to 16 commands, and receiving read data 16 bytes at a time
> * Error INT report (ACK check)
> * No-ACK bus protocols (SCCB bus protocols)
>
> Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> ---
> =A0-v6:
> =A0fix/cleanup lots of minor issues pointed out by wolfram;
> =A0add OF property clock-frequency to support freq setting by DT;
> =A0add lost devicetree binding document;
>
> =A0Documentation/devicetree/bindings/i2c/sirf-i2c.txt | =A0 19 +
> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 10 +
> =A0drivers/i2c/busses/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A01 +
> =A0drivers/i2c/busses/i2c-sirf.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0459 ++++++++++++++++++++
> =A04 files changed, 489 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/i2c/sirf-i2c.=
txt
> =A0create mode 100644 drivers/i2c/busses/i2c-sirf.c
>
> diff --git a/Documentation/devicetree/bindings/i2c/sirf-i2c.txt b/Doc=
umentation/devicetree/bindings/i2c/sirf-i2c.txt
> new file mode 100644
> index 0000000..7baf9e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
<snip>

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_stat & SIRFSOC_I2C_STAT_NACK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&siic->adapter.=
dev, "ACK not received\n");
Could we send stop here?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&siic->adapter.=
dev, "I2C error\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&siic->done);
<Snip>

> +static int i2c_sirfsoc_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct i2c_adapter *adapter =3D platform_get_drvdata(pd=
ev);
> + =A0 =A0 =A0 struct sirfsoc_i2c *siic =3D adapter->algo_data;
> +
> + =A0 =A0 =A0 clk_enable(siic->clk);
> + =A0 =A0 =A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL=
);
Could you explain why is a reset needed.
Or am I missing something.

> + =A0 =A0 =A0 writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 siic->base + SIRFSOC_I2C_CTRL);
> + =A0 =A0 =A0 writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL=
);
> + =A0 =A0 =A0 writel(siic->sda_delay, siic->base + SIRFSOC_I2C_SDA_DE=
LAY);
> + =A0 =A0 =A0 clk_disable(siic->clk);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct dev_pm_ops i2c_sirfsoc_pm_ops =3D {
> + =A0 =A0 =A0 .suspend =3D i2c_sirfsoc_suspend,
> + =A0 =A0 =A0 .resume =3D i2c_sirfsoc_resume,
Could we use simple dev_pm ops here?

> +};
> +#endif
> +
> +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitcon=
st =3D {
> + =A0 =A0 =A0 { .compatible =3D "sirf,prima2-i2c", },
