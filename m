Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A853A6EF7
	for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068284; cv=pass; b=X4P8ZRvKItJ3Gwpb303SLQZiT5YAoaxgyyUKMU6vS/ldfOM6MvMNEwNti5F30ODQHb+yyTky9w4E+g+RGdeiVVglG6FgxeghUSEqn2//RVbng+r3x24bPSE93ie9a/4WvfC43Qdz2db+gO0nizoPE0rWXGoTGkWpcFIDTnPZ51o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068284; c=relaxed/simple;
	bh=Kr7oDKdU55g5UujuqnKWNs4YuX6K9H43zs6YbbtsyO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t44MzWyBDFXBDA+G1NQMqRm2ZysRVG9SFFiiwk3wwC9Ez9QB0l5AoQR7CeZfJsKz6v889vbZuBjgJ3B/FLDpjzRKXhb0ggzMqnQMgUnBcdC8t1pbcBeusCG63AH5eoyuUQC8/7FHqSgzSINFXTjYYQJBfRanMxN26nHQmBwh2PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrqBdkSz; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrqBdkSz"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b886fc047d5so652926766b.3
        for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 01:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776068280; cv=none;
        d=google.com; s=arc-20240605;
        b=Cgh5NxJIFQodSpMHZHfO//Rn7oeasKI+0/3KHOBrwhdW46qtdLGjySQsg3ec9nEHTL
         9UN1JHsG30kvZNS2y9It1jpM5JpP0wCgOU2jTOh75HDEmvVRG3f02jMBOcTWG7LdUqzE
         uaS2VxhqqG/HRsE4WtlqdNq8+gfXCN8fvtmBxVAgEYX326WimDQ3HPeG7C6zFwmIaMQL
         vOkYLP4kAQzUEW8G6pK75UoESkxsBGkE3BDnQjs2PxU7o+v9NPCBwAVlg8WLlxCIsvo0
         CT5kGrxOPzOhQIfZKI0/1RW29UOzmjK+A+kVxloY23s/OQNWnvMYzWhyyfos//yfRZN+
         VHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKKtC3Qnmy/nhNGVLZ07dvj7VhPVzyQUkTlW6PGzNKw=;
        fh=wvlCDG/XhU7gMesxWfPhDnEcUa5s+ZXWuYY3BMw61/k=;
        b=F8e1UJqSs5HQ+ajLg77e3sSDGVJTJqcWj9bYgfl94z5+Al2Xzt1Nebj+di8Di3sq3x
         auuPidJiIUIy7PLh0gMQogtI2R1A+0uwKFLRpPONTWNie3qXnMR5xORqpP02WmSr+MOZ
         Onke1MC4jsDb4XmjfWptJeJXI471DVqJahDr9ef9/fZ7H+febCQn887n+mE2IIVfZFxF
         CzdHNC6zeCOCtU2wuUWFNBGYJ8VOvw6SZDD+g4MSTybpRxME65M+zNbyJcPgD/ZMEMtL
         zmN5q78vOaexywoYqskpJ3OprfGNO1cyEdOXPKbiS752O2WfueX//7wdkmL7azN9I1er
         goPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776068280; x=1776673080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKKtC3Qnmy/nhNGVLZ07dvj7VhPVzyQUkTlW6PGzNKw=;
        b=SrqBdkSz3IimTGrj3sYDJ2vp38C2TcOYM5k5gzFIAoGUp8yIcub0LceMVX+/z/nvo3
         ePark7QRopoaUOTkISEY9Bu56d70UuCvNr7PFmGqe8PYo3HZWC0FmpDggLPkbhhoc0PS
         hpbul78v6GT8P4YYRRGBrSGnSyUSBmGoICSHH/eOMnysZl19iXPG2bk/Eahnq7VTVVHO
         7bbuhemlvbG22AVCy8S40k2yo36Y4ZNaSpwnnS+mXpGbtmLiJQFK1jSxj4FqyPiUvx6j
         7IxrWSSqUeXOSsLSECdvlDnT18rTAVWjJCXhimicZjrN4EHlV8cergaMjv7RdBoW/gch
         5tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068280; x=1776673080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKKtC3Qnmy/nhNGVLZ07dvj7VhPVzyQUkTlW6PGzNKw=;
        b=iEc6vPaUyXng+waC5+XS+0FcixFIayLbXUsNiMS4fuRBEnH/q4huBSEOhn4e0Q+Cy2
         slzBHdCWVfr4iRLaHuSK2+ltESEQ6ugnKE6gV2r82DR5lMCvVT32Dfx34d6jEZ+H/A7r
         cnUN5LyxdUYgT6UvdRzh9sF1Ih7Kc44wpDwNBdjWsnfhgQcCUFPCEB3pXOT5/Ear65qP
         LrAtpyrFF9NTnyPeL5MH8DTdSaVg1ar87IgGZbNRhZ2EOK8PjP5tBvL/xPrUpf1sfW+O
         Zc7IZp0bh7KA4csQUICec6cnVkNx4Au5HA60N71Ycwr4VYvdcekRQTUY9aTdbEdh0R/d
         UcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtb/qh2OrYZmUqLOKpUgQvxaSG43bu/EaoN/S/RXGcKQUMRRa48r+Wt+OML7q6idSz31dbNZ/1CBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxakn6Ws6E1PLWl98Vcyweg7sjOJlQmKBSGMDWohs+zX1ELvaYd
	6CKP7YrL0IaJ4vHZ71XVbEwVcp3XKMgIuJRyNPNiJFKTGgfMw5ghKz1eqqiDrx4e8adPGBXc0jm
	Nl9M+0XqHDOdAwVnFI1s1xYDao67g0wo=
