Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF033A1681
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186016; cv=none; b=l+FuKQ6/WoprMxNiAcVl9b72uC2Jk2rW7jbieSXuFbrECNyVSKC0ebRkoovuV3LMU2hPe2GLB+Niz3TuAEBBo+G/BZgtIdZbhL6YdzZMp8EKXPcfEVC4IQpUSBUYdqEQMmk15B0ATpkvSJYqsE8h7Ha3I/BqHnpDcGaG2kIJRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186016; c=relaxed/simple;
	bh=EdZSaA0C6gAMyC/7Ma7PIqm5PA2QmdakXhgc++wfox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA9O3mr+fmChPYB0wN2Py+ZCFjvJlRU1bCTUHVO/rB/RYMkBwXx7oEYuxIaotyvCs7TMzdAKTINu2W7txxUu+DFU8dE/aqXe/BQylVG8c2CQx+xpb2bx9wl/Sl1B+pWCu2+Ek0nL2HZQ3Ua0GgKdUKZuuBXnxitdzLz8F9/9Hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G0DlJkG8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G0DlJkG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GUQk
	wZvXcKvl33DLs7tJ5DB4hVcyDoCZruagdLhcOrY=; b=G0DlJkG8olXslFjKmoJ9
	ykZBcLQFqdr/i+f6lMd7mtfrvKnkvq79BcupJ8XVMNZy7gaEXvwb0BseiA34rZNw
	nEkn4RPtjQiSqwTe6ZVnzyBSo6w0Cjuw6BFQX1GvjLHMeXu9QHJ9RlfOW6eNYQgQ
	lsr+lrUIdHUFUKQrgleRL+8qG1BIKgWDw2/feUhMCOrIV3YVu3qmTq0nBYdRRkdn
	fsnuU4xOQUrttY8V1iAjxQj7jMKnUKzX9VYtemaxHuvB5Ej021V6o7Xhhyqd/KZa
	tos/AdIW/bL5wl1deCiex3vYt44P5xOyvlp/Tj2m28l1N6d0an2vUseAywBANAoF
	sw==
Received: (qmail 222168 invoked from network); 19 May 2026 12:20:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 12:20:10 +0200
X-UD-Smtp-Session: l3s3148p1@Ml4mBilSnt9Uszca
Date: Tue, 19 May 2026 12:20:10 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Akshay Gupta <Akshay.Gupta@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>, Kees Cook <kees@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of
 i2c_device_data
Message-ID: <agw5WgpA0ul3jith@shikoro>
References: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
 <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>
 <agwvkt_iWF9UUR-t@monoceros>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AMjDdzBG2cBZzHid"
Content-Disposition: inline
In-Reply-To: <agwvkt_iWF9UUR-t@monoceros>


--AMjDdzBG2cBZzHid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I missed Bart's original mail, yet...

> > >  drivers/misc/eeprom/at24.c             |  62 +++++++-------
> >=20
> > This drivers lives under drivers/misc/ but I maintain it separately
> > and send PRs to Wolfram so they go through the i2c tree (historical
> > reasons really and maybe we should move it under drivers/nvmem/?).

Good idea!

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Happy hacking,

   Wolfram


--AMjDdzBG2cBZzHid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMOVYACgkQFA3kzBSg
KbZqjxAAqgvBmY/u/CikpFcUz2lfKOC/2SlV6zFf95onxyw+vTWXPKCqyM19bj7B
wktwtqJ2srnmzH1rqCGQIdca4IzwyLb4czkTSnSz8dEY9aZVyBiWJdFv13TujD+y
EzdgdMipQ18DqpPH/hI1KsEAT3KRPt/PihoMtA3oGRnpaOZu04y727pr4qNzreS5
F7jc9cELwySNhn1HEVeukvvGS9YZ9mKhr1EsHtLFsTGhHX74//iMB2thIzLOxCnJ
zIqyiToBvBsUxxPCom3VHSmk/fYUBn5j0AO86b08DCrAQ+evgrEWAKWAB0bYNkyx
F6j1xz4ijDK8vRREFBjL5iHNlptg9QRKoON+aCpHWLeIkniWOjiQiKig/2TNuT1G
Ym9VtYKqxYD9QgvYZjQgkhcz/Ga+8zxYGwzi6AKLwHdFzxJT6JT74YlXe1RyxI0j
lIybjnr2U7VEBy1AvWY3MN5huWCZ5J7qu2iP+PN+xUWlhgUwMbDdfnQmWewSuK2l
RYcsPvK7L7sztPpyUUcBARG0Fjh+irpYZwYpXV4mixsIWU1tHTg0QlVdKuxjBsbH
PmFG+3e9aePS9LDaDruRRJ4/z/l1s+rtoVj3inQCbSiFS/gVNB7MfSyGEczak3m5
CSMwX5CNhAl2PQ4KPlgw3rcMQVFX0z4peL50q0tDlE4qn6l+n6U=
=8cFu
-----END PGP SIGNATURE-----

--AMjDdzBG2cBZzHid--
