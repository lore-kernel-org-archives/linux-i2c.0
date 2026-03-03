Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27038C2D5
	for <linux-i2c@vger.kernel.org>; Tue,  3 Mar 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529680; cv=pass; b=aInVXzQD/jG5p68gp7TmMHrUPQqYH33eU250Mg7atD6shpeq0cd8ANstMFtjfC48tgrx9ug0hybVV9rpU+F6mTW9QBDVUqgB0uIZUITHeRL1ie8aVjULVsk3ThFXXuQJVb7tyGjYQrIUzmk7FtRWlKib5/zGeOC/HYjLeUBCRww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529680; c=relaxed/simple;
	bh=qUC4hlaUmuE3q9EP1O1YjY8UBnpLS5yfmPzZcVaubz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnrDf4DGpoihw0aGddZe8gNMeq4RpHk80R4s90wVE8v2gnFEsb/PslUXDZzbTidVd7k/5v2Xt09xCGw+syzCPoIfIvGVJbD5geSrKBmjfRVdiKKu0qIqu81QHnHtbZjcaqasbl9n6cTVPrrqxCdm8DsXiJCr/VlTjRehDO2paAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBqTpAL2; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBqTpAL2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65c5a7785b4so7844215a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Mar 2026 01:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772529678; cv=none;
        d=google.com; s=arc-20240605;
        b=ewQ+J38aX5wEfs1lDKF2LM4iV9sRvs7eL0hidpk44OSeIUd0AM2IVMmf6ezA/29wKr
         lvq1WBiOI7bEfoluD7oZaL/bEzrAM36goMO9QSNyMz/SYBPwIiN3lSIp3lqezv3YAZMR
         jSUL4XRP/fiu2VWIdGjYGqBaLO3oZBa9g1vuGBCcA1cy2gPaEhHFZgutfMaXWwlRYdlx
         M6/u6M+shgQKT6eYEuGKs+ARvJCmVn/5lOHfLB92axLQ0NBoHOs6fSQL9Zlagsd95DnQ
         lN8WHr9Qj77hSwBxXlx3+EcZNE4D53iw8vCbVqbbgGrzA1DRZrnUF32+xjTiG4LzKCX+
         zPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b+6M2KZPF5EI514CqHFmtrBWN6sT/McXIxVWsbPFXH8=;
        fh=1BWIieL/EbOqYfmq7DCS5oc/Rg7Zozz4sqtRolj0jp0=;
        b=M0NslCJp0F5CzmosX5ehuoemZtwOdg64xVs1NypVNzeF1z2c2C5dp7GaNuDu4VZtho
         ot7g+zdoxtC/cneFcfpyG92BZ6d9hSHH8fh+D8LV13xeFU+AnVu90GnD25g0GvwDc7hd
         VGq5G6+WfIBXcfyO8CsYwj8zTpLwu6EcJTUdVUWHBBBID1NVSi2cIWJlQ02h4o27erZL
         vOeGHDAW2p1TdCsBjU28I7/GIZmUtA+ynfvCetIR0L52xQSgwi4EGEGmpQCh5uiQjpWQ
         azXCB7vsmItq4GYplO34t44muNbUsn3/0STVvf19BooivmuvHSPD2qKFWs4A8+oO25rK
         nBrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529678; x=1773134478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+6M2KZPF5EI514CqHFmtrBWN6sT/McXIxVWsbPFXH8=;
        b=HBqTpAL27x9eCOEsq2i/Jfyo+vk+0RtMQZnYfyBH9Bi720ryCNk9ELjgI9vVQIaeQA
         QfAmlXbVuLz/ndtQNU/ZJi1vAiWiRKAYslO8CQ4R+vYGCCUPA70DS8TAcppRlyc37uOf
         Sih75loy/zCfDMyd09T2F5YoGi/GZ8Lwx55r7BNmhE+MmrE1kLrYhajw7O3bJCOEHsZp
         3NZnvzZjpP5b0qGCTORaXLk8RqKIl6rq3Cw3qop1U36BmzKxUkDcqrF7xFFIfvKN/ECW
         2KcIfsEFvW95WDQoeY/Y6Q53SBEarb1V9LgY9++pQEiDWwjnYNTJveOWDTwby8J0ZNVb
         uHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529678; x=1773134478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+6M2KZPF5EI514CqHFmtrBWN6sT/McXIxVWsbPFXH8=;
        b=kr5pONWtOkFIxANO67CjLmaC0Du1Y/baNaIVNYXXsK7PwY52n0+/gmM7frDnQGE/ZH
         O66S+OxcdHbOEHkx8MayBNU317RCEl64LpL2CA0QniPovmqgSAaTGh2KAK0hbpYItBeK
         DlsAf7adWBLiztfRGLBVeSrn+O/Nw29DDgmIwpMXjFJu3i8enZKDM1h9Lyb3kwNnwMty
         YNv4GCiBFlu2jQ1xQ0a3GePrVPsX7nn3doOhMeiQrXTGTiiVByHzcHWHO2qVgeX6Qf1T
         jlvk3IEuZPVaZZX9vISyHQPJeJgT9LgFRsVjK7QHmMhvapD5sg+U9l2IzAvFCVukcclG
         qlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE0f7YCIT8Qkp8LtOiMKeETm4iksBjQ2gDYwgyKRTkM071ekPAxPyhUDjofamCaJoBNYIdriNpDto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFF1teWCURd8aovXzI0T9BekEw+GCDzn3e1oGkerFRnDKlffL
	eV9xL0efkVBudAfy1xcSTfjjOF8UrhYeLIMxLuS2UjV1x59sn56YyBS6wNqemoegqE7xuo5GW3m
	J49PIS4CWZ81i8rwiQLbT+YDizItnXwc=
