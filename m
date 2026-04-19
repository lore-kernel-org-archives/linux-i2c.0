Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF414BF97
	for <linux-i2c@vger.kernel.org>; Sun, 19 Apr 2026 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776636526; cv=none; b=JvYgXXj+cITO72uTHptW1io27IXlELdsaTTnjY6JKDJekD5YTPhH9gfESE82VL0Aezrr/oTxHHi6zoWyx2OjTdjGVVXKWKl/iEjNBU75Xw5NU7tiqOfFF2ZgnhzdO0TkCO3Wos+VXRDNVy9Sa4Zy9h0PxZVqjmxaVapL3bLQwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776636526; c=relaxed/simple;
	bh=CfnXeAur8UFoWLV/slJkAgsQC1RemDf3iwNDxNAfgH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FscGknrCusRDMff8AmQKaYvZrA2yN89cF9acx1kEcgParJ9LbSf61GraemodSRUpPJWpwZygVQM1t40MjXsHwABFM1Fog/ZcakFCHIe8CCqV87i5PERcc/SXWB4iCtjqSoSakb5Cx9Ot3CCKKusu8gJzGtnKRyTSGMQw0KVgKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hCsTIwuU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hCsTIwuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5KE9
	nOCVgV2c9YXWFw2kRICLjUHBaRK59fooZN/Buvc=; b=hCsTIwuUbabfw6WKA2Ne
	elruENmXGYOCMt00wHEY0uz6sDNM8bqZVogueBWj4HdmGyWIZOkcijG61BUKwMlZ
	EeyF6JF9aV6m0LBNrWCwzmlTWhgSJdJfywXledFvlRE6utAW0VcFUPt8aJrYwhZG
	Koy6pXAWMRbFz0WPOa6BHeRPa2gViZHwM0H136LqzVyzgqcHBhzkIs00bb6MT76T
	jGs9rAey+miRvHot6DKU+U+XxsDB4VUUtUVYw9+FOMXPf2qq8MnupmbwAVrk/AIZ
	Xozjb76I7NFRy8QDxQdYn++XmeWY7XSTc1ezdClCMjVoZicoMzqA3LZm+5BN+uTx
	hQ==
Received: (qmail 597842 invoked from network); 20 Apr 2026 00:08:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Apr 2026 00:08:43 +0200
X-UD-Smtp-Session: l3s3148p1@YT7ZbNdPJsoujnsM
Date: Mon, 20 Apr 2026 00:08:42 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [GIT PULL] rust-i2c-next for v8.0
Message-ID: <aeVSas5zBfbAF64r@shikoro>
References: <3f459ba1-3d03-4c44-a8f1-5ec939f9c0e5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tikwlA2NsrvRpmfp"
Content-Disposition: inline
In-Reply-To: <3f459ba1-3d03-4c44-a8f1-5ec939f9c0e5@linux.dev>


--tikwlA2NsrvRpmfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The following changes since commit 8fc326e15895c9f0403e6243dd4ad468b10aab=
3d:
>=20
>   Merge branch 'i2c/for-current' into i2c/for-next (2026-04-04 12:03:01
> +0200)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/ikrtn/linux.git tags/rust-i2c-for-v8.0
>=20
> for you to fetch changes up to b388d1f9a51d3e1ad48e1d98bfe2ca5d022e0a83:
>=20
>   MAINTAINERS: add Rust I2C tree and update Igor Korotin's email (2026-04=
-09
> 19:41:00 +0100)

Thanks, pulled. (Technically, I cherry-picked it because of the wrong
base on i2c/for-next. But we discussed this already, and all is fine.
Please use some -rcX next time as a base commit)

Happy hacking!


--tikwlA2NsrvRpmfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnlUmoACgkQFA3kzBSg
KbYWbg//SPP9VNltnwzHiyPz5uU2ZeRAaNBg45CEA6Cpi1WBkl3kUEThSEnAs3r4
pZVqNNgFw/Ve2/Y64WpiBjpeXRZSGrycEhICA+ub95ZdXSkdYsm+4dY3A6pzxT5S
hubS0vFHGCo2l0Zi0aHtbLLTDT4uW1roAAMP6HrK19uFO7FiD6UHCvnuJnlwrUDk
1zV+3iHJFdb715PP+RUHsjadqEvzKV0U7PvakOIAcEMWcvkwYFookWLg0FRFfrBJ
xpf06MpUASooi1lxmgZsMkumU3UGad2LWX3BY+NbChBClCUk/FUyAXpXoVGHyexP
oI2OP9mM460VtDoUzrQDZ5JNr0RwoBE7CCNr8Aqmr4cEsF/irAEEelCZOxWjTEi3
YjZIBdkozoYnjr+lFauxcf5zbeliXcKh5CxI5LOjBjkFJmOVDiiJ8VpsCnCuknGU
BeHAwV7KBKgshzJkHnEaStrm60HOM9/KnBsyRcCaSmBP7Ne6biqlUZyGKPxV+CkW
jea/nqsJ8PLK5TsGWNoBYI51FuCMsQFKoWZyIhYBzaGmSSBsnDmrYAzMKx8XXLCW
S2Meg5meEER58x3EFS6TTFpWdWMVlXgwNf5PBPkO9dgKlF3wRBMWJ3IC+du1xl14
kJGMXTnvlw2rWUSd5ul0Kya1u/AealDTz3gxNnOF5ciLEvpc5eU=
=gYyS
-----END PGP SIGNATURE-----

--tikwlA2NsrvRpmfp--
