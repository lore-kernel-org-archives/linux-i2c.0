Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408C3E316D
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521902; cv=none; b=upogzXu/VHdltUmiMn+KyA2JndwVkTNH6B2Mew1Ed3cGqAwdF6ry8YQ8HQOwR9ZPIFE1v9bwq9PO0+tE1o/cru/cU4binnOqJYIfUXfy9EJ3CcH/iNT9RZYlp0Airvdp6nz1SQegheOENGcqpAJ8/WRPBZFQz/1JFoJKyHbxJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521902; c=relaxed/simple;
	bh=6FH+xx6Z7YPdj2RrLpbKFD4oGi7nrYVvErb7BKuKDds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEOQ35Rdyl8fFALXtUcHgdCDvqOiPzX1BelSW/KmHIeA+209NoclM0D2W6DDCh6jyKXrpLbmPMrqT1G7AXvfR4+7tu5tXJVLuekbD83CZFEGqG3d89bgwuAfekQoLx7DIhjB653H8lux8/I7MA5YkgpngHdQ7hqIOxPP9v2Z3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=B1bDwx8F; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="B1bDwx8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6FH+
	xx6Z7YPdj2RrLpbKFD4oGi7nrYVvErb7BKuKDds=; b=B1bDwx8FrlnximT1BR2Y
	TvJIHZBSYaCGeAcFmDWWO2c1ZGnupT1Bbijrz0APANzn0vhd8IOXGO5u7mO2C932
	Z6xxFGLbxwbapLSguCzmqlij5YCMAURyTufpn1xmJXOb2ZAEj0BkitWps2UsnAus
	2OFbtvk6lkGKBnVk6qGjYnHkoif5uf1NZqfObHIZodozZv0fz4iQp6wKwY6adCzl
	3HIc+VlV6LlYklY0hEwJl4/iRhBVxWT50RmmzAsotCFMgfmvwLgE9OA7RLhw1y4m
	SmxbYaP0W7xMeJfi9OHni4nyM37rPOYS+LuKdXGc8qs9jiyQ28P4ubiuLFgsCENz
	tg==
Received: (qmail 3514068 invoked from network); 15 Jun 2026 13:11:29 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jun 2026 13:11:29 +0200
X-UD-Smtp-Session: l3s3148p1@Wrxh40hUOLsujntF
Date: Mon, 15 Jun 2026 13:11:29 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Hardik Prakash <hardikprakash.official@gmail.com>,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	wsa@kernel.org, mario.limonciello@amd.com, brgl@bgdev.pl,
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
Message-ID: <ai_d4eIId8Ml9g7I@ninjato>
References: <20260610083701.18663-1-hardikprakash.official@gmail.com>
 <ai8jhK9hUGHpojB5@zenone.zhora.eu>
 <ai_PwNWnMZB01AYU@ashevche-desk.local>
 <ai_cAd41W3iX1ic-@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3wNYid5tlrNlIDZ"
Content-Disposition: inline
In-Reply-To: <ai_cAd41W3iX1ic-@zenone.zhora.eu>


--t3wNYid5tlrNlIDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > $ git tag --contains ef76a3a28c79b6288
> > next-20260601
> > next-20260602
> > next-20260603
> > next-20260604
> > next-20260605
> > next-20260608
> > next-20260609
> > next-20260610
> > next-20260611
>=20
> Yes, but I'm not finding out how it got there. I only see it in
> one of Wolfram's branches, but I don't think it came in that way.

IIRC I asked Linus Walleij to handle this via the GPIO tree because the
proper fix landed there and the I2C addition was a mere cleanup from a
previous attempt to fix the issue.


--t3wNYid5tlrNlIDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmov3eEACgkQFA3kzBSg
KbbEUw/+KttoUvU/VSVAEAZrdXls61HpaewzkGZG5CK+qIAzDVeBHSzr5TlfOlbn
/cdqaWcFt9AkVvkT+Xg2yd3Cv+I5KOJePiMbNkFAeEfUJGCgpA1QUb5Pn9WYG6lm
pCedUZCTQ5GN55wOUW2vgpls9utrSAcmWvO+Db+XcNAlIOJkdpdye1Th0T475j1I
PXcUTpfFV0vzQFsoyTVxZ+LlC3c9JS6Pry+LkCMJV4jVjnWfGlJx4P+Vw4O6L3xH
14MA6pVRcoUA5v9VcPBtEBg8RmoCAmMKxon9Gue6z73D+LnaFhA+XtVywDtqa67k
F84zATe8STszZkyLnHV/Qkom6FLs8ARnMzOSwqA8Kc+loUIaBjYZRt3lypNob87N
LzHXDsS93RBstxmE5PEywE4vN88LY8e87+TL2sQhpTe64mVnypdVwOKsu6hl6IJV
kjn2O2OAs0BES8FxKDfd1kXiQl8VdUUEuhlsT2Mq/bAMaLMuC8Ax5H9pUc1riOwa
eA2O7kcB6pfETs95UN1OV/Cf5GDtV7SqpU+bUzfsl5SIaYk4feZc1CapbLi/FRZ2
4Xc1UCQav7laON1uIXT1Gf+ztCSHnxtfxzKKM90NdA2UBHwj/YDLqmqvrQrqAxxv
xAriVjCsE/U2MuTcl8mWY4cCiO0CHP4l39OOAz7n3CFJXedjgRs=
=L9NH
-----END PGP SIGNATURE-----

--t3wNYid5tlrNlIDZ--
