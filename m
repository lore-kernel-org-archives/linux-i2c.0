Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2836C0D7
	for <linux-i2c@vger.kernel.org>; Fri,  6 Mar 2026 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777591; cv=pass; b=Z36GlQDjS+pCZjEHZ9QoNXe+is79rev7wmFVEjCkAC071SYd2KqnqrDlMci5ciOmT8cOjwbqm5SapCfY5UKnmGK9QJqV+3Mk6p0UeKbtoX7DjZEsNJ0//z8ekjaAbQ9lyNy1tv0Rzf8b2lDcp90t62GbPqtS72Jz5nXOzJUWDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777591; c=relaxed/simple;
	bh=J9ejm7l2pDDZBEBAmBnyioiS0RjaAA3R3XJo0dQw3zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTctJvB7jJtFbi6G8BOYZlVJ3vWAxlyp+WSKfzFPyFxOBL8c+MbNi15GP+F4/ryTaQ7etZtnMehgiZ0K0MLdpelayYhNWKW/mu1FklIvzwicMFDGvkFeR/EAUQsqF2ZOtrG0TIviPFDjNbfm8kz89JgQsOBs0dD/u1NYLGv4JXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxc10K74; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxc10K74"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fbb24a9a9so1451364266b.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 22:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772777589; cv=none;
        d=google.com; s=arc-20240605;
        b=WXgI3EXFU3a3B9/EpFqx2YBXp1biayruvXpQaADmoe/KxDDLcLlw2GDJY3J9eK5LYJ
         SSlHJ5Ubacgoqb9AWdEPnlux09z40WHKPT0KI2oawioJ2QVkt8rPC/X06UhyEWZvz52l
         JD0rUmU1jMZjZdVfeD0bQMN1OtOcpYPcNSVRihLmlsl5ZNsNhs+DwpiORtKUIMdlzepY
         TV4SV8pFEmDddsVxbFLVqcAHXgiTuXVAa4FGQypIHenpvVTIH9U9VWe9T8q1eXSEH1Xj
         URsGCuAZJkpnEuSx2XchCqz0X8CnDn+dNvaihM3Lu6T7/6H3OWDPmgKSN6jRPoH+LC0d
         lwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8VAPLzN3H0mvNexfeYo6kcXoCX1WV6dDMHioOJ34WQ=;
        fh=ZKIPDwmAw8hvW1/waIQqqRq7nNb+p7/P0sYuGvsJrDo=;
        b=CaTG7/gyDXi0Mke8ecO60P1Sjrg06QNbW3+laCcryfdFE3r02ujvLZhfRAQwSWcmNl
         QwVLPRpuMAfpvu5O55p92tVR2/RsU2ygCbu3XPOkT18GDmtCg70UMYkJRkj53g4efyXy
         Wgcq9fwxzHRodmCYBXRDCqyETcyTLWH/5PZwu+KFP4MBFvjFyjb7m3LT3I6C9bFshUhF
         0EkWbc6nDWe7Z5jUwO31gFMYvQwleEMXKr29AXSiSf2QZPxXKtqn9CX34tIYyPPD3+8p
         AH/LtxLZThnSPtIxQpg9zxrQZG/rhaJecE+j96DpleGkg1kySrHe2SHJeQgn2DfOm4gd
         wZHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772777589; x=1773382389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8VAPLzN3H0mvNexfeYo6kcXoCX1WV6dDMHioOJ34WQ=;
        b=hxc10K74HakH0e9YYUijVuwBsTR42Ndp8eheClmK4qFd1O2Ny/XanKP+b0YS1pX/Bd
         Cs340/a7IgACVgbNBNa0uurh9MYaANHl5ez+9/Kkch2vzaIXOHKKS1nN8CvqhnTetVSE
         yd1L5g5dFvp5PrmpQryCKSmws1scyoZXpkQg0GF2IKGHbEDmsSeTY4GVxeA2v/PZC6jQ
         uKNXkQsBHK05oF+oebDXYk1wbyyGCid/IAcpyl8vYg2kNKHRQr9mANEKSg6+pJ1hAFY1
         Iv1qTQ0S22KOOMQzTGfeTQgW2BU+5q0F7Nq/hktR/AB/1dEjgtgWthZb55xKuiPpe9R+
         H5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772777589; x=1773382389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8VAPLzN3H0mvNexfeYo6kcXoCX1WV6dDMHioOJ34WQ=;
        b=SE4M5JyyKoFf2vfFilgLUkuXZtGGyqRjH+e4oTe602rgHjlnBUNQLKEdIwD5iYFIYr
         iTeqjZM3f8FhiSiak9+lGHTKbMNNxJz9VzzkPsPv0ZB/b45rEJBFLvYlNGmRYdWyBIDh
         2DykIpeeZzt2ggViVswWXSr1RSd1oH4JUEIGNy8NSzMuy+yifcNx4AknWljImvsLoJ6e
         m9bpXDKKiLj3o9Cx49FE1eHyufD0FcXgyfUvYSAdzEi6G3IMltx74rPDygF7EvAZ1Ttd
         bTtFjVS+nlJCfsYToisI2q7kZ/cBn7geaWAH3otzBSxipGposlyUT/+sYs3KaG+7X8vC
         Y1BA==
