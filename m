Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E218872A
	for <linux-i2c@vger.kernel.org>; Sat,  4 Apr 2026 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297044; cv=none; b=n3GX7Tic3CbdGe4nDfnJXIBzhy/vMP+dyFjkXOXMWT7boGkkNFw0cjEk/Djv4FTDh62AlxS4+2xjcxwoJNxW6HB1ZQMjCDhD4+f/l05aJ2F+I+8uj4QjSlotHF3iYvvZQzzcXv4K1LVzzWitWIhN5We36U8DqWd4RjYmQg5Iq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297044; c=relaxed/simple;
	bh=Ex8q/1V1bYKx69c6c/wyQqDZmVCyXLbIUlVEXA7sWqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1dxdqv/zsRX1xGEHWoPIO2d6OXlK5AgPBG/aMAOmo1RjXs4FMdCSQde9vfg8fFRV24Y+m4eW9pkg5EMy2vJia3nykhjBX1EsuNYhVj+Q5T5JYFwOH/c8VcPRRupYMbGyec8bVIU8Flf5u4cUgoFrR6E1uRUTyMZTqs817MmKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L1RdO680; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L1RdO680"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ex8q
	/1V1bYKx69c6c/wyQqDZmVCyXLbIUlVEXA7sWqI=; b=L1RdO6808eoBezqqAm6M
	p+4lZf+K4Gron72LtyGy/digVaicYxWO50nj8rKxClI2VEBkXciUPD0x1YtznMeZ
	dAL47NzK4jQg7PSKSWCCQPSB++xvd+Mf5EKGhWOVaQMEuYfX2xEc7APwmNlCnTem
	7USD22g5yD1sDmGff9ocANxnS0DKdUCFu6k8qLUPez0YC3Z1CZhJ/6ry9dTviPv0
	Ugn3fRfHuPCTxlUHw1gBoPk1P55wPmmk7ZtpqbdUDr1a96U0PFw9ub4uck8Fv+mm
	3/XO04MDoGbtc6x1tnHj0TWatT7A5ZD4OEeEnIQ1En9hG951Q1wil6Dqdq5wttUj
	ig==
Received: (qmail 3189581 invoked from network); 4 Apr 2026 12:03:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Apr 2026 12:03:52 +0200
X-UD-Smtp-Session: l3s3148p1@87TyjJ9OLscujntF
Date: Sat, 4 Apr 2026 12:03:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v7.0-rc7
Message-ID: <adDiBkAMqHlrGcTZ@shikoro>
References: <ac9aokZYJOTAW22a@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SsjT4T7xmRJ0XgYO"
Content-Disposition: inline
In-Reply-To: <ac9aokZYJOTAW22a@zenone.zhora.eu>


--SsjT4T7xmRJ0XgYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026 at 08:21:07AM +0200, Andi Shyti wrote:
> Hi Wolfram,
>=20
> here is the fixes pull request for v7.0-rc7.
>=20
> It contains a small fix to avoid using uninitialized fields
> in dma_slave_config, triggered somewhere deep in the fsl edma
> driver.
>=20
> Thanks and I wish you and all the community a appy Easter,

Same to you, thank you! Pulled.


--SsjT4T7xmRJ0XgYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnQ4gIACgkQFA3kzBSg
KbaxLw/+NNFBhaXnSY2m9PnvScUR09J8CNSajwrIiKOR/PsSeID6vrYQSp1a/FHI
MNLobbhTwD0It1/WuarPgnlYKEzfGSHa7lqM8mUW6bMt+6yIpcx6m+RbLEXA4YOn
QCTf21X/JZV6l0npR3jwWGMuN7vRy0xnnzePcFVwFHtmioZ3Q3wuzD/kYuO6oSmL
5yyIEqaWVEQZaqiFOWbkQ4aZsOEY6GjUlLK+WN9yBH/m4f/NXhuvw01swy33Rbsp
H5n9vW1j6xUgZDT+nt6SVzLsB/r/tqT2nOB8QL2RC87tl1o5jdxpBYPTkBzgJKhg
jF/hnYeQ5JfeHgKmG0M33D+6GtXiZPsdk+MUmw6slA9ra4Cm56jlN4MYznFob/MZ
AYvWZ+oSEDwGOZpIZUPa1QAk/1iq9/2uGW8tkiWHiCreQaoC/RpGrP84PRTHOYF7
LBnQWEUYKgbXFzH2tlhMvBZLWc1S3c7ZtLM0ADzjqAhaWp+WCiKvzhXF4967yh+a
O4cfYGVWg4nxxy7osYZLwW6fXTpzicjchrta4MISIWnuRR5nUxn6Zn1l18Opneab
RVQaLIWspMoArlkGuq8EbfvcpRovEKb8+4iWj5eqeVVs4cFeENM+aF490akzfhy0
bgBAmIhd6ptJoN5DJVp5IW5zJIGH0nMjpabdL6mJ+Bz/0/H2mvQ=
=jLrZ
-----END PGP SIGNATURE-----

--SsjT4T7xmRJ0XgYO--
