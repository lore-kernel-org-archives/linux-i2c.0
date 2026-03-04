Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD5371D0E
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643656; cv=none; b=OevjZlAm8K2hA1mP+AQE0hCgmxNny4CXnIc5m44GiiYI55aKuVhb7W4CI9HAO6zHRAh5xCuovonkg+C15GuSiQpDRVyzOobQMPi5aTiAIjHFWP+klX6FFOgexXyC/KJjwENvtOkUIG3ElinTXw16NGqXlfCJcXt/o+8HnGyg2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643656; c=relaxed/simple;
	bh=6npAOUschZg/e74DXs0mzrB2RPwbvGgy6i5f9d1i0Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOz0KwSvDvddNP0AXM1dSq9vNnQDdRdxu27O5e0/F5ym3mPNW2PvKi9fGXy4BtBxsmWPA62jXgTQivs3glO/9gUhShivcGiIN+bIt0hyH4VdxnvmZQdqwJh5Ehmg0pCzL9V2B7hsDTdBexHZzJO8VX/ahw3OsANeEhS2lCjWUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XHjM21av; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XHjM21av"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6npA
	OUschZg/e74DXs0mzrB2RPwbvGgy6i5f9d1i0Iw=; b=XHjM21avabVS9vy2Siyh
	/e3MAPkTFNCyiRmq19paWfIbclNhRzfSvhjIVLfLLFrwjcGz9acpH677vKNj+OLI
	b7eJ7UiL/w9zHuflsXOHX+cI2LGUVWbffhGo8CYdh8vApedj6ksUlN3JPrL4hcAL
	n27tQy4WYksfR34eJpEbHfwLx4H29clukNy5G4js+NWNTw1vH/yYWCfA5RiEYqDe
	87THbTBRr/+hNjfuUKh/4doQscP6OAYFt5Zl2xmIDw2ZIfbs5PrPab3mWVQlyKnT
	aWXubSC1z9m27cPgS4wu2JL9TuVCrPu3M1mXqgpVEooCVyXf0eEHzkSe8/aSKwWw
	tQ==
Received: (qmail 827994 invoked from network); 4 Mar 2026 18:00:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Mar 2026 18:00:51 +0100
X-UD-Smtp-Session: l3s3148p1@5icgwzVMtSZtKXFP
Date: Wed, 4 Mar 2026 18:00:50 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, Frank Li <Frank.Li@nxp.com>,
	Linus Walleij <linusw@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kalle Niemi <kaleposti@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core-base: fix devicetree alias handling
Message-ID: <aahlQvkhtHOJkDSd@shikoro>
References: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info>
 <aagNrTJYj-MdeBRO@shikoro>
 <CAMRc=McAvQTc=yZngaHh54B-ZLAfLf_ssFQc-_EUh4zjnuOR5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+rdxzzJGyO2rwrON"
Content-Disposition: inline
In-Reply-To: <CAMRc=McAvQTc=yZngaHh54B-ZLAfLf_ssFQc-_EUh4zjnuOR5A@mail.gmail.com>


--+rdxzzJGyO2rwrON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think there's been a misunderstanding. I've never suggested this
> should go into v7.0.

Even better then!


--+rdxzzJGyO2rwrON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmoZUIACgkQFA3kzBSg
KbY0zBAAimysX94JnPFfF862omU/Z0U/ZmIhRRPnUmgiLZgby3+yB9yemLsrOp1A
YrIYO77haPOd6UmYFC/BvmTwxa2Qe31YBzi3lYzp2G7/un6f4iilhtS09IIOoy+S
FdhIeZd2sjbEnoDwVG8hprNWqQKRtdCNBHzIe6RJRfQn9COcuoe0+/ataFvR0wca
mywkerDsLPq4bVcoWuXySkbIoZTvq5VN0/rUCXvhQ6jH1t9fPU7TWJzGJJWl/8UI
I8X6jnN4IzzCne6pXCynGQEC+aKrWY7P/f1uFMGYOWLR24tnXYiXPCgI0OZYii/5
cIKRROwPs74pcsJrn6Z+mb0EnSI96MF5XPpv6I6M3hzI7u7O5FqfMUSkpxG0x4tY
ewhY/LG6QeSGndr+HPg/dzNX7Y8xX0RjdwFryWJ09eTPk2HXJ+y1YATO/hF3zj4/
0m4b+bStoQGT935I0UUdzmrXm2ODyB8AsjOpoLMv6jz6jnkRh4DO0R50aPO3Ci1B
mr6liNJSqy2ZcG+nGWrLjRm9cSyuD7uUPJ4gQTI+yNKNxD838zMl+hH9QTO64zcJ
1uqojes3RVuSA4j6fp/wJYYXQtSYmTTsHo56SV9usS6fSnL33kM0ckcQYCMtUjp0
SdzynRhrAzMv5dztTL1yyxYXOapNrUyDfupkTjhW4HqcXNacEl8=
=3Wzu
-----END PGP SIGNATURE-----

--+rdxzzJGyO2rwrON--
