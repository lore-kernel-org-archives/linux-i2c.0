Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660C1C8604
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124971; cv=none; b=UzMo0hmjIK86HJ76bRak8O87JbivKnDZiGdQXoWV329qjRAdKnft/la36kEYHlMV15kcuNZWoLa/w8X+FzunXqc3t2VQxbxCI1QmUdfjj/+RmCaKCVrmut4J01sdCSxQI5T0NRC1MxNjun2TmVJXuiyr1Ityj0nR88/WSkEAOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124971; c=relaxed/simple;
	bh=n1+GZim2SQFU5c5+F+EwldHuUUydvnRevxKkCv/ivto=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO00wcaqIERvglVR9+DElK9rV+cs6h9ubXO4zgwIPbUPEBIfAHcOIbemLC8F0LvldGSmcNAhiAkQFpjY7F0UHL4CMy37NxzR/y/niFWRH1CAiJJK5jVzXhnKy8DUvIkzK5Kp1ksF94vQ5DuqnS4xtuAN43OU6xUswoJtABcuLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Jqr7xp4P; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Jqr7xp4P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n1+G
	Zim2SQFU5c5+F+EwldHuUUydvnRevxKkCv/ivto=; b=Jqr7xp4PmM4QSUAYCHAG
	Ieip2sFpgpOhoOXfo4Dz2Fghuc+2MbMS8311mDwSnhuJOtcM4Dpmxsj4biMuWzpS
	eAVNGRyPEBz3GtcLqeUfCFgrMgZ3jbiXapFuuz3JyM1V10adi3+/BChi/aGYyIre
	eXxdYiwp9t/+u4Ax64vGZsANcBOr+Ou31eTjZRx0i0fRfMCxu55IsN5bV2Lc7KUA
	aNLDNLIV0yYhAFE7UVvbsWu+95IO0WUDEUUu0u3AMIFd8Gz6tIulNxe7c+jqCG/S
	1BpuxAgmaHBLguafzliUpRsSohfIB8lFkrzkk7ywSuRjko0z8D/ocyWM9Udu7vvE
	ZA==
Received: (qmail 1839046 invoked from network); 10 Jun 2026 22:56:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2026 22:56:08 +0200
X-UD-Smtp-Session: l3s3148p1@jOUAeexTTI0ujntj
Date: Wed, 10 Jun 2026 22:56:07 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: Re: [PATCH i2c-tools] i2ctransfer: man: make data block suffixes bold
Message-ID: <ainPZ0k9tAFw7dLl@shikoro>
References: <20260609191823.1772-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xe5GUXWK9tqJ4KZb"
Content-Disposition: inline
In-Reply-To: <20260609191823.1772-1-wsa+renesas@sang-engineering.com>


--xe5GUXWK9tqJ4KZb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 09:18:23PM +0200, Wolfram Sang wrote:
> Highlight the suffixes for better readability. Inspired by an upcoming
> documentation update from Beno=C3=AEt Monin.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied!


--xe5GUXWK9tqJ4KZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmopz2cACgkQFA3kzBSg
KbZ08A/9Ek+m729RmjwgtfyCCwwNNnKaW/czNwTefXDJfr7Zhc+eAC1K6eSY4t2S
QBjnudioBYp4FEsYCO0s2M7AQ8Z54P2K/9QjGCBO0imrOEaNpRCJaNNltdgbRzyF
O6ESfvRMXSVVvtysvAqKTvUxvVj7YG69FEtQrUJnV+xd4t9QxF9/6sYubsQp3QLr
t1DnDg7qiW4dweuZjFDWCv0jqCPwEIdXA9TdQ734dGNUMCd4jK8WnkxYaxkrREra
xgWg9x3iFAB2jwN1RenLfbq2014xNSLlZRTPrxpROuDp1JlsYq7+oZgEwPzSmxxu
IGSkaKNYbceafdSh0ItLWq3Gq+Q/60TFX9ScooI/TUpa7ChHYywjzqXKH4K7oJcC
qJJXPgr2Ctx48k+GWdCgnozPmDRe+r2Leql5cUVGkOfc3rg3N/yyarq47OFabmCg
ztzgcLdLKfv4+e/R+2xa2Y8XdYZerWlGM0LcBavHxFcfRjio0LRn2WWikh6oW3OO
wCVFCcAuL0jELiBQu3XSB5u0IVt5Bh2kGxBjIyJpFcytWer254tzewcORb2WBEF7
lQY1qQh4GB7fuxq3lSoYcg2HLnBXJzdh7rQGEGr/eXBVT2X3hC+9O1xuepmYUi+W
WH7yVg1ukbHdqPwa8BGnAxGAEp87eF4uu4csw6cQgeCmvp+1E5A=
=RzKL
-----END PGP SIGNATURE-----

--xe5GUXWK9tqJ4KZb--
