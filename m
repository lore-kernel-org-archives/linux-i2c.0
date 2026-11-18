Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002746;
	b=j4L3Gm757TL6k5cTrtCH7MlnxK8eNKYWJOSz+ZO5ZeT4CZtBYXayH1ksPZa7rWXB+io3
	 CgHFpAhvFZLltubs+PA2iuEjJL9IgTfCdXgfdolQ/tZRiuBs3kEYnzMkvxbPgW2AdRY3X
	 rJkyqEdE0h3jkKc9kdN6NNd3DwwygLZlZFF+ixpUmcf5zmCVdejCW6OK2xLmpbrJmjeUN
	 gK9xjkMcpxe9AGOG7LlcWY/DEoc6C4xvCWLU7oigJFC2zXtmTNei7Wh7nbn/SO9pfmS9l
	 3mqJmgOxuy9RqoCdPcM7EWBgulXnoSREJtBnBS4/uJmnt0hUct7EXjKvVQzmWmZDLzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002746;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ndJaca19R9fhRnp2YbP9NHGiZ6oo3XdLFCKLEmG3qR4=;
	b=1j5EkPFpRLQdBITykRS/7hBodDMP+bUYk9rxX6vXFGghtTHehaLLBnXsbnc/RiI33PJt
	 PsliIHimNCN2B08rV999nCcEIFFOqyxZz45y3aNFeHQ1yrypF8xLFeCPFMffoFhstBJqH
	 YFzyQgunce0rOsbIupRBF694JdIF8ictvyAZtqUh/aGJrjdbmjQxGZ7O9LqXtVGPdvNnL
	 ZOVQ5vyySeacV9i9eSO333ru7J5D2VV19IzfHtrldW9l/BCkil9IJ0q3duOYnUss7Mxf3
	 LwRoAvwrwDKriXHbtpKlsYtN59iW6aCViTptFrDucGV5bjR+RfGkMzIBcFgZ7/8m/7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Lr1MJ0bF;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985D606A32A
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 11:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5985D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Lr1MJ0bF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ndJa
	ca19R9fhRnp2YbP9NHGiZ6oo3XdLFCKLEmG3qR4=; b=Lr1MJ0bFAhl+fPUEcjqc
	sJIHwklEZ/plnXYFECQfk3f2EnJe/hMMSJEfZGKucAxJalFSHfbLwaGoA2d+SWBK
	fGkZDS4BR8LnEtg1Nt1y+UYM6xV6mUYxuAsOQVt+cj08Mt+w8q7F7tI3y6RRBfWc
	VA0U1s2rc+QlYGfF1As+CFLPWlJVZFNVkN7OXlgOLj8M5Beez8ipwC38Cd/IwvHT
	3jnRa9Xog5e++t0Cxm1Sg2+nzWVeauDqQiBo4BFo4tLoIWKxdJSjjdQpuXwNdR9H
	SJSG/rjsaXbm4ymILSqHQLa++JCoNo66/XXv32iYhxURcdLGNhEU0gmhkvBaNl/V
	3g==
Received: (qmail 641160 invoked from network); 18 Nov 2026 12:52:22 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2026 12:52:22 +0100
X-UD-Smtp-Session: l3s3148p1@H7XVpItgyqcujnsi
Date: Wed, 18 Nov 2026 12:52:22 +0100
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
Message-ID: <av2RdnZofdcdU_td@shikoro>
References: <20251013060018.43851-1-clamor95@gmail.com>
 <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
 <CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
 <aPCfiJxyKOXsgNJe@shikoro>
 <20251021132529.GA4133357-robh@kernel.org>
 <CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
 <20261118091334.3d51a5f0@bootlin.com>
 <CAPVz0n3=rL9jVc7DtG9FmcH0zs11+LXg1+HRRf9aagUqZf=+_g@mail.gmail.com>
 <av2Nb_likDLz1u2c@shikoro>
 <CAPVz0n2rZSRAz2NJsPUXYncgEAi9cFGM0ApfarFq5uMoO9LqsQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="lS9EU+8BTFAwrrKo"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2rZSRAz2NJsPUXYncgEAi9cFGM0ApfarFq5uMoO9LqsQ@mail.gmail.com>

--lS9EU+8BTFAwrrKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> You are very "helpful".

Yes, I am. And I am "honest" and "experienced".


--lS9EU+8BTFAwrrKo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr9kXYACgkQFA3kzBSg
KbbZLw/+MKYnCxvcKsVEM7TtKmNveNNx7bhwxekOdrVpDaDZOwMNw37wRxQJZOGu
CISKAl8z8fJpFTadYyYfmu2a7gPokp4ATDLKxRomTt0CS+aFYNZhHCOkYIgEedZC
Wn02NNbdbX3guhwSnIff8b0Bo1ICx4co1u29GreQU4BJcuVphkjSxg8Zze0lXf8l
HiDqL/i8+b8XtT75+UHaIRh27tDAKrYw7zGCBuBC9+NVB/0R01l7F62RrKjY3d52
HnRwcSw3wTxhFjNgtVRCMS3Q2Blg9HKqy/yJpWiq4OoxUVzXAJ5hNrU4GKXSgKl5
fB8t6or5KxMzt/x/C+hyzb2uCUH7YECOOjNHJl+3lSoTk9fhleCuGs4xxgNS17/Q
13PnyQCcMID/8U0fhn490cQRs0HWE5WoSXTFOS4qQ82t7gxd0coYtyQh2tSju0sn
YS0yzo57nEycDWD42kW4SeRbghlwY7r9Y0+gZHQKBKn5zY92ma1q0fAbp/ZOUKyd
sga4X9Q5dCpN6IJpbF1io0fUnR+04xDKDXHPe1KSJyxHu5VnJ7EyJwFu8X4rE8k1
VOESskH5hGhfIkzHdcSGkrFY5IA9rb3T5gYDBwh8La9sHsw2vicKlAOrOCk8ySsY
9ejx+oYqkhTmNm0abk+iwhk3EL/M2/0ssFV4QtPGdKSAnJ3r1nk=
=LXjm
-----END PGP SIGNATURE-----

--lS9EU+8BTFAwrrKo--
