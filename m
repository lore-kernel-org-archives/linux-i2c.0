Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8A298CA3
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656374; cv=none; b=PiY4mMmyLs69nA7V8q20qbEJD4bm9nbGGCcj7/NpGkPSKsftpDqz5o4mUCdOVgB9BCMQuBB/N+uAdLjg3lY1q5qjeRo0WVDZSC+h2JP5Z6J7R2PECkwtPxzsygPldC4f+/9rHk1Swb1Wg5vd0OiWP4sH3suI9CGnBpTlJuzJj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656374; c=relaxed/simple;
	bh=0H31XGK3CYCvcMF8pnQIjsZUwd4VAVONMjyThwF7u7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzaG55DeOM9ZFKsoufWTltVq+IXN9Z7UZ1pQfQtWabwkf1/KYMAEtliN4+R8IaoH8K1gCPjCteQePdv9jIPBghIsFS/iaJgu47Ks3+vfiaaYU16gWT3lCw1t6dqtMQ2XUEa53OsZiMEw7Te/btqoalH2TK7gQNW9FTjvLyX/xSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mNEDwqRV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mNEDwqRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0H31
	XGK3CYCvcMF8pnQIjsZUwd4VAVONMjyThwF7u7Q=; b=mNEDwqRV/E0LY3clUO79
	Rln8EDGDv0QUwaCVnDpASmvH0GZ53yIDKNmHd74P40iGSogAT/HhX53HsEooGBD+
	ra5SEbkk0WZYEvmm3oqLrm9u8X/cGKZzu6brMZ6Jaqh8NljK++kOFM1mE4hbT6GE
	13qALU7LuDWjzl6LX/LAqKUCTTn2eyFLqAhmOgh/ENjVQ8wWTWaGBySKRx7U3002
	kcultJ7NE1g4SyX+u59VN++NtY4xVS/C7iUJYkmVkW7/HLXsQ+ZDxHmCVmjpWwSs
	/MDR1Bja9a7t8COr+VyugI8qykusDsvdXNsljdkZgAMF6nQ0rHyTkmTr2G4R9SgU
	7g==
Received: (qmail 3314701 invoked from network); 13 May 2026 09:12:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2026 09:12:47 +0200
X-UD-Smtp-Session: l3s3148p1@42D2tK1RUqMujnsX
Date: Wed, 13 May 2026 09:12:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: markus.stockhausen@gmx.de
Cc: 'Bartosz Golaszewski' <brgl@kernel.org>, andi.shyti@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	'Marek Vasut' <marek.vasut+renesas@gmail.com>
Subject: Re: AW: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
Message-ID: <agQkbnSHblUNz-IZ@shikoro>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
 <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
 <004c01dce29a$0e44e7b0$2aceb710$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TOvYIP+oU2ewljgr"
Content-Disposition: inline
In-Reply-To: <004c01dce29a$0e44e7b0$2aceb710$@gmx.de>


--TOvYIP+oU2ewljgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > It just so happens that at the same time as you submitting this, Marek
> > Vasut wants to enable shared write-protect GPIOs for EEPROMs. This
> > seems to be a similar situation where the default is to keep the line
> > high and drive it low if there's at least one consumer that wants it.
> > I will rework the gpio-shared-proxy driver with that logic in mind.
> > Would that be enough to address the issue here?
>=20
> I'm unsure if this helps. From my understanding SCL gets toggled=20
> high/low for each transferred bit during an operation. This data block=20
> may not be intercepted by other consumers

I agree. SCL is shared between the busses but if one bus uses it, the
bus needs exclusive access to generate the desired clock rate. The other
busses have to wait until the on-going transfer is over. This is
different from the shared-GPIO examples Bart gave which need all the
input ANDed together which would result in a chaos clock rate here.

But thanks for the explanations, Bart!


--TOvYIP+oU2ewljgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoEJGoACgkQFA3kzBSg
KbaJjw//U7zNVVcuo9qfnzCHu3M4qzh7VAT9m2ulJoChRuz4UO0b8sFp/NhA7+yS
GUklRRRsGEnybfliKxgQHKrngBlTogyMBi07PvaZ/Dk6o4vSViNskwokdZtns5Y3
OriT8yq58Oh1XWRQ7x+85KmV8w2ikyN/IrhyYcR3LRmSxSU/bTtPCkEsD0kXFxQr
UI4GyiteFAVav4ExSk1M/Lw+VxLiGMVVL1lyw/pqedBKjHm7WcmF5VS160HgSyIJ
6614/mGUvYW1c1OrHmc7kHOVRPMGeu0wb5yWJgLtH5sBvrWE10ME2byQ+GSHbPwI
5YMlUamqEX+sbRX3OYI0dQlKHCqwaVy2qC/KLJcqhDJfKuwQshDy37HO4wMRYHi9
kDmKjYPLeY1g34kk8aO5+DcAoS3y2A2CS4BqbBqDLZ32WXi/9X8FEgj2tGLv71Rr
iR0SJQR21IhOzrZhIx4ZdPB6GCwCvF7YLl6pHUL27XvgAWUy5KZMI5v5ebcU1Jfw
qW6lte3HiIxVfrpEewxLJ26bxg0ff3SX4oAHUDbNGN/HaxzQS6mIzbU9OBTmLuxu
sPSld4LaOroyPb0zQmIogR/p/mPxx9jRLMCfk5r0CRU9UQUIAr00TNtyNBOZyCKL
3raWJexoasoEkkA8iev6tda5jlIRHVo6/z05nJ5P9Y4H8VQgNcs=
=O+S5
-----END PGP SIGNATURE-----

--TOvYIP+oU2ewljgr--
