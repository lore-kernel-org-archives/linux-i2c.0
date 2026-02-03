Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21B2F90C4
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152113; cv=none; b=pn128KsnK9OddxxaMiY6jEHtV+3MSsH8zUWcTgL/eLDMJQzpQVqC0ZAfGBTUMdKAf19ubvyUYSLpUFx1+Ed0aeEioMKLUtLIPcObsk1oHMwuYbh4ngqKd8GARcZkiHW0tQ0Rj3sjU1LnfcOTRb6XKf2kJdj3JNbaLtxA66MeaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152113; c=relaxed/simple;
	bh=Xlxx+TJ45SydVQtMrQX0lZYV+PdJxWJeV0aa+NGf3T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8+LHayL+XzspTuUMqKhikKhGn61bYXrimSBw+mN93fvrZ7cpSmc1EraYsRHjJvkbokCNcHuOViHfJfyBwVKqfIHNx8C09y0HT2cIXD+J1pWYK8umbKhf0DpXXDlKZ+aqoQ6HaS30RqZszjvzgb91Pg6Kp0EfJU76Wi2pns7XJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JVkIwhI9; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JVkIwhI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Xlxx
	+TJ45SydVQtMrQX0lZYV+PdJxWJeV0aa+NGf3T4=; b=JVkIwhI9VeaoRbHicyH2
	bid+LdwHmBWJcVv2+9ZcEhUlkD4z/6mjwR20bxdICz9kZGCKhYT16bSv0u2+kvGq
	gmcNUtsMpwRxVZawcDXptyeAsFMiTcFCxh5wkAwj2/XXzxAdm/oHXyzUSWjPuA51
	txchVU1sT3mCcI4yAsf8ZpHHYvNLDtad5Meucp/8caUoBCJGkzAy+D1T4QMC3QLb
	xePtfuBDforNozWaWvgSebCKo7F1Ch4C4kCQdN7yS5tBGrQQwCb1tjgkWedZOKv7
	x2MXECqiDZJFCdJh4iOoOBrsw7MNJlJds9jxUMJVvn/JznOI730qSTeyyKoO5gk6
	zQ==
Received: (qmail 2069021 invoked from network); 3 Feb 2026 21:55:09 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Feb 2026 21:55:09 +0100
X-UD-Smtp-Session: l3s3148p1@pmCxp/FJQOAqAAAQagvIAoH29ntsUY5F
Date: Tue, 3 Feb 2026 21:55:08 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host for v6.20
Message-ID: <aYJgrHjSnNM1c5yO@shikoro>
References: <aX1yiVJq7s2iJ3FH@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U7zAaGO941oV/H5+"
Content-Disposition: inline
In-Reply-To: <aX1yiVJq7s2iJ3FH@zenone.zhora.eu>


--U7zAaGO941oV/H5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

> I will try to collect a few more minor patches for next week, so
> if it is OK with you, please expect a second part.

Yes, that is fine with me.

> Thank you and I wish you a great weekend,

Thank you, have a great time as well!

Pulled.


--U7zAaGO941oV/H5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmCYKwACgkQFA3kzBSg
KbYcjQ//ctIqetg2ZRB3+ATb+UlI2gptcXpt2VcPoiwNc7+ya4aAA4R/qarMIssL
JjP0Sr6V0y25AfGyiZppYHg7Jieia+kN37T+Bh7wkaFpOCtbN8iROihGCyAlGDQW
4SKVIME1+CMiHwQpqlRJD2UdvIn6D+G3s0cpB+Y/DaujavnKrKd9m64Xo+DWo4hF
9raHfjRu1IKYa+Lbo4ziYI1ZA1Y9RlRd2ST298pMwDPnJUF0Mj2/eNHHB7zd0hSP
4rdCGD2hR/Pyz/bBXCefbpNixmU5NiEUYR87QlqvCdmiJdYOxZMUbrbGylpLgMKD
EZOBEfRw17mjMsvX1VFpV1ODHeLsvvZNPumpsFL59eUbiPSVLgfQhbogUnoQXF46
f9Zc6K0PZxS0TuD9prWBnoor0YfBpGInbt1rvSU/TemSsUzeDlY34mpSvvDHeeZL
Mpgv4kTCY7y05ED3Q9LQG5YL4/LJkcSTr+lgL6z9ClqRDfhcLK7Rzp8I4mXA5DW1
Nt0RRi7wxblLKDfikBTYvaD8w/MUHzACyL+z/28rSt0y4VNM4lROtslq84WgIOUE
dgX15CXCU31bJhYNiRLdmlRxFq2L8CnzGKxe424QMvyiWOq9eIJCUzsFDsQNtV2q
nJkbE4FRwo3AVRv/DdVR29u0ennMwZnIm5jLPaKVdonz68GBM6Y=
=/Q2c
-----END PGP SIGNATURE-----

--U7zAaGO941oV/H5+--
