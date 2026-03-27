Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667B2DC764
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624932; cv=none; b=E1O9eaIaNrdI0716r9heTLZcAwh8NPTUCffyCZvYHMyew1ibFTNVUYcx9eq2Ms/6qdIoS5suz+XPnFizcwK7aCtohxtTN1SJKqUXjhR9WEijbMjjfxcQq9jMCXaf47vuodI3qRZ5vaJbKqQIGQPpluhHJkvOKur3EUmqfXJUEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624932; c=relaxed/simple;
	bh=sgDTTNVfXPaE6wXVS4hfIOXDKzsQser2IBdIDO06IKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS+0rV/IzZ4EY5vFkchxRB4bshaKICfB0rmhierW0duDVzZwUgeCoQsWiNNS+CLHVUWjyWpzmfVEFmIUpPnz5FCLoh13gNHwg6D5qGG8JFFy9G8kDpeA2GHZT7BS6ubVaOA8ctMiCu8lss2N4Wqgr4iekrvzNmVNhACfHsllkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TOL7GGkw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TOL7GGkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=sgDT
	TNVfXPaE6wXVS4hfIOXDKzsQser2IBdIDO06IKE=; b=TOL7GGkw+7BTqjRzsYEW
	ZYADkq61DVBUcJrhvDMcShlp1Jv5gygsNUdL9lYNyUj2nNYvBO3RxhTM5W66w1Xy
	0eJXC6XBRFwytxTJQlHVT/O1OGLWOfbuoZ/4jUR3X8zzOumS1aC9DQFR7RoNwgjG
	jEMWbgGvVgb/Txq+XeyIXNcGkxFO9ike02/vSEkIf9GtW3ws6ky/fY/PIn4Ov5F9
	uApU3Vlcq4PgMFdxPWRZVbJ8Nyrf1CvVy49d87VbcduLuWuPOyxT52Oq3qFBniS4
	LkBfxlxabNXBqElOSPkAqGPPEDDLqSkLwVKh3slWR5+kw7k98UxTw0H8r2ENbYCA
	Uw==
Received: (qmail 237797 invoked from network); 27 Mar 2026 16:22:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Mar 2026 16:22:09 +0100
X-UD-Smtp-Session: l3s3148p1@+9iAEANO5tBUhsJN
Date: Fri, 27 Mar 2026 16:22:08 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v7.0-rc6
Message-ID: <acagoI0hO1WcVsnY@shikoro>
References: <acZnOtLJANk9wbZR@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncePxCKOeB6VtryE"
Content-Disposition: inline
In-Reply-To: <acZnOtLJANk9wbZR@zenone.zhora.eu>


--ncePxCKOeB6VtryE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 01:57:56PM +0100, Andi Shyti wrote:
> Hi Wolfram,
>=20
> here is the fixes pull request for v7.0-rc6. It contains three
> fixes in designware and imx.
>=20
> Thanks, and I wish you a great weekend,
> Andi

Thanks, same to you! Pulled.


--ncePxCKOeB6VtryE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnGoJwACgkQFA3kzBSg
KbYjYw/6ArGSPdmrZHgr5i5JJve+8nYQler+PFhVeh0H6OHD4/uw5iNbEdWSicaI
018sKCbpcuePMV4h72EOVpLR98JGJsUIR7msuICVl5fUWxTpfMwHvw2168Y0xkPc
HEX7K4cJVjUJR25xSawyhR3FsmRs2DOLJyuBDMYRrPx6UG22MsrbsGWCvHuJYra7
teBW+yLaqd9/4n0eGPkX6jl9qKYvWJwjntH+jXZOtBOx0/KAqcLHFdyp3XhdyFNe
8deJsH8I6ED0lNaqsAOjS7qgJNkkVOQO+/UpKoWqHHAPHbp39W3F2C52xDOHn/qH
H3UWq+0mAGoDj+QgIiimScCeJY/AKs7rNMyGjvmKc31ykznGlf1Luu9/t+inmy+w
EN0YzCNSpYL/bmGZVw65XVM2oD0a1sxYVpuB684H131z/gCBo1kuaQHbctDcNeAE
C42fbIMx+qr1eK9gHfrurgn3l/MvJajmBt/GgDpIwWl8NDhitYnEEKoPvK/nzZ1f
xohYDpuyKKGJ0CeeazLDTtBNtBDALjeadFY0hXFjQWUr38NQ8t2eEIH73Ojy3sfP
hjfqa3NjPepKQiGURfNhZ4WHt71sJji0ndnoK8WHprfDvOtWLnZ4o98soMoJAnUv
7w/6skht5ndmoJYdvdkS8jQE8Yv5tE7zfTNEyfBxqU3f5eomGJg=
=3EzF
-----END PGP SIGNATURE-----

--ncePxCKOeB6VtryE--
