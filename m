Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE903AE196
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708070; cv=none; b=hTWdyPSQCZIZzRrLCS7AwZ7pM8eesfIO3dLErQAacsNCoX7ehpXfZS90DRm0HNVqd1RerFwZhRTLwJFeKJRizuKBqQPzCXmAjdLK3xV2nOuBLAF0XpHcljEMtGGXMWoIsCub7rDZM5+lUOIyev2uvgA0ZdnJoYbLTPED7ktFQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708070; c=relaxed/simple;
	bh=iT+/QPHVcHlecNMd5It7pqkC3hVv/s24hIydGjYZxHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSP5XO8/vIsiTJTiy+Tx4h9T/RNYxi8BwqKokV08Hthm2JG1gQI4q4h/Y7QRy1yPeO20n2gJqLfrNZ3+Kgz8hG6Y3D8+2xXvZU9CbU0QolIB3gxF9xomV401wpdNzh9ETk4X9qy4kyDrO3KeCaoFld9PR0QTvwubzWiv/k4vsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=N0fPE7P4; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="N0fPE7P4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RcAE
	0lJGCwpijpOwUA4sY+aEmjEb1isYlzggOdNNR/g=; b=N0fPE7P4AtyttLRp0pbB
	Qzr2tz8BvMXYF1Ypn02X9PsAh8cAmFfDCCvm2eleIt+z92OiC9BN4K6hShWpyoV6
	X0BwzxAeG44aNqnnYybQGHo4FXYPE71KOUrqTavnvhX/rLjo9JWST13zNGoeNjyY
	BcCfQeP3SReLfYEGKx+qllemvQ1Isz3tehYluyn95l7QKTedeRldnQLbMaQ8M09D
	wn3ml1bowtC56c0ArFQNV7WFI83SsI/q0loLXVE4LDlymgnAMVUwO70w7z3puUee
	GqtIy8PLtYcdGLO3gp4bKwrYp1xKYnS5OIQ/CMNUO23LGqZ72Ox1GGdbIugr4sz0
	kg==
Received: (qmail 3580323 invoked from network); 13 May 2026 23:34:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2026 23:34:16 +0200
X-UD-Smtp-Session: l3s3148p1@GrHUvblRMrMujnsX
Date: Wed, 13 May 2026 23:34:15 +0200
From: 'Wolfram Sang' <wsa+renesas@sang-engineering.com>
To: markus.stockhausen@gmx.de
Cc: 'Rob Herring' <robh@kernel.org>,
	'Bartosz Golaszewski' <brgl@kernel.org>, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: AW: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Message-ID: <agTuVxMAhttk9sX-@shikoro>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
 <20260507181711.2696783-2-markus.stockhausen@gmx.de>
 <20260508131830.GA1135235-robh@kernel.org>
 <007a01dcdef9$05ba7140$112f53c0$@gmx.de>
 <af9xGlIWG_OmREzX@shikoro>
 <CAL_Jsq+RyLno6kojsULC9M-Db+h1N+aoyJZgYs8nXtY4J+zEFw@mail.gmail.com>
 <05b601dce2fc$9c82dc50$d58894f0$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bCUDLevkwMqEYaF5"
Content-Disposition: inline
In-Reply-To: <05b601dce2fc$9c82dc50$d58894f0$@gmx.de>


--bCUDLevkwMqEYaF5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Markus,

> While working around this challenge my POV is as follows:
>=20
> - See each SDA/SCL combination as an always hardwired bus=20
> - There is no muxing of the bus as a whole.
> - It is only a question at what time access is allowed
> - Why not expose each bus as simple as possible?

I agree and it matches the idea of DT being for HW description only...

> Coming back to my offer about the new I2C bus that only=20
> switches from compatible "i2c-gpio" to "i2c-gpio-shared".=20

=2E.. even so far that I don't think we should use "i2c-gpio-shared" but
only "i2c-gpio". The DT part (HW description only) is this compatible
with SCL and SDA described. It is up to the OS to decide how to handle
multiple SCLs using the same pin...

> This should be achievable in the driver as follows:
>=20
> - add each SDA to the individual bus
> - build up a shared SCL list for all buses
> - link each bus to the required SCL

=2E.. which should mean for Linux that the i2c-gpio driver recognizes an
already selected pin and reuses it by some reference.

> That will need no shared gpio features. Managing the list=20
> should add ~100 lines and the rest of the driver can be=20
> reused/adapted.

I think we are aligned. It would require no DT updates, only extra
handling in the i2c-gpio driver.

Bart, what do you think?

All the best,

   Wolfram


--bCUDLevkwMqEYaF5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoE7lMACgkQFA3kzBSg
KbbZMRAArotBofvb4b/alr9cF5Lp+gTTV9YtK0077D10qu5ECfJ6ahhuIxUHolaS
NgiseXOAtpTMUPqXVoQ7gw6uVC0j1g859NWnxWhlmSeRj3N+/gqFUQsHGiUc78mV
hSGVrkuQ0QNG3WYSnnbueqYKhNtboJDusCAJNTVWxZZHBk86lXoik5SGXTed1gs0
t1yWd5AV/J1xr8vdF4ep5rNdUUzCk2QhSgpWuKMdiVxwZuGgtbX3AVPkqC+86SBs
lhpXNqZnIUFWGLKuOPdbEvkhJn52TzY2jbjig+JYHf1JVH8IpYIe0aUV8g1UESpO
+ngiRln7HxykTpkJ2NuZbnE/gDpT1Kn/phPMXJYLK0Fi5oe7imD3mFkiLUIQb45q
+095vbkwOPSRpEH1tw9HsMjnKt/Ds0iDTcwEJWTB9yFu6qYDMmrEJjZAUrVkml7b
0lf911OI+ft4GPb7GjZtD4vtIc2r2sjNzakh9rLsYlAvmTEimUnT65qITFzPCPdR
P68XdueOWpg3hudlvY36hqCgUGJCjwpbQNFuLg/q/eAwa5k/brSSxMV5TG0WtiJ8
yIl3Ktedoeg2MKv4UY+Pfh8LhxfGaW46e+nuq4VYl856of4UE6SJ9icFg5eyYpBm
PVKuc8KTZmuaqSN8vlFZwLnqluNfW9CrDvRlJE82f3oVdKEzkyU=
=umRh
-----END PGP SIGNATURE-----

--bCUDLevkwMqEYaF5--
