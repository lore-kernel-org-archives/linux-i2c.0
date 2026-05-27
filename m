Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196B3B7B7F
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865525; cv=none; b=eQEgWLFOpxrJQnLPIrkhvOVHUdlNhLpYoKKTrNT+agoUeBOw3+k3FchxNXR2Y+XWyMaTFpTIqPpfC0VO3I8PDwAAnWmJKHokEK2gFaoo1rfWmJWs+NSH9vZ8Wmgp3LVz8eKaqkKmMQy124adTHR/McuuiymEr3lzHiHlpZclRJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865525; c=relaxed/simple;
	bh=0pCwy/RguArIW+sW86JSSX5fHL1H3WwZncOI/Pose9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER0c9kFrsZ55akrmA7MtwUBmtvI3da8c+KdR4BJ3O951gUP2OSEsNWKZStdybYGad4MMHEwUWvKVJ25AqFye7zL9lokSoA06IRkJ2ltd47guTldOfQxJ8GTwudW2DMhPkB9Vp4c6qmuiZW78eOW2Bt1zsbwZM1wN7ejJrStLjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaLezCvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaLezCvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006E51F00A3D
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 07:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779865524;
	bh=MO6v4HCZ6LZWxyBV36xbPHRbeaRHshh+uR5yRAgk3F0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OaLezCvn2bGbIWkY31MgtotWImoniNhWzasJl/PaQBzyqoNpwfni55c+gfNn/JKXh
	 b0gR0IyyLgz2aboPqnBMvliCGznPB+NgaM5aVgAvSn6b3M2Ydk2a2rr1V0jYfnBY9F
	 emiVVP++y1H8CsjCAEX4XxyDpjGG07j3Ymjg+HhVjPKZMmoRmIAerg0VIwnmweSVRH
	 Z5WR8GeqPytRzfoBsgwiLR4rv9KWgg7TJxS2VRc+Nxhd43FemXbasbOfY50GVzAylJ
	 y2kQHRiYTF7jpSS+WWOJDybgs8C0nfn7n1pp0xVOd5rffVpubglI7WsLRiDpmQ6Q2z
	 lYNkJdhPR/h9Q==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bdb3eb93e20so1033622366b.0
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 00:05:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8EkG/h8puPJdds9BGC6TPNmMQYtPfS7PnrajWchYXsA2aN6lTy6YPrNZQub73nCeZcItQc15+9TxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BxQ92Dmd4+qynZLLVC5x+6FqsEV5LDmZQnkFeNb1yt2vavhS
	2iPzj/0w/Zdj13jMVLmKdrLs0Fwq8ckgl5GBvbdJCJPdBCxWGP94FwOsDqB0ZEP58pN8t6vXZVW
	FnIzIMPM5DwZUriK2OvxXgPatCp+ABII=
X-Received: by 2002:a17:907:c706:b0:bdc:bb32:2ea9 with SMTP id
 a640c23a62f3a-bdd263cb23emr1287027566b.35.1779865522506; Wed, 27 May 2026
 00:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526031021.32662-1-wanghongliang@loongson.cn> <20260526031021.32662-3-wanghongliang@loongson.cn>
In-Reply-To: <20260526031021.32662-3-wanghongliang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 27 May 2026 15:05:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H71ZiakZaLVKYg2Qvp8ZJiT7hr9P9bAmXCrjWkHg+-vGg@mail.gmail.com>
X-Gm-Features: AVHnY4KXhbotlQbkE83Q64EiG9DjibgCY4KcfZdbq6nZO0CioN0A_51bEtuDJvs
Message-ID: <CAAhV-H71ZiakZaLVKYg2Qvp8ZJiT7hr9P9bAmXCrjWkHg+-vGg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongliang,

