Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DE2F3C3E
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198454; cv=pass; b=o5pHDNV+Q4Mx2T5HfqZet4tKrLFypyvD2djVv+GjjKkEBjDVRN3YnvLhJZK6prd4A65CygMdnvM2Qh8DCtpjpfIAXd9dOp3TZ8G5o6hv5AbqBt83x+3RlKu80nqppA+oIXGCTCHdlswiHaPHa3P012G1BSzwWZ52MG7n4UYfhFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198454; c=relaxed/simple;
	bh=YcdgJwR+tV/SUrqfcIFipReYxQ9TgZ17E68VThHwd3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfBUpxw5XkmlGKx427B/sIaBH4sNTT/MKxopQZAHvjSAmz3V/cw3jgDxjbR3ltQZugok6zlkrx1RrXnvCIN7vQ+Rv05G/1EUA2jZd1YOATj6LN5QRmCUCHpS/yieI55eSn3MuqKDfDrWsNN0UKE5KYKAVgOVsWU1Ltp/VGQm+z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNWZ11Ok; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNWZ11Ok"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b95c0fc928bso690793766b.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 20:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773198451; cv=none;
        d=google.com; s=arc-20240605;
        b=BEiWMMteZXdzWc2hL54oKX9Kseov49r4LWbITIGGPpj3P6r5z8B3pmHD8/fjvrGPZP
         5Bt5Sz2KHl6M/rVcNmv26+XiffrbNqfND2YHKXWOst5hvWyICgkfuMjbc6LYW9MpEueT
         AxDEETU+/wetLPgbZ/w5b++tIvzkS/cT48tgF0NT1wroKyhA385dUCPp+eVy0aSoOibw
         +k8mcDPxgiCePrEVLJhA/yExnjRIoFojKCO+JgJPUjA8R4F/XVOwKRoKY9tp29FG1Uv0
         OT1woz3HEfsHwlG1ewgRvXYNghbIqs8JCbeaTGRaYnFGup0afxcfBcPqo5Xmh8bTrAhK
         ljDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yw3z5TruSohF4QKS94PIgWDRcyGqH7FND6pkLUOm9rc=;
        fh=meZBCtXnYtyxncHRDiUD3FL0MUQcy0uqN/HNL339z0Y=;
        b=UmGVIOEMmsYOoGHKbHFpelKBT9LuDXIeCXV8dKQKAq18Is9vyHrczeomnAJNMn4O5S
         UePNvGJ2mc4QUDMEXL5ijGUxWM2Zfl+61cH0KUs5QIwJtqX1a5Zpn29nAnrbIB+fUh2E
         WJzBE1UmWnyz2QGZlrnJLB9WWS8x3M6i9S//rNTrTJB6+Z3HYyIVBYzh9apdk0Bdy2sT
         fL45Pv2nKu0hhUEvM/SheQW80juytPb9E2gsN9ubvH4mZ+hiz3tXQClDQguXkETAHPkz
         53KXYty8fgJb0h5CLGTnU9P8Itg+pTt9UCSVCQ0cCJHlX30G+C3jHIk8zKQN4dvHlTvz
         CK9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198451; x=1773803251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw3z5TruSohF4QKS94PIgWDRcyGqH7FND6pkLUOm9rc=;
        b=MNWZ11OkOOmA0WYV9Uj4eA4Ac7TILhD+ALdLhC6vaUVJu7wkZq0fr+v1u4ALTdXuV7
         EVBhRPDxZQRnFU//jOY5ooGvbE+2L1t2C/G/N3y29bxVgmerWwpohxiyrbzyJXB6+WKq
         5cf4iDmIVQtRB+EZbXFBFp2JB1pmOyDjRbXWv6nK+agh2Jse9j4ilpycvIGm3D5x6HcZ
         qvkOmGbxNt/Xs4lB5Fb2sT9DQv9nTJFectESyosiLIP8kfrXAQKlwkXa3yJkC1Ja0qMh
         Qn9zgEYqqwwzhlbodAoYGy/FSBs2EzbJaWIFxsAOH8eDBGeNoIsAc5/+NyyhfU+5of3Y
         1xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198451; x=1773803251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yw3z5TruSohF4QKS94PIgWDRcyGqH7FND6pkLUOm9rc=;
        b=NIPxPrsdlc2Ty961742/SoeHLTe7rvOpteLycJSzYDq9CfIgqS7EbdRr1x41uOApSN
         G0qtgc2N9IOvBRjP5KCiZg6hW933f9tfBJImBqRPezE62q7zS/Xpl1V/dwCBqzh5MHjS
         12uLK1RHErtrPPisP9NM0hjwOSn54W1X2vG8PFU/dO2kFw2FjNJivJyT70728zpKqKWP
         Di8BE5uUn5h9PBBkWVKfjU/e6JEKchZclcKaAfjtyP8G86WTP7KgKXp/BCedrc0xl0dt
         /eRJhYjBHhE3QvaNSTb24gIXFhoK00/7/sW3ADo8izjulP4xfEATi00g/2+koAvm/GGh
         0VJw==
