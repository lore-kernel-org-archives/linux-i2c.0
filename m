Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001722;
	b=tFq5CWAlMEufdh6RJqzWdZvzy2Mq2ilxT1zdgCXZ0bZIghdBneIIO+nm8lOCDtiYMklo
	 jgpZz6QnQaFG6+Frwp2LKycf0u4ZSKbyY8DKqGfmC7I37TOpj6MNjcROITZcuVCqf2Htw
	 u1o19H6XVTORmYCdts2RhUZqon1ypWKlyq9XaNTHL+L8tl7V1HrnJ1yJ19bqeg4L8GiLH
	 5bj8AzmSx00SdMyHiuMZ576LMlET1AQVwS2f4z91lDRoEtkanMMQYrJ/mjDDWkl5g+Iu8
	 0rZlGTwNBxAS/+lPINk8WvjnbMiSRY4YJcdvKM+v9xEZa/CPPhjbSL40s75H/IiaKYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001722;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=k37KO7KB+i9fXXHpuqDuGG7GUmrapPGUxzY4xauYm8U=;
	b=rqsY/+uecvF81wJAW7oJYxCCa/XirJUpLUQtGbXQh31H/S2iKohzB/1DXUWzWAFrXfzi
	 CtFsMbM+L6JJnqgB0L6DKplOiqUiU1itouhwoN+yrcTgfB8btE1NibjcitOD9PJTmgzX6
	 4DCgIyc8P9cXqPH9B3lsfg5tWIhZJn4eGcNvt4TpaUM8gCeI8TqMdYWWyWsaGbkDdRccu
	 xScxuNdczyvNBUp+5l7C2uQ+A3NS+Q69HmTj9rxqCTgwuqOP4r8d1qRGejq5SCTmVnyAd
	 yRgg++WW2E6Qbb1pmI+fJvkkVzH5C4fsWpNJPPCcWpeegSrFQRpvSSrr5SXkJ/LWqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=GYv7qfbE;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8F606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 11:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=GYv7qfbE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=k37K
	O7KB+i9fXXHpuqDuGG7GUmrapPGUxzY4xauYm8U=; b=GYv7qfbE93OtE7KY8yKu
	Oame7dYZ4yO3t9HylRAGkhCRnHhEO4hEzu41Gs/Zty7aZoiNeEoCs5nuV74Msooo
	OQZgeZkzb959F6xfhyUInoojbO0SLf7n+RxeK1qJvrP04Im4Jv3aN0ZoZIPR+ibd
	n5FMW1c30efpANJYWqVrWsGxKou3IFxHp2yBEL5mxHOpMbV/sNaLXFpscjf306FN
	lbh0NxiujPIr+5drS0bTs5GYZPvhem99Qtu40yhw9p00cPOghXb7Acqwas9tjVwV
	g9td8v0w7zEuzgq0WtUka/UDqMRaCrKO0hCtAOllyVU0962icco8pxWkmRLNqXZs
	1g==
Received: (qmail 635607 invoked from network); 18 Nov 2026 12:35:16 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2026 12:35:16 +0100
X-UD-Smtp-Session: l3s3148p1@QgSlZ4tg0LYujnsi
Date: Wed, 18 Nov 2026 12:35:15 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
	Luca Ceresoli <luca@lucaceresoli.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
Message-ID: <av2Nb_likDLz1u2c@shikoro>
References: <20251013060018.43851-1-clamor95@gmail.com>
 <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
 <CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
 <aPCfiJxyKOXsgNJe@shikoro>
 <20251021132529.GA4133357-robh@kernel.org>
 <CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
 <20261118091334.3d51a5f0@bootlin.com>
 <CAPVz0n3=rL9jVc7DtG9FmcH0zs11+LXg1+HRRf9aagUqZf=+_g@mail.gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qYv5FLU54i6hmxOp"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3=rL9jVc7DtG9FmcH0zs11+LXg1+HRRf9aagUqZf=+_g@mail.gmail.com>

--qYv5FLU54i6hmxOp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Svyatoslav, and Herv=C3=A9, and all,

> > > > > So, if you want upstream supported I2C hot-plugging, you need to =
wait
> > > > > for Luca's and Herve's work being accepted. Or provide a superior
> > > > > solution. Or, if you want, join the ride. You already have experi=
ence in
> > > > > this field (and hardware plus use case), you would be a very welc=
ome
> > > > > contributor, I would say.
> > > >
> > > > Agreed.
> > > >
> > > > What really slows things down is when there is only 1 user of a new
> > > > binding. Too many times have I accepted one only for the 2nd user to
> > > > show up right after accepting it and wanting something different. So
> > > > now I just require more than 1 user and it is on the submitter(s) t=
o do
> > > > that. After all, it is their itch, not mine.

For completeness, let me emphasize the above paragraphs again.

> > No new advancements. I moved on a prerequisite: Having support for addon
> > format in dtb in order to have support for a list of exported symbols
> > resolution when an dtb is applied on a live devicetree.

Well, I would consider advancements in prerequisites also advancements.

> > Anyway, the v3 series [1] need to be updated and a new iteration need t=
o be
> > sent. Also, same operations need to be done on the SPI version [2].

Herv=C3=A9, is that the next planned step or are there prerequisites needed
still?

> Rob, Wolfram, since the DT Addon framework is not mature yet, may
> i2c-hotplug-gpio be accepted in some form? Maybe a staging driver or

I vote against it. Accepting intermediate solutions will slow down the
proper solution even more.

> with notes that ABI may be changed and are unstable or maybe as a
> device specific driver only for transformers like
> "asus-transformer-dock" etc?

Which kernel are you using? Can't you use your driver downstream instead
of upstream unless Herve's work is usable?

Happy hacking,

   Wolfram


--qYv5FLU54i6hmxOp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr9jW8ACgkQFA3kzBSg
KbafLQ/+JjGVoz1Y+FppxPCBTtUIJhVL5FvNMF83wKngz0fuh272fiYTm/TFGIpZ
AhBiOviIuzRujDi1Tvo3S1BQumVaHGzLkn8bLW5xU85y/WkWdhrdccHpPWQ56CTp
aCr587UH7Qh2V9p0j7mWce6fQ7d6wIpUq9ocJ6uhbM9V74pMtm+4+cSgfyf97g4k
+ww9DfTUEXY/QfCY/HwLBnzgeeakaEp18I/NXxz7rap+2PJ7SWdDEkv3sNCzjoFH
ltuSZP6TIekUR5dx65URcyy087WeAcVKGdAU+Jhwobd1laaL2VYs+8QiQ5tBFLu0
tjHV9AZsAtR/J/NQYp+Pw7M4Ubihz2OkQ2hmwWtu36zY4E2iFrJYfClcc2DkNZ45
pUoxR4hpMUjyMHEo0Up59zvwZZQHSqTrwGUWj8fHfu50Mtqtdl/avQV/HTChviMI
M3xfLmKTkSL9ldLrHfjCP5LFVNI+jPtGvyxDPE/22/O7mvI2YGvifO3xTbQ120oz
6GH+NDkOaAeiNt02n/aJAuK1ADFmTYwsaGt1KP2Ni/ClHOBP/0i3BuZ8b0djNcLf
bMB/23oXVl4CAc9tmxER4p+RgRwcYiXQ0HLf0DAxx6dM2dexet1V73TeIoq8mGDt
bdjtG92Xip7ukm26GoBaKTPD32P3ER67CN2YPNsG+UYNBCmGQi0=
=eUXI
-----END PGP SIGNATURE-----

--qYv5FLU54i6hmxOp--
