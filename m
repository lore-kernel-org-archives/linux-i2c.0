Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795012972;
	b=3d44gbe/mzZpuEMsaDoJpJqzNE4hXF/GcOWeuv764veoXUvQZZ7C5PL/48X89MtRyhOK
	 r1SFof3Mcy9pxK+iGW6px6YddlcxJe0edRLiLpTOJ9RrPlMmQnCcSIrrBFauEeImhpuNz
	 +MjE9risEISbC2tOo+f8BGoCH0VNnO05rxmeifuSnhefW0bLOG3ZLegd2KSJqWYInm0eq
	 f1BdoM2xs7mcwsWj25Jzkj1wtFJLMrvq9ylSSzWHyM7enAF2a+Cj1+NIn4XWN6QXp28sp
	 5Z1TOk2LOj1h2QCpJigZkfDyu5yUyBBQ6hVF+QxHJtNML7uCjwXNPnrV5cF/68QgXSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XUoJPQ+bQcBMLjchQg2sOom+qhVfJBoy/IZRsgGe9ys=;
	b=kfbpwHDHegJmqNwuOvtB74Hyl2R8tsmNU2ybStB19v3XtVSiF9EEnWhqn3D1uj/7uFCa
	 bDsuAsp6OBeR/Oz/sswlerrqYHMSV4G9Q7cEvmQkyxc8Ni7qnHHJEvyAso2Tzksu3Jr7c
	 lUdKGXgKwSuk7P2tvTINyHTpjsXPdTG8jchpaCmzyO/O1GjS2Zrk+WgVXhX7mc23Duj52
	 UKdoxX2Mi6gNZ99gr7Pk59Z1tcyFRCjcCb1mM5qi5thuVjmMYtBZVSbEcve5WHFWDic6N
	 Ro3JQES07ei1svCjoGqAqjfIoyO0RU7EpIRc/5M3QBA8bA25yB4kWzZJA69U+kIiJyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jTiQDbi/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4790606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 14:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4790606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTiQDbi/
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b8784a3284so19470a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 06:42:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795012970; cv=none;
        d=google.com; s=arc-20260327;
        b=SXnaQ26kgI1wV6+9UliOaZKMUyAiqgzxotrm5fK6a8utsb7wdRQwUOrDZEOW9RmC5y
         RiX50JQVG6JgYpLSujgDK1wchoF4U63EF82lW4kH8jUk2ezDnOrxuM6s6BrTj80iGE6r
         wYuFbmCfc5a0BneYu8xt+TnbJsIHj14eeJAHPk6EPI2exDQOzUue9zpDN/4pPDM/GRTk
         JsE+gskRm2VnLPsKQrQdcplO38e1W7m0/GwmeMu/uYSUZF/slmwnzyr1qbh7FxofwsZS
         HVBRxSI6WQvpTdnKi9pgZWIhDCJjmWvepuiqqaPr/K76zgjS9d1ihsrY/GXQ6VzOP+fA
         TaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUoJPQ+bQcBMLjchQg2sOom+qhVfJBoy/IZRsgGe9ys=;
        fh=PVzq7sg2tHemA5A0b8op+4cLnvQe0nc+4+PJcpwuAYA=;
        b=rU8VYQvbBn166XgP+Mp8MYY5r0gN1wB/TfDuCDJbgeUlElzRUneHXavrhSq8PfRtkA
         si251etWlEf3qlKnkX3tyOFkKzaSwuYzIeu1J1FHddAXEmGDy3httyNXrUL9lPtuAKqx
         x4t7FYTM5mqKmjjEso0QtRDu4rxmyPLPTM/KjcV/dtdzrWff7ANamwjlvhucBp2OSjgS
         PZancSKvrRt9zs1BdWwOkl2soK+PmE1GUhfgPPgsI3SUmkNb0DnN4QwZbXqi6b5LpJvd
         jA4sa0U91oizcVwF6yaZ8cz2ZeG+LPz1HtrkazQjWrqZ7q4K9+rzxshox5Y4QU8lWsV5
         /8uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012970; x=1795617770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUoJPQ+bQcBMLjchQg2sOom+qhVfJBoy/IZRsgGe9ys=;
        b=jTiQDbi/ZtDF9t7SdZiTQkBZF6ofbKF1K/q0w7e3sDchHSUAOksiNycNOD7xKOPLqg
         zhnYNkawYM2wCk380hedn5Rd00ZQCh4tOqAUmiix3gR+AyyaiA+eDJ/E3PlvsFYJYzC3
         BE5HqaDLzWfvWJS3Hry0BVCbMDMI5JnmBMXQHsPnZUpnpwRYbt/Inu1lk5gxec8XS/tJ
         RgIcD4ZkSKHPIeYSAzprNwYjsKa6lt2s/20I5DNtB+ZNJC/bEB1+JGDUHI75kO2qkRK+
         jsqtJb/tW9GUrFzizei7Y9LEWjJjsSv3KmCtAV9m1v0QIPJwfAItP6FbSgZWRCz/WfjH
         PTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012970; x=1795617770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUoJPQ+bQcBMLjchQg2sOom+qhVfJBoy/IZRsgGe9ys=;
        b=IzoVqbVpZvVkHGIY7Lzvo+y1CaDtxoahIVQW5JPRKRnYJvHJwdMZFsZ/uKnEMu3GJz
         MbeYIFHTjG14nVd1/rpbLraSUaxKu/YUSt7DtKasygBvIrNQw2pbS/kUaBdEvO119mR9
         A7om1HSSnz9BA6zQZHRID89NRlPa/nEKfr3AzyLZDIglArRSZ5NR5LTyF0eATKO1PmUo
         X2smguZoJiL3ruh86Z5sU84NjuXoRomkkijL5fR9+ZnOPEZPgeXrrR9XepJ5Fh/3Aw+r
         UqfdJk0e8VGfOqzqeap203JRKXHWzLGWLnUZE2L89dNuilUQaiYLHXsLLbie1XundZS/
         RN7Q==
