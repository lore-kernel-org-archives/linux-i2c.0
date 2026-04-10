Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92153285CAD
	for <linux-i2c@vger.kernel.org>; Fri, 10 Apr 2026 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784807; cv=pass; b=NavPRNMrsUjKcOJcBE8oNaJVTKcTYBXOOOJ/8MVNtFsAh4bA3UhUKGX+/rLF7SYsvpq2B13PG+qZqssYKAfCCuekFUjRPn7gTUAWPNv1+fTOpIU50m4jLhVkcCXqlUfENxVDt36Yh93V0TKxqh+fLwj0gX9IvgwVeNA9tGstE4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784807; c=relaxed/simple;
	bh=v0RxlfXW3Yt4r9QqOZBaKvi8zTLZ/zaxLSOp6ntgf+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZm5hS8u9NnjVD8zdsLw5H0fgbm+TULX8ChmC0HeFUjLTJogA8mhQJqLNI0gA3g2ygzew9gqmYW3KwXaDep2pmqBvDOVLKDB+JaAUqbY3s4031BOxEfJhbTnBIFd6BUGp54gqLlK44N+uTKBAjYLhDHwSP22CkqRDt/yLbY5+Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibvt0kv5; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibvt0kv5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8d7f22d405so229674066b.0
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 18:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775784805; cv=none;
        d=google.com; s=arc-20240605;
        b=HgHMAegp+PGJ4ZpCKSwm15EpC917AMQNdwFRUoonn+sZwGt8VtHRy+d20YeaQHy9f2
         S4Bu/vwibr51tF62F/VM1MgnJZp9oONtAAZpjAa597Vy/peBqpBI0PXy6jDas1YEnWoS
         IEZpHHsiadiqHEMnVf2bZAJ/LqINCSTlV2xsu79TXGwCId/uDSeWQTWDFzZSRJHXQhUp
         /BbTr979Y+CD3GrhMp/N4AvMRaimCmJDq5K3cscFzmGmSZSQZELLIUyqu/p08/k2LXvB
         jdR4wKG0VP/WgqYdKpfhwvkohfwSiPCPKDFqdT3V+fdpj/QdhivAh1ivxrdzPxfA4jmh
         f31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TAZr5maqNwb2p7O3QeXeUeWJQwU2bOpGNhJioqUYzWw=;
        fh=WVQQB6C3nRT2hcxtGuaTeihy3+BFrLyARZU3G9+0ZrE=;
        b=hRhKcaPCRfSmnknxSZITvqPr2pT9XeLAYYja5SIpDS8GUrxeSEPgj5EGoyigbMtsFT
         45w8fmVysyd5xg1bJLeLrMHQK6tO90F6wFcp01N+X13Fui8Y6PISyjRV7WaLE6bicOWA
         +LeIvKAL4sOr5zSwfCdOYO7rGA1vjqs/VBPClZnhfet4rzEEZoyCiMmrjbdLutDwaVs1
         haG+EfZRKQ4mjr5LDL9Dd3cO2CXff0U/JsdItKLT1BdcCtFgApSMCv7M3FOx6G4AUGY0
         gk2MNJkbM0sDW5CkWawbCmBkgM2diAwyKerH+xlIx/gwrmzKberf2DOmV0rz3NUElmeB
         VKcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775784805; x=1776389605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAZr5maqNwb2p7O3QeXeUeWJQwU2bOpGNhJioqUYzWw=;
        b=ibvt0kv52idIeUAP5i0K12b32ZXuazr7p66l0GDXB2BSnMLWgvavB0ncyouy/VYcQM
         eD9cmrSyFf0UyznKg78H+X9EMLT4XEn5lJiMdyyWfJGt+Gpeym03G6F17OUq7IlfuBX4
         2tW+rbzQE7RAyMyEEu3BDKNemdb3m8+MxfQtgKVXdnY6feSBU0G4uSF5Jl0cnmbHxzdm
         AZ8cL4Osz7ns1sPHuSApHUcjn/6soTukdVFlIaCzsy/uHPPcdal1CavTqqS8dB2kC8oq
         0UTN9mxoSStuyad8DN0KPnrzbhhUisFT+C7sOki+DABX9NiQc8yLYMcN8FfWLulGhO1t
         icew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775784805; x=1776389605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAZr5maqNwb2p7O3QeXeUeWJQwU2bOpGNhJioqUYzWw=;
        b=dK6go1QovbQtUaCOdFxZJ8gu3JdV0ENwjkxPUIBAWPkGdjUxRhOmnbcycFCJHoklFW
         TlB8lLj4Ooku7JTb2yzKtJTNvdspbFOCdQ+Jx+M58D/JGJUMaBwrr6Yvg3LrcGBTnXjG
         HhE/ORKkc5XK6Pos73Dl/Ng18SAo5dxblLKxgcgMwiA215lnwVFxNYa0FKavKX/Xqj+b
         2Y1k8x2W5v8jrD+Xr7TBwUxw8gh+Cf//7tmJAh0XuRf1nBc7gqcr/M5QtMBOAZmZjvJp
         ugSgKy1cEvVrpCrJfE0GEAvZLa8IxxJEYFte6WoVjnKneWvqr4CzrNBmaVLDHRpRHLlJ
         kcmw==
