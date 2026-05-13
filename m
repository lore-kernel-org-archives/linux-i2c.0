Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B49298CA3
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658474; cv=none; b=eZKt8Yh7CnkJwRAWXrl1UQuo9iGfH2raERPa8vF5PWZ8tL7DxOEEy/f2hCKo0g0K3SFm+huQ/HP9eBNosXREIcJdNz9DgPmIg011jG87/KRAjJtDnioghOMGlGH6a64KM4kYaRNgQeUIOYeue1IdrgUBIqnMsnRviVZoBJjLzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658474; c=relaxed/simple;
	bh=la07t7G22tUTJn6yhkaAdXSSftEzlXTdmijnmx9bsig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDWTjaUnzYB9+FIYZuTiX724RnRWyyOca3iLTKrJ9aadVNZ7/r/wIQiA8AUQbfNW9uUk1q0w1YhGeLsOQgZSomuSdatUyRxaL9sKgImUsz53MZCik7ud9XJmcNYTlYJ4vJrnkk5SUPgiYXXluK2SWosB2ABgiy7JHubPEsQY070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bvBXyesd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bvBXyesd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=cXna
	x59z4Hqvl7eRjKVhrobircdl42kkDxMES6CStf8=; b=bvBXyesdRyCj8pGuinn0
	Re1KxHFKzOiEgy4qXUSFTq0vjbsiaceuFgMdN0wC6h6MqwKXUByZIQT4L55zw3lb
	NbmCPpseWZfU1wUjOu4NgAQiRUd77ZuFbbx2djLbJHOBkMUKhyqdA3Yot+Nkfl0v
	lr0yUbGKOhJs7ByPHQXDyqMfbbNQ4RbeMBXtO6EBzDPocc0iEpNrmtx/IeltSWrj
	v8wFpiWoWLVfAF9rYDpZvjz3CpcEJ8K5abluduK+70ywyk7pC34c0nB9fws24ET1
	B3MGO1lWAKkD+hdqyGPCNnry7GyzOdp8BnT9ji1n1fktA/u5wea/6UjD/S6OYmhs
	oA==
Received: (qmail 3331290 invoked from network); 13 May 2026 09:47:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 May 2026 09:47:50 +0200
X-UD-Smtp-Session: l3s3148p1@G9dNMq5RZI0ujnsX
Date: Wed, 13 May 2026 09:47:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: markus.stockhausen@gmx.de, andi.shyti@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: AW: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
Message-ID: <agQspjVCkbmVDnt_@shikoro>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
 <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
 <004c01dce29a$0e44e7b0$2aceb710$@gmx.de>
 <agQkbnSHblUNz-IZ@shikoro>
 <CAMRc=MddGonpdukfZ_eHa8C4ysdCTqhYva6yVRue06LVkyubxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RCwWtzau7mu9P3K0"
Content-Disposition: inline
In-Reply-To: <CAMRc=MddGonpdukfZ_eHa8C4ysdCTqhYva6yVRue06LVkyubxg@mail.gmail.com>


--RCwWtzau7mu9P3K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bart,

> Yes, in that case it seems to me it needs a separate virtual device
> driving it. In general, the idea Markus presented is fine but it must
> not be described in DT. Instead, you need to create an auxiliary
> device from subsystem code.

Okay, I get it that it should not be described in DT. DT should only
have standard i2c-gpio busses and the OS needs to figure the details,
right?

I wonder about the subsystem involvement, though. The I2C core doesn't
care about the scl-gpios property (except for GPIO recovery which is
moot with the i2c-gpio driver). So, maybe this should be handled in the
i2c-gpio driver instead?

All the best,

   Wolfram


--RCwWtzau7mu9P3K0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoELKEACgkQFA3kzBSg
Kbbc6xAArLHuJ8wOUWhc4LHdLbBefnKvXGuf/n75CKfctd3pi8lLKovrT4kko1X1
/QGbyuWt0KiEHF6CzJkfQdJXeBOE90C288wDoiBN8vj8ZHpJN++sXK4ZFDZUOLYy
8yr09mjZPbtclsw5YOc0hpv2/fr1zKn15gSltJpsiNjbV0+vE6+qafrzdPFCJH3m
E4Q5sP0JKrFIH6De74Tcm0zKIYdKS3kTBVwnUYOLzM1odCCIUWevw4n8Gk7r0yp9
ONCwPl6sMRA/nBJmojFRnaT8dDqWU3UASM+GXAZIO6d8IZkDmhZDyO4qcuuUTlU5
cMKewq7eW1y90WYhXlofxEpj9Xghm5YlqEw/2SbQRwpS890mmds3WkBwx7M71414
wieM2FTq69l4OFy/WKjRvt0MJ7o4IMJy4K50J++bGST6H/u4DcZn7zwVIyO/3Je7
11kEGyXZ6EHfYQFRmtSQkrBKheENPrqB9SljDIjXP7v5Fo+EYflRHmdOFGpKhc1v
Pt0SNMPTVYriGHOlAxNvhkgnQnX+vsCRPw8pesbHuhACb9L88AujQPyt8uW2+0aW
DBcfgHHLce1SKkThYDKWsuFTfRRmkqjE0FPwg9lZP7t+AfvzxaEplAH/q3ZYB1Eb
RuRywAwgickRMz4jL6tnb0QBjjNSllu5AqROb8Mibiu9R9YGWQA=
=er50
-----END PGP SIGNATURE-----

--RCwWtzau7mu9P3K0--
