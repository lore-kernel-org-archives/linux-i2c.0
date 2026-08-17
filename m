Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B662EEE99
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952542; cv=none; b=h5qFVPsoMXoc4YmL3QNQLKcPvarXk12/Qz4nzMPG26/lorF/qkSIysoMj5m39v9N9Ii99W2Vv0gnk3eBnZZ9yEeUV3P2wTGXDe6BQvjc1cp+vJSKBx3dy9N3kwYxaih/Fofb0NWGU5kt80zk78NzDCQthzf6coGX5Ctcvb/wu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952542; c=relaxed/simple;
	bh=bvJQt6jOK09+sWrd5qrb1zONB/P4dperJ8S16KlrGRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBKMGBsRZYIcusxlGwBF0NhMSiIdmZCdwjKnSMVwdW31GXtx70C65liaIbKAvihLeY6qaz8bhegb33APfCp/L3NXSXUTRtscdmowS6n0T80e6yXtV9gz7qcn2WhI+nVkfTuzSGNljv2PbWW+d3f73Iw5He7LgWgfM1UCp7/ZgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MVwoZvdA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MVwoZvdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=SkkL
	vrPYkGVG1ryG+nQhWbsSjwpQ0FTlmX59Cki5PIU=; b=MVwoZvdAC1N0Rnr3zDUn
	9HPS3yB++aco5QlH6ETC/I81n8f2z7BdcCHdYO0XuWIni8tBypw6O5QK2dqh996h
	5ALgI6lDF07Xzf/B9z4YZR4AQmsBcoVBuRO/nvEsEas9HzxNXemDnZwsLXDQs8is
	QJuvAg1aU0elsVDM7lV4GZ+OtG3l0WtOpKpTF6H7Dr/5B8fKeaQdQl9iwgIg/ndb
	IksNXcdC/4u7i7fIvOst3xFTipwM4ljMXBNAmteHXNKbuWeh5f9+ZlyPSvYyvM/e
	kdp2G95WGwN20xNe5aDS+5O9y7oDIyjbBhR0dVxLejRsB2+4yKzC5wo+TS0UmxL6
	Pg==
Received: (qmail 3370620 invoked from network); 17 Aug 2026 09:42:08 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Aug 2026 09:42:08 +0200
X-UD-Smtp-Session: l3s3148p1@TGqzTjlZUsQujnve
Date: Mon, 17 Aug 2026 09:42:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-renesas-soc@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: rcar: add R-Car Gen5 support
Message-ID: <aoK7UBuJHiXfYHNI@ninjato>
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
 <20260727122546.4232-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
 <80a94424da18d5003265c5e8bf5ecb5a90499b59.camel@pengutronix.de>
 <CAMuHMdWVtfizYD4vKzsQrVpzr4ekmFQRtDZ4QpOhVHMh6K7JjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d+q1vb0FAkpmN4PN"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWVtfizYD4vKzsQrVpzr4ekmFQRtDZ4QpOhVHMh6K7JjQ@mail.gmail.com>


--d+q1vb0FAkpmN4PN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This could indeed be moved into the reset driver. However, that
> means the reset driver needs to become aware of the peculiarities
> of the various target devices on the various SoCs.  We already have
> something similar for module stop delays on RZ/V2H, though.
> And it means more dependencies to track when adding driver support.
>=20
> Then there's still the user in the PCIe driver[2], which can't be
> handled like that.

I can see the argument that the extra code could live in the reset
handler. But given the harder dependency tracking plus the inability to
handle all corner cases in the reset driver anyhow, I tend to update the
handling in this I2C driver.


--d+q1vb0FAkpmN4PN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqCu0wACgkQFA3kzBSg
Kbaydg//RsiuWtHKDz2Yj4MiUBIPKeWYqpNLWcMK5FMsFslLMmTiaqaZe1dJV7IE
qO7HiruOHOQgtPi3xRUDR0XQaTdS/oyPzRyju8oKOKbx92vsBVQJ2FRJ8l/tyneW
NLQQPcNYa2j84+C5SQHBoDNwWz5+ZYvpU+qrQERsVf2hIVF1P//UlLmwdQ55RkgC
3opVUQDy4NOomnUInH+OukmSnBsR3TW/93GJJN5agr0LHT2QP+3TNCGx8T5w+d7J
uf9NW05gV0QZhYftzEj1DeCH6Qz7Jfin4r8zbWTskAt32VMmoQAtFcLgSn5z0Lf7
GmK14w6/2RYX103AipY9OTb6tIYM6kilstKgWLDhwj6MjibeSERMSlYcEb0K5TJ/
PHd6mYhF+oNPfavTUT/dLALKm+74YrwNEA012KXa6vRSNaFcOL617mnc3VpqLty6
qtGfEEH7T18aCvANcw0J6shI35GrshssB/DRaZIEBArBsoAvZ2crLu5nourCrBLk
Nu60dsJQN8KFWMfH6y2b6Cpb9Hg3qgxDIvfL/+EVXrVelq3ZZncNQHm3IDo4NcKf
YXG6+YhWmNfiE6b9RtBtYdnjxiZ1e91TpygA7Czel+DX+rGO3VyFBXnpkk6fO1UE
XCHocB2mDb9Cif9QdZo0BzwOtkZFp42qLFpSSPP6xoXq7TF0QDE=
=hOor
-----END PGP SIGNATURE-----

--d+q1vb0FAkpmN4PN--
