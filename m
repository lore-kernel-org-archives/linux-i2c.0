Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C32C21C0
	for <linux-i2c@vger.kernel.org>; Tue, 17 Mar 2026 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750657; cv=pass; b=pW4WkeOwCEP6U4Uhrn4NLsXK6xHzCZRT2V+s1m+Og4amO+Ama6Qo53nMAUCbGuW37EP6icQX167WzVMUYZkshRAw0SQ/LlIm/gbJl7QBybLpmhOniRkaitobo9Ft5XVH2XWTUm7IoMoaeOx439zcos4BWcvcM4Joaf++KvUlRcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750657; c=relaxed/simple;
	bh=iVI/aYbZjML/zXQFyx/DyAycVJiYb1PkAlg427mPHcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qP10I8Pm3SWo9XbBAfFYh++3a6NSQP5cpfw0Zf8a+OKQ9IV1VDSu4oA41wd/hB1jY9gJ04thN9dcbT/tWz0KDFzlE/Lh1eA3SH7ijPBj8Nljv17q7yy4aBzWgzM+IiA/l+RPvl55CKg5ord65cnu2My5EFiVIssNV6nDSpVB9/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHEnw4k/; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHEnw4k/"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6655469237aso3742023a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Mar 2026 05:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750655; cv=none;
        d=google.com; s=arc-20240605;
        b=StOwXIrDX4/tbDeLQWN0fzGQJy69nT1bWv42yyuNXOjTskubySNMQSJxC5HzccUCfc
         21r/WUtnPSBFaMEKqKEWW/HaS0+HCc4AsNwq8X0CZ+h70PrL/qfTqfhpVu7HrBCp+wlm
         S7GCgcaHhIkpQDSfmlxtYU0/NU6M5sK1Tw50mKfFkkJoCYRtJwADabGLgy2eruY5axD9
         FgrWpye/7hg4FIJubkHtdzGnECsEptf6UDsBhAKa5AY+cYeaaa/qPE0XkonzZGXR8wM/
         2eXVzy/mky/Ve37Oa3CKhW14OabLyODgpPnmnAt4vrhZe0NgJJQRPxU8SO/j9kx6iq0p
         mCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eKGVaZGEthLonpWdZqAUAIX4b+v5oagSeyJWvMOko08=;
        fh=Hs1vz9xFr8dfe5ozWxFNqqxbcqP8Fyw1C3SY5p/+PiI=;
        b=T1y/kVXq4yTQvEXnK1sKuGOJ6fO4FFFLL/Cwvl53q14P2Kl84bUebnBStM0HUYnR8j
         M8bXbG/Q5ACPdWY0fil42GZxBvOuoqtACJZWThLCoPRHyI3Ma+xhJioSMxo8IsLMcWU+
         Aq501etDFbvuj5+pwwC557arHfhDA/aUlrSjK9bidkSDIbk6iao3XhRuZfnOLxmtgW67
         cmvMUsKFIJwbReDsMNzxLAVWOJEqWZd3gcdk8Y4BPN7PJrqTEvfOTmlHnqKsSHrOyHom
         6XSVxu6E9StAu9tSJMkmbV4Bs4SyVnMjqQP9UeSmw2+Hcklh5A+avOq8w72wuZmYDe0q
         CN9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773750655; x=1774355455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKGVaZGEthLonpWdZqAUAIX4b+v5oagSeyJWvMOko08=;
        b=QHEnw4k/gr4ixTlgHgmKa6hwAoK1aCzGTl5K+iHmoU0KiOiIg3yKCoOlIjbxU93CZw
         DGNmQ2D/sj9sz9uqsxJFdsZH+Q7XmkKCqWIPhrbGJw5NMf8s+AmPxTw4Cs3P+voCbEae
         lYaEKGIOhPBwIC+O7mPVAfdROGkLwKumxV1/Py9MyxuAnI2V7aD11pVx5i8Zl630hB6k
         +fPPrs1YNCbn0Qau14/zirwxvNkJW2GuYGbD6D+S0aZzLPCeb7KBquqXzmMQ5rdwfkmC
         888TAT0mhGtHo56LaQwm0MeN8x04kR/jekeGSTXRfuhaSBhQSMtrX1Ep4PpWOE4JE2qB
         wx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750655; x=1774355455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eKGVaZGEthLonpWdZqAUAIX4b+v5oagSeyJWvMOko08=;
        b=CYQ5exVTVSoIl6WFWs8CzU44Lo7Rst6B6dZLG7P/KBFuUY4DQKLdSRYazNQ5U5+Mk/
         C3i1arikfFje1oDxRlcbnXAOSTUfFnMr5Ef2V0FyHhEErFSGmXgi5z1B7fIEeqW8LAhT
         U+TULyq+Uwb4w6/tCax5QZvzX79dz/STKy1Vp1LGzU3SepJbfWEgkX/ceoK51Yx++h07
         PdQ1uKo/piDZrocbgoejI2whoIWG4DAxGbRa7Q1gUkdN2XVlc2ZkO715gTGUqY3cxxKK
         fM+Z/jdwrO3zN/GxJ4k9osEyoZsYSz3ka3oj/9JP/FvLFb1SuHLJVoCmyIYnKAvzCJQl
         W5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvNPmnTHqOYb3nDQtNTOTKBtuHNCQMI72uTSiavgz3pZ1f1sOFQGN4Q6Wksus7GkGccXIvFA1UTs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwscthL/DZHMLqs0YIA58aWzvJ+mhYdGEFr2qvkNo6RVPxIwF
	8Ajz/fSoXb5BmhsHereORkVBFZ8sFSiBxwwNhUX3FHuDltsyyXhyIX3nB1Nmf+CaH0k3gYiz5cZ
	8VZBSckn9pJP6CceRD7VeaX4iIjcaQAc=
