Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1E3932F7
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731628; cv=none; b=rX8rN5T6PcoAzL1Mq52ra3Hpxko/iuHN81rkBdXnic4/0gZioK2sqUjdxUSQyO++5viQYISZuQ+wcBkT9iwK+2pS3dOk8jSPqflXINWXOveHk2jc2Vy6fD4QL+jqzZS212p3qHZ8AScfeKMcKGDSy5r0zJQ1yWVYKnvJRREww1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731628; c=relaxed/simple;
	bh=c1xvuunHAFr9/HhjkaoBKMVFRlMFUNOWcdIncXbZcBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puca/Oyt60y9ZOdIUKewHuMYy1UiPPkMwS8+uam6+plPiD6l5bsMcXip7dsEb1dC2P6L8xHyO3MAQKW9u5a2Uub5m3NXuGlGjdqySVs4ahsIqgaXfxmdN8xtkk6W1tvKSM61WrWmqnjv41qTaXha9x21P8iofp+SnznAEqyzXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gS3qlV26; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gS3qlV26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=c1xv
	uunHAFr9/HhjkaoBKMVFRlMFUNOWcdIncXbZcBM=; b=gS3qlV26fxz4PLlrrOfW
	uTpl9BaU800zDLSckhC5lzMcikxJusMfxxFJbx7jGQsSDvLLsGwls9+DHPrJ73d/
	/uo4MZIjOMwZJAsYWweuTvcFWcjlhLFR/BVlbCTdjJJNHHtSIXXXyQQvRjuU5nrT
	9IXNm1hKZNLC9bF3OZyJ1Aax1hjrGrsZdbn0yO0ISvwTJk/c97lRM0YHvG2YhY3u
	Pu7TL05Ju4mEXemCilBbDc50RHPZ2ko6bQEBWpBkHtewOY+uKnCkj5bcNN89tUMm
	GjspzNnevWEc9+Pj7ochh3GREF1Gk9iLRllBpYIjuLjXgSHY9h8M2n7e0jA8VzSa
	Sw==
Received: (qmail 779719 invoked from network); 26 Aug 2026 10:07:00 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Aug 2026 10:07:00 +0200
X-UD-Smtp-Session: l3s3148p1@S2gwtO5ZrtUujnsh
Date: Wed, 26 Aug 2026 10:07:00 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels
Message-ID: <ao6epMEj9j5BWsWC@ninjato>
References: <20260825203251.2118-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HfL8RjdjS6WtM3uW"
Content-Disposition: inline
In-Reply-To: <20260825203251.2118-2-wsa+renesas@sang-engineering.com>


--HfL8RjdjS6WtM3uW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:31:28PM +0200, Wolfram Sang wrote:
> R-Car Gen5 can make use of it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

As the Sashiko review was not send to the I2C list, I will send a v2
based on a valid comment.


--HfL8RjdjS6WtM3uW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqOnqAACgkQFA3kzBSg
Kbal9g/+I1LURG9UDBdzWoPSsuyI+9DCGn+DDnOwtP5Kk8NbwNEiOZ+0UCbhpZin
5YLvmJcpnfESRnDcfJ/zU/AS5bbMkr1j4FxZ/JTVByrrBMBTzJFTzw3gLsjvoasd
tPqp3tm19ucL7OKjKFUc6dXADSyMvt4MkSviMAmakU3nP6Gti0K9/a1YyHa9gChK
HP2REhv++OeWbG/d487z8z4ezc/+qOFL18D8eoQcSmAujUtPAzDMxrlxCdKxQjat
AjAk2HKAcSS0h4Djyyrj7jyCWdrYARgEPTkg5SXLeo5MYZHvcHSnapbJOKwIyl7X
fZavfeLaYMOwmTqHoeKPuQl3SxNlTxavgKrTF929JPgxThmWAqBLdGxEfU9cAMUS
0S6drAXYENwIM42aBPRvU6NRl7v8d5jg1yzGR/FbPginCKZx4rPTl5micm5afyEM
eGAYde1TOG1xN60MWqILL1630ioMlWQVljg4TsOquP4l828vJkTYKTTeYu+Gl3J0
4yAiMFc2ulnmOM+9VPxy3tKk6vc0ZQKD7EVG63XLaU5jkQaW0/AMCiwwCKEdQ6mx
9VTdR4dSKIFYcSquJb60gNg2ZtuE2DocjnQEe3bLbQIPlNApeGT/jVY4oUDMmr8/
c6M1aZvzAzOWt3RFbuTqf3XirbF02wM4DgbBwzrpdrQZiua4OVk=
=VJyf
-----END PGP SIGNATURE-----

--HfL8RjdjS6WtM3uW--
