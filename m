Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33038CFFD
	for <linux-i2c@vger.kernel.org>; Tue,  7 Apr 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546886; cv=none; b=GXk4QeKgNdhZwqpWePuqxHpgiTsSZogFEtlnKIcwxklngqoR1nJaLyIiTOncnnqvvrb4uioEY3KHWHOybBXftEPTllWzaW94I9CCC6ZcUCi/ia8Nc8dxvMhTuSfRfghRmxtUlyaAzhVAWLSKkTZA0fwKBDU4eAXAvJwJWF3k8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546886; c=relaxed/simple;
	bh=lkNCIx8/uD1kgBiLxFjmYySv6Zet24McPNXvuAxpG3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL/uL3ygwAnjdVggrjt70iy0O+xdvBjBFxFufHSEbGuj7/0VPLwbP/HXp3EfvGQXCgfFzk0jsJvjUe/NIUJ4R/n2hVbXlGtVKgUJCTvHe/zsYqEVSU6lnn5d7BSqkYRIAJYP3KFmifdofBYVJy89od3CMqg34WG4s6++wPj8WGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XKFUh7fG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XKFUh7fG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lkNC
	Ix8/uD1kgBiLxFjmYySv6Zet24McPNXvuAxpG3Q=; b=XKFUh7fG1HdgVJN9oaT8
	g43lvfrlWxiksOvSmwl/J7z71T5zIOCeZCQNNqW/o+PxhT8e6J8y2QGo/EtNmRO2
	4m4MLECpOCRJySAvO1BnXgI4oIVLZJPvYem4kZd66PH8lNnTqA05h/lIHoXg3TQi
	sZDeru7i3IqH98stZbkHmpMRyeUTCtT7i4+7RNzI2bDGNtaK+wPORTvYDnvAHPtF
	xzMVP2GXt044Yb9EI9dThIOq+ABERDPBzJBo8GNEoyhV+pxdVbH7NTeXKxojeXRy
	pdDkPFlR71k8/EyWgGqoMOwzQM+n8MRJ43BcA3Nncoo4VFyongTyUlHWw+5TOIQ4
	Xg==
Received: (qmail 4127677 invoked from network); 7 Apr 2026 09:27:54 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Apr 2026 09:27:54 +0200
X-UD-Smtp-Session: l3s3148p1@SD+wuNlOstIujns2
Date: Tue, 7 Apr 2026 09:27:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v7.0-rc7
Message-ID: <adSx-S1SXPAcfk7d@ninjato>
References: <ac9aokZYJOTAW22a@zenone.zhora.eu>
 <adDiBkAMqHlrGcTZ@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GmEYnPJRAucbcWZZ"
Content-Disposition: inline
In-Reply-To: <adDiBkAMqHlrGcTZ@shikoro>


--GmEYnPJRAucbcWZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2026 at 12:03:50PM +0200, Wolfram Sang wrote:
> On Fri, Apr 03, 2026 at 08:21:07AM +0200, Andi Shyti wrote:
> > Hi Wolfram,
> >=20
> > here is the fixes pull request for v7.0-rc7.
> >=20
> > It contains a small fix to avoid using uninitialized fields
> > in dma_slave_config, triggered somewhere deep in the fsl edma
> > driver.
> >=20
> > Thanks and I wish you and all the community a appy Easter,
>=20
> Same to you, thank you! Pulled.

Sorry, Easter activities made this fall through the cracks. I will send
it this week, promised!


--GmEYnPJRAucbcWZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnUsfQACgkQFA3kzBSg
KbbAeg/+OjyPE+ubuJ0xOBPqLx3X4NIvptPdY8ZT+vUCypUgIoUY3SJ8+iIywixl
M99tZAwOlTqESL2EnlsW11acaxMrxTUtERJer5K2Hecoa2+j8mibqOPvsKEHl4fs
KZRNvsfiB8F5PGgPJCLDkoRrcEnr6bN/aqUK2PFT9xtc9Fs+E/UMDmLAGRPEdKZb
2tYZUOW2f17X9Ux6HMtVq55gN1tgkrOROCVj4jc2Gijj9IJk1unCB/diq9Rtc3fz
3W7IwEMwRtVL38F39AoJMuT2HOredoCCTlk6mKFBvHvlAymiFHPA20kL0FAkabCd
dr9mQ/DlhBb62qqudO2E7GYCsl/TjhRGwa5keEHRqf2/6OL1dcuVbSeveLUUmqFx
MXWkdkBnNeqygf47VQnTfV64+6y9Wl3lgHewlByNjBuJRdyXIVZULviQBWtMEY2y
hZe3xPHBcBAwsL9nZIrt8M0to9z8gVNwvU9GTiL7sKJ0cDJZps9RpaRjTYVbRcGZ
KKY4kdoew7f1Pa5ILqPs4Qlw1xTwUeduzVQA+whKegbhooE31OF30qkPLWEF4pvt
rI1YaUlrfM/eNaxh8b9pgvNqWSQgyaS82R4pOwJnhIwVLmOcyY+sHf0beqR+0NN3
7Lz+fFoVz7qArRZBs503AhNzEm+LYtSAtEogho8wsLD+9LtHciI=
=56fR
-----END PGP SIGNATURE-----

--GmEYnPJRAucbcWZZ--
