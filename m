Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBEC3DA5D9
	for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589877; cv=none; b=K048aKuqti1kd9XCju/DT/DQ13TwtriC8+lcvZY6aOv7uwyWqqVI5blFYqj846A99JkC5gtLmGjzjr8PhD873ps6GMPYCkcRXQWio+wE1B/MSokWUQZJtpuH6vE6vU5M7BJ+fdtfp+6FPFplNTN2gxsITjS2TAkB5hGzD+HT8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589877; c=relaxed/simple;
	bh=Zt35hKcQpMBIQMXyuv9utQb7opykqF+8QAv0mxPGhAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNmgdArxQVozH3aIN2Px6m7GfexxbY44h+48cOzUurS/4r5Xv8da8ia+ko6J49kULmYJWoop+9YMdOso//KHUgnz3xVI6qXijfWz3GkKbFEpZbPVM/cuThmoHkCtJehycgFOaaWrXqqcS/m8pXJBwULrLTju4/86H84e8IC7aZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J1qptdT5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J1qptdT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nkBm
	QQ9dqjG18VCLU/qKEfRoNEHraCSMs/J733uvHnw=; b=J1qptdT5Emcah7Ku3DIG
	OMcGp+giZ7CQ6zLZVRBet0ON+Ouwq8zpexUaPzE/cI2PHivMpdpMSunSfAywXQYY
	FlTtfqGx84PytXlTx6QrYF14Pu+PryHUnN1HGiZS28rINtJwS9y4n5aeNcFebpFd
	5vffuOq4V2Zo56AKg8v0akm/lH9jSycbKZ1GufBCJZ6eEMFrPiN9ILpd5cHMW3rd
	cEZ/cGa9bNapUQURTIPT3Gn0h/LKgPhmLQOM02rDdaTNEO6EjAGiA4Xw1C1isP+n
	Vkyl3Ryfi0/EULxtXVdfZ0jJITp2ofTyKSyirwKhDqD3HLMyIDsiDxMIE4ES1MME
	0g==
Received: (qmail 3824001 invoked from network); 16 Jun 2026 08:04:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jun 2026 08:04:30 +0200
X-UD-Smtp-Session: l3s3148p1@33RUt1hUONZUszEP
Date: Tue, 16 Jun 2026 08:04:29 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-i2c@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <ajDnbQJhfeICowkn@shikoro>
References: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>
 <ajBGibftf679T6P4@arch.a226c7d-lcedt>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="olvrVkuLCufgqrzf"
Content-Disposition: inline
In-Reply-To: <ajBGibftf679T6P4@arch.a226c7d-lcedt>


--olvrVkuLCufgqrzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thierry,

> By default I used to list the subsystem maintainer as the bindings
> maintainer if the binding wasn't Tegra-specific, or in this case the
> original author wasn't active anymore.

I understand that. Yet, since I handed I2C over to Andi now, this entry
becomes kind of stale then. I wanted to drop the maintainers:-property
completely to avoid changing all the maintainers entry once a subsystem
gets handed over, but Rob disagreed to that.

> I'm fine being listed as the maintainer for this if you don't want to,
> but I prefer to use the thierry.reding@kernel.org email address for
> communication.

Ok, thank you, will fix.

> With that:
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

I will use your kernel.org address for the ack then as well, I guess.

Happy hacking,

   Wolfram


--olvrVkuLCufgqrzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmow520ACgkQFA3kzBSg
KbalOhAAq5Wo7LCUYVLgQFlj5k/eFBrQU9SS1Qs9t3CVTM/TdRLrBCJrQnxbnh1d
jYMxuVqpWt7YNnkw4/v/aL8LA7f9IZl1391hrI1N5Zuw8eVltb705zHlfK6lVF3y
r333VTTQJZHowAxAKCtmzYG9SgZ8rkU0whazIXBtqlsUsF0tCc0RodOeMU4/tu56
HeCbTSRbQyCF+lhSCSwyyeck8iW6HQVg4NSli/7xtGsZy1JxHKxeSTpHGstf5ZHM
8mKQk+3FMqwC1J3GBASCJDwyewUo/aK7TqOCYAibv1yqXTemYFli5RAr5B0h72kt
dL7sKAv8JDcdDD2zyTwMjizS1zXhG8OcKA26mktQIoBBKw+b0qclN7WqIRjv4nEN
n3L7vjaI80fCeXFDwImsZyigs3BPCDBRxrsla2woLTQVQK89IC/BpnhsEy8dQUpn
J7Zj3XjaB9k3zn2SknQRczFYHmNNcps31ccbtq9wiH15Nl7L4B3UVcg84IWKEwv1
22jk9DjiOVh50PX1QHfAOButrxpCQISP/iuCSdFnUQIHqGb+00FJPBXVXtz5sqyV
nElLGoJPG9U6o3a/sDLPmSMtAS44y9HKvmv2QCYAIijm63A3n9RYrqUBSkEgnMK3
B24OVuLP1ui3dHjubFa003TXo+ACNxsj4EhndozEVAdIHuikfBo=
=xZZB
-----END PGP SIGNATURE-----

--olvrVkuLCufgqrzf--
