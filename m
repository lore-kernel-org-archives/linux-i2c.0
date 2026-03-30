Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC643D2FF0
	for <linux-i2c@vger.kernel.org>; Mon, 30 Mar 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876264; cv=none; b=YCKdsIxQ6nJInh8UWK/NBWgkopaDkLjpsar1F+laD7SF6o8ciyoXctDMGlhGcA6MX1krVngBVdrLptqVDS/sMwSXCFLFnhy9NIMR56Tl+Ny0ywxczPTjAefWsrJN8dNdnvfN6Z9rOznxexeyGc14X8X+zZCW5bzMLzRlaQIoJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876264; c=relaxed/simple;
	bh=782szpsT4xRw+LPPErL2w6/G9QhfZLV+j8uDe+81LDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHvYbTvLdwSSCnjD6UTFxiD4j/S5fJp/e+HCNsew9AmQI6JgRcTVg3l7fflX8xhZndbuDCFCjmGWCpMcVHOrstmPvcmHr0jZzb72RlAxynrnNV0akt+PrsWqgVVFu5dKBjI7PmlJXQi4sT2TJVdoS4fa25UScnfzlCaodukuE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SbuKr1Q/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SbuKr1Q/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=782s
	zpsT4xRw+LPPErL2w6/G9QhfZLV+j8uDe+81LDs=; b=SbuKr1Q/iKsql8OfQYyn
	T/acTLfESq0zMS/WvEHRHPNEubnJjeeVm4GT65g7iOfkj3naPEJC1S1CE8aQbw0q
	RcjApyZUzLlwsl5moshfn8uY2FBdsSFaDgsQu73Vu09EMa7P2cG7dU6aK/sLs/O4
	Bknf3KgVUACKmprWjQqRQ8wCasINUxK0NcRu7QLyTXZdtxj0IdjHFn18kDrG3284
	AxPdTDhXPJrp5+klGWv8daUmToI1Mp7kh5IrsITjmcQfA7QSIh6W2VTNpcmVSAvy
	K9vwUnqeovSpZivfYj23HKhbDz15iE08JQq1GSsfcS+7qfdA160/AzYXJU75bmd6
	qQ==
Received: (qmail 1283137 invoked from network); 30 Mar 2026 15:10:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Mar 2026 15:10:57 +0200
X-UD-Smtp-Session: l3s3148p1@X23XlD1OxNkujns6
Date: Mon, 30 Mar 2026 15:10:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] i2c: tegra: enable compile testing on all archs
Message-ID: <acp2YLm6OqQYlnRx@shikoro>
References: <20260309081259.2557-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grtjfiis3AsZ0RDX"
Content-Disposition: inline
In-Reply-To: <20260309081259.2557-1-johan@kernel.org>


--grtjfiis3AsZ0RDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2026 at 09:12:59AM +0100, Johan Hovold wrote:
> Commit 4a2d5f663dab ("i2c: Enable compile testing for more drivers")
> enabled compile testing of the Tegra i2c driver only for architectures
> that explicitly provide readsX() and writesX().
>=20
> This limitation appears to have been too restrictive since the generic
> implementation of these primitives added by commit 9ab3a7a0d2b4
> ("asm-generic/io.h: Implement generic {read,write}s*()") predates the
> commit in question.
>=20
> Allow compile testing of the driver on all architectures.
>=20
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

I wanted to give Krzysztof the opportunity to ack, but I can pick it up
now.

Applied to for-next, thanks!


--grtjfiis3AsZ0RDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnKdl0ACgkQFA3kzBSg
KbZhwA//ZoWmeH9SgY9LPUe+dIGof/MqsJXzgj/sP19zhTFJNOwVl0yLEez9hkX2
KXW2BbEbKG5rQYGJVLj9vAE3iizO98BPFPRPokX2BTz/ubZosWk1aOR9mO0l7Iic
Z7cQijSbju086bWj7mud+wZaiPSea/JivOTHRBlBt2QDzgEeTPV2KFWEqv0PKAhi
OcXjrPevuYIvkEbx0Wdy1Xja8CEUjBpFVjtbP9UxGI/v4KU/YlHdo8BrVO4BA01j
4867Sd9ClYudCjY4nPZZoywI16xIVSsC17Jo5qqjRAlyF+Wg2oi/WC6Is6g7phd6
/MZp7m4OdpZpO/myUxvK35ZRVPR5e0r0d1Zi98l0dDK+U1b61MXHR0mL77szCVNK
z4uaoTs3zBOcNUt1Ga1b9ln4fkfrgCmmtbg+XchmvBQedMCjseO6QPz9mVpICwwb
Br/CFmoWhz//EteAOL8vCySpb/cF9RRZl1QYi+na95rsDpyYnUHoacy9oi87vGWA
FEnmDvHRrB4dlBKl/cSmym5ET3erCkyUE1KVDSylhbudXse1QJhRX/ZBNZ3/cgLN
Gx+Am5lx8rwDPuqrAiYGHPGrUBEIcg/B6lOMoXx03uSqaH8CM30HsyKwufRmaB6H
kUokoUv/NF7yODOYsqEJF+7xA/pxPLPXtWZOLz1fMBoFSECfPJ8=
=JcGd
-----END PGP SIGNATURE-----

--grtjfiis3AsZ0RDX--
