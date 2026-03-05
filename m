Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41536395261
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718728; cv=pass; b=em3zR78YLn47mxHdIGx2jW5HSzDUVymuENHtL9uK9BB05fFaye8uDRGMX4bD7VDpAd4ay8z4GnGDYtCFx844GWvVEJc1TyWkeNMfFkmnNPkcw0IDYp0pCEDxUOEMFeG/vseS3gv45/MdpVgJhk9uQFBejLz3jJpdPvgWkW5paxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718728; c=relaxed/simple;
	bh=7nQxQrQcVoedGHXekMdQmt0PnChsID8+XSzvyS0i5/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5vD3BL0Lii3GsrEou2xjTreZQ6gbZl4Ha3cOVIXde20bkwsWgmUdu8ZHFps+djabiikwyJ2KLYjmXGOy7am2Mi+EOsTdzDu+Y3cBTNGl2/vYzSRi58FeFdLNV5M7qs30ACI0dF6dZus0hRO9SfUMzlgo0R/rfaiwbpgWMEOaCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSjVAMBW; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSjVAMBW"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9372552059so1110460766b.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 05:52:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772718725; cv=none;
        d=google.com; s=arc-20240605;
        b=SvN3Hu3GiBQyGbM4ovrJ+ygTp63DgeJPOepS7oaBYCf3LHuB82sWcRBJtKPPxNtZ5P
         d+79/V4lGEjndZ/7HxlFMhVSp0BqILtVaybre4YWrgT+259sJDMyk94VHKMBSV8/o21+
         x390MIEh4VTzq85fxjY48HPpQfP8sMERJ9bQvWK6DR8a4DtsP1uO/DEK8gB/UoHFbd12
         2tJBJ2Cir8rlKLit+72bNYlLH4gDT5B4pgJFEFaMqia9poMxvwRmhvMgEwu3pzFX5mqB
         FtHV3IE+MDSpa9HkHDaweAel7/lYNSKxQCEOAcPZldRFwjlX8GydkvjBTackklBbRpjL
         Z4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZyEoKNZ9+FBEZoQGrBgOEAt7Mvz4sJQ58VTFJSuB4U=;
        fh=6bwqhPSBAW/1ZSMfAYEcI0dMWGyITeqx1ZPHttVo4sc=;
        b=ZioMq6X6ZVDoPtcOYrm+mPO496YveeW4CGlY5IQ9jys71cjw7rRBbJ5loftfw4VJuI
         2v/tT+GrlHA2bEV/law5iiewKE0+4iR40kF3WcEi0RPxF0ROFFwveaimH4+gPXlmBIst
         miftaxP69TuaoPGjJcpIvXdHCCxJeqYILgC1OzouAnjHMBaG3aaKUHUIgbIagPxmVVUA
         ex9m12Hh0a4SH9Tc3DjetT4WPkAbS2RBDKc7qyXnU6FYvIoXr/7jAxds0+YkoA3uxIJg
         4eA28J2yHm65CuWWYJ5bvpUGiFdwYnd0wOpS+wt4TMNVqNSmchw98Hm+Ee9Yk+vG/OrI
         i//g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772718725; x=1773323525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZyEoKNZ9+FBEZoQGrBgOEAt7Mvz4sJQ58VTFJSuB4U=;
        b=hSjVAMBWOc8/UAqVDw4/hRqucAjcy6eFJ42n9K1tmsUUBpl1xj4LpzIbXaAgA6YmsC
         m6M9JTBtoztFy00IF6fW/Hse80sJmtS5wHFZ2iAWYUx2eXocXJfnCFpTPlMeDlH6KX2q
         CC1cHUmjrVXCn7r/nqwn4w1Yzge0H8JfKH1V+ESIsNx202V8kShQ2k7wZGKR6G7Him1u
         CPLvz/R5LPZEgMTGssqePxVGiMpYecnkU1ex8Qja6ckqohxH0bqdrEqT9JtWI6aRDIY7
         KceXUbWd4+U7nHIWD6SHlhNtRJ6Bl0lHxtMk7926d5ypEtN9scX/HzO8eUCl5gkhzZML
         4qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772718725; x=1773323525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZyEoKNZ9+FBEZoQGrBgOEAt7Mvz4sJQ58VTFJSuB4U=;
        b=HheUTZFWTYGcxGRaN9OmCgmHXFC95lgcFkGdCuXXLRqkEChV7H/TW4LZqTHamZWhxF
         hVq30iqmtmdxae98JRUljKRd3L59CLuK6Fc3e/8Jrp422zR+O5UQDV8JD3/HPJy8VIoN
         550dX6tcMCiWqoe02KjEem31qDl9W+NyWJpSWwSzQtQ2hRcEukbXumpokkoCmkEHWSUA
         /Q9zgYDHQjD1vtHDMW5xVZEO6EZr8RQgJHNp3PGewdVutPxMhXTfQgvMncy0otWRoFSd
         iWnxp0Q5kL20anw51EGYXfdXW3UraXMV282ZI4tf3Mdj1m0BnQt31yZOVp+2SfRWctmM
         i2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdHW3KwGybzuAD8xxfUhu5xJpkFqipAYz3V2pTWHwTnpAnMcuiFR92lIa1mSQ80SB+BoRt4dMQx/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoAk/04SjAfjsZTAKCwi4izfZUu8whWYt7s6yulvlQjLLH2Nl
	C3yBwcnjtoxkfxuaGwaSCTu4oC9TPH10UO62x3E9J9i7UO3XmTuHv3v1nT9KBupRsbTQGkXKxHv
	EmTqDi98e2/ad45RApi+/9nv5kDgIizQ=