X-Gm-Gg: ATEYQzyp849qzEwa9lGT+WzREyb3PMcoppbxtUiGryLwtx75tt4zSccg1nJ2wR1/XTY
	NB+VsMitN9kdwVGvbeE+dI7WTVqFKVXpPZXnLfw37ZcClnA/AO9tm61ofAWwpRMc3Ietfl1hbES
	5O37zmuumQGh1HvObAxmpixdaeSVNf+EhuzoSraZSkwd8I6neVmrScFd2VQD815UvlvOTgg+VBq
	3nqWYVBjg1Fa26JFO0wAm5HTPq/MTqE1UU8tpE8JJpBkW73VzJ4g/OFIKkB+MRM4HoABmQD22iQ
	VP2xPuQ=
X-Received: by 2002:a17:907:3d51:b0:b93:62dd:a4a4 with SMTP id
 a640c23a62f3a-b93765924famr1000653266b.51.1772529677321; Tue, 03 Mar 2026
 01:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772001073.git.zhoubinbin@loongson.cn> <27899156d9218ced7cb0679cad2b2f59f688bd99.1772001073.git.zhoubinbin@loongson.cn>
 <aZ7Jq5GTbROvcrJH@smile.fi.intel.com>
In-Reply-To: <aZ7Jq5GTbROvcrJH@smile.fi.intel.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 3 Mar 2026 17:21:05 +0800
X-Gm-Features: AaiRm53N21CC9RPmD2Ik9krhB2wBhnxwcc0xxmriyv_oPuqBCDKnV5p1bMyZQPI
Message-ID: <CAMpQs4J2NS23seuNWQOUeBxGF+=L=XZL9j478xc=bZx4x9v5Ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
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

Sorry for the late reply.

On Wed, Feb 25, 2026 at 6:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Feb 25, 2026 at 03:34:44PM +0800, Binbin Zhou wrote:
> > This I2C module is integrated into the Loongson-2K0300 SoCs.
> >
> > It provides multi-master functionality and controls all I2C bus-specifi=
c
> > timing, protocols, arbitration, and timing. It supports both standard
> > and fast modes.
>
> ...
>
> > +struct loongson2_i2c_priv {
> > +     struct i2c_adapter              adapter;
> > +     struct completion               complete;
> > +     struct clk                      *clk;
> > +     struct regmap                   *regmap;
>
> > +     int                             speed;
> > +     int                             parent_rate;
>
> May any of these two be negative? The kernel doc says nothing about that.

It should be:

u32 speed;
unsigned long parent_rate;
>
> > +     struct loongson2_i2c_msg        msg;
> > +};
>
> ...
>
> > +static void loongson2_i2c_handle_read(struct loongson2_i2c_priv *priv,=
 int flag)