X-Gm-Gg: ATEYQzx32mryklVxZJ77S0P9fjuH8kYhEvA2BYn9HODHRAhDwp3Bso0Ebm9ee+6NZQ5
	Dll9pHDDI3ylTkDzHm12lCnqRaUcEsO8trTA7LzG7P5/v8DldSKGnljEs3LKVtKU5ZLLTvKy+1n
	af/sOMatlKgogpNCIy8veTAjm8btJ+Nh0rVkZ+Qn/1zX5fY3+pkDBk3xJPgkHCPbXrm6XnKIixT
	aeiCHkoPRsqlmv12FYdEpa4C322fTr8sDs2NP1HigItVPT42zMywjINAsZxkAZEaA0mOjuPakaH
	8kPXjaRvFE/IVEtv/Ilw
X-Received: by 2002:a05:6402:1d49:b0:663:4560:aa8d with SMTP id
 4fb4d7f45d1cf-663bac0b2a9mr9465681a12.26.1773750654417; Tue, 17 Mar 2026
 05:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773142933.git.zhoubinbin@loongson.cn> <bd5c06a20ef2e61f76902c4209f2be539ca91a97.1773142933.git.zhoubinbin@loongson.cn>
 <abAyd9uyl3TC8vC_@ashevche-desk.local> <CAMpQs4JVYRo4DQyEVe5NhHQ=VN96mF17AtSoo6a4CGB6w_Aphw@mail.gmail.com>
 <abFTF-RDxLqsSs6X@ashevche-desk.local>
In-Reply-To: <abFTF-RDxLqsSs6X@ashevche-desk.local>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 17 Mar 2026 20:30:42 +0800
X-Gm-Features: AaiRm50Kv8zppqeHF9w4EcoyL9629DqEk-04yGnKyzwAzL8KPJzuesVItDbOu6Q
Message-ID: <CAMpQs4J323uWkjPXYXwwb2URRV0wsfkiFAXOcNazejzdhEsx2A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all:

On Wed, Mar 11, 2026 at 7:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> +Cc: Bart (what's going on with i2c_adapter_set_node()?)
>
> On Wed, Mar 11, 2026 at 11:07:19AM +0800, Binbin Zhou wrote:
> > On Tue, Mar 10, 2026 at 11:02=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Mar 10, 2026 at 07:48:53PM +0800, Binbin Zhou wrote:
>
> ...
>
> > > > +     struct device *dev =3D priv->adapter.dev.parent;
> > >
> > > Derive it from regmap (and check elsewhere) as accessing dev in the a=
dapter
> > > may lead to issues related to the object lifetime.
> >
> > Do you mean regmap_get_device() API?
>
> Yes.
>
> > Also, similar references exist in `loongson2_i2c_xfer()` and
> > `loongson2_i2c_isr_event()`, requiring synchronized updates.
>
> Correct.
>
> > > > +             return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed=
 to enable clock.\n");
> > > > +
> > > > +     irq =3D platform_get_irq(pdev, 0);
> > > > +     if (irq < 0)
> > > > +             return irq;
> > > > +
> > > > +     adap =3D &priv->adapter;
> > > > +     adap->retries =3D 5;
> > > > +     adap->nr =3D pdev->id;
> > > > +     adap->dev.parent =3D dev;
> > > > +     adap->owner =3D THIS_MODULE;
> > > > +     adap->algo =3D &loongson2_i2c_algo;
> > > > +     adap->timeout =3D 2 * HZ;
> > >
> > > > +     device_set_node(&adap->dev, dev_fwnode(dev));
> > >
> > > Why?! i2c_adapter_set_node() is part of the i2c-next.
> >
> > Indeed, when I rebased the v4 patchset, `i2c_adapter_set_node()`
> > existed in the i2c-next[1]. However, when I prepared the v5 patchset,
> > it was removed[2].
> >
> > [1]: base commit: 6117e1ba1db78a52a4161208ea403d3769ad73c6
> > [2]: base commit: b82316862bea929265725c077dffcec42e3dc20b

Excuse me, I=E2=80=99d like to inquire about the current status of merging =
the
`i2c_adapter_set_node()` API.
If there hasn=E2=80=99t been any concrete progress yet, I=E2=80=99ll try to=
 keep
things as they are and prepare the V6 patchset.

>
> Bart?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

--=20
Thanks.
Binbin