X-Gm-Gg: AeBDiev0p2PSXXxgCmLAGPItuPEtKO0A7XNsHZF4VwOzirm7HcU8orKtjKWxSB5v9SK
	LXkYCuBnyrxS7v8FqwR3Ey6HFX2YL1KMV2hMVxJ3SI9IRX9quiPvNlzWJ2OhLZgyKrozbyo7cpR
	BPX6aW7+elMqF2M+tE+O1geNh4JcPRFrdESi/WAwUrxPislCtRNPjfDISuewTEmEvJ8+KuhS3i2
	DyvJp8OyfvGPRGM+A5qZUK62gDrFyNRjWwzn2YW5zYMbrzD93bGEAvHhJa77U0iLFhoiXFLQ7US
	dMEmYgsh53T/8GBzPuMOjEsxkApVvcMUT3/862LJva2lWZuE+eI/oNZDrp1dK4+ZVmRBjF4YeT/
	tqKBeeYI=
X-Received: by 2002:a17:906:ef0c:b0:b97:34e7:ea87 with SMTP id
 a640c23a62f3a-b9d7248ab15mr627211066b.19.1776068279504; Mon, 13 Apr 2026
 01:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775900045.git.zhoubinbin@loongson.cn> <CAHp75Ve59GPAFvKM6yOkPmr=kmHBjVL-Vz78X0WDikiWd+2arQ@mail.gmail.com>
 <CAMpQs4+QmyAObvCcJOFnfTuufG8=M0q5m+XMkaP6-SOp-8wq9w@mail.gmail.com>
In-Reply-To: <CAMpQs4+QmyAObvCcJOFnfTuufG8=M0q5m+XMkaP6-SOp-8wq9w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 11:17:22 +0300
X-Gm-Features: AQROBzBJwSsZg2tUBgFtmmJxajkFQLHqP5eXC7UwkUnFX9NthWB1sHncPf4yD5E
Message-ID: <CAHp75Veymi3z2atMuSeDyrhyx-HLHgCMzJF5EgpJZzTGgpcD3Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] i2c: Add Loongson-2K0300 I2C controller support
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:08=E2=80=AFAM Binbin Zhou <zhoubb.aaron@gmail.co=
m> wrote:
> On Mon, Apr 13, 2026 at 3:52=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Apr 11, 2026 at 12:58=E2=80=AFPM Binbin Zhou <zhoubinbin@loongs=
on.cn> wrote:

...

> > >  - parent_rate_MHz -> parent_rate_mhz to avoid CamelCase.
> >
> > Was it a special requirement from maintainers?
>
> I=E2=80=99m actually a bit confused, because when I submitted the v6 patc=
hset,
> checkpatch didn=E2=80=99t issue this warning.
> But now, it produces the following output:
>
> scripts/checkpatch.pl --strict i2c-ls2k0300-v6/v6-0002*
> CHECK: Avoid CamelCase: <parent_rate_MHz>

It's a false positive of the checkpatch.

> #512: FILE: drivers/i2c/busses/i2c-ls2x-v2.c:437:
> +       priv->parent_rate_MHz =3D clk_get_rate(priv->clk);
>
> total: 0 errors, 0 warnings, 1 checks, 574 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace
>
> > Note, the physical units are special. The m and M have quite a
> > different multiplier value. So, even if asked by somebody I think it's
> > still arguably should be kept as MHz.

See above why.

--=20
With Best Regards,
Andy Shevchenko
