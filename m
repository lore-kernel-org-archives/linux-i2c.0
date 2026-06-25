Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C425771
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418937; cv=none; b=YQAbJbclyjR78Z6Bal5ToBhSAHEO/leG3x2ZqtzDfCxxJ/1KXV5IVgOZe3MjsjwkmIqMxDFYvZ7ulODoeGnG7F3Hl3c9+XtU+gDEgG5VR0/gyAQtXKr8QZndyCKoLIilJJ8pCF8GYFrnJIklbr2qyJSmWp3ucaoopqWJifTqEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418937; c=relaxed/simple;
	bh=YD6LtW669LHxDqll+Pq9PP5l+vwGGjkT+qANV/P1Exs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtmD71BkWpymZt74w2fvTYwD2MtKmpA3xsThDKg1eS6tWeWj+GEghZvZ+7dLQe9PiY2VKVymh4IGw7YSqPp0hBFW9xPE157wS1ALyS0+HlgvLLuxOl8TmiY/BtCfOyQjha+L6ob2kCJtaAaukosy9sS5EaLrundudl6Lphmt9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G83uvZPP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G83uvZPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LAKR
	rDuzJLPFXpcrQ9QnyMFf3qvZkAt1onk0EY7uLas=; b=G83uvZPP4XYcNhdGUgsg
	Ij+esrO3TETf5xAXrc+fGchgCFBgeuk0TQ/GKJdUfQm0z/comD7JHL73Zlz5oknl
	ALuxszy66L/jNKcY9vbSkwMqWBknai91BDoFtc6YKucAWuK17wlPB2x8M4akyV7P
	nJ79Uc2xBD+B3JBvShU2uDJGiS6u+/E2UrhWzHKjJ6V2yqeKigSh7ibOlUW6mAN0
	3t57PVDiocrURmjCv0ZERGF7bKYeY6MQoB8tTm3DoK6OxU+uTXvmqLgjw+X18+j+
	eYs5Imb3A3y1eThZs6TvlcV43sTLwMX4IBC7pdVFq3C9VEobHwM9bn0cTSMn6nhp
	9A==
Received: (qmail 3283903 invoked from network); 25 Jun 2026 22:22:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jun 2026 22:22:04 +0200
X-UD-Smtp-Session: l3s3148p1@UMLUvhlVAkBtKXMK
Date: Thu, 25 Jun 2026 22:22:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] CREDITS: Add Wolfram Sang
Message-ID: <aj2N7H6gMgr-aR7P@shikoro>
References: <20260625163221.183414-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EgBgSMIHM2p6aKIy"
Content-Disposition: inline
In-Reply-To: <20260625163221.183414-1-andi.shyti@kernel.org>


--EgBgSMIHM2p6aKIy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 06:32:21PM +0200, Andi Shyti wrote:
> Wolfram Sang has decided that a decade-plus of I2C was enough and
> is moving on to new things.
>=20
> Thank you, Wolfram, for your years of dedication and for keeping

You are very welcome. Maintaining I2C  really shaped this timeframe for
me. I hope you will have lots of valuable experiences, too :) Thank you
for this patch, Sebastian and Andi!

> the bus in line. Your legacy is now officially cemented in the
> CREDITS file.
>=20
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

Reviewed-by: Wolfram Sang <wsa@kernel.org>


--EgBgSMIHM2p6aKIy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo9jecACgkQFA3kzBSg
Kbbm7A//aB3NB3rqXrmZKGxVDkc0WsCMlWpRd2VfcrbGOLKYQNyy2eEB9lmtADwp
tCg4e6jjaoopwndssNH4ARJMo7DyAb4/EV1rg5I6Fs56q3fz/46fUqnmRIE8bSQE
8xO733839JlBJE7maBuhSY5zqzKe8/UTgfFjjKrD7D0feEPjrwcrqwEPf3fjCVjU
Iabxl8MFS+SWJrmPUPHaqnWIzw1znTTBidiXGGki4Kzq/ljTNrj2fjDHO2vgTDbf
WtnYG9M+/HBOqfF76tvw+iaYXaBwciFiakILgKRFxdivLuA1VyJw/ajDX28mc2NC
jNi326rOcHGsoap126/cykJB9rdBhxJqnObVr3jZcAIFhmEzESmK3Td9MrgNtWpI
/bvQsqFqeIQokdLYp5HAqb2kjjdz7E8gDmKmxvvhbMPl90pV9KcrEuwzCmn4ANKz
44jsvqL2d6zv+gEmOeFJEC5SnykfDK+7ZBPFxjn0wWgMPYOg4SAspTYMwpAnC1e6
TQWFQQqBGjuP3vtcNL4quWTBK1sPs9Qp7xELgKNQqyga6qKVT6TXCgRLzUMmatft
JwK0rczbRDlGkafpOtVTw5PgSH/uO3U8IBICkz7k1Tw+iX0JGC3SBzC31jkzLTC2
r7/ybT3i2c+Ls3kl9k7uK0fFhrcQhUgbPwNrJyZbtYaRTOrV4iI=
=dtjC
-----END PGP SIGNATURE-----

--EgBgSMIHM2p6aKIy--
