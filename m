Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D95233937
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147513; cv=none; b=BqQAnd1hLkQjYvmJondM8RohWLTCj3MjHwcvf5Vbo9t0Nd55SlImsm/AhHtlT0l1JbNVeR46qIiFQ4N0qvP/M9OS7nUQQfRt3W2JnVG1d8tzsHVZjGez+XFMgviHZeL6i6VVKoBOYRKdqhpOW6kkKWiXR1vzdfHHod7kKaKlvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147513; c=relaxed/simple;
	bh=otl8K0U5UzxX+DRTgztNdQpHXVFEWBHXAGHuMog986c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7wThOJBZ/RsRrt8OWgNE6VnczfaMaQm0LCkT9le1szLDlX6k/h37iM2+6zGBGLxjL63RyD/OT83k1y9t1LyDDzNmSG+WNGTWdB8egHBQ/rtUc9CtjQvQWjBN5T1s0VvVRCTXYmRq9POgHzyGrxzZ5H2lODk7myET+aUTkaqKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fOu6S4w5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fOu6S4w5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=otl8
	K0U5UzxX+DRTgztNdQpHXVFEWBHXAGHuMog986c=; b=fOu6S4w5YoZFb18cqrSI
	dxUj+BB8kztO3JE2Pf+PeCaLeme8qkrtvLVwvbWeZEdLaa8MVZtZCrmDy6cOXU8k
	U7j0UakljZpo5rGmYjimJh/E8ll2vkXJY0RHZxvbGM5cwtwbrfGA56WIRT4HpVWz
	PLpWnkytsQzlvBCOatVHI8jyUyWn/I7Fw+RdPAZSUZsV7Mh5bjsebRBVTGlztTPa
	voR/9wbeaqoZ622UBQC3jMKfPiSG8hJHWN47nMYX0gmPvukMdopco4pn3RijFA/2
	DQXOCfrHSz1eyxTLtK0Zxo1ROUyPSjkTWabIUwNieaWJgGVelFF7gEiTRUas8Z8d
	yQ==
Received: (qmail 806259 invoked from network); 15 Jul 2026 22:31:44 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jul 2026 22:31:44 +0200
X-UD-Smtp-Session: l3s3148p1@G748NqxWLpYujntW
Date: Wed, 15 Jul 2026 22:31:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andi.shyti@kernel.org, linusw@kernel.org, brgl@kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] i2c: algo: bit: Allow to skip bit test
Message-ID: <alfuMKlJqXD-YEMb@ninjato>
References: <20260714162915.3018703-1-markus.stockhausen@gmx.de>
 <20260714162915.3018703-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyHZ2W+MoS+ded/S"
Content-Disposition: inline
In-Reply-To: <20260714162915.3018703-2-markus.stockhausen@gmx.de>


--pyHZ2W+MoS+ded/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 06:29:14PM +0200, Markus Stockhausen wrote:
> An I2C bus can make use of shared resources. E.g. two GPIO based buses
> that share a single SCL line. To synchronize access to the bus the driver
> might use locking with the help of i2c_lock_operations(). While this
> works for normal transfers it is not available during initialization.
>=20
> Especially if i2c-algo-bit module is loaded with parameter bit_test
> it will issue some basic sanity checks that will access the bus without
> locking. This might interfere badly with concurrent transfers. Even
> if these are well synchronized via locks.
>=20
> Allow the consumer of an algorithm to override if the bit_test is allowed
> or not. For this add a new boolean attribute named skip_bit_test to
> i2c_algo_bit_data. If set the test is not run.
>=20
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--pyHZ2W+MoS+ded/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpX7iwACgkQFA3kzBSg
KbYB0hAAk/GR1vDzxCyAXQtaN9S5KYGxgV0RQg8ySrf/o4bsqKCFtoPcMlgdpeGR
amdOmQXmt99avgueWGuvModfr+jTPZ8rcRbDdOfwfkQufCMsFN1JG1tAmHhB1mwG
BWtVcldSJ9Mz5cQZvke8w1G/WqxRPhvH7DguNpnLiD0WG/O/W0/ECJGCq2dUnNY9
jxJ5y4IF1E+QVmp6F2ySMrFLZKAIpI1M3q72rvKSZdu3rzVD6JeBkiP1Ss6QmapJ
qr5Ncw4tRbmD2VJmTIpF0V7WJ5dOSbnaM9pemBWBtQrbyMQR1O+ysB74YNahTm4P
/Et6huUtSwOunZP6/LiVIueEJVk9+5+A0jgEJpaKEpOKrHjunjQYb5Laaqu43s/e
VIwNaBzddIggFRbDxF9EGYElrgQJqO6oPMb6IibXOOoHQzThyjlUUuDtIwsPkU08
oT++K9HaDL4xbzkRJIg3FUtsEMGBCaoItWQLkBvGOncIW0P0u1M0c5AMA2hGWLZm
eoZ8/jk2bHRWYLjWNp3QL3Msa7FU8yMdmHr3sB9YjOPjkJ9Qwpk6g9fkboeIg/0Z
6pp58pHEnd/lz19OFkBoOrsWn0Gy2K4qA94KteE1mdzaM/uOu58hECIeaH1oAPja
Wc1F5ih1a4lz90HbTNFi994Zd1Hf4YHej9niVa0ssq3dAPaBmWw=
=bj6/
-----END PGP SIGNATURE-----

--pyHZ2W+MoS+ded/S--