X-Forwarded-Encrypted: i=1; AJvYcCUl6kkxuRK1es+r9Ixii5z0negTIDt5rph17tTue3tm4CttO3fGshEfvUmo+8xzZQBAOVUq7MHg4TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7H3Q5XtsQ37oTjIcQf9a6+wNo1XJYt/KZMZeLYvLEkgE/K1J4
	chViItRtHb9XRVSTpDXWC68/Ll5s9a/v1bLZ4LYsdkyf173xjQmk2Zp6BklU06y16rTgF5XgQ2k
	A1X0ZwSv46F7wluyL4Sh/K5hkbARGiOc=
X-Gm-Gg: ATEYQzwOwNxvWs0umyF0GGWAL7W56N8bNcjUme+d6v2g2ltgok4tdvXxrM8KYGEicLh
	BhIeyeWR9wpUgFUILmiCOvVu6akStuOKCejFA28sC3w6fite0rZLAs+Q1zkTasjv36ZDz/NuCsW
	xyT7VRBbS/Mx20tZpySpqsGFPu1pEqckmOCQVzg7S/d0cD0xM3WyIuktHbZcRkuuzIUP+5gJYhx
	st6EEmzTpWzoBKVnE1ndddpKJ5sQyzGLu8xWPpPBt3jtOWTv+lHlgQ9hAsXMjnTFqEBq8n2hK3K
	kyO6NYE=
X-Received: by 2002:a17:907:3e10:b0:b94:1913:7802 with SMTP id
 a640c23a62f3a-b972e58db89mr40090566b.35.1773198451017; Tue, 10 Mar 2026
 20:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773142933.git.zhoubinbin@loongson.cn> <bd5c06a20ef2e61f76902c4209f2be539ca91a97.1773142933.git.zhoubinbin@loongson.cn>
 <abAyd9uyl3TC8vC_@ashevche-desk.local>
In-Reply-To: <abAyd9uyl3TC8vC_@ashevche-desk.local>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 11 Mar 2026 11:07:19 +0800
X-Gm-Features: AaiRm52S10jKyg3CzEsWlvTqDK1di5Q_PURZWQ746N292xm1melrStZy-WP5vrw
Message-ID: <CAMpQs4JVYRo4DQyEVe5NhHQ=VN96mF17AtSoo6a4CGB6w_Aphw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy:

Thanks for your detailed review.