On Tue, May 26, 2026 at 11:11=E2=80=AFAM Hongliang Wang
<wanghongliang@loongson.cn> wrote:
>
> From: wanghongliang <wanghongliang@loongson.cn>
>
> The i2c-ls2x driver supports dts and acpi parameter passing.
>
> In dts, uses clock framework, by parsing clocks property to
> get i2c bus reference clock, and define the div of reference
> clock by device data.
>
> In acpi, by passing clocks property to describe i2c bus reference
> clock and clock-div property to describe the div of reference clock.
>
> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> and div, calculate the prcescale of i2c divider register. The
> calculation formula is
>
> prcescale =3D (clock_a*10)/(div*clock_s)-1
>
> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> ---
>  drivers/i2c/busses/i2c-ls2x.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.=
c
> index b475dd27b7af..6d332e59452d 100644
> --- a/drivers/i2c/busses/i2c-ls2x.c
> +++ b/drivers/i2c/busses/i2c-ls2x.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/iopoll.h>
> @@ -63,11 +64,18 @@
>  /* The default bus frequency, which is an empirical value */
>  #define LS2X_I2C_FREQ_STD      (33 * HZ_PER_KHZ)
>
> +/* The div of i2c reference clock on 2K0500/2K1000/2K2000 */
Please use "LS2K0500/2K1000/2K2000".

> +#define LS2X_I2C_2K_CLOCK_DIV  40
> +
> +/* The div of i2c reference clock on 7A1000/7A2000 */
And "LS7A1000/7A2000".

BTW, I think this series should be CC stable.

Huacai

> +#define LS2X_I2C_7A_CLOCK_DIV  50
> +
>  struct ls2x_i2c_priv {
>         struct i2c_adapter      adapter;
>         void __iomem            *base;
>         struct i2c_timings      i2c_t;
>         struct completion       cmd_complete;
> +       unsigned int            div;
>  };
>
>  /*
> @@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *de=
v_id)
>  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  {
>         u16 val;
> +       u32 pclk, div;
> +       struct clk *clk;
>         struct i2c_timings *t =3D &priv->i2c_t;
>         struct device *dev =3D priv->adapter.dev.parent;
>         u32 acpi_speed =3D i2c_acpi_find_bus_speed(dev);
> @@ -107,12 +117,29 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i=
2c_priv *priv)
>         else
>                 t->bus_freq_hz =3D LS2X_I2C_FREQ_STD;
>
> +       if (dev_of_node(dev)) {
> +               clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +               if (clk && !IS_ERR(clk))
> +                       pclk =3D clk_get_rate(clk);
> +               else
> +                       pclk =3D LS2X_I2C_PCLK_FREQ;
> +
> +               div =3D priv->div;
> +
> +               val =3D (pclk * 10) / (div * t->bus_freq_hz) - 1;
> +       } else {
> +               if (!device_property_read_u32(dev, "clocks", &pclk) &&
> +                   !device_property_read_u32(dev, "clock-div", &div))
> +                       val =3D (pclk * 10) / (div * t->bus_freq_hz) - 1;
> +               else
> +                       val =3D LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz)=
 - 1;
> +       }
> +
>         /*
>          * According to the chip manual, we can only access the registers=
 as bytes,
>          * otherwise the high bits will be truncated.
>          * So set the I2C frequency with a sequential writeb() instead of=
 writew().
>          */
> -       val =3D LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>         writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_=
LO);
>         writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER=
_HI);
>  }
> @@ -295,6 +322,8 @@ static int ls2x_i2c_probe(struct platform_device *pde=
v)
>         if (!priv)
>                 return -ENOMEM;
>
> +       priv->div =3D (unsigned int)(unsigned long)device_get_match_data(=
dev);
> +
>         /* Map hardware registers */
>         priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->base))
> @@ -349,8 +378,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
>                                  ls2x_i2c_suspend, ls2x_i2c_resume, NULL)=
;
>
>  static const struct of_device_id ls2x_i2c_id_table[] =3D {
> -       { .compatible =3D "loongson,ls2k-i2c" },
> -       { .compatible =3D "loongson,ls7a-i2c" },
> +       { .compatible =3D "loongson,ls2k-i2c", .data =3D (void *)LS2X_I2C=
_2K_CLOCK_DIV, },
> +       { .compatible =3D "loongson,ls7a-i2c", .data =3D (void *)LS2X_I2C=
_7A_CLOCK_DIV, },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);
> --
> 2.47.2
>
>