X-Gm-Gg: ATEYQzxoyNbr9PkmqJR+8dG0Zb6gf0Yunh0i306hzQqbC0SMbaP5Deo4ZHNuQAW3w6U
	z1nvlfrFwkUffVLZfU7IOesi/FyIX1csHAyIVBF/c66ip2YTiCl0937da8B2fRNUw08N45RM2J4
	LC7X2oe7Eadsa2YPMoeykZHz6kKs/cUC+thC8IPNHR3aDNGC6I2mFj70QOcZCt7Ni14BasZz3Hu
	7VmhqCY6T3RYPhmwALkBwH25FHhXM6O8up0ft8sDpPMaB1YQ+QwdiGQ/dnPFP7bJg+r+tq+QH1u
	yrFvkHInt8707qWFT2iZMgzr5jRiraNaeZs9FyZb9yi01sMs1SI3and0eaOWTqptSNGfBleyILn
	Y1fvng4A=
X-Received: by 2002:a17:907:3c8c:b0:b87:701d:341a with SMTP id
 a640c23a62f3a-b93f1372c8bmr367272966b.25.1772718725247; Thu, 05 Mar 2026
 05:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772714348.git.zhoubinbin@loongson.cn> <8b8dbdc580fd2e2ebf1d5990e55e4a50db1b253a.1772714348.git.zhoubinbin@loongson.cn>
In-Reply-To: <8b8dbdc580fd2e2ebf1d5990e55e4a50db1b253a.1772714348.git.zhoubinbin@loongson.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Mar 2026 15:51:27 +0200
X-Gm-Features: AaiRm51vh4mEPHUkSIfvf4ZLeVmD0p7aetq1ZB0tT3uMdF2f-JUBdgLw69Qz0Bg
Message-ID: <CAHp75VfmupH=dE=L3+vboo7D9DDEMvU-Hwy6HwuVFsg1iB7hcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 2:57=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> This I2C module is integrated into the Loongson-2K0300 SoCs.
>
> It provides multi-master functionality and controls all I2C bus-specific
> timing, protocols, arbitration, and timing. It supports both standard
> and fast modes.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

+ time.h // for USEC_PER_* et alia.

> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +/**
> + * struct loongson2_i2c_priv - private data of the controller
> + * @adapter: I2C adapter for this controller
> + * @complete: completion of I2C message
> + * @clk: hw i2c clock
> + * @regmap: regmap of the I2C device
> + * @parent_rate: I2C clock parent rate in MHz
> + * @msg: I2C transfer information
> + */
> +struct loongson2_i2c_priv {
> +       struct i2c_adapter              adapter;
> +       struct completion               complete;
> +       struct clk                      *clk;
> +       struct regmap                   *regmap;
> +       unsigned long                   parent_rate;

it's better to keep units in the variable name

       unsigned long                   parent_rate_MHz;

// yes, it's fine to spell the unit suffix as it's in physics.

> +       struct loongson2_i2c_msg        msg;
> +};

...