X-Forwarded-Encrypted: i=1; AJvYcCV0QANAq2rIJQ7piTGJ0dI6Zezsb5TMyUOx0Lg4pmCFd0LrH3N1BZiQZQYSJgSXAzScRZNPT+xqoqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGS31d2zzkYGzcCvdz4JCZV9iH/tga7vOjJv5bbKiRdQ3Ooysf
	FbS2LJ+NO4HrVm2b8URLL1Ro/lE5p2lRuIq8589DuEmgjJAwqSNDKFQd3oZBOjY4/Of7rcHekWc
	x4fkqe82VKp7f5MbS3XHdYf7b6m4hAA4=
X-Gm-Gg: AeBDievO+hypfvhbx33aEraAoazn27FcemAL5cBtNJJI1cansa66rsnzv4+uxyEeDbb
	D6+iMBljU4doOe0msJMVczqi4+6haWjr+oss7CogLRYSat66VGdoJrnwIRh4JF1XR437JgumMEp
	5cIxwR+j5uC9cNhu7rLMpheMv2dZWCHsbDvo3fyLfpZXTi1G+Iuvr0wkdg1rM16Dfh2Obv91qHS
	6ZKHfKP62PO2HcvJluVi1HU2eadjDb4loqYApjEMvZ4t4ubLAL+cMRRwLir9MApVsRLplNRefri
	aciHV1u7
X-Received: by 2002:a17:906:33c8:b0:b9c:8da:15ab with SMTP id
 a640c23a62f3a-b9d72ad229amr50444266b.44.1775784804564; Thu, 09 Apr 2026
 18:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773991081.git.zhoubinbin@loongson.cn> <4236113143cc88b45062c1b8a34a1f840f29a0ac.1773991081.git.zhoubinbin@loongson.cn>
 <adfMBWyDh27NRe0T@zenone.zhora.eu>
In-Reply-To: <adfMBWyDh27NRe0T@zenone.zhora.eu>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Fri, 10 Apr 2026 09:33:12 +0800
X-Gm-Features: AQROBzAlSa5JEpCh7UCmcjzWRk8bSKAVEwCcV1FA_1Ptmw1ZcZ9lnGSVxWuLbF8
Message-ID: <CAMpQs4KYDVJnok5UfPJb3b=WR6u3OTdps+976YOox9dAFKkEcg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-i2c@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi:

Thanks for your review.

On Thu, Apr 9, 2026 at 11:57=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Binbin,
>
> > +config I2C_LS2X_V2
> > +     tristate "Loongson-2 Fast Speed I2C adapter"
> > +     depends on LOONGARCH || COMPILE_TEST
> > +     help
>
> I'm getting a compile error here, I guess you also need
> REGMAP_MMIO here, right?

Yes, that is indeed necessary. I=E2=80=99ll double-check to see if there ar=
e
any other omissions.
It seems my other driver has a similar omission as well. Thank you very muc=
h.

>
> Andi

--=20
Thanks.
Binbin