On Tue, Mar 10, 2026 at 11:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Mar 10, 2026 at 07:48:53PM +0800, Binbin Zhou wrote:
> > This I2C module is integrated into the Loongson-2K0300 SoCs.
> >
> > It provides multi-master functionality and controls all I2C bus-specifi=
c
> > timing, protocols, arbitration, and timing. It supports both standard
> > and fast modes.
>
> Nothing really worrying, this version only has an issue to access embedde=
d
> struct device in the i2c_adapter. See below.
>
> ...
>
> > +/**
> > + * struct loongson2_i2c_priv - private data of the controller
> > + * @adapter: I2C adapter for this controller
> > + * @complete: completion of I2C message
> > + * @clk: hw i2c clock
> > + * @regmap: regmap of the I2C device
> > + * @parent_rate_MHz: I2C clock parent rate in MHz
>
> ' in MHz' now is redundant.
>
> > + * @msg: I2C transfer information
> > + */
>
> ...
>
> > +     /*
> > +      * Acknowledge failure:
> > +      * In master transmitter mode a Stop must be generated by softwar=
e
>
> Missing period.
>
> > +      */
>
> ...
>
> > +     case 3:
> > +             /*
> > +              * In order to generate the NACK after the last received =
data byte, enable NACK
> > +              * before reading N-2 data
> > +              */
>
> Ditto.
>
> > +             regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONG=
SON2_I2C_CR1_ACK, 0);
> > +             loongson2_i2c_read_msg(priv);
> > +             break;
>
> ...
>
> > +     event =3D status & possible_status;
> > +     if (!event) {
> > +             dev_dbg(dev, "spurious evt irq (status=3D0x%08x, ien=3D0x=
%08x)\n", status, ien);
>
> IRQ
>
> > +             return IRQ_NONE;
> > +     }
>
> ...
>
> > +     /*
> > +      * The BTF (Byte Transfer finished) event occurs when:
> > +      * - in reception : a new byte is received in the shift register
>
> Extra space before :.
>
> > +      * but the previous byte has not been read yet from data register
> > +      * - in transmission: a new byte should be sent but the data regi=
ster
> > +      * has not been written yet
> > +      */
>
> ...
>
> > +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *p=
riv)
> > +{
> > +     struct device *dev =3D priv->adapter.dev.parent;
>
> Derive it from regmap (and check elsewhere) as accessing dev in the adapt=
er
> may lead to issues related to the object lifetime.

Do you mean regmap_get_device() API?

Also, similar references exist in `loongson2_i2c_xfer()` and
`loongson2_i2c_isr_event()`, requiring synchronized updates.
>
> > +     struct i2c_timings i2c_t;
> > +     u32 val, freq_MHz, ccr;
> > +
> > +     i2c_parse_fw_timings(dev, &i2c_t, true);
> > +     priv->parent_rate_MHz =3D clk_get_rate(priv->clk);
> > +
> > +     if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_STANDARD_MODE_FREQ) {
> > +              /* Select Standard mode */
> > +             ccr =3D 0;
> > +             val =3D DIV_ROUND_UP(priv->parent_rate_MHz, i2c_t.bus_fre=
q_hz * 2);
> > +     } else if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_FAST_MODE_FREQ) {
> > +             /* Select Fast mode */
> > +             ccr =3D LOONGSON2_I2C_CCR_FS;
> > +             val =3D DIV_ROUND_UP(priv->parent_rate_MHz, i2c_t.bus_fre=
q_hz * 3);
> > +     } else {
> > +             return dev_err_probe(dev, -EINVAL, "Unsupported speed (%u=
Hz)\n", i2c_t.bus_freq_hz);
> > +     }
> > +
> > +     FIELD_MODIFY(LOONGSON2_I2C_CCR_CCR, &ccr, val);
> > +     regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);
> > +
> > +     freq_MHz =3D DIV_ROUND_UP(priv->parent_rate_MHz, HZ_PER_MHZ);
> > +     regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C=
_CR2_FREQ,
> > +                        FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_MHz));
> > +
> > +     regmap_update_bits(priv->regmap, LOONGSON2_I2C_TRISE, LOONGSON2_I=
2C_TRISE_SCL,
> > +                        LOONGSON2_I2C_TRISE_SCL);
> > +
> > +     /* Enable I2C */
> > +     regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C=
_CR1_PE,
> > +                        LOONGSON2_I2C_CR1_PE);
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int loongson2_i2c_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct loongson2_i2c_priv *priv;
> > +     struct i2c_adapter *adap;
> > +     void __iomem *base;
> > +     int irq, ret;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     priv->regmap =3D devm_regmap_init_mmio(dev, base, &loongson2_i2c_=
regmap_config);
> > +     if (IS_ERR(priv->regmap))
> > +             return dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed =
to init regmap.\n");
> > +
> > +     priv->clk =3D devm_clk_get_enabled(dev, NULL);
> > +     if (IS_ERR(priv->clk))
> > +             return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to =
enable clock.\n");
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> > +     adap =3D &priv->adapter;
> > +     adap->retries =3D 5;
> > +     adap->nr =3D pdev->id;
> > +     adap->dev.parent =3D dev;
> > +     adap->owner =3D THIS_MODULE;
> > +     adap->algo =3D &loongson2_i2c_algo;
> > +     adap->timeout =3D 2 * HZ;
>
> > +     device_set_node(&adap->dev, dev_fwnode(dev));
>
> Why?! i2c_adapter_set_node() is part of the i2c-next.

Indeed, when I rebased the v4 patchset, `i2c_adapter_set_node()`
existed in the i2c-next[1]. However, when I prepared the v5 patchset,
it was removed[2].

[1]: base commit: 6117e1ba1db78a52a4161208ea403d3769ad73c6
[2]: base commit: b82316862bea929265725c077dffcec42e3dc20b

>
> > +     i2c_set_adapdata(adap, priv);
> > +     strscpy(adap->name, pdev->name);
> > +     init_completion(&priv->complete);
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     ret =3D loongson2_i2c_adjust_bus_speed(priv);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_request_irq(dev, irq, loongson2_i2c_isr_event, IRQF_=
SHARED, pdev->name, priv);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return devm_i2c_add_adapter(dev, adap);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--
Thanks.
Binbin