> +static void loongson2_i2c_handle_rx_done(struct loongson2_i2c_priv *priv=
)
> +{
> +       struct loongson2_i2c_msg *msg =3D &priv->msg;

> +       u32 i;

Not needed to be here (see below how).

> +       switch (msg->count) {
> +       case 2:
> +               /*
> +                * The STOP/START bit has to be set before reading the la=
st two bytes.
> +                * After that, we could read the last two bytes.
> +                */
> +               regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONG=
SON2_I2C_CR1_OP_MASK,
> +                                  msg->stop ? LOONGSON2_I2C_CR1_STOP : L=
OONGSON2_I2C_CR1_START);

> +               for (i =3D 2; i > 0; i--)
> +                       loongson2_i2c_read_msg(priv);

First of all, in another case the type of iterator is unsigned int.
Second, this iterator is not used outside of the for-loop, third, the
upper limit is already known, no need to use magic, hence

               for (unsigned int i =3D 0; i < msg->count; i++)

> +               loongson2_i2c_disable_irq(priv);
> +
> +               complete(&priv->complete);
> +               break;
> +       case 3:
> +               /*
> +                * In order to generate the NACK after the last received =
data byte, enable NACK
> +                * before reading N-2 data
> +                */
> +               regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONG=
SON2_I2C_CR1_ACK, 0);
> +               loongson2_i2c_read_msg(priv);
> +               break;
> +       default:
> +               loongson2_i2c_read_msg(priv);
> +               break;
> +       }
> +}

...

> +static int loongson2_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_m=
sg msgs[], int num)
> +{
> +       struct loongson2_i2c_priv *priv =3D i2c_get_adapdata(i2c_adap);
> +       struct device *dev =3D priv->adapter.dev.parent;
> +       unsigned int i, status;
> +       int ret;
> +
> +       /* Wait I2C bus free */
> +       ret =3D regmap_read_poll_timeout(priv->regmap, LOONGSON2_I2C_SR2,=
 status,
> +                                      !(status & LOONGSON2_I2C_SR2_BUSY)=
,
> +                                      LOONGSON2_I2C_FREE_SLEEP_US,
> +                                      LOONGSON2_I2C_FREE_TIMEOUT_US);
> +       if (ret) {
> +               dev_dbg(dev, "The I2C bus is busy now.\n");
> +               return ret;
> +       }
> +
> +       /* Start generation */
> +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C=
_CR1_START,
> +                          LOONGSON2_I2C_CR1_START);

> +       for (i =3D 0; i < num; i++) {

       for (unsigned int i =3D 0; i < num; i++) {

> +               ret =3D loongson2_i2c_xfer_msg(priv, &msgs[i], i =3D=3D n=
um - 1);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return num;
> +}

...

> +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *pri=
v)
> +{
> +       struct device *dev =3D priv->adapter.dev.parent;
> +       struct i2c_timings i2c_t;
> +       u32 val, freq_mhz, ccr;

freq_MHz
(or at least make the parent_rate and this one consistent with the
suffixes in use)

> +       i2c_parse_fw_timings(dev, &i2c_t, true);
> +       priv->parent_rate =3D clk_get_rate(priv->clk);
> +
> +       if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_STANDARD_MODE_FREQ) {
> +                /* Select Standard mode */
> +               ccr =3D 0;
> +               val =3D DIV_ROUND_UP(priv->parent_rate, i2c_t.bus_freq_hz=
 * 2);
> +       } else if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_FAST_MODE_FREQ) {
> +               /* Select Fast mode */
> +               ccr =3D LOONGSON2_I2C_CCR_FS;
> +               val =3D DIV_ROUND_UP(priv->parent_rate, i2c_t.bus_freq_hz=
 * 3);
> +       } else {

> +               dev_err(dev, "Unsupported speed (%uhz)\n", i2c_t.bus_freq=
_hz);

hz --> Hz (in the message)

> +               return -EINVAL;
> +       }

It seems part of the probe phase, so why not

  return dev_err_probe(...);

?

> +       FIELD_MODIFY(LOONGSON2_I2C_CCR_CCR, &ccr, val);
> +       regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);
> +
> +       freq_mhz =3D DIV_ROUND_UP(priv->parent_rate, HZ_PER_MHZ);
> +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C=
_CR2_FREQ,
> +                          FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_mhz));
> +
> +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_TRISE, LOONGSON2_I=
2C_TRISE_SCL,
> +                          LOONGSON2_I2C_TRISE_SCL);
> +
> +       /* Enable I2C */
> +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C=
_CR1_PE,
> +                          LOONGSON2_I2C_CR1_PE);
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko
