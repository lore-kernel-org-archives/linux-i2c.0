Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E765293E9
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172432; cv=none; b=uPbSxMZcnrOJ9PI5MXVQ8O6gMpj1O4zy/Q8h+HQY7EXScLpileNueQKpr8BjyhX8PJH4GQMILOQYZ2r5OQ0vsu0IfFUILqevkv1lOUHBr+Xi8O8onCQGYzhyjnaJcb3geM3D8AzMgOFklgZ0n0YOfiwJlYn3WdTgJghqAtAqYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172432; c=relaxed/simple;
	bh=wybTwWof/MDQoMZjmwxI/U7NZee0w+BUaIv7s2t/h00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWKSIx6kTUbrmITvby6m5B3fp8FEZFwIGm8grxzO7Phzg9xNYoVTwPKRoH88TGPu4ihirpEyhKeUl7MA0xjz9nO4WsHqBaCZrlQrnMEsR3n31RiXBTv81/+uZyzg+yRLCDqQLqh658xiWNocAdCJ4J6eoSIx9PcCyT2UOA7ugRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ogv3rpqJ; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ogv3rpqJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=FwSTdb1/TpsxcIJ39RYbmBW11gYzJPeVrTojNFdUEu4=; b=ogv3rpqJUZip3ouxtADZOriOcH
	5cxteKBy8xVLww2rTiW3KrrqPG0w2zmmdgJvy+0o/+DoYduuiNPk75OB/WCd14oOZvevHNwB49vft
	q1eVaWrYC+QoijfIeEgVi3QcsBFRqXislcWZXLqvdNjdN7/HOU/pMtaDmSdXBTGSga1PM3R0dggea
	mSdZxaRit/6AsoKk18Kank2HZDPZr9ki4MpwyMy9brqN30ByYw8rhv+v7pf5Q9QmooFNwPtLP8xNo
	nK8KeoV2Y0i+xvuvzYLyZmdIOUVBNUCNQsebWm+jaPIv8PxrMD5Or9EWKP3w4r2E1RhwrKjxArdO7
	nESI1cnA==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1x9Nce-0063sf-23;
	Wed, 23 Sep 2026 14:06:56 +0000
Date: Wed, 23 Sep 2026 16:06:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Al Ma <AlMa0@ro.ru>, 1110749@bugs.debian.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Subject: Re: Bug#1110749: ee1004: DDR4 SPD cannot be read, =?utf-8?Q?decod?=
 =?utf-8?Q?e-dimms_fails=2C_=E2=80=9CFailed_to_select_page_0_=28-6=29?=
 =?utf-8?B?4oCd?=
Message-ID: <arPcZcu7S9vqE3JE@monoceros>
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
 <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
 <ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
 <812847a5-5630-4d26-8012-c816e6d1db32@ro.ru>
 <20260911135604.6c2451e7@endymion>
 <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <8d8740a4-6b9f-483b-9ea4-145293e63c25@ro.ru>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="imelkw77qpbbslbi"
Content-Disposition: inline
In-Reply-To: <8d8740a4-6b9f-483b-9ea4-145293e63c25@ro.ru>


--imelkw77qpbbslbi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1110749: ee1004: DDR4 SPD cannot be read, =?utf-8?Q?decod?=
 =?utf-8?Q?e-dimms_fails=2C_=E2=80=9CFailed_to_select_page_0_=28-6=29?=
 =?utf-8?B?4oCd?=
MIME-Version: 1.0

On Fri, Sep 11, 2026 at 10:33:07PM +0200, Al Ma wrote:
> Awesome!
>=20
> Below, I'll comment on whatever I can meaningfully comment.
>=20
> > * Short term, you want to blacklist the ee1004 driver on your system.
> >    It is not a good idea to load a driver which binds to the wrong
> >    device.
>=20
> Here we go, following https://wiki.debian.org/KernelModuleBlacklisting:
>=20
> $ echo "blacklist ee1004" | sudo tee /etc/modprobe.d/ee1004.conf
> blacklist ee1004
> $ sudo depmod -ae
> depmod: WARNING: -e needs -E or -F
> $ sudo update-initramfs -u
> update-initramfs: Generating /boot/initrd.img-6.12.107+deb13-amd64
>=20
> Can the above warning be ignored?

I think yes. AFAIK that depmod step isn't needed and the wiki should be
fixed.

Does that help?

> > * Still mid term, we probably want to blacklist SPD probing explicitly
> >    for your motherboard (we'll need to know the contents of
> >    /sys/devices/virtual/dmi/id/board_vendor and
> >    /sys/devices/virtual/dmi/id/board_name on your system). Maybe this
> >    can be implemented as an empty entry in mux_dmi_table (as in, we know
> >    the board requires multiplexing, but we don't know yet to implement
> >    it on that board).
>=20
> Here we go:
>=20
> $ cat /sys/devices/virtual/dmi/id/board_vendor
> ASUSTeK COMPUTER INC.
> $ cat /sys/devices/virtual/dmi/id/board_name
> WS C422 PRO_SE

If the above is confirmed to help, I think we have everything to
implement a quirk with the same effect as blacklisting manually.

Best regards
Uwe

--imelkw77qpbbslbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqz3PwACgkQj4D7WH0S
/k7zMwf/epi4XIYdQdXSPRou8IE8OQfXKIhI7UQXkxqhH95xJJ5oqelh8OVmVtRv
rzzcmG5cZDuwaRo1h0k1/HNbSdcptj1yoAJ9SPGxGr/iZENAekohAgQTfp3jABTF
nl3KYV7Mi7VSnEb9iUG6GSoVOCDC2MLjarCleAO9pdGfRzNRRWa/+AQLjAZRI8ak
qBGwxvhGVKDES8DZantYBo1fuQRYcGzNe1iJc3bQLuMbESQUvGnpvFcNCDxyaFIe
vqEgcpkk8CWf2d00DHisw8Y8/l4cWoqOlObRniNY5m5k8ZGIt8turr4kHD6F3nPP
4J43XCw3kYmH83grN1yf3L/Sqn9cAA==
=4FXv
-----END PGP SIGNATURE-----

--imelkw77qpbbslbi--