> > +{
> > +     struct loongson2_i2c_msg *msg =3D &priv->msg;
> > +     unsigned int i;
> > +     bool changed;
> > +
> > +     switch (msg->count) {
> > +     case 1:
> > +             /* only transmit 1 bytes condition */
> > +             loongson2_i2c_disable_irq(priv);
> > +             loongson2_i2c_read_msg(priv);
> > +             complete(&priv->complete);
> > +             break;
> > +     case 2:
> > +             if (flag !=3D 1) {
> > +                     /* ensure only transmit 2 bytes condition */
> > +                     regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR=
2,
> > +                                        LOONGSON2_I2C_CR2_ITBUFEN, 0);
> > +                     break;
> > +             }
> > +             regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONG=
SON2_I2C_CR1_OP_MASK,
> > +                                msg->stop ? LOONGSON2_I2C_CR1_STOP : L=
OONGSON2_I2C_CR1_START);
> > +
> > +             loongson2_i2c_disable_irq(priv);
> > +
> > +             for (i =3D msg->count; i > 0; i--)
> > +                     loongson2_i2c_read_msg(priv);
> > +
> > +             regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONG=
SON2_I2C_CR1_POS, 0);
> > +             complete(&priv->complete);
> > +             break;
> > +     case 3:
> > +             regmap_update_bits_check(priv->regmap, LOONGSON2_I2C_CR2,=
 LOONGSON2_I2C_CR2_ITBUFEN,
> > +                                      0, &changed);
> > +             if (changed)
> > +                     break;
> > +             regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONG=
SON2_I2C_CR1_ACK, 0);
> > +             fallthrough;
>
> Instead better to spell it explicitly:
>
>                 loongson2_i2c_read_msg(priv);
>                 break;
>
> > +     default:
> > +             loongson2_i2c_read_msg(priv);
>
> Missing break.
>
> > +     }
> > +}
>
> This also make me think for the possible optimisations.
> if regmap_updates_bit() in case 2 can be run after the completion,
> the case 1 with a parameter may be split to a helper.
>
> Also would be nice to have a comment why in case 3 we only read a single
> message.

This part might be a bit confusing. I'll try to restructure it, which
might make it clearer.

In `loongson2_i2c_isr_event()`, the read/write operations are divided
into three parts.

        /* TX empty */
        if ((event & LOONGSON2_I2C_SR1_TXE) && !(msg->addr & I2C_M_RD))
                loongson2_i2c_handle_write(priv);

        /* RX not empty */
        if ((event & LOONGSON2_I2C_SR1_RXNE) && (msg->addr & I2C_M_RD))
                loongson2_i2c_handle_read(priv);
//Handle FIFO empty interrupt in case of read, it is called when a new
data is received in data register

        /*
         * The BTF (Byte Transfer finished) event occurs
         */
        if (event & LOONGSON2_I2C_SR1_BTF) {
                if (msg->addr & I2C_M_RD)
                        loongson2_i2c_handle_rx_done(priv);
//Handle byte transfer finished interrupt in case of read
                else
                        loongson2_i2c_handle_write(priv);
        }


static void loongson2_i2c_handle_read(struct loongson2_i2c_priv *priv)
{
        struct loongson2_i2c_msg *msg =3D &priv->msg;

        switch (msg->count) {
        case 1:
                loongson2_i2c_disable_irq(priv);
                loongson2_i2c_read_msg(priv);
                complete(&priv->complete);
                break;
        case 2:
        case 3:
                /*
                 * For 2-byte/3-byte reception and for N-byte
reception with N > 3, we have to
                 * wait for byte transferred finished event before reading =
data.
                 * Just disable buffer interrupt in order to avoid
another system preemption due
                 * to RX not empty event.
                 */
                regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2,
LOONGSON2_I2C_CR2_ITBUFEN, 0);
                break;
        default:
                /*
                 * For N byte reception with N > 3 we directly read
data register
                 * until N-2 data.
                 */
                loongson2_i2c_read_msg(priv);
                break;
        }
}

static void loongson2_i2c_handle_rx_done(struct loongson2_i2c_priv *priv)
{
        struct loongson2_i2c_msg *msg =3D &priv->msg;
        u32 i;

        switch (msg->count) {
        case 2:
                /*
                 * The STOP/START bit has to be set before reading the
last two bytes.
                 * After that, we could read the last two bytes.
                 */
                regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1,
LOONGSON2_I2C_CR1_OP_MASK,
                                   msg->stop ? LOONGSON2_I2C_CR1_STOP
: LOONGSON2_I2C_CR1_START);

                for (i =3D 2; i > 0; i--)
                        loongson2_i2c_read_msg(priv);

                loongson2_i2c_disable_irq(priv);
                complete(&priv->complete);
                break;
        case 3:
                /*
                 * In order to generate the NACK after the last
received data byte, enable NACK
                 * before reading N-2 data
                 */
                regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1,
LOONGSON2_I2C_CR1_ACK, 0);
                loongson2_i2c_read_msg(priv);
                break;
        default:
                loongson2_i2c_read_msg(priv);
                break;
        }
}

