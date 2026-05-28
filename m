Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB882D8DB0
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977021; cv=none; b=qbLfsnM+oteuh/uRFq2ikR8yebTXB11SyUIRsczzn9HLWmzcfr3edyr02reER16geuTkjOIIhQmPhTjqNtSZ5c/jbHls/XHAM7w3eBKmc4QAF5LaWzIy03tsYz+okrTxKkvj7pOOCN9eVHIjvevOHEt5zBi1ce/VXL3ZKUiyIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977021; c=relaxed/simple;
	bh=CSsx0HXjLCj+H35zRjNH/2c7lMd5CrPaoH2+4KWhDbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWqCbYl+1vg8rTW3usAWCXS1mffSGceodQo8Y6NcKB0My7qjk3/3bQ7B4EB4WW29JnlkHNVM0LvQ+S2rmV4IlOQ7QVfOmeXZlgYpLUvUYLrH2Fk405dyB393wxNxrC9OZ2qDfWZSHQB/kzgtcZh6ET4ixO2nrGBIAZgvUwm2SmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=McxHLS0L; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="McxHLS0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=CSsx
	0HXjLCj+H35zRjNH/2c7lMd5CrPaoH2+4KWhDbM=; b=McxHLS0LgcSI5TheiVZy
	E3GYA8m7ASTaWnOnTiC1aNYFI5WkE3bpOUPOL7QaMAWRMPMF3uqtnIXPjBMDtMhK
	sV9xIqnzcNRciYrm5yFHtD72Cfgol3I55Bs8/F7vLw2AZLyQUcv6C1yOFNJLWO/T
	m9x+pegCWmT+k476Ta7zrN8qnee9I8ATm7msjhLoFkwJdJI3u6weP2b1wV336ul2
	XxFE5CTp/DB1Zg4ADYLm0ypioajcjgLld/nE8z3HoEn5kOifzPSLcBYE0sAc1+6d
	NUxzfxrzs1ZdaLUaKuf6ZyKf2uMUzcGS3WKDdg270EJhwPvs52A+FEEhebwv59HK
	sA==
Received: (qmail 1060636 invoked from network); 28 May 2026 16:03:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 May 2026 16:03:38 +0200
X-UD-Smtp-Session: l3s3148p1@xVjWMeFSlpKSAB9x
Date: Thu, 28 May 2026 16:03:36 +0200
From: Wolfram Sang <wsa@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org,
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] i2c: riic: Use the "dev_name:irq_name" format for
 the interrupt name
Message-ID: <ahhLOPEmI0g6m1Re@shikoro>
References: <20260520131206.932050-1-claudiu.beznea@kernel.org>
 <20260520131206.932050-3-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9omyMXJyxjzhq7t0"
Content-Disposition: inline
In-Reply-To: <20260520131206.932050-3-claudiu.beznea@kernel.org>


--9omyMXJyxjzhq7t0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:12:04PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Use the "dev_name:irq_name" format for the interrupt names. This makes it
> easier to identify interrupts in systems where multiple devices may reque=
st
> interrupts with the same name.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Looks good. I can do testing next week.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--9omyMXJyxjzhq7t0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoYSzgACgkQFA3kzBSg
KbboEQ//ZUGahxpVIx4ciP7YEPQyAfjqEEvERzzH32bg22BdAbza+2He/YeoVkc0
MOK5qrG8zGUYanipPJPOqz570RbJ0sA4H/+wpiESG/66dK1JDgpjW/ticYD1BvyL
Nukg6yWBzVTThIE5TMGN5ZEQk/GN0gw+e4u30Lk2C2rUeeo00s5EvtYNv+LzyXN6
2C5tSA7JwrDjkIl9tayOHOkYJWX6/U/bwgt+UDn7QXBdGFGFf+KJFefZgBDTD0uA
nnLeECNvlwpwwAK2+7gblTOjDnr+53gvkEVx+1muupJID1V6QdYGryd/x2lLdcaG
YOCrcFelRv0PTp1QnKxkGscZcA3wi6IVbp3+MgiRSOMXJtQohC2m4AXg7M6YIfxb
yL8wnzPO+BTovZ5C7LJb5bEQ5YP16C6bGkNruv4r5MJT3qn1JQtQuVXUcqb1ZcFP
+fV9/eV6xB8ofU9eTixB+1U3KQoxFGIoVSThm607RDBuBa5AGGChW57LV9EWsSjD
R2tgrbp5LwyxpZtGTo02dHxcnQT195XQRQvxABhmU/XD4CkhiEds9+S5rwg6b7Jb
XUrt30KLRrJ9QNIkDc426Q5uTKTF148XlLqlmWxMW+BcYyuruWdckNDkq3CNePEE
xbLpEm77GnnIJmHRQAGWinNZ0n4JFw2eWRM0AGPkpmm9TBcXW58=
=m2B+
-----END PGP SIGNATURE-----

--9omyMXJyxjzhq7t0--
