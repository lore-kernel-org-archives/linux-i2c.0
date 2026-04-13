Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737B399352
	for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067711; cv=pass; b=iu8FVqNXrRgsFU094YUi/o1NHRnuyjAg0MT/l3Q2Pcx+hPpWepqrrc5TTMTz8LeqGXv6HWWXSmSJ9poC01880rxazHHnWswdfQVXtgmqR0/vXTvM7zK/Vkck9w9vCQ/+tSBpp8G12f9Mk0K7lhH8s34Xw3d1UaEX3L2JUkDA7iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067711; c=relaxed/simple;
	bh=8VnhIoj02WULflqqgWqAu3E/FZcCIYMP+zvbnxKj2aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nILNYAfN+uVwnCkN+it7dCLIXUG5yZVeyGnoJwqecX26HYsYJuhHitoS8I8vU3V3GylUcPKnl3SGp+zpjeMAgs+MKwBhnmsWpsXI3xM9ZGXM2x9ygvyPHpQ4ge0cgvmPz+myYb9O2YJpPWCFhTg1KaNLqwm1ltX+rJ57+bYFVAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0Njt2Xl; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0Njt2Xl"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso5319782a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 01:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776067709; cv=none;
        d=google.com; s=arc-20240605;
        b=ZABesPUMznx09pTM4QFDanI/fDPu7ZL9zxt30f+Y9XAOFB/cNXN63pybErMY1Woeu0
         sKAdJ5uQ7pvyaXAHp3yT3uun39mbVvU88WWn4V6BRgUeFhsAFlABBGNtNYfSoaWHWmej
         KZXCPPDRXdym1KiJgQBW+jM89UDLDGZ+irjUeKqiKzl2LUEV5zELdtgn03KSgRQZBZj4
         UxK89xvIESmLT5ivpqrsgjux9FJ+xxKvnwdeNY9gYJSXWbeWO5U/QPw45Z7HUpVo6CbW
         v1hkZIQEQkj8DG02zQ6lcFN3Pk6l48NBvVyOXsHpi1TTaMAiAx63Pyb/HG2TAr1TTymt
         KLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvkP8KzDKek7CehUY4JTh8N+6Hv3yrPu4Ys2u/4PdPc=;
        fh=AahGs7hSrgv54VgBf+Ko4JFwbFR1+bBjWq+YYrgwmEk=;
        b=Fkm2mE62U9Y7eV2mBf6WJHvK2RiXQfXU5xxgw6ITvrkjvSEsKrw5drMWiCQEUAjcQL
         wftZ0GiOT3e4jjY60lE5+KST+DEMcz9H+wSqMjTr3rTsxCQho0XhbRWfI+BeAkJEdeqf
         6fNJ1KgcjGPQk+XNzoT7sHtRlZPMvN9lPGDjfVwkT2+exFbasG85ZzUC6zl1WUcxkD81
         y+shnXWfxhZvNbhM7ICL3g/CUO5KU6dHrk1OuCie5MOhxwhcHnLuzU1zr/XWM1xXurru
         rqd4zrigelbTXwpKCW6ar9eOBtOIkic4ZlVGwjgxEq1aCYIBfEECvYwaGaPHtscdCLac
         SW9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067709; x=1776672509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvkP8KzDKek7CehUY4JTh8N+6Hv3yrPu4Ys2u/4PdPc=;
        b=X0Njt2XlAwuLFmJovw7MJjUw1XZtfOsK6iGvcWNxJ7lT7iwhY9YlL+OdNYQ6uUxEF4
         NWkL2dpFX4fFTLn90cxlDiwxXTT677VI/13OmK/DMpvwx91o2HTIi775SeIVYnSFRHru
         w0BRXh74UNOeBU4RygvrQlmeimqCmshHxZFCiCdlBZRlkicggs6nozqyJMCUYAacsbdi
         Ad1WW8hxidXXmSsf23u5h+pHYr52HoQfqZ3cAcUfwZQaXyKYCYaHack6H5oPFRDX7/AE
         WRgZqJ9AnStLROG90icXKBjUeM7ova6tjpdD3twImtcO3whKu2oXBCkVW+rZ/SeoyHAw
         sqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067709; x=1776672509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvkP8KzDKek7CehUY4JTh8N+6Hv3yrPu4Ys2u/4PdPc=;
        b=CK7X//WBFU7GYCW/+M8Ymsh4J5Rt0b8QrCZdRkZKbjIZD7atP48ERVwkJZE5XC7IO5
         iVKMOmJidZS57GpCQuXHcWAkUmBpu+0xsqUla/vu3kC/P1u5SB6MqkbnBZMDmgcYidNI
         g/PZYsyYCav+pwdhCUnpQYXftQ802tZtULCg7FVMw2dPIfG0JrdwVXEL1c4R4hcIhmfd
         XlXq+kpqtWtq78XKOXYtqUcsDVyvjZlN3O8pp+u7RYPyvN+sgxUVy5vWnopm9aMejROZ
         jHc0CrRrS/TXLLP+f556e74OfM01GcSN4HqSGeQHnoIeqFowN4xNiyTqZgazNeyC378/
         YBfw==
