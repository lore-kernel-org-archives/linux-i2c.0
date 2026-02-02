Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AFE27FD62
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014384; cv=pass; b=N2iDTuGgoKogDF45iCJu6XbNuYuty0WezrjwSAym+Ir16P07ili7wWzEGHxMUia7u1PR2ZOPQ3cyvqbzuxN+K8pMevrBsqI/AayUTiNDB3ugGo8aOLMj9WsBcRQrWbJMzFgafSvmmcKAnZohkz/M+1dRdxIQkf/lFYvtbt2BDQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014384; c=relaxed/simple;
	bh=kkuvM7CJppS0pU/h0KzKixJfh04HhSPTu3S4mwLZ9mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9lXv63E7cBr/GLZVHPwg9THeBCTbMeRDXU4UISUjNaOtSJbh0mf/5OtRC5xvZDVxZxVDPA33uV0dTuM3xlRNrlJxcEj4JOhuwkzzjZJFEJ+rhXnYTk5vqpL0FaZ+9Lf+xZ+4eh3HHm9RQ1ui5gT6lRyqRp7U3eJaKXEduyNg3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzBAgR2t; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzBAgR2t"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b884cb1e717so766106866b.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Feb 2026 22:39:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770014381; cv=none;
        d=google.com; s=arc-20240605;
        b=DVlPxiyllLjlOG2E0MukfpuCFLZhFkEV3d57oN64iTm0AThMARlm+ArktQuVkgxYF1
         9PO+gnCYRSdR8z6PaXHKVSDH65J03ZkO89GMRaaZrTyGaLUnL53VNfjmLtsY6NLIwcmD
         f97pR2m2Yw5UvUX4DkmCMkrZuF2dicP/VrzHCEIVa1pZUetGv7AmKT1+2kQId+/IzaN2
         aXAB10v50Hxo4l/BbwIwpdlf7mGGlF6WHjHtgFXlJHURWQxKLh4eXV5rliYGX82G6cod
         uSazjR0FJ8MrmQDrN0/71/Z9K8N2PO2f+rYR1514pbeaIVeaZNvt4Que3riNlQHhGcsw
         9ktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dE6334Db/8q+LVE4TPM0RlZCcc1UGZ7Evu81B8EwWuA=;
        fh=nR4xv3KstzTbQshQVCBM1p77ESIAZkwfBgSE6nkrvHE=;
        b=ijwDwQrxItp+IxJ49sHpm/5SEaAFE+yOAZB/hcuu2DsaHFZXAPEeQuc1HGtX9SMDnR
         xDrYQ3AdOq8S4tFhg8X5dywtbOm4Yzo0re4lXCPxujSpY7xXbIPE19P26BZ/PkzkZfao
         ry75HieD1E83Oxa4yQ1ThYFJe7fa8atOkscTyxeAQ7vPr6QuTC77ZxXH0nEd64yUaTLt
         lc3V0Vr3M5RM1jaYWVrNTc3BzJYhyOokE1KALliDaPVbSo7cf5MBk2GHJLI9+gWGBELb
         Wl+CnkMShhTMAkY3gnMkKryaPEs+MbYWN+Wgjt3M4Mi1VCDVPZ7gavJQP+xD1Rg74hcB
         aDNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770014381; x=1770619181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE6334Db/8q+LVE4TPM0RlZCcc1UGZ7Evu81B8EwWuA=;
        b=DzBAgR2tgzZXVC6q3Q88dQsq2sRIyWcgn4PoPzfSf/vc10EgyFnB+yZ0pR4FniYOYD
         1lSipenITiWEhpEUMMWwnGoTfXy8mbPIuLfoKONRiOWcNVUZB+l7YSczZZL0KaHcd2qT
         JNu+uOAHbsXTQUTY+nGSXOmWIovw9pb8hDuLtANlWqiMhV4pxYsgZC9ZYnv9ZlRQ1M+U
         5Bhch9JdaXBkQtAzhOuLB0J4GCynStMeWD0mXxSAKv2aBeGdvv10/+hYVZaiDVr0KcWK
         eTfMBN9uQwk5oJTs8cssEEB5Tb3/T33+G2j7P+sY5Ikgh5iDBSZVPB7/hPPhNpCEBqEL
         VG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770014381; x=1770619181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dE6334Db/8q+LVE4TPM0RlZCcc1UGZ7Evu81B8EwWuA=;
        b=bd8Hvaro8LTGxWsMA8Zs4e5E8b4jrh0lnAMjSsNXvVzydHRSUb8CFjbtAyY5uzXkfD
         EGWV1rSWQMfH87rshhVmauRbrXRt1Eomfi+VDkOlB9NbzYido0cYTi2g/Fhx78qF6/74
         IdDL7j1g8oyxmMramjGTWN2RNdLm/zPWP3xvOdxHGwrO9R4GrVZYpVLQyQwSvR78SWzA
         wQ9niNqcINZPNNQW+QjQD6p2RZuZe4QCNe8QPOu0xwgQaBt1t6GvFzmJSEKtOoD/JJjR
         vxqnoYhgwUSu/Do/BqgEsidIubl9OLqcT/BEAtWiAT2ecTdxjTL365rmExkdQPsvvZBV
         SBkA==
