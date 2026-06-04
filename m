Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8F3EA66
	for <linux-i2c@vger.kernel.org>; Thu,  4 Jun 2026 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555102; cv=none; b=pow8PPmaMO/kpBjjg61GQYJn4tlifaiJXzQVxV0GulxMrywzRL8ldCtOVyabMClyIXZPdZcoAl8GhqSLSS3CxS6sBgsfUyHpazjPCl6MaCyegBU9TiOLPBxtuqvx9sJKKaWmOmTXmJ9tOdzcJwjHCTYoY7ZcaCMFZOqYCdfxPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555102; c=relaxed/simple;
	bh=NSlJPFa6hcVHH086xd2b3a7mCyhwrOar/MuZ7rToxkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOzDpu4Zdvp/mn2ghP5hYrMGYarRRIl5H4DqTwQuZ9ypVt/3hzFeMT76H5J8RNuFOh4NSpRnQifbgP4hIF5FMWZioowfB/7mpXPppuwN1w/2OrgG7iay8novvJUhB/ZhYKe372RTAVsEskOsLNBVf7IdOP11t6b3i6HP+0Xy/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BLJUjk+R; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BLJUjk+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ntyB
	sLXVQlzwx1a8FDr6+Yg7CnWYY4OwzT9n70Qafxo=; b=BLJUjk+RJXLBidNHAKqA
	vzcYKLnYzL0mGUeTi9BtIU73seEZ1KgQexI475SEfjlYuzd4KCjujTPop0eZE+Qp
	GY0/CnKAsgNSURFqHafoFGqyrh2WxIPXebKKIuwmHXeTDkkPa2YM3p6X4TeCw4ov
	jxQmzUv/Whk5DeqcziMNHAHIJGjKCgpIcgLlY0dP1D3hemQ/OBBj0ge6SU2g0XTx
	dI6N0b5QG2ZZfMu4OCg1ohLmmnc4MWvwd0WzyjE82zSEcUnW1qBO96NHXRvFgyOZ
	PhePwRowgks+7K12j0mwXahBVmIJXjmGFlJTjrqNtJaN/7KkO25tnNErSlSk6qv5
	Rg==
Received: (qmail 3539546 invoked from network); 4 Jun 2026 08:38:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2026 08:38:09 +0200
X-UD-Smtp-Session: l3s3148p1@KNObyWdTutkujnsi
Date: Thu, 4 Jun 2026 08:38:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: SP_ISW1_AT@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ben_huang@novatek.com.tw, toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH 3/3] i2c: Add i2c-nt726xx.c i2c driver for Novatek
 NT726xx SoCs.
Message-ID: <aiEdUbGIcmAdzac6@shikoro>
References: <20260604060430.355733-1-SP_ISW1_AT@novatek.com.tw>
 <20260604060446.355787-1-SP_ISW1_AT@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x/mSmfqbch/sghnB"
Content-Disposition: inline
In-Reply-To: <20260604060446.355787-1-SP_ISW1_AT@novatek.com.tw>


--x/mSmfqbch/sghnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thank you for your contribution! Sadly, I have to mention a few formal
issues first.

>  NOTICE: This message, including attachments, contains information which may
>  be confidential and privileged, and is intended only for use by the
>  addressees designated above. Unless you are the intended recipient, any
>  use, copying, disclosure, or distribution is prohibited. If you have
>  received the message in error, please immediately delete the message and
>  destroy all copies thereof and notify the sender by reply
>  email.</span><span

a) Please, no HTML messages.
b) we can't apply patches with a header like this because we distribute
the code to the whole world.
c) the sender e-mail address doesn't match the author or signed-off
e-mail address. Who is the sender?

All the best,

   Wolfram


--x/mSmfqbch/sghnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmohHU0ACgkQFA3kzBSg
KbaUeg/+MQbB9TCMfDpenHgSKhKwQdxRZYqw908LdoWm4xFlfNOgxszimmvbPVKl
QiN5rXUdQJqoTaOmEjxg7qCGaT1Jf0y9UV0VNu0c4fbJJJBLCMD24XicHF6vd+hJ
KTkYw16FGySgfT/V3J0KjXLADK/HjU+Ao+FG2HrYXWF1ivFgfpSeg7X6v5DXS6md
uipl2xWnvgaftq/jpTlEIP5rMzFYtIsEhQ5HV19RISJ1AElnkL8cAMf2wbg1QrwX
xtA2MZHpTYI9brwm7MFtXui5TVYMmRlzF2y2PQPHm7bpKfyTGWVeVr4IhnZIJgAp
w2wDZncIkP9ASMJ/uCjR7RAtrNTuJCi70c+gOIDZFPwDnUCOPiGrLjUj9ZrKovsY
N4JXYVQy5WnRIbKIiZ43QvVa3drFDyz4kgfdeZimqKrx6OCG15bKLoXssJe3o7gB
skYB2W1sMDuSNcbfuxYp8upwdmJG0hpQeLdM0+FU9YsaGxHcrJy1Bi/2mNM7jNh0
PqLi9brEouctN4QawU+Uafdtf9Iw9P4SLmeaJjudYtEN0NPe233oKcwOvxFexYpX
6n0ccopj5zzgQqkv+lk/2KyvpWxX540e+/MOGTSCacUoF7M4ZdGJ4lyNYcHUz+Pw
PzYwTpcasmXlVr2w0aX810X3a7bEz0/ApqXtn69cVNCp98DAi/M=
=W2KA
-----END PGP SIGNATURE-----

--x/mSmfqbch/sghnB--
