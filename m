Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E13F074A
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995617; cv=none; b=Cx2LYcZHw26sE5/ES2rR8Wx8CfxfI4nMLUQoZXxe+EajBcVYJ3dD+QrPeFXLanjhP1sDwUn3a3h+828hGt9yZva3lsTHw54iTmh2k35v3I1cI9GXdef9dH0SJmAwhn8eebgY9kZ/5Qb7RwxKOMaSnmzJV8dh+P4zDciAQYbZGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995617; c=relaxed/simple;
	bh=oOzhgcc4r4A2xebyb2DzdG/R3/5wptfDdfPcoEOxOeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNBENls6i/UlD/w4vTFEJPbsuYUnovYM9ZUHiyzzLRes+8/Ll5Oqt0Tos+PDHZP5BDHbrwLm+DtYLkpUCGCu61CJD4pLE8zlvIFq/1C1Bj7qbFNGwm8R8LoOeO2t5JjKwuxvNDNh4h5JiZNGvbInWq/l2tOoRkiNtSaW39r3PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J3sUYJ5t; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J3sUYJ5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=pXcZ
	wzHMs1E3I7nlmiO9NxguoWa31AWead2fp8pYy5o=; b=J3sUYJ5t5mmtIIoBIlH3
	REse46xSWq2G8/M/vmT7LE4cdW3OvHXe090V7R2rjvoDvN8kBfbjoi19Ww/KxY9F
	YGQnFnqgEKNCcc9Ju2EAu8aaHqcz46P/tRK32LheybMYneZ41cA6ivTnBzPyRB9B
	iFfwVVJ3pUm//8M3xaEXgo6NP8OgzC5H/MZYoXoeJ86irpbbF3qJyCBQmo+MJvPa
	QLBkfLYrNv/W4z37eR1BkpORe4pR5I0WKNt1r8lOk0pLcocn3FrTl59/Yd9ZxMPT
	AV9Dm4nQxnGVO3rFMP2xXUUIEZQZGzs/x4UE6go0EzGa5L/xtn8fKPRVL31eIrvo
	MQ==
Received: (qmail 1199053 invoked from network); 9 Jun 2026 11:00:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 11:00:09 +0200
X-UD-Smtp-Session: l3s3148p1@4kSkWs5TcLkujnvA
Date: Tue, 9 Jun 2026 11:00:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org
Subject: Re: [GIT PULL] at24 updates for v7.2-rc1
Message-ID: <aifWGc0GuNjlTzWe@shikoro>
References: <20260601122923.3714-1-bartosz.golaszewski@oss.qualcomm.com>
 <aib6P9jvkFhmd-LI@zenone.zhora.eu>
 <CAMRc=MdVvUDa5THVNRr-O5PzEKdCDf7wW+t7N+FBoQJGOLqXkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ExbMzQbKdJsRH0BA"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdVvUDa5THVNRr-O5PzEKdCDf7wW+t7N+FBoQJGOLqXkQ@mail.gmail.com>


--ExbMzQbKdJsRH0BA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bart, Andi, all,

> Ah, did you take over from Wolfram yet? I'll make sure to Cc you from now on.

I wrote it somewhere, I'll do 7.1, Andi already does 7.2. You can drop
me from CC already.

> Or maybe we should just move this driver to drivers/nvmem/? Srini,
> what do you think?

I think this makes a lot of sense. The only reason at24 is in misc and
was handled via I2C is that nvmem did not exist back in the days. Which
is probably true for most if not all of drivers/misc/eeprom.

Thanks and happy hacking,

   Wolfram


--ExbMzQbKdJsRH0BA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmon1hUACgkQFA3kzBSg
KbY3XQ//ZuzCoKtw0KvZ2BbHKmiJDVouteUVJck4tJiHB2vPw8VST4yRl34UCSu+
byh4jivw7JIM7R44Dtq90DR3622RpYHn8uiSCct+tDI/za8u+FHy+5zblKQ7iEZ+
AodqTYe2z+DM2dA+ZaiWdzwhNluqW/+MrIoYYICXQmRdtUGEHMzweZsW5zNmRgtd
9ohg7zfVq8Ae7YfjHC1pOCP4OYBsir3mowyWwqwJgRATDkI9VfZdLjn/Dcj/NeW1
AESTFP5XXuOVxTuJwU0LWYbhFb66qPzKXetZrV5F7Dl90NCQDgCc/DSP4EOUXCv1
L2zAuC7E9Uh8UbTgE959iUO7O5BjyJkVSbz4u6C51qhKjuXKnk92/l3KSm/G4aae
RDIa7yCpEMmNicFHEE5r2aOF4OaVvGlcBCOKSdwAJbCKorsRm36lMWX+EuBVHAEz
ybGGR0DqLRF3LBXvaW2tb73xS68pRUj+cvYIS6qUfkuV+rKRiECUYy/Nf6XSaOZU
dgMHzq0MPeY4V3WdlrUPsA8eTgVg6ZSsjMa0f2utoAwiCXatGkoe7FB8RZiudvyE
lIRxTzPSk9K7QI6W6iCLFKFNEiVGLGQiwxWQ+UHD9tYkwQuZyhY4jZguVEQBZ7jp
MzieEoosgr499jysUe0IKlJFMVe1N/CT41EB97hQvC8yIFJiYIY=
=BNjb
-----END PGP SIGNATURE-----

--ExbMzQbKdJsRH0BA--