X-Forwarded-Encrypted: i=1; AJvYcCWOxSivcf4F+coWY/G3FuCcUZyyY5K4vlKrpr6f9WygZsgPUjMlzljvyRTeVCBkl7k7qQ9Y/pptkRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyofO4RwW4IXQYBOkcvLNGBI4U49wJcV48hXsa6itOUzufZlRSb
	Zfm17sxj/IkLAkpxTu1yfbMbDjFcr2cqfyeY5w8om9/GyCNbMjHUC5A2Ve5J6/QlBom2ghsclzP
	aj5hUieij/x+rS9y08E+Z/OC4uhs7zSq8yoqpjy0=
X-Gm-Gg: AZuq6aK1YKZbxhMN7i8gFZO7VZgRqHWycKQyhD0BkRrtDrNCGmFPTqloGBv/GC+FEkE
	ov/nb5CuFbMNQTBLELLUelQRODHjOzOg6qBMOjtdfesdAdYbe+Z7a48nTKGkqRXLHmrPwO5M9va
	qC6uOcOdIprNyt6Q9bcsKQl5BFdjX2J9jJteDL5vSFgzjGsT3ynHGXnhOYv8FryckfGzxpVCd3E
	d4yt2Rg2gxDWF/aFAKCscAU0upeJ0JkajMt+xGfaQEh43/arDSTTeZLR/gbkItEQpVCt50=
X-Received: by 2002:a17:906:2547:b0:b8e:380:5669 with SMTP id
 a640c23a62f3a-b8e03805c91mr453056266b.32.1770014381217; Sun, 01 Feb 2026
 22:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769476820.git.zhoubinbin@loongson.cn> <402121da829497fc97f1461c8aaa3a44252c3f06.1769476820.git.zhoubinbin@loongson.cn>
 <aXh000kBfaqd1G9H@smile.fi.intel.com> <CAMpQs4JTqWr6AqRwEO9bcno-_MjjE8GKm_kUvrpy7m_tLMtuSQ@mail.gmail.com>
 <aXtw9h8WUs5H9MgC@smile.fi.intel.com>
In-Reply-To: <aXtw9h8WUs5H9MgC@smile.fi.intel.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 2 Feb 2026 14:39:28 +0800
X-Gm-Features: AZwV_QhXj9tszc0HGFFue9c8RTPxI3-iEb6Mu4cCGgevEV_nbiL8J0mGuBe64dI
Message-ID: <CAMpQs4+Rk7-ERUetW_V4ojGxLtpzoX+hGgr7wV+0iQ8Uhdri4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
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

Thanks for your patient reply.

