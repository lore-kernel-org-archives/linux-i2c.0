Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4E362156
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147810; cv=none; b=gOudHBhRDMGus3bYCj8emkwdxaHI79uknZSThKfHqq6jL39SKfTPkqquD9pbVSR1wc91YKJgOWUd4UaoAhVX7e+K3rNkbIU21ehpDnMYMXsYP5xVsuxDnS9cHmKfIwUzqjcIBZ2Gp/pLWZ9C+Ur4xp5zQOcD+5Ld+hjGJKl0oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147810; c=relaxed/simple;
	bh=d/SAu9eeFjJTHVvPtRFAShOn0hrgA+W4jlbm76we9dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpKadW8DpFaHoLCOQNqQkHh22OVHGCFj7CPiEEWuL+s9R0uMmdKz+IQz0UmwuCQw/3MQZ6AwSXlkp4FuOwFSp/lNfxYOzin4MZqLVq7ROAR7yPZ+I0IeNiALWzMS8Osq4Jhy/ZIinxbcTL70MyBJ3oT5lnFoe8zfFSlLNFwWKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=acGYbqyw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="acGYbqyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=IfIx
	pL5Jul1cTgZPJL2qQ4xUgTwI9XsjtS8e70Z9mZs=; b=acGYbqywQYmHt8/tsSnj
	7UHU2PtWBXD3Dr63zfMDnhFWSDV9CKBZHp8ibdUrmer82lWjZQBMBkV1rN2LpalB
	kQmIelt81y9ydoaFm8rL86iAI/SOpnpj1JzqIYH5Jl/xgdm0LxeD2E/J+5pCdheV
	1OnheETvXohJ2bAMhE7OccU62jS/ljPc0LnbREehAjFQ7ye0zcqpo4XtZOwlhMVF
	1W0FsMq1CKnqYkB9Ws6kydaEHfZksxxgkHpF4FEI3LMYr3B0qpkQ8hP/n6azXP3e
	Ajy5jwFveMF3riDWT9uP/Q0sa6FCIw3TbUri/skfm4BaXxu6xqzpIz82VlPhGYPv
	+w==
Received: (qmail 807219 invoked from network); 15 Jul 2026 22:36:45 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jul 2026 22:36:45 +0200
X-UD-Smtp-Session: l3s3148p1@LCUpSKxWPK0ujntW
Date: Wed, 15 Jul 2026 22:36:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andi.shyti@kernel.org, linusw@kernel.org, brgl@kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] i2c: i2c-gpio: Enhance driver for buses with
 shared SCL
Message-ID: <alfvXUq_lNXhKQZk@ninjato>
References: <20260714162915.3018703-1-markus.stockhausen@gmx.de>
 <20260714162915.3018703-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xUYWHdNOCWTi42o1"
Content-Disposition: inline
In-Reply-To: <20260714162915.3018703-3-markus.stockhausen@gmx.de>


--xUYWHdNOCWTi42o1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 06:29:15PM +0200, Markus Stockhausen wrote:
> Some lower end hardware (especially Realtek based switches) are
> designed with multiple I2C buses that share a single clock line.
> E.g. the D-Link DGS-1250-28X realizes 4 I2C SFP busses with 5 GPIOs.
>=20
> Enhance the i2c-gpio driver so it can handle such hardware designs.
>=20
> - Detect shared SCL GPIOs that are used by multiple I2C buses in the
>   devicetree by using a "unique identifier". This is basically the
>   phandle and all additional cells.
>=20
> - The first probing instance allocates and requests the shared SCL
>   GPIO with an associated rt_mutex. Subsequent instances detect the
>   existing entry via the identifier and increment a reference count
>   to reuse the descriptor.
>=20
> - All data transfers are serialized via custom lock_ops that handle
>   both the standard adapter bus lock and the shared SCL mutex. This
>   ensures mutual exclusion across adapters sharing the clock line.
>=20
> - This shared SCL detection works only for dts based systems where
>   the GPIO node has at least one cell (usually the pin). GPIOs in
>   legacy systems without devicetree will be handled individudally
>   as before.
>=20
> This patch was successfully tested on Linksys LGS310C that has two
> SFP slots with two GPIO based I2C buses that share a single SCL.
> Test environment: OpenWrt snapshot ported to kernel 6.19.14
> including CONFIG_GPIO_SHARED=3Dy and CONFIG_GPIO_SHARED_PROXY=3Dy.
>=20
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> Tested-by: Sander Vanheule <sander@svanheule.net>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Cool stuff! It took a bit of handling gory details, but I could not only
check that there are no regression with non-SCL-shared busses. I could
also try two busses with shared SCL and it worked like a charm.
Congrats!

Andi, from my side, you can pick up these two patches. I will put them
also in my 'for-andi' branch to increase their visibility.


--xUYWHdNOCWTi42o1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpX71wACgkQFA3kzBSg
KbZzBQ//ScYdJvdIg65ub4h25ib+LfEuCwpSdHrUwnU9IgJv3PFL76qInl+7x0Si
+3X/HOhRtwkn0mvYAZPCw9WzLavPRMAFfUaz2vh8eh8V3FqLcZC1e3KaHlWrZtBB
JEqA6ap/Mt9XOJeA1OIesDpwd1KEEWUMkYJ4iwUFNutMvnPljoeL5K5QjJb44Hmv
V7mg8AhyURHYCdz0+0CbqyytR/IWkXoIR0NI27VW7oTgh0H7f2ik8OdhdFZl2ZeZ
9XiwMLZXHF2fSifrL3pnBHZw/+ik92eiD8T5cKguyhuQcfsVn7UrWkxSdZ1deR3e
35620OpS1hHpA8dDnyQ+TngdLVG+0mqC67jG78ZHP3Lm5Pti+YdU12nhgUIK63wS
9C2fGtkvwDMbOi4sZhSBpDjbb0rEr71sQp1PBx4srJwp0b3wZ3AtZk+ZBFxaDIvi
tWDIgz5HQpqwUD13r9pxDDoGn8rZUEtaimNapxcDbaDrQy3xe3wXPlt5bmxdMDFI
WqUyJYcCczZRPmkdl/obp22VMhI9osFi3g7EEKYCpilPljlSPmObo6ejWSjj3ZkL
wJc6pErNh+WxKZD1WpFu/gNhnAGSUgYB7UGhFIKUBw1qgw5lLu5i8VZMk1VTnCy0
j6j4fPU/76lLk9RwljAkAnyIQE2TrGQorgZTotbByYu/KlRpQmg=
=2y6S
-----END PGP SIGNATURE-----

--xUYWHdNOCWTi42o1--