>
> ...
>
> > +static void loongson2_i2c_handle_write(struct loongson2_i2c_priv *priv=
)
> > +{
> > +     struct loongson2_i2c_msg *msg =3D &priv->msg;
> > +
> > +     if (msg->count) {
> > +             loongson2_i2c_write_msg(priv, *msg->buf++);
>
> > +             msg->count--;
> > +             if (!msg->count)
>
> Can be
>
>                 if (!--msg->count)
>
> but someone may find it difficult to correctly parse.
>
> > +                     regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR=
2,
> > +                                        LOONGSON2_I2C_CR2_ITBUFEN, 0);
> > +     } else {
> > +             loongson2_i2c_terminate_xfer(priv);
> > +     }
> > +}
>
> ...
>
> > +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *p=
riv)
> > +{
> > +     u32 val, freq_mhz, ccr;
> > +
> > +     priv->parent_rate =3D clk_get_rate(priv->clk);
>
> > +     freq_mhz =3D DIV_ROUND_UP(priv->parent_rate, HZ_PER_MHZ);
>
> Usually the rule of thumb to put assignments close to its first user...

See blow.
>
> > +     if (priv->speed =3D=3D I2C_MAX_STANDARD_MODE_FREQ) {
> > +              /* Select Standard mode */
> > +             ccr =3D 0;
> > +             val =3D DIV_ROUND_UP(priv->parent_rate, I2C_MAX_STANDARD_=
MODE_FREQ * 2);
> > +     } else {
> > +             /* Select Fast mode */
> > +             ccr =3D LOONGSON2_I2C_CCR_FS;
> > +             val =3D DIV_ROUND_UP(priv->parent_rate, I2C_MAX_FAST_MODE=
_FREQ * 3);
> > +     }
> > +
> > +     FIELD_MODIFY(LOONGSON2_I2C_CCR_CCR, &ccr, val);
> > +     regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);
>
> ...somewhere here.
>
> > +     regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C=
_CR2_FREQ,
> > +                        FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_mhz));
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
> > +     priv->speed =3D I2C_MAX_STANDARD_MODE_FREQ;
> > +     ret =3D device_property_read_u32(dev, "clock-frequency", &clk_rat=
e);
> > +     if (!ret && clk_rate >=3D I2C_MAX_FAST_MODE_FREQ)
> > +             priv->speed =3D I2C_MAX_FAST_MODE_FREQ;
>
> Please, use i2c_parse_fw_timings() instead of custom approach.

This section will be merged into `loongson2_i2c_adjust_bus_speed()`,
and `bus_freq_hz` will replace `priv->speed` as follows:

static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *priv)
{
        struct i2c_timings i2c_t;
        ....

        i2c_parse_fw_timings(dev, &i2c_t, true);
        priv->parent_rate =3D clk_get_rate(priv->clk);

        if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_STANDARD_MODE_FREQ) {
                 /* Select Standard mode */
                ccr =3D 0;
                val =3D DIV_ROUND_UP(priv->parent_rate, i2c_t.bus_freq_hz *=
 2);
        } else if (i2c_t.bus_freq_hz =3D=3D I2C_MAX_FAST_MODE_FREQ) {
                /* Select Fast mode */
                ccr =3D LOONGSON2_I2C_CCR_FS;
                val =3D DIV_ROUND_UP(priv->parent_rate, i2c_t.bus_freq_hz *=
 3);
        } else {
                dev_err(dev, "Unsupported speed (%uhz)\n", i2c_t.bus_freq_h=
z);
                return -EINVAL;
        }

......
        freq_mhz =3D DIV_ROUND_UP(priv->parent_rate, HZ_PER_MHZ);
        regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2,
LOONGSON2_I2C_CR2_FREQ,
                           FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_mhz));
.............

        return 0;
}

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

--
Thanks.
Binbin
