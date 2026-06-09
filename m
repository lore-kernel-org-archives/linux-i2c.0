Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC43F9F44
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003245; cv=none; b=Xz+p+lC912fZJTyTpurX3aSKfHX53/bzPOXQ0YVRZsMM8FsdGzmoed5QHmbNKSric4lnOfD3Wzb8O09gHqPfnU/tYR7U9pmpda++7cd8R1a1e/Gulj7hIa9mg1tNX5HoFGut3fipJWZsqCKrmEQFaJqjtyaba0IWRGJs+viO1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003245; c=relaxed/simple;
	bh=k/4cjrJIiLkc+4OP5DerHdsbprOm0eI7rjiynXY0rLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZSsn3oQOnDMYqzkivjVtNih9fvCSlciJJ9yBlEDhBBDkoiiOZXGumjTpkAvS20Fhq4oOdppRkX9x/cU2v1dWNbPi9wAp7IU4J6eC8BGz8M75PBylh9IIqlgKS7BgEwMVNVjtz2lGeycu2ao9ttkQt7VvBeqvDrAK3kGf2dMiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DlCAvGWX; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DlCAvGWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=o+An
	bWzeyRJv0nP5GhAvs9HbLvJXNFbGoCHHyfgze9c=; b=DlCAvGWXzmiTMKAry8EB
	ygllAcIN9eu2UuCSScjnSbd8hsLjevAWaWiRc6/MQQlZel+5gml9ccu+UkSGTm5D
	4HoeEGSKAoF42myBbE0bjbI+xCioA70xFfE0aT/pXD1eznngOMUuKEXIV9SFMoZF
	XBddQfxm31Ec35DXn6QH6k+SiBcRKSYF4FCSsl5eRjg6ea4qO+PjMCCbXNc9eXmW
	ZH0LkNNCXOibMvcvMssho70U4HRz9ClSPzkYqNdmTI09tW+KwgJtIIvGnuxOXbIh
	YRkE6R5AVdfbxpeSnG5A8ugeuLNSwl12MbqGpYVRzf94H4nbjBe4rCHOXyNxAI0A
	Kg==
Received: (qmail 1244159 invoked from network); 9 Jun 2026 13:07:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 13:07:20 +0200
X-UD-Smtp-Session: l3s3148p1@3MJ3IdBT9JkujnvA
Date: Tue, 9 Jun 2026 13:07:19 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PULL REQUEST] i2c/fix-registration for v7.2
Message-ID: <aifz56BVLCdk-lDu@shikoro>
References: <aiclzp0IA2Rk7NyU@shikoro>
 <aifphmi1oFYZz7dQ@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HNwE9elCwylO6fpy"
Content-Disposition: inline
In-Reply-To: <aifphmi1oFYZz7dQ@zenone.zhora.eu>


--HNwE9elCwylO6fpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

> > Johan Hovold (10):
> >       i2c: core: fix irq domain leak on adapter registration failure
> >       i2c: core: fix hang on adapter registration failure
> >       i2c: core: fix NULL-deref on adapter registration failure
> >       i2c: core: fix adapter probe deferral loop
> >       i2c: core: fix adapter debugfs creation
> >       i2c: core: disable runtime PM on adapter registration failure
> >       i2c: core: fix adapter registration race
> >       i2c: core: fix adapter deregistration race
>=20
> I cherry-picked until here in i2c-host-fixes.

Please don't use 'fixes'. These changes are too intrusive to be added so
late in the cycle. Stable maintainers can decide if they want to
backport this. While -next gets some testing, a lot more testing is done
once it hits Linus' tree. If we cause a regression now, we won't have
another rc to fix it. If a regression shows up during the mergewindow,
we have multiple options to deal with it (fix it, revert it). Next
mergewindow is totally fine for this.

All the best,

   Wolfram


--HNwE9elCwylO6fpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmon8+cACgkQFA3kzBSg
KbZjkw//fXpdimXo21UaAROEEmlVxQjwGUYF0ff7R+SNI7FD27VQ7xQ2GYsjWHsz
UY43Q9/LhkE6bFVkFyPC+OM0dSx+bRhOBdb3lwu8BCJb+rFSCUCKRnXogHVdMXVs
cRhveghW7+BgSo1opvM7Qly5HjLwvsS4BntWp3nydjqlCpJTBamxA3r8OGjoFZYh
jAxQTzjl9XV6mobpBn6CHRvEvPKTTh7rQhdfEiV7l2IVpq9KrXGmtyASe9hXdUUj
0uUELllsbkX9xvyeYpBMp3Z36BFlMJl+KT67Ir3H3Vh0+BhZcDqGbISW3pH3+Rc4
j6Gd2R/lLfD3Hr6gw95geVwQ9MjdnxKgsHdps39o8P+vnlYQeStFnyfJ1zhQuToy
kK2MOX9BzD8tPjG9ZzY6q3yp2T/t421SayXF0+fQOsDTRLaFE+dPImJGMqKtb7xV
78dX/0+T/SKv6mEQj4TOH1Mf9vAVOZsq8quN2X94qT4Dxx0UlnFvC3Mox1421u1Z
9NDb+dJBO0k5OmgLbZCMqGXFiIb6bCIUS20UuH8tsf4HAwFl/r49dVZ/GnPPiN2L
Wj66w7wF0i0bOhIkqoHm5L8agBaScmP5nhv8qKDEX9659hbcAbXMIFo6S9m+YzLa
6bXGDTykwDOSwBf7D8WFTzZKqJdKDjPBr2vRRpV1HltrFn2Bs/o=
=bT0A
-----END PGP SIGNATURE-----

--HNwE9elCwylO6fpy--
