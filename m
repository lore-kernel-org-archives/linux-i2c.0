Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A4401A01
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499947; cv=none; b=naQ2G41xMxIcEzJRYhr2BG/QzQvF2wFiDGQj7g2o9c4ucBZuKx2Wrfm6oWJSXtfiQPc3t/xoUUgBHHFaXu6pTU7DKYr918Ya3FNmLUSig6qzVIZxghFIXnYgb31L9lfRbv0iuka+te1e5ge/StKOnl9DhrLLW/Pv5tw99Cs+9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499947; c=relaxed/simple;
	bh=5tymxeNUpH5NhX0T5/yFIkzkW5gC0qaKZG6UOofDHjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oABdH5zFfITOFzxRYhZcNwZmdt0GRIQkkbYGM+9/RpKhC4vYK9+9M5aaJHv0fpN2FrSP0BK3D/HD3YPU0gmgdHXt55S/bHRtczs2NoRcSlwGCa4SgCSUX+/pvishakjsovgIRpkguDW+ProjHLLbzRoIXIfMhVazdafyo3rf2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PzUqmFRD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PzUqmFRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5tym
	xeNUpH5NhX0T5/yFIkzkW5gC0qaKZG6UOofDHjA=; b=PzUqmFRDvjYc283EMKCm
	yjF7+Ywsyj09ZVgJ+Zr25iwdgYWmHMG4M67hAo/PbM0NoliCvLfG/OOojzaJWlzQ
	g59ShNKLWqpkMSQH9kkxrhMs2EtyTtpQWyLdKsWh/QnxxU951kFf85pDYw/Eyzee
	E2e6q7XBwH0Kj2RU+g7U0l3yOS9LUZ0+YDEuVHJBVfqBOiTVM6BX02+7eVF1bnif
	F1E8vnENSeJCQxh0gFjb1LTg61zvnKaELC6uUUi8dCIP4tUoqUkmZiVkoRJaeQP5
	HJr5K5TWB4fIJkWU1u0gi/M+NBaN99pzNrnACYKuYb/V9VfKSf2IVhJR99tQB1rW
	tg==
Received: (qmail 624507 invoked from network); 8 Jul 2026 10:38:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jul 2026 10:38:55 +0200
X-UD-Smtp-Session: l3s3148p1@DpYdcBVW6sNQT+F6
Date: Wed, 8 Jul 2026 10:38:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Horvath <s.horvath@outlook.com.au>, linux-i2c@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	=?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
Message-ID: <ak4Mn4NOfIqCQTO3@shikoro>
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
 <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
 <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
 <DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com>
 <akzuG3VpcoUWRhUr@shikoro>
 <DJSVN4OMOMB7.EBB9SV2PLWTR@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DuJ0d4dfiU+owrMY"
Content-Disposition: inline
In-Reply-To: <DJSVN4OMOMB7.EBB9SV2PLWTR@brighamcampbell.com>


--DuJ0d4dfiU+owrMY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


@Andy: you know more about laptops and I2C than I do. The initial issue
was reported here:

https://lore.kernel.org/all/DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com/

It would be great to get that bus working because Brigham likely could
then test the new DDR5 patches for decode-dimms.

> It looks like it's bound to i2c_hid_acpi. No ddr5 temperature sensors in
> sight...

Well, it was worth a try. Thanks.

> > How many? If it is in the 120 range, then every access from i2cdetect
> > fails with it.
>=20
> When I run i2cdetect on the i801 controller, on one invocation I count
> 111 repetitions of the "SMBus is busy, can't use it!" error once, then
> on another invocation I count 112 repetitions.

Okay, as expected, this is more or less one BUSY condition per address
scanned.

> When the kernel's i2c bus arbitration retry logic kicks in, it appears
> to be able to eventually complete the operation successfully before the
> i2c core driver code gives up because otherwise I would expect i2cdetect
> to exit prematurely and report an error.

It would mark that address as "XX" if there was an error. As it prints
"--", it indeed indicates that the retry could have succeeded.

> Wolfram, if you or any other kernel developers think this may be
> indicative of some underlying issue, I'm happy to investigate further
> and report back. I'm using a Dell XPS 14 DA14260 laptop.

Thank you, but sadly I am not the right person to ask. My expertise is
the embedded sector. I don't know much about laptops, ACPI, and how the
management processors play in the game. My assumption would be that the
BUSY state has something to do with the latter. But maybe Andy knows?


--DuJ0d4dfiU+owrMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpODJoACgkQFA3kzBSg
KbZl+w//bYIs75zXxlo66uwBcY52w8uJF2ctT9J1M0HeWAdkyXI73NJbK4pDeoD6
rqWWOLyreuFS717m4kzLOALfDVEzDrkTl/VlH4pf74GcyfhZ61QVx7azMtgTPgnv
uf6mhuxEfZ+b4Z0A885FnQ4ACrjXvAOqylgZti8aepL6VpL5HyK/+uamVcEo/fwW
lg3KNa6iLzUvXxcrsMsELhdKeCaO4GopwSDlYxak/OaSy5Vsp9uQF5Dd5qK0lGzf
lHjxgK8qWOc8X5vQqVOQSr3OKj9JkSpD8RY9usnw7w4wpEZC14ADtOWhq63FAaMZ
7qbkd5XbEmeLCjvI3EFrlOb7FwUryehyUf1EPDqw3gdOEWrAQc4wrhlCRJaouN4V
eLtEd17h1SLSmZhmNLBf7cR190TrC3f6e5y4kTlf5caLj0quSo/6KSQcNb6H4N0Y
dM/Mww5s5WXx99iBfX9xOBtBsaPlsFdVDWGH/Q4X8UWIgwqIsKMWoE8uf78bWe/S
jHojyWvydyeVwPQ3WBsIvI8olIR/TnMxvKsYh9aMCNJvlj0A5G2PQ9/na0wWUadP
SXf6Z+JvmClSsx4AMuPzslKK2aX/0bIzfgCJTCbtA1N37P0GnEsEP83lVoWn4I3z
rJ+aUx4iZo5W3kpuWOImEEIA2lyBNYaUvGMMPAMp5J3KAP26cOg=
=R3OQ
-----END PGP SIGNATURE-----

--DuJ0d4dfiU+owrMY--