X-Forwarded-Encrypted: i=1; AJvYcCUyCRftgP4zUBxivAdFcMUJMD3nfNQl8oCOjhX8QBwXoCfDqhkNSh3/7OcI7YEXGAfwn4ujxkfJ0nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUSXOoaqKVxxjMs1rnJ6GkgBu+3HUSwMbYl98+8lEtvWx4JyF
	sIWt2pxFmf3p/VTGjr6qefhuvdefC2j82IzPhebpG7c+Hb5CfEQ8WX81uAIUrs719O6DgA1e2tH
	evqDqgyQxrwIT6No1GHMQaIl2lXB97xo=
X-Gm-Gg: AeBDievIqurZiWtgqF3Ja18wauF0YKTn0pptTFBg9ZGx0SCFp3UDaLwEI5gNCMw+5ff
	J+yd5ju+eJVforNFJS97BYer8VET69Wyj/DdgS70s6IfieUa6V+7IIRnlUzuQARJNnkJ+vUZNWH
	jZnSAR/Hn2Q6k6I1XXyy6fTre3q9p/NiovrA+rg0Ao4GBsfoe3unrRlyLY0W/Ns5ZybUWbnuLX5
	1Ff/V1fxpYqv8dVYAs2Hwn2YpDG+8cLNGfyvgURJLJWg1ey93Nyes44qxi4fwlne3bE74Lvi4ox
	aP4pgfyT6EaBfGRDFYY=
X-Received: by 2002:a17:907:7281:b0:b9c:eede:adba with SMTP id
 a640c23a62f3a-b9d7248aa85mr708424466b.13.1776067708140; Mon, 13 Apr 2026
 01:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775900045.git.zhoubinbin@loongson.cn> <CAHp75Ve59GPAFvKM6yOkPmr=kmHBjVL-Vz78X0WDikiWd+2arQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve59GPAFvKM6yOkPmr=kmHBjVL-Vz78X0WDikiWd+2arQ@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 13 Apr 2026 16:08:14 +0800
X-Gm-Features: AQROBzBp1_1f83xVVf78iSav36n4yOfOrZ9Vhqu0U5oqBm33LFFYkL6t-qaEFjA
Message-ID: <CAMpQs4+QmyAObvCcJOFnfTuufG8=M0q5m+XMkaP6-SOp-8wq9w@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] i2c: Add Loongson-2K0300 I2C controller support
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

On Mon, Apr 13, 2026 at 3:52=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Apr 11, 2026 at 12:58=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson=
.cn> wrote:
>
> > This patch set describes the I2C controller integrated the
> > Loongson-2K0300 chip.
> >
> > It has a significantly different design from the previous I2C
> > controller(i2c-ls2x), such as support for master-slave transfer mode,
> > and  DMA transfers (implementation in progress), etc. Therefore, we try
> > to name it i2c-ls2x-v2.
>
> ...
>
> >  - parent_rate_MHz -> parent_rate_mhz to avoid CamelCase.
>
> Was it a special requirement from maintainers?

I=E2=80=99m actually a bit confused, because when I submitted the v6 patchs=
et,
checkpatch didn=E2=80=99t issue this warning.
But now, it produces the following output:

scripts/checkpatch.pl --strict i2c-ls2k0300-v6/v6-0002*
CHECK: Avoid CamelCase: <parent_rate_MHz>
#512: FILE: drivers/i2c/busses/i2c-ls2x-v2.c:437:
+       priv->parent_rate_MHz =3D clk_get_rate(priv->clk);

total: 0 errors, 0 warnings, 1 checks, 574 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e

>
> Note, the physical units are special. The m and M have quite a
> different multiplier value. So, even if asked by somebody I think it's
> still arguably should be kept as MHz.
>
> --
> With Best Regards,
> Andy Shevchenko

--=20
Thanks.
Binbin
