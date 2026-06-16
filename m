Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91B35E940
	for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599760; cv=none; b=UEJ6+RIBXL1NtfD+by+xX+1Jf0Y+lliY5JN9T0aoVLV54/rovPbFqsV1jSqdRHJc4T+Ct2tgW9Zf1OpRRMYyOacRLgsj1gSDkyA3yr5qiFLTDltlfZkrhSfOhGgonQz6/+7C1Tbw9T6uhNgzTJwca8HOmKY65QbocFXSAGBPAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599760; c=relaxed/simple;
	bh=5qZeW5YzLFhcgQkjwqN2LfNQ6PaBD2MvWbgc/7xFC5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/ZJLzIaxapJdAZghBnhB/DYeuRlNVKNQc/pHJzxSAQJMoclWZ+cutKA9vnQV3gAeONYCOloE8JFptoMDPNcgyadKdEOIC+4Bjrr/e6PKB5DQTmLrJwTb2Br1pFU+XyDe96nHiYZu8uUhWCMyd2UUExcShIUwBt0bFmCchTuzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Zh6au3Ev; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Zh6au3Ev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5qZe
	W5YzLFhcgQkjwqN2LfNQ6PaBD2MvWbgc/7xFC5o=; b=Zh6au3Evcf1q6/dpIPJT
	2dx4W29iNgvmzHO9v0dAEBllP9VTixhPd3uBQOHpgCKVtu1e0KRVTD4hiybmb8y0
	sCU1PjZvWJbXey7QXWYyzJ54l3isAhwRSfvN1SXQvLusVWHOiA0p6f6a95uYga0D
	0Uh/T467nYXE8TxaDZ6ADUW3kK4FpxADQSSrSG+1tH6i3GokTV/Y1scDMaQAm1lD
	ntXL3E3YZyjIWFl36Yr7yAKWOVBlGaW9iglN597IIIuvIzKQfXnzWCImm0UerFdA
	TPQVTmYZt/pltrZOJ+oSux02Fpw3LWZu4fc26MWn2c3VeQNjxN/nBO5WK6bVMI1Y
	vQ==
Received: (qmail 3876385 invoked from network); 16 Jun 2026 10:49:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jun 2026 10:49:13 +0200
X-UD-Smtp-Session: l3s3148p1@KsdtBFtUCTFUszEP
Date: Tue, 16 Jun 2026 10:49:13 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-i2c@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <ajEOCZtuknAlvda6@shikoro>
References: <20260616060910.1480-2-wsa+renesas@sang-engineering.com>
 <c41975e9-e238-441f-a71d-3c7bf3d67e21@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gflUkJnjzO6OqBFk"
Content-Disposition: inline
In-Reply-To: <c41975e9-e238-441f-a71d-3c7bf3d67e21@kernel.org>


--gflUkJnjzO6OqBFk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:41:23AM +0200, Krzysztof Kozlowski wrote:
> On 16/06/2026 08:07, Wolfram Sang wrote:
> > The YAML conversion added me as maintainer but I can't recall being
> > asked nor do I want to maintain it. Thierry has created the YAML file
> > and works for the company which contributed the driver.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Thierry Reding <thierry.reding@kernel.org>
> > ---
>=20
>=20
> I think Conor also acked it already.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Yes, my fault. Sorry!


--gflUkJnjzO6OqBFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoxDgkACgkQFA3kzBSg
KbYwqxAAiXkpJYibOhU5A7FjTTAppsFkFup9MbOwG/xyLhojjFUTs857fXYiTFlH
qPGmDOIiBMRsG/3WKzmqWPyZs+TiIdQIjv9lcJqFUDbPSM6Gpra9iILMLlIQTWJY
tw25i4tuDjpv17H/stQz2BbyXHRN9EC2N3UzxAeZYS6Q6+Zy0RcuxZo10qZfw5FU
lw4LTN77EQ+vWcEU2NLH455vXAroQQO36wbGvNntHPp+z2yHtZU7umS8zKIrOU59
0b0VN4/cpeS8arON/4ampCTGpZTWxsCSYTg+YzBuDFECDBaYtxfcxMra7GF/YZk+
bj+tZHZBXToVX1QFOk/SQ2znJJhyWzB4X05ofHxRGWxcxeNfFNfAhtMbf1wbK9Jy
vMQV3YFLXM86Ij84ckp9w2JBsdxbZ6v/JUz+q/hX6Hmct35CD6s4ADblyZM2cBD9
d6GFD7COtgnYRKsTt8FZnglsPEJq1vf3JeL0CX61yhnnQJ5Uv3qK4sa8UMOF+9LI
5ihkKojlPgHJEx3RWzTLBNUf5OQl+YSXt81xrFeRRY4lzna+h+XULBEgcVS8wgBV
9OWyzn5nbnB6UEf+xwWorIOyYDTu3UDM/aNw3m0USgewOHVQg0ghMPpT8aU9QrGJ
SZE5MEdePHj85L+eFXH/kOzI+8iZBIKXvQnyCMsjakWAjqZvO+U=
=iNmr
-----END PGP SIGNATURE-----

--gflUkJnjzO6OqBFk--
