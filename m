Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002256;
	b=Mbqa1UOfRnDwJaWfolKRWIz3zylOb4KHBGPdWdMI0ugQWSXoDy9wnxRCZDD83+WCXoEx
	 VqT+Zs2y+5hEsLi/0hQIGPqZDNNZ2vG0zxL8Dco1XDdZH5kWpQsns1AmoxjLyKSNbcc6E
	 zFR8z1yWtxuWgQstHPgh03VYOxAFKtbFxBl1SdsTxbunBflSPWtzBhGCQrkzuUTh5l9Wj
	 QTM1vtv5m9GQfLtEE+qUZvZXaiTOLRFbO45Ipn71uneuahQe+zerXuUcGojvHS1SYD43w
	 KxI6k26GVmrzaw9zrGtj5LK0VLiMTx4y1MnsJYY/095Q1EU7FUrneKng4Dwr1gyM9Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7wxyVYogwlbLITEcqMPp6Ab4ibF5XqXtt1YOnFTe6FI=;
	b=yAwnrel/Bjn4QCSRYhOI6Pe4SEe4xDALWNN61a3cvXtLMExt5+5F7IrbwLynGuJGktLH
	 E+NGVZaYOz0hIP0gZDAFAwjRNse/A1TElXh6eF5enDMySn+oGFofxc91b7fg7mlJMgl+0
	 b3MwkWMQpzYYpz4iojLR0//GWVL/o6qW3K8E9oAOmQuCpnRC4Vcft73MYz3vB0ojLzykx
	 aELgEjNsEvnxhnFWfacOWAPY9KCFvzuzPSZSof+JuErqTuaq2SsppBsF6r/LveW2BZQXz
	 x8IuEAELiqy96uAQgVscs+JoRVI01syt5rGU2GDkciRrDbZ3yd8bejU8VhqbQTDmgaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jN7BU0u6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B6606A325
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 11:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405B6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jN7BU0u6
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c445c95d553so112903166b.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 03:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795002254; cv=none;
        d=google.com; s=arc-20260327;
        b=QJjagp2YDXvM9ICpD+6/jgcSN0xAzt9WfC/2uFD7hrgtHkMPZHLogylj1eNZ+l1rTF
         WX1wSksL5Kt7AmW+o2QqVFM0Az38FzrFdsLAUmgy1ySE2mxmwWN6RAad6Y8g7LDTroGS
         oOHMOgY7LI9OtWTJygi/JL7wHz6+U0Z0Md1HJFLVhHKVTeMnR1w3MQHEs1eEjy5gPj0N
         7LfPjb+QNmul1DQQZGG95eOSMKeIK5OQpxV8y5rNv4pS13MIPluqNFC5ahet3Oluk6WE
         SnBeG57uLVD1JCQD834jPHDPuyagnnGml0LxDmNC0AvsJ+fDLBGkSyIsXJl3UbfEYeXQ
         4PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7wxyVYogwlbLITEcqMPp6Ab4ibF5XqXtt1YOnFTe6FI=;
        fh=t31P9QcKyH6bWVzHpw0+w940uNGUscqY7ELPiyP0juI=;
        b=s4gPHYSgtgO/+rVqw3NJdoTS4V2H58xnpgvQINIInRAYV6obtvl54CWw6CB0cu7mmV
         ZjlNSIJ2l3QNzC9sc9ANuKKj0564i0w1m2Jjzw1K8MisR6611P/3scWOtGHhqELSuFO3
         FnPpSivaw5plRsGo88PukEI4V9KAdGrovFpuPAJKv2ZNyFAGCSaO+qSl6DK1Mk3F4wNK
         Pa73boAd6ZPPygs+HVGBp7ccRp4UWpatUzqAvGA5Kgit0eSbenbv6htnwzim4kU/qyCe
         I+SJDmcT96/DowftEPJu1rFXJ+MlvbA2SP+2ZjApZiOjEcquwUl/EXNtOTu7rPV92tb4
         sWcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795002254; x=1795607054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7wxyVYogwlbLITEcqMPp6Ab4ibF5XqXtt1YOnFTe6FI=;
        b=jN7BU0u6VeM5zSAfAgsDJ9IyShENVOOHKCcCU6Tj6O5lMwlQz+dubJKsJAYbwPU7yJ
         6hsznruHd45cPNEkXsTvlDysvzMk2ZekMgtQWKk54R/4tCebZc41mm6s7okNdb5m/NZl
         Q3VkLw7qfhudVbmDNpoB/D9KEr+jg17v8jaaPzVjx7sRtQgGFWTP7hF6eAPFz4h6Umj5
         YoRqzs5n7yRe9aXS6QamGXu9HojILioBaDIJl5DvivDrY1HkkgGMLnJeAzGKpOmrxinI
         sH/qNInFGi/hCvH9VZ84h3bTKkzH/RRvY0dutglXPcJEJriQ0Pwm++QTnPDizZkEh1S6
         QjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002254; x=1795607054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wxyVYogwlbLITEcqMPp6Ab4ibF5XqXtt1YOnFTe6FI=;
        b=fmtJdcLFvoYJpi1Q9RCkcFdcBZS4NdbBp0RWHfVdmWjVrDMZsTbMcnVeSbtVAD5AJo
         6+VsaU014CztVg+asPul5TT6VPwTPqZBfFLXajgpqENGyQS4tsRUHs+pibPObYvFYw5u
         WDT1QjoAQf9epw++eTokap7bI1ZAIcV63nKYcpFZEu68YHQ2ZhfZljxq9ZcNhRcncUxD
         VMYDABvgop5ec2aIlAJ0f5Y1tuf2x4nnE1kBMOLjTq8M2aU06WfPfUV+GU2vxD4kJ7LE
         BMDfgCUZAQxCcinpEDVAHM/3tg1a66W1AIDnLnXBh6r7VrVXgoL63Vd02w27Hp44ZNwj
         dUOQ==
