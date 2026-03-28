Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0233D4E1
	for <linux-i2c@vger.kernel.org>; Sat, 28 Mar 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774726378; cv=none; b=sl+7sneb+DMcObOwgU/uKFvbFchZefHjqpWfLHXePgp+BoTAS8rlG8OBru57wZY7FqxVqxoP02kp0bYHy7WwgbltXJWDdwhlKfj73URp4KC1wUsKMW1kEloODvExUuxBalAc1X+9w9ddhJIzK6yvhs9+OXJxLpnjoUvO9E588eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774726378; c=relaxed/simple;
	bh=BEXpi2zEa2ZH7O3jPUw07j75z6own5UEeqqciM0HhQU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNUWodbjeygBZtWuyPAjkxlI4Sf5VHDDg3xe7iR4p5KdUKGaP96YizthPyEzBkn8tN2QeSkS+AA2gVqXvtSr+EhacXXO5i7DkvczOB975PmPQLw/aSl5GyhpIgumhhPzt7UJswqq8/X+KmRO0P5ZDdYliOmZExPbvU0rvKrQsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=duqZrH7q; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="duqZrH7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BEXp
	i2zEa2ZH7O3jPUw07j75z6own5UEeqqciM0HhQU=; b=duqZrH7qpNLzOiY/1wKJ
	MvMZwS6C3XwGKkBD3oC+1n4RLe03kd/bDFCYJejQs6/XztKWf4ONoptdTtTX7C84
	mVd90BUWc7WN33t6Ndq1i/dwP8sw4gcteC3dXysaMW2PTYmG4G8DtQAYSpg6G6Q/
	0JOo2Ne1ak9bfnXWzaffLelzyuRNV+dstZBrBfCxIAW4cpqHfy/XatHcP79mfxyd
	wfl11cSzfzyV3DovmrLglom3qczJoTGPOnse/NqXYWnlGixuBXNxc1tfFTXLbTtU
	lWNqc7lAymCFxh22FOQ3MAEF1fFsM2UZM42mNhcpaKgOBKIPF2L/VsMpmBjt8sU9
	2A==
Received: (qmail 655162 invoked from network); 28 Mar 2026 20:32:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Mar 2026 20:32:47 +0100
X-UD-Smtp-Session: l3s3148p1@XxOurhpOlKkujnuA
Date: Sat, 28 Mar 2026 20:32:46 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop outdated I2C website
Message-ID: <acgs3t1tvnj8kYf0@shikoro>
References: <20260327151823.5859-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4swWnV8s4Xj055qd"
Content-Disposition: inline
In-Reply-To: <20260327151823.5859-2-wsa+renesas@sang-engineering.com>


--4swWnV8s4Xj055qd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 04:18:24PM +0100, Wolfram Sang wrote:
> As stated on the website: "This wiki has been archived and the content
> is no longer updated." No need to reference it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--4swWnV8s4Xj055qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnILNsACgkQFA3kzBSg
Kbbmdw/+MR9yHp+1/3+pS/7xr2wZNtj8eoH4EuNqLsWGCOcEc7bglAd7K8oqALGP
W0pFzmyGZVnlA0PbCwsvAS3AbtSgA5TNGos7xc+2sILLq9eOsHHrRDznHlNw+Eoe
7GB0fBCXjFB/H+5VCjYJNl2IkMbR7tGQWR7pN+rHLxHAhXOPiYKQoICUdMwIh2B9
9bym5ZgEF/RBrOPBk0zi72FDfwcWgK9Wq4a9vcMIc8UGMqczA1I0gClI0aYcloRv
UBvmBLjQ/i50bRaeyGxM1la9Hsp3TZzuMxN7Zz5yX9wAMLvpYb0p9y8OI1bYCXs+
JjsVeaeUKb/0KzjioZL2vdv9SYzDYWY+sPVajDIxRTMuUQ0rLOZ31GwJBycuXiMZ
grqy3qQWilTM6vLhB5F6Oo38KyWbphTla7BBgX88GoQnXE0bY72fD3j3BMp/Ud4q
YcZ4Q2tQ2En31hroL8Mo2NrSfnwAfQP7EJ8bAa+J6j2OoUKfPs2USp/H0msvQpUV
Bb4lMYTDqVf8aYKJgpYka+3KdU/Jl9X2tuFavXkQSgBMSAP/RJLFAhe4CKGIosud
GT2ecdhGeU/tdcqMrZaLYfJIZTkiOdyJGVTkJqLWjElmEjePNDbEacLazuWQJz3w
pRv29PeaNL8Q18kfJ1xkZQBzSyfSRKlGIIodYbbemNqk8VagslA=
=EkD1
-----END PGP SIGNATURE-----

--4swWnV8s4Xj055qd--