X-Forwarded-Encrypted: i=1; AJvYcCUi3ov7LDCfukVETmNvhr/zsTGQsYzDqFgf6ZkYdMEaB1wcWmbnxf9SOyPRu9CMto9oreD4eAczS7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlR77vGGr0gC4K6+PsBvrAMafPOjgll1n8KkueHhRHPdu2lXfN
	uPXepwYYLUsRBhDcVlO8tOi/1bPdZrESJqGUo4qAhpj9h1BSY6LRXRbkHovUI1w+PHjUdX3sm9r
	wBntnRaH1UOiae36a7Bbwaya+1juqgns=
X-Gm-Gg: ATEYQzy2Lh+fjXXBy4aaSf2FLknz57ltBaJx7Elt4EnJtkPliLd+3cWfX0WJwpyZjD4
	20MADaPms2GZ4n7DXzmqrbpNWXyDTzDOXpyAnsmspJLmu0jvneF4Q1q1ch11AwVJWwotCzGPu6Q
	SSpR+Kuuk3KoYiyOzk28eziay3vrZ3GBguXNrG30mvfQI0FQKg/tEQMHkTGB9qy6XZtnW5qLtmC
	fMmQR2bVzbqgXGQso2ycUp/xZw0y/2soaJywDnU6Q38L8KXgv2PKtqXYY5GW8okBgk+U7z8USVR
	JBJNiIM=
X-Received: by 2002:a17:907:94d3:b0:b93:514c:b420 with SMTP id
 a640c23a62f3a-b942d06f5a0mr62179866b.13.1772777588346; Thu, 05 Mar 2026
 22:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772714348.git.zhoubinbin@loongson.cn> <8b8dbdc580fd2e2ebf1d5990e55e4a50db1b253a.1772714348.git.zhoubinbin@loongson.cn>
 <CAHp75VfmupH=dE=L3+vboo7D9DDEMvU-Hwy6HwuVFsg1iB7hcw@mail.gmail.com>
In-Reply-To: <CAHp75VfmupH=dE=L3+vboo7D9DDEMvU-Hwy6HwuVFsg1iB7hcw@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 6 Mar 2026 14:12:54 +0800
X-Gm-Features: AaiRm50an37wagGCXboOs8Vds_uSmaHBQQtCYdqmiBRo3BO64gJxH74nqdBEb8c
Message-ID: <CAMpQs4KC42_2HwSnW7gDZm+vZv0H6eO0eV4=1ooY1Kx3yeRzXQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy:

Thanks for your continued review of the patch.