X-Forwarded-Encrypted: i=1; AL+hErHhGsAsFfii3bXltEEtcHVgU81cw0js5z4Mz9OI0qyZ4tf1u0o8H931JBDLmvfZFOMRDCiWq3bkWrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CkP4wPuIUgvhrnvN0p3GJjMKoSPkYcQKCwaf9gTDPJSPGP3TZ
	saIJgHWM7sb/Ff5P4k/EsMC/XEJMfSNYfT8PItMAHyIMCdGibf7imqGM6JCC2tJPGuGi+mB/m6V
	1RmNxjE0ujvMmDa/kz/qtvalPE0ulSDo=
X-Gm-Gg: AYBFou3JGyQDbJzG/Q+cx52kUs6cecafcBpxgQMVtwdozP+Bz5mkhPzyQjhBms1ynW8
	5W7pgI23nxcHTd8P2wrVFVwhutxh0xrTEMHL5vZAFiutKEjjtMLptGgzWf6AhyaPcan99QUWl5y
	u2wmcQC6Y28NDq71mFDRS6FdIBnTOc6jX9QaPLNzzKsZqq5S6/xtRB7FhZ8x0Mo9SRb1p0LazOA
	+KQzXhw0ECfFVOVUmsGiDGgkgycJ1Znuy8GpJaCMw7y5KJS0VRUBnmxmPIw2ynCMLABOXwjAvW6
	Jnd9WrbOlUYg46gnXP4aE4Qvq+xzW7WfL+jgdSLIL/bnJf6UdC9J0C8WUp/pDkNy8gfHmbmz481
	IFu7jON0golegkTeCS8DZ0PCVX9AQ9grRvhFMkspmfYvFxSD/nxgFqhS4UGl+ZCvhcsi657hqq6
	rdGmAyBGUROfssRProtHbU4Ux/HiPZzg==
X-Received: by 2002:a17:907:2d08:b0:c41:cf68:bbcf with SMTP id
 a640c23a62f3a-c510e4c7b01mr203942866b.32.1795002254458; Wed, 18 Nov 2026
 03:44:14 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20251013060018.43851-1-clamor95@gmail.com> <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
 <CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
 <aPCfiJxyKOXsgNJe@shikoro> <20251021132529.GA4133357-robh@kernel.org>
 <CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
 <20261118091334.3d51a5f0@bootlin.com> <CAPVz0n3=rL9jVc7DtG9FmcH0zs11+LXg1+HRRf9aagUqZf=+_g@mail.gmail.com>
 <av2Nb_likDLz1u2c@shikoro>
In-Reply-To: <av2Nb_likDLz1u2c@shikoro>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 18 Nov 2026 13:44:00 +0200
X-Gm-Features: AclHuK96an4qc5B-PYbtLDwncBYBe2347MxD2hcXG5FWth-Tpd6Gs4iX79m0kGo
Message-ID: <CAPVz0n2rZSRAz2NJsPUXYncgEAi9cFGM0ApfarFq5uMoO9LqsQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Luca Ceresoli <luca@lucaceresoli.net>, Andi Shyti <andi.shyti@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 18 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:3=
5 Wolfram Sang
<wsa+renesas@sang-engineering.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav, and Herv=C3=A9, and all,
>
> > > > > > So, if you want upstream supported I2C hot-plugging, you need t=
o wait
> > > > > > for Luca's and Herve's work being accepted. Or provide a superi=
or
> > > > > > solution. Or, if you want, join the ride. You already have expe=
rience in
> > > > > > this field (and hardware plus use case), you would be a very we=
lcome
> > > > > > contributor, I would say.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > What really slows things down is when there is only 1 user of a n=
ew
> > > > > binding. Too many times have I accepted one only for the 2nd user=
 to
> > > > > show up right after accepting it and wanting something different.=
 So
> > > > > now I just require more than 1 user and it is on the submitter(s)=
 to do
> > > > > that. After all, it is their itch, not mine.
>
> For completeness, let me emphasize the above paragraphs again.
>
> > > No new advancements. I moved on a prerequisite: Having support for ad=
don
> > > format in dtb in order to have support for a list of exported symbols
> > > resolution when an dtb is applied on a live devicetree.
>
> Well, I would consider advancements in prerequisites also advancements.
>
> > > Anyway, the v3 series [1] need to be updated and a new iteration need=
 to be
> > > sent. Also, same operations need to be done on the SPI version [2].
>
> Herv=C3=A9, is that the next planned step or are there prerequisites need=
ed
> still?
>
> > Rob, Wolfram, since the DT Addon framework is not mature yet, may
> > i2c-hotplug-gpio be accepted in some form? Maybe a staging driver or
>
> I vote against it. Accepting intermediate solutions will slow down the
> proper solution even more.
>
> > with notes that ABI may be changed and are unstable or maybe as a
> > device specific driver only for transformers like
> > "asus-transformer-dock" etc?
>
> Which kernel are you using? Can't you use your driver downstream instead
> of upstream unless Herve's work is usable?
>

You are very "helpful".

> Happy hacking,
>
>    Wolfram
>
