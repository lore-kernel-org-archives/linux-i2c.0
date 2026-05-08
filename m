Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EEC293B75
	for <linux-i2c@vger.kernel.org>; Fri,  8 May 2026 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209603; cv=none; b=hMS6UxPGkBjailxFpr/1tvOMMABrnolGxUp8rhJ8KxGj7VOlxZU7bLmE72usX56jMYZxnFotHqJ2WvSbHGNysKYTSBz2Mvo86xse7GYLV8QZiQE5/oVS4V/53Yjlfk4MF8mt9xAF/meWWZMVvlaY9A/vBjVLr51dZB7ZaGPUqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209603; c=relaxed/simple;
	bh=HOaLBVwOi2SeNx/rpT5yplhV+BCsdrhoEmKfmE8GNP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjG3R4BgxITcmNZDrIxeDE11RzqSm1XWDAe/3Bhq4BtTyFPXlkbd45EnKwknvfZJlB0EkZHsQcstTfI+WsXt5t55rwnqiLGuODAi+mmzOYvi1Bdjufg4foLZ/gQUs9Tzj2YaSdviT/NHX7LcmkGb3q3fxfkh4ddpF1ntHuOVUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+8xwZry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+8xwZry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C127CC2BCFB
	for <linux-i2c@vger.kernel.org>; Fri,  8 May 2026 03:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778209602;
	bh=HOaLBVwOi2SeNx/rpT5yplhV+BCsdrhoEmKfmE8GNP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O+8xwZryG4b8MwVM4FROcBwwzUmjbTd0s6mA2lFZZss2Wck1yvTmHLiQa1GjBGqDz
	 lKZ7ntYMBEpDixBGpNFLETAyW9EXD0hMXzfCc3sP6ed2pNBfjU2U/bzoxssJZBsR1+
	 x3MusTroJqb9FsDaAP/DScmeV4m4zlNMxCJ1lms412OEX/cqU71iLpu+9Yw4LoHy3p
	 rCg4h5D9VoPDMsFRVnQH3rEXYxbcB1KAjizpLSd8+ZacaiM8aFxcURRTByQMx8sVVg
	 qPN+jjbsxXii5T2pTYCyxWRWZiz/srnkm3wpb2kvsLGlOaIqAPkY3BebaWf5zjBcXw
	 bFsbDfPltGKlA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bc177ebda91so292113566b.3
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 20:06:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/PaSsjKN/GuCHDmRwjAYqDA+PpuNVPPl8ca39aeEa0WXyYrmRZDA7Q+XiOEGhBsVVNqHGqLZreMJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/m00WAlWJt2WMM+xmJfgF0kem61qH9B6QA4mNZNPtZEFKFDd3
	gyvNXkMvDQqr/bZu/rUiQGXtLsAsZYrzLtr8uXZorVnujPHoU+h3B5XQirssQWVAWR1f4wLgYhZ
	jR+nb7yPAjPa/7OgMfK2+ATEjTMF9PV8=
X-Received: by 2002:a17:906:5187:10b0:bc4:9acf:f53 with SMTP id
 a640c23a62f3a-bc56c62c6d8mr554913966b.20.1778209601248; Thu, 07 May 2026
 20:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507081010.12810-1-wanghongliang@loongson.cn> <20260507081010.12810-2-wanghongliang@loongson.cn>
In-Reply-To: <20260507081010.12810-2-wanghongliang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 8 May 2026 11:06:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H46sOPPAoH31DijWYK+v5fEzgq7ZVucCuoyRTwTgUHYxA@mail.gmail.com>
X-Gm-Features: AVHnY4J_-aYxSREAluBXlm9Bi9SsaJaacOWMVK_KUGdF5m_vVZ-0b_vQKA1iI84
Message-ID: <CAAhV-H46sOPPAoH31DijWYK+v5fEzgq7ZVucCuoyRTwTgUHYxA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus speed
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongliang,

