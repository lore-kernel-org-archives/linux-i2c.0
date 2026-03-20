Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8B1E98FF
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041393; cv=none; b=P9NXSBgu47mQwS1fztYr0+dL8ItuuwvGxxS2QIc6uH7aoRk+xwvuwt4vfZtwuM6ua/DX1f1ksEqyuMXBJbO6tIMwD5HTkqhqvvQNs7sV0/Rx+vmxCDq+jBaG9v9IolYBe8xhacbetaHwNxNQ010oAnD+dVkvP/M2X/yy1Y8IvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041393; c=relaxed/simple;
	bh=m0jAX2jhSJ+4YOM659dXaIv5WVwfXv/1NEu8joApXho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP79k0Lmbt7PTYnSc5ygQ8AZulh1NUBa944neIAL98u08Rp+8ZfgNFgnqj4xQnQbPXRru6R2bgUhbTv4VrUuMbgH3xb7kiIOOfTHhRK+/2d2xJvfb1eUcJX+FaxiF6GtCrTYGHLZucRIgscJd6cHfIi6i3qiIV2bQj8CzH4lUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=icEe6YZo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="icEe6YZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/t+8
	UF4jkcGMc6EqL/sMsbOsNUTLTFRDgYjYwmMB3sE=; b=icEe6YZobaWGCQbm+AXl
	gAFlgtvVtDmwcmyMvs8zWHxltcKRI+b3hytXhhcPbYUG3Bq9m8YWchcIuwkwWSoc
	aJDBbYSuDOLheENF+mxtyflqUpoblz11g4W510JTmImQkf7mYEcWWfVZU3UZQtLw
	I916dfQZn5n91R2uvsqsrHai7qkPOGFF76l00mrj55dCKYi9ICVfe1DkqxjzW40v
	uF9TqUKFuINCWC0AwiEYyAby0a6FbfyDR7+jwWsCmuViR9X39sFcBArmDcSsR/RE
	5gNElSYWUtvQgV4m4Azcjd4sKvDXCXOUUeJGQxkjbsJW4KPBtm7xtE+K1/T5iAvy
	tA==
Received: (qmail 1698964 invoked from network); 20 Mar 2026 22:16:30 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2026 22:16:30 +0100
X-UD-Smtp-Session: l3s3148p1@KB3aMntN5uAujnsL
Date: Fri, 20 Mar 2026 22:16:29 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Jovin Basil <jovin555@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: gpio: replace printk with dev_err in probe
Message-ID: <ab25LXF50CSUhgjY@shikoro>
References: <20260320122656.430939-1-jovin555@gmail.com>
 <20260320150144.432345-1-jovin555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AsiGbg3kNRnu7i2x"
Content-Disposition: inline
In-Reply-To: <20260320150144.432345-1-jovin555@gmail.com>


--AsiGbg3kNRnu7i2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:01:37AM -0400, Jovin Basil wrote:
> v2:
>     - Restore original log message prefix ("i2c-gpio:")
>     - Restore original spacing and colon placement
>=20
> Signed-off-by: Jovin Basil <jovin555@gmail.com>

Please read 'Documentation/process/submitting-patches.rst',
especially the section "Describe your changes".


--AsiGbg3kNRnu7i2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmm9uS0ACgkQFA3kzBSg
KbYkDQ//X5RKpBD4jQhOi9qX7AmS3c8nE7IuVw3JLHPNa+KAXsuVvlSK3SnnOZYp
t8mlsCzfIXpovIfYuaVtd/aZJyfC2iG8jkb5K3IUbiOhZrtQfYzq1PXNJ6vhNZKo
bBMdCeLRtLgdr/VdSh3Uf+4qsKuwDxG/Q76hi/eA/a1g8yw+EoxqKJkIlqe2m62b
U59zoHTkcJBoHlTaBopevbsvgCBvsmDc1t9rRP0UXXIHXji2Br0wfm10Se7DzicV
X4IhMzNont3XXIK70udsJ734Vhf07BPfZSQj9mlGrwZHuX1R22e0wxLzw/WqgJT5
G4zhbT0SXA23R5ilqFUfCrwnMLk5WHJilWOz7a7Ep6DXWQ51Io9u9jj1n6gdWP4W
eAtiDUa7RH6lGrfJmmVRW5b7bd5BBI8+yt2ynm7zL5kRuVzdHK18V1wLVsT61sAK
MwVIDyzT+qN5A6idZq5leatQXjamee4ZXE82//7gCw518yPAKrTXprXARK6hWPL+
hIDbm3Y/8Cz57YJAh7ctdMJ5Xfp6XWGknjgaBKPbg7u/8/lg210e2c2hNlh7cy+9
aEPj2r2dEC2nen65slagmUN6UNgFDjuAXVPeKBuFqWREpJ92iJm7oRTa7h1zozKs
eBBlGNOVrz2F+MpuiLr5Mvo7tZ5idVXgFNvd1MNyivyPbWIQfHQ=
=BSVe
-----END PGP SIGNATURE-----

--AsiGbg3kNRnu7i2x--