X-Forwarded-Encrypted: i=1; AL+hErHaQ/vOU5Uyf1jqhDJ7Fn43ZPq99emisjuq55wgp2LuUhxYrLv9iXRc+thwVWY1ckVkOlxIUMGdxLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cGinkvg+Pggu/beiVTjt9VHMBWtlP89RnTXz7ifmik0kLIPLe
	HkbmGiK5YXGGUzDqwkoNeT5mBIaTGRK/UkLgAfeeJwraodKh8qXfL65rjyHpfcKFxFNwjqRiVV7
	9uQX7jRgwWLD0s985H5+gfh1aMNqVQTs=
X-Gm-Gg: AYBFou2ny/WUBkJxDo72FvRo3VBpfkTdV2kipERLFvPuUWPDNIAtwnzQ+gGiHTAgwla
	wOJ/8HbOds5Xmk5XjLtamsinRNzWAS+6kZj8dbH2lyk7ZTXl3C5YqX5LWglCdOgIAYv3wkKzuN/
	F2ysOHo/n6j84DTfiBdfGRGd5kBoY5daSe2LyqhwZPP7m77B022jtkiG0V/uSaAhAGL4gjgOh5w
	/5W5ehvyUMyGNfGcQe+b41/ELOZIj6KLGFK1g1nYcyGTKzi9Zb43s/jLIh9npEKIsr6BcMyJ8pe
	S5LJkcab8CscfqVBoWdzhnGvyF3Oip5/4BnqzQZ0FsXG1GqkIUiRIx4ea0c+VixxkxXyHUM3Hlg
	mrcmQ4fHFVPrYyTbd2W2WrmfGv/TkIh4icEhAb0L4AorAO0rzfKrxheAKaxlizVP9imS1t2mjdY
	gHzymPMPSdi8apLzulP1Koo5Se3TaYYQ==
X-Received: by 2002:a17:907:940b:b0:c29:f5d8:9c73 with SMTP id
 a640c23a62f3a-c510e324a07mr241805366b.34.1795012969839; Wed, 18 Nov 2026
 06:42:49 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118134555.195479-1-clamor95@gmail.com> <20261118134555.195479-2-clamor95@gmail.com>
 <av24x_dcu2hggP5y@shikoro>
In-Reply-To: <av24x_dcu2hggP5y@shikoro>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 18 Nov 2026 16:42:35 +0200
X-Gm-Features: AclHuK93fhxoBlMqicbFK9Gc1HJyqVV4hippm2euH0OtywPbIka7CYKr7EMAras
Message-ID: <CAPVz0n2jSrZ+ya=7JgARDRTFZ8-cu=209GGiOK8KYAwph1hGDg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: Document ASUS Transformer's Dock
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Hans de Goede <hansg@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:4=
0 Wolfram Sang
<wsa+renesas@sang-engineering.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
> >  .../bindings/i2c/asus,transformer-dock.yaml   | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/asus,transfor=
mer-dock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/asus,transformer-doc=
k.yaml b/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml
> > new file mode 100644
> > index 0000000000000..5f4a40539c2b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml
>
> This is not an I2C controller, so "i2c" is not the proper directory, I'd
> say. "connector" maybe? DT maintainers may have another suggestion.
>

I have placed it here arbitrary. I am perfectly fine with any place
schema maintainers point to.

> > +allOf:
> > +  - $ref: /schemas/i2c/i2c-controller.yaml
>
> Hmm, this bindings only uses "i2c-parent" which is not even described in
> the above file. Not your fault / problem, but we should describe it
> somewhen somewhere central maybe? I guess the above $ref could be
> dropped still.
>

Child nodes too. IIRC i2c-controller.yaml covers those.

> No comments on the general approach, I'll leave this to DT and Asus
> platform maintainers.
>