On Thu, May 7, 2026 at 4:11=E2=80=AFPM Hongliang Wang <wanghongliang@loongs=
on.cn> wrote:
>
> From: wanghongliang <wanghongliang@loongson.cn>
>
> The i2c-ls2x driver supports dts and acpi parameter passing.
> In dts, uses clock framework, by parsing clocks property to
> get i2c bus reference clock, and define factor by device data.
> In acpi, by passing clocks property to describe i2c bus reference
> clock and clock-div property to describe factor.
> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> and factor, calculate the prcescale of i2c divider register.
> The calculation formula is
> prcescale =3D clock_a/(factor*clock_s)-1
>
> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> ---
>  drivers/i2c/busses/i2c-ls2x.c | 42 ++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.=
c
> index b475dd27b7af..7db91e7a5d78 100644
> --- a/drivers/i2c/busses/i2c-ls2x.c
> +++ b/drivers/i2c/busses/i2c-ls2x.c
> @@ -13,6 +13,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/completion.h>
> +#include <linux/clk.h>
This should be before completion.h.

>  #include <linux/device.h>
>  #include <linux/iopoll.h>
>  #include <linux/i2c.h>
> @@ -63,11 +64,16 @@
>  /* The default bus frequency, which is an empirical value */
>  #define LS2X_I2C_FREQ_STD      (33 * HZ_PER_KHZ)
>
> +struct ls2x_i2c_chip_data {
> +       unsigned int    factor;
> +};
> +
>  struct ls2x_i2c_priv {
>         struct i2c_adapter      adapter;
>         void __iomem            *base;
>         struct i2c_timings      i2c_t;
>         struct completion       cmd_complete;
> +       const struct ls2x_i2c_chip_data *chip_data;
Use "unsigned int    factor" directly?

>  };
>
>  /*
> @@ -96,6 +102,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *de=
v_id)
>  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  {
>         u16 val;
> +       u32 pclk, factor;
factor or div? If factor is better, then rename clock-div to
clock-factor; if div is better, then rename factor to div.

> +       struct clk *clk;
>         struct i2c_timings *t =3D &priv->i2c_t;
>         struct device *dev =3D priv->adapter.dev.parent;
>         u32 acpi_speed =3D i2c_acpi_find_bus_speed(dev);
> @@ -107,12 +115,30 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i=
2c_priv *priv)
>         else
>                 t->bus_freq_hz =3D LS2X_I2C_FREQ_STD;
>
> +       if (dev_of_node(dev)) {
> +               clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +               if (IS_ERR(clk) || !clk)
> +                       pclk =3D LS2X_I2C_PCLK_FREQ;
> +               else
> +                       pclk =3D clk_get_rate(clk);
Reverse the "if & else" so the default case will be the last one, this
is also the same as the ACPI case below.

Huacai

> +
> +               factor =3D priv->chip_data->factor;
> +
> +               val =3D (pclk * 10) / (factor * t->bus_freq_hz) - 1;
> +       } else {
> +               if (!device_property_read_u32(dev, "clocks", &pclk) &&
> +                   !device_property_read_u32(dev, "clock-div", &factor) =
&&
> +                   factor !=3D 0)
> +                       val =3D (pclk * 10) / (factor * t->bus_freq_hz) -=
 1;
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
> @@ -295,6 +321,8 @@ static int ls2x_i2c_probe(struct platform_device *pde=
v)
>         if (!priv)
>                 return -ENOMEM;
>
> +       priv->chip_data =3D device_get_match_data(dev);
> +
>         /* Map hardware registers */
>         priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->base))
> @@ -348,9 +376,17 @@ static int ls2x_i2c_resume(struct device *dev)
>  static DEFINE_RUNTIME_DEV_PM_OPS(ls2x_i2c_pm_ops,
>                                  ls2x_i2c_suspend, ls2x_i2c_resume, NULL)=
;
>
> +static const struct ls2x_i2c_chip_data ls2x_i2c_2k_data =3D {
> +       .factor =3D 4,
> +};
> +
> +static const struct ls2x_i2c_chip_data ls2x_i2c_7a_data =3D {
> +       .factor =3D 5,
> +};
> +
>  static const struct of_device_id ls2x_i2c_id_table[] =3D {
> -       { .compatible =3D "loongson,ls2k-i2c" },
> -       { .compatible =3D "loongson,ls7a-i2c" },
> +       { .compatible =3D "loongson,ls2k-i2c", .data =3D &ls2x_i2c_2k_dat=
a, },
> +       { .compatible =3D "loongson,ls7a-i2c", .data =3D &ls2x_i2c_7a_dat=
a, },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, ls2x_i2c_id_table);
> --
> 2.47.2
>
>