On Thu, Jan 29, 2026 at 10:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jan 29, 2026 at 04:07:06PM +0800, Binbin Zhou wrote:
> > On Tue, Jan 27, 2026 at 4:18=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Jan 27, 2026 at 10:47:57AM +0800, Binbin Zhou wrote:
>
> ...
>
> > > > +/*
> > >
> > > It's not marked as kernel-doc, but looks very much like that. Why?
> > > Same Q for *all* cases like this.
> >
> > I didn't intend to mark it in kernel-doc; I just wanted to comment on
> > the variable.
> > Is removing the `@` symbol sufficient?
>
> But why? If you want it being properly documented, make sure it follows
> the regular format.

I sincerely apologize for not having read `kernel-doc.rst` earlier.
`kernel-doc` comments use `/**` as its opening marker. I will take
this time to learn the documentation.

>
> > > > + * struct loongson2_i2c_msg - client specific data
> > > > + * @addr: 8-bit slave addr, including r/w bit
> > > > + * @count: number of bytes to be transferred
> > > > + * @buf: data buffer
> > > > + * @stop: last I2C msg to be sent, i.e. STOP to be generated
> > > > + * @result: result of the transfer
> > > > + */
> > > > +struct loongson2_i2c_msg {
> > > > +     u8 addr;
> > > > +     u32 count;
> > > > +     u8 *buf;
> > > > +     bool stop;
> > > > +     int result;
> > >
> > > Run `pahole` and amend *all* data types accordingly.
> >
> >  Moving 'stop' from after 'buf' to after 'addr'.
> > >
> > > > +};
>
> ...
>
> > After run `pahole`, the structs are reorganized as follow:
> >
> > pahole --show_reorg_steps --reorganize --sort -C loongson2_i2c_priv
> > i2c-ls2x-v2.o
> > struct loongson2_i2c_priv {
> >         struct i2c_adapter         adapter
> > __attribute__((__aligned__(8))); /*     0  1064 */
> >         /* --- cacheline 16 boundary (1024 bytes) was 40 bytes ago ---
> > */
> >         struct clk *               clk;                  /*  1064
> > 8 */
> >         struct completion          complete;             /*  1072
> > 32 */
> >         /* --- cacheline 17 boundary (1088 bytes) was 16 bytes ago ---
> > */
> >         struct regmap *            regmap;               /*  1104
>
> It's better to keep pointers like clk and regmap next to each other.
> They are semantically coupled as "resources".
>
> > 8 */
> >         int                        speed;                /*  1112
> > 4 */
> >         int                        parent_rate;          /*  1116
> > 4 */
> >         struct loongson2_i2c_msg   msg;                  /*  1120
> > 24 */
> >
> >         /* XXX last struct has 4 bytes of padding */
> >
> >         /* size: 1144, cachelines: 18, members: 7 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* forced alignments: 1 */
> >         /* last cacheline: 56 bytes */
> > } __attribute__((__aligned__(8)));
>
> ...
>
> > pahole --show_reorg_steps --reorganize --sort -C loongson2_i2c_msg
> > i2c-ls2x-v2.o
> > struct loongson2_i2c_msg {
> >         u8                         addr;                 /*     0
> > 1 */
> >         bool                       stop;                 /*     1
> > 1 */
> >
> >         /* XXX 2 bytes hole, try to pack */
>
> >         u32                        count;                /*     4
> > 4 */
> >         u8 *                       buf;                  /*     8
> > 8 */
>
> Also think about it (don't blindly follow the `pahole` automatic mode).
> This is much better if you move the pointer to be the first, followed
> by a count, result, and others.
>
> >         int                        result;               /*    16
> > 4 */
> >
> >         /* size: 24, cachelines: 1, members: 5 */
> >         /* sum members: 18, holes: 1, sum holes: 2 */
> >         /* padding: 4 */
> >         /* last cacheline: 24 bytes */
> > };
>
> TL;DR: don't use `pahole` blindly. Use the common sense.
>

Sorry, I slacked off.
How about the organized data structure as follows:

struct loongson2_i2c_msg {
        u8      *buf;
        u32     count;
        int     result;
        u8      addr;
        bool    stop;
};

struct loongson2_i2c_priv {
        struct i2c_adapter              adapter;
        struct completion               complete;
        struct clk                      *clk;
        struct regmap                   *regmap;
        int                             speed;
        int                             parent_rate;
        struct loongson2_i2c_msg        msg;
};

> ...
>
> > > > +static int loongson2_i2c_wait_free_bus(struct loongson2_i2c_priv *=
priv)
> > > > +{
> > > > +     u32 status;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D regmap_read_poll_timeout(priv->regmap, LOONGSON2_I2C_=
SR2, status,
> > > > +                                    !(status & LOONGSON2_I2C_SR2_B=
USY),
> > > > +                                    LOONGSON2_I2C_FREE_SLEEP_US,
> > > > +                                    LOONGSON2_I2C_FREE_TIMEOUT_US)=
;
> > > > +     if (ret) {
> > > > +             dev_dbg(priv->dev, "I2C bus free failed.\n");
> > >
> > > > +             ret =3D -EBUSY;
> > >
> > > Why?! What's wrong with the error code returned in ret?
> >
> > I want to indicate the bus busy state if it times out.
>
> This is not an answer. So, why do you remap error code. What's wrong with
> the callee's one?

I examined the existing callee and found no special checks for
`-EBUSY`. Using the return value of `regmap_read_poll_timeout()`
directly is the more appropriate choice.

Additionally, `loongson2_i2c_wait_free_bus()` is only called by
`loongson2_i2c_xfer()`. Its separate definition does not appear
essential. Calling `regmap_read_poll_timeout()` directly within
`loongson2_i2c_xfer()` seems more concise.

As follows:

static int loongson2_i2c_xfer(struct i2c_adapter *i2c_adap, struct
i2c_msg msgs[], int num)
{
............

        /* Wait I2C bus free */
        ret =3D regmap_read_poll_timeout(priv->regmap, LOONGSON2_I2C_SR2, s=
tatus,
                                       !(status & LOONGSON2_I2C_SR2_BUSY),
                                       LOONGSON2_I2C_FREE_SLEEP_US,
                                       LOONGSON2_I2C_FREE_TIMEOUT_US);
        if (ret) {
                dev_dbg(dev, "I2C bus free failed.\n");
                return ret;
        }

        /* Start generation */
        regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1,
LOONGSON2_I2C_CR1_START,
                           LOONGSON2_I2C_CR1_START);

.......

        return num;
}

>
> > > > +     }
> > > > +
> > > > +     return ret;
> > > > +}
>
> ...
>
> > > Ah, it seems it's a helper. Please, return the error code from it as =
int and
> > > not irqreturn_t, this will make things clearer.
> >
> > How about just define it as void:
> >
> > static void loongson2_i2c_isr_error(u32 status, void *data)
> > {
> > .........
> >         if (status & LOONGSON2_I2C_SR1_ARLO) {
> >          ........
> >                 msg->result =3D -EAGAIN;
> >                 goto out;
> >         }
> >         if (status & LOONGSON2_I2C_SR1_AF) {
> >            .......
> >                 msg->result =3D -EIO;
> >                 goto out;
> >         }
> >         if (status & LOONGSON2_I2C_SR1_BERR) {
> >          .........
> >                 msg->result =3D -EIO;
> >                 goto out;
> >         }
> >
> > out:
> >         loongson2_i2c_disable_irq(priv);
> >         complete(&priv->complete);
> > }
> >
> > and in loongson2_i2c_isr_event(), I reference it as:
> >
> >         if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
> >                 loongson2_i2c_isr_error(status, data);
> >                 return IRQ_NONE;
> >         }
>
> > Its return value is meaningless for loongson2_i2c_isr_event().
>
> Works for me.
>
> ...
>
> > > > +     u32 possible_status =3D LOONGSON2_I2C_SR1_ITEVTEN_MASK;
> > >
> > > Split assignment...
>
> > > ...to be here, which improves readability (no need to go somewhere up=
 in
> > > the code to see what this is about.
> >
> > ok, I will put  `possible_status =3D LOONGSON2_I2C_SR1_ITEVTEN_MASK;` h=
ere.
> >
> > > > +     /* Update possible_status if buffer interrupt is enabled */
> > > > +     if (ien & LOONGSON2_I2C_CR2_ITBUFEN)
> > > > +             possible_status |=3D LOONGSON2_I2C_SR1_ITBUFEN_MASK;
>
> I expect something like this:
>
>                 /* Update possible_status if buffer interrupt is enabled =
*/
>                 possible_status =3D LOONGSON2_I2C_SR1_ITEVTEN_MASK;
>                 if (ien & LOONGSON2_I2C_CR2_ITBUFEN)
>                         possible_status |=3D LOONGSON2_I2C_SR1_ITBUFEN_MA=
SK;

ok...
>
> ...
>
> > > > +     strscpy(adap->name, pdev->name, sizeof(adap->name));
> > >
> > > 2-arguments version is even better.
> >
> > Sorry, I'm not quite sure what you mean by `2-arguments version.`
>
> Use 2 arguments instead of 3. I.o.w. just drop the third argument.

Ah, I see, the third argument is optional.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

--
Thanks.
Binbin
