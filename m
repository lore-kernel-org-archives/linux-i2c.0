Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED03C2768
	for <linux-i2c@vger.kernel.org>; Thu,  4 Jun 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566950; cv=none; b=J9F7nSqSwkAkyNEXcObB/sa9JL4TddnfLcAApOfcECGEzcqbhoJIz26aVTCRM7Unil0sYnH9ggFPjHcFi1vpgKu/w0GSOcsznMnpLXjzsE5bseH1kGMuBdinLgnOGy8Z8mtT+KwZd1vR586Nx1Gdheb2CktFJXCRaG5x52Ctglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566950; c=relaxed/simple;
	bh=hcFNgobXbpPv+6Msy/Zq/evK5wzZInp0ODMdH6Cjgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuXNKmGoQ/fKcXgNcwQOsTnnhy7+An+fbuRa+IIvaHvcdFu6Xh8R2GGRaHEpR0f82f+iNfUkBWPybGUH00gYU7btn8igB/op2azepGNjYwqsEOp5S3oY0IMXUOLbVQmaKSpMnhKRFU5qtXlNEVfiwwzyqkKyljMoQThNDF+Isjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jfb5xnRp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jfb5xnRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=hcFN
	gobXbpPv+6Msy/Zq/evK5wzZInp0ODMdH6Cjgr0=; b=jfb5xnRp8ZRE2SeTlIeS
	Ifou+aiIq3AzHhnrbSFqbJRBnYejSviu/Gpn0QO9uQAXJ+6y3niOynaCPUp1/mv+
	v6rWKfTqRqFYuMDCnYXWZbAiX0UkFwlyZSGYb6JZGTvFySCLHiN+vF+cG0SzVwUO
	mKepQbCeXMAuCdw1hPJfLckkzhtHBMTO4uUE9YHvwENGXYun6DjO1WERzQ2//pji
	iZ5FgD3xWo+B79FvoNOATWpn4ixzO69p5JOZbh0xPHiOP98yAsuXnqiyQp7WIdKh
	mbsl3Vys7Cp1/uvhrziXMRZ38fXeHmk9LGJqmn+GFSOmQS7jyXT3+8TeqQ4frjRR
	uQ==
Received: (qmail 3592027 invoked from network); 4 Jun 2026 11:55:44 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2026 11:55:44 +0200
X-UD-Smtp-Session: l3s3148p1@roU4jGpTRoYujnsi
Date: Thu, 4 Jun 2026 11:55:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] i2c: core: clean up adapter registration error
 label
Message-ID: <aiFLoJ1IUwrZTnth@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-11-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H5guffAm0rElp9pa"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-11-johan@kernel.org>


--H5guffAm0rElp9pa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 04:37:15PM +0200, Johan Hovold wrote:
> Clean up the adapter registration error labels by making sure that also
> the last one is named after what it does.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--H5guffAm0rElp9pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmohS6AACgkQFA3kzBSg
KbbvvA/+KNSQ10dtFe+HIC7kBOT92U+KI2SXPDlK7NKv+4tT1AEWX9n4E8io9RnI
6IC9Loglu95mxOtXp3Rz2cSkCoiu5ccdcOmUlPo5cCpmcagmri0yYs012psP9SXz
dmCx+1l6kvwXnMJJ+QRoNNd8PuaKficALO1i/aPPJR2AoG3E49VQAs9b9U+93SPb
hR40VwZU3X7+LvczqIrSV/Lj7o3sIaHwQViDFZelB6e3g6hweFibjebWP/g7+uaJ
Swndrz/oq5TzUzwcFlKbsSR/SfCGK/g1J0JVmqAV/8WCBnoYComa9dMEy+LkUqYt
h56eSmICKOFmz/U0lI1l4RpwFssv0VrPrmATsoCNuVpHa3gslf+P4tTXn99y5YT0
pfd8ZIVp0ASkSvJP3nFIFB8vgE+gAn8CC5IKOi3fCd6QXs/uYH0kfqmbpG0PHIlG
zAm4wokeStYuHjvWc5aAfm2LG9ZSZK7SdpG9PgKGBow83if1iTMhQnFiCXtWbmCX
5Ly9wwncDexCNG2YkCgGXHsKsPNa2SbA8uncz/DjyQoz7d9ORhS1+JOe+GJaLe6R
P4VTXfUJnrTvIPVFnV3hOeeYyOIc70wqcjtMSOLFV+9Pco+wU4K/Uhpvcv6pEX+J
JQrxkACUjfFCARp8usH5n0GGLE5C45hFODE+UE/iEu8Tzu4LPmg=
=WuP/
-----END PGP SIGNATURE-----

--H5guffAm0rElp9pa--