On Thu, Mar 5, 2026 at 9:52=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Mar 5, 2026 at 2:57=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
> >
> > This I2C module is integrated into the Loongson-2K0300 SoCs.
> >
> > It provides multi-master functionality and controls all I2C bus-specifi=
c
> > timing, protocols, arbitration, and timing. It supports both standard
> > and fast modes.
>
> ...
>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
>
> + time.h // for USEC_PER_* et alia.
>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
>
> ...
>
> > +/**
> > + * struct loongson2_i2c_priv - private data of the controller
> > + * @adapter: I2C adapter for this controller
> > + * @complete: completion of I2C message
> > + * @clk: hw i2c clock
> > + * @regmap: regmap of the I2C device
> > + * @parent_rate: I2C clock parent rate in MHz
> > + * @msg: I2C transfer information
> > + */
> > +struct loongson2_i2c_priv {
> > +       struct i2c_adapter              adapter;
> > +       struct completion               complete;
> > +       struct clk                      *clk;
> > +       struct regmap                   *regmap;
> > +       unsigned long                   parent_rate;
>
> it's better to keep units in the variable name
>
>        unsigned long                   parent_rate_MHz;
>
> // yes, it's fine to spell the unit suffix as it's in physics.
>
> > +       struct loongson2_i2c_msg        msg;
> > +};
>
> ...
>
> > +static void loongson2_i2c_handle_rx_done(struct loongson2_i2c_priv *pr=
iv)
> > +{
> > +       struct loongson2_i2c_msg *msg =3D &priv->msg;
>
> > +       u32 i;
>
> Not needed to be here (see below how).
>
> > +       switch (msg->count) {
> > +       case 2:
> > +               /*
> > +                * The STOP/START bit has to be set before reading the =
last two bytes.
> > +                * After that, we could read the last two bytes.
> > +                */
> > +               regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOO=
NGSON2_I2C_CR1_OP_MASK,
> > +                                  msg->stop ? LOONGSON2_I2C_CR1_STOP :=
 LOONGSON2_I2C_CR1_START);
>
> > +               for (i =3D 2; i > 0; i--)
> > +                       loongson2_i2c_read_msg(priv);
>
> First of all, in another case the type of iterator is unsigned int.
> Second, this iterator is not used outside of the for-loop, third, the
> upper limit is already known, no need to use magic, hence
>
>                for (unsigned int i =3D 0; i < msg->count; i++)

Here, we read the last two bytes. In `loongson2_i2c_read_msg()`,
`msg->count` is decremented, so the loop condition here should be:

                     for (unsigned int i =3D msg->count; i > 0; i--)

Also, I will address all other comments in the next version.
>
> > +               loongson2_i2c_disable_irq(priv);
> > +
> > +               complete(&priv->complete);
> > +               break;
> > +       case 3:
> > +               /*
> > +                * In order to generate the NACK after the last receive=
d data byte, enable NACK
> > +                * before reading N-2 data
> > +                */
> > +               regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOO=
NGSON2_I2C_CR1_ACK, 0);
> > +               loongson2_i2c_read_msg(priv);
> > +               break;
> > +       default:
> > +               loongson2_i2c_read_msg(priv);
> > +               break;
> > +       }
> > +}
>
> ...
>
> > +static int loongson2_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c=
_msg msgs[], int num)
> > +{
> > +       struct loongson2_i2c_priv *priv =3D i2c_get_adapdata(i2c_adap);
> > +       struct device *dev =3D priv->adapter.dev.parent;
> > +       unsigned int i, status;
> > +       int ret;
> > +
> > +       /* Wait I2C bus free */
> > +       ret =3D regmap_read_poll_timeout(priv->regmap, LOONGSON2_I2C_SR=
2, status,
> > +                                      !(status & LOONGSON2_I2C_SR2_BUS=
Y),
> > +                                      LOONGSON2_I2C_FREE_SLEEP_US,
> > +                                      LOONGSON2_I2C_FREE_TIMEOUT_US);
> > +       if (ret) {
> > +               dev_dbg(dev, "The I2C bus is busy now.\n");
> > +               return ret;
> > +       }
> > +
> > +       /* Start generation */
> > +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I=
2C_CR1_START,
> > +                          LOONGSON2_I2C_CR1_START);
>
> > +       for (i =3D 0; i < num; i++) {
>
>        for (unsigned int i =3D 0; i < num; i++) {
>
> > +               ret =3D loongson2_i2c_xfer_msg(priv, &msgs[i], i =3D=3D=
 num - 1);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       return num;
> > +}
>
> ...
>
> > +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *p=
riv)
> > +{
> > +       struct device *dev =3D priv->adapter.dev.parent;
> > +       struct i2c_timings i2c_t;
> > +       u32 val, freq_mhz, ccr;
>
> freq_MHz
> (or at least make the parent_rate and this one consistent with the
> suffixes in use)
>
> > +       i2c_parse_fw_timings(dev, &i2c_t, true);
> > +       priv->parent_rate =3D clk_get_rate(priv->clk);
> > +
> > +       if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_STANDARD_MODE_FREQ) {
> > +                /* Select Standard mode */
> > +               ccr =3D 0;
> > +               val =3D DIV_ROUND_UP(priv->parent_rate, i2c_t.bus_freq_=
hz * 2);
> > +       } else if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_FAST_MODE_FREQ) {
> > +               /* Select Fast mode */
> > +               ccr =3D LOONGSON2_I2C_CCR_FS;
> > +               val =3D DIV_ROUND_UP(priv->parent_rate, i2c_t.bus_freq_=
hz * 3);
> > +       } else {
>
> > +               dev_err(dev, "Unsupported speed (%uhz)\n", i2c_t.bus_fr=
eq_hz);
>
> hz --> Hz (in the message)
>
> > +               return -EINVAL;
> > +       }
>
> It seems part of the probe phase, so why not
>
>   return dev_err_probe(...);
>
> ?
>
> > +       FIELD_MODIFY(LOONGSON2_I2C_CCR_CCR, &ccr, val);
> > +       regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);
> > +
> > +       freq_mhz =3D DIV_ROUND_UP(priv->parent_rate, HZ_PER_MHZ);
> > +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I=
2C_CR2_FREQ,
> > +                          FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_mhz))=
;
> > +
> > +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_TRISE, LOONGSON2=
_I2C_TRISE_SCL,
> > +                          LOONGSON2_I2C_TRISE_SCL);
> > +
> > +       /* Enable I2C */
> > +       regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I=
2C_CR1_PE,
> > +                          LOONGSON2_I2C_CR1_PE);
> > +
> > +       return 0;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko

--=20
Thanks.
Binbin
