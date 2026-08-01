Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCC370D5C
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617858; cv=none; b=bfc8JUQ83qTvlTyAwO4MdDpEhuWZpl2XWPEDoto6fn35cRdh8/KTFZkW1rPY4BAxxJZ3TH85VPyeOtXdpBb/HAO9v7xS7evnuCFImwowgWdheyYFWfh4LGAP2sNZ77Qb5yT01CY5ctEtIk56IBV7G8C7X+MUOxbXrGDllfglD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617858; c=relaxed/simple;
	bh=VGwLBVXK3z6dtMCtKbTtsPXwc1KsfFcu2KcqK/qF4z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgqfcAbwnPB5GW6iYbkRmdGg2hcTnVNvkPUACzl2wdyepxOFKz8TYgr5n4j6Ywtz4O1+tQei9gJvXoqReZtZgQmIzmguBcm1aFF22sDpCNQcMQ9V98qJsEPg3vLuw95MaLJsZGaJJMyeQ+lIBBAk8/ixWsrqo4qaKgyMw3ChI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VFYIbqG/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VFYIbqG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=XfXl
	WOe45MSfYlAGM0vejuZlOOTUfHR3rr36V/WnBrk=; b=VFYIbqG/JFQVgwOB4Etn
	h+vfxxiKhD0+UpKvj2UP/BGjDC2QG32rm/IlwvO7oWl2D6X3EQYbDPjh7EHXKW2n
	t17Hjzd0ihRETroZI56oUWZmjIhjJphs5Pm6V0sRzryFXzEno9QHUeTC4BQLZNfF
	ZtVCtpS2PCM1ZHIbDn/bpNqxsVx3v11jPf3vfpzDK4/8RIl+EHraiZEQzhLr9lL2
	Z5vZb4cZrRSvhkEXbYJlp3eP8mRct/Z8polWLggO5h5DQh606pdWcvC4tItSWKVQ
	z2qQeCDZasBA6rsPL5xm13VpcYlZc/cgkwkIrHioGftOxshjQObifWJC3PtJh7RY
	8g==
Received: (qmail 2495434 invoked from network); 1 Aug 2026 22:57:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Aug 2026 22:57:34 +0200
X-UD-Smtp-Session: l3s3148p1@IijqjQJY+K0ujnt8
Date: Sat, 1 Aug 2026 22:57:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: core: document preference for
 i2c_get_adapter_by_fwnode()
Message-ID: <am5dvgXS09CA3ohj@shikoro>
References: <20260716133029.1565853-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SJ5bFrbXcgFDxfRE"
Content-Disposition: inline
In-Reply-To: <20260716133029.1565853-1-johan@kernel.org>


--SJ5bFrbXcgFDxfRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 03:30:29PM +0200, Johan Hovold wrote:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
>=20
> Document that i2c_get_adapter_by_fwnode(), which also takes a module
> reference, should almost always be preferred over
> i2c_find_adapter_by_fwnode() so that an attempt to unload the adapter
> module while in use fails gracefully instead of blocking
> uninterruptibly.
>=20
> Note that by implication of_get_i2c_adapter_by_node() is also generally
> preferred over of_find_i2c_adapter_by_node().
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Andi, I would suggest to apply it to for-current even, because this is
an important doc update,  but I'll leave it to you, of course.


--SJ5bFrbXcgFDxfRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpuXb4ACgkQFA3kzBSg
KbZ94g/+PlE1D7FkiFaiypGmN4Lqa8HtAnPrwgHaAef11FHJHzpEucbxSxOu2HPB
BMV7djxEE2X1sQ6RHSMLSqVNMC/5UeFLGQKx6a+44xzLi6XRH3eT/HInNIXT/W0N
oP1z22ILzhIs5Z+OPp2rTW92sO2PT+Jl5Bjg2jxO2DlCtQtqLs7WokKqx+WmcH6r
TJXlZ3QLpopmZtbkuNskPbL1W0omisVH77szj24VjgrIrJC8+LsyB7DAmbfze0zM
XJT1InNPsIhDxykfUlNjS+ARIXVJDECzcli0naIObN+pVkPqEWDq0G2cGrFjcuij
4L7ytWWMFgPx5yxGaumcrJI/LhGSFRB4K2qqYl5pcFfNnMj1Dcl0wB1r6GEsYQQn
X2Hw7soAON7w/TQ9yApj2Mj/J8LsJVEqDFQnINdFctvuSscii47nj968N7/o9XzE
aM9e2d5H2UaASdRCmIJft5TDuQDBlvYi/k9+pE2/JymMtMay/iDktGHW2ExTls42
2UvVHbubrkMs3wbq9D1g0OB8Sua+AwSSCffXX6qclMqfXpGFomECWrrZvIgcw6V/
nJiXjhQPtLbW2nOy1frWyk4vlc4dxPglIj6Vw+QXx9BbUKtl0hZ4OR6r8G9TKRIl
9Qi5HOLN/29wr2+kwiy0dH76sAGWmHV/lq/hrazHE3KRo4jVpwA=
=+k5l
-----END PGP SIGNATURE-----

--SJ5bFrbXcgFDxfRE--
