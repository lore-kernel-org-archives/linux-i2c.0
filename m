Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70057421898
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088136; cv=none; b=brP2Ak1nELr3X8BHKFVUKa1cweG8+5400r9Q56JDJnaxxTwRFMQaaeAHcJNUXvCYs2MuAJ6NwMdLoIioOuR3LVojDPu4ZmPmW7fC27JqzFTHr8pcV2EOrjKFjgzNfAj43LI5Zu77t3c0hWHErLMmbHbGMwqcRTZxPxCdFi5sgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088136; c=relaxed/simple;
	bh=22pROvyrbyauGEmWGtCEM7Z+ml7jfG0E3MthRLNx1z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlyJ6SUpBzAgYBmT5VUJSTG9Ybpvr1QXy5u9lrTDN/scR8Jg09xpvbmPaV4XoF82aRxSxzodBXCH5gchiRbLSeT/QhMDseri7caQTST1CUbnM9LU5FwmQWZhGiNy8nlaWyT+PHWqqwDznTJK/d5JcvEdve5OSuD/WbT26SJerg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=B3Hx7PkM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="B3Hx7PkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=22pR
	OvyrbyauGEmWGtCEM7Z+ml7jfG0E3MthRLNx1z8=; b=B3Hx7PkMcw5sBbSL11TI
	T6QpFr2Qryt05JZmwSjHaV5bn6jpkIz7IL0XIozkR6q+8aUJHnbdf/itc6gBMKDw
	DN6jYTIKch9TtfYG0UdR+9tuFk6NragCys+5cVrfZ89YWR2RloVsDziYRVFPyVOq
	45wbuQUfhJ55wwK35BAw3n7TC++vw5Wk2Q5k5wu3oUhG7V8YRmZYThpp4x34pxvh
	VlE5DHUbUpdJDEfRmUw6yw9a7tnveSQ2VeLuudpnajjT4I0zfInSN3+iZW7eUEX0
	FpoMzJTbYAtV90BVGgncLQqWuRaGqvmIGxolOGgMstQNoRCH0sh2+SMAIgXv33yy
	Xg==
Received: (qmail 1539237 invoked from network); 29 May 2026 22:55:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 22:55:32 +0200
X-UD-Smtp-Session: l3s3148p1@XPXDEPtSSDhdnheM
Date: Fri, 29 May 2026 22:55:31 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	wsa@kernel.org, andriy.shevchenko@intel.com,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <ahn9Q-9eHjBSj39h@shikoro>
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com>
 <ahml-rVa2PIA5DDC@shikoro>
 <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4ejUHi/YcaF17bG"
Content-Disposition: inline
In-Reply-To: <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com>


--l4ejUHi/YcaF17bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > In case this goes in via some other tree:
> >
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> I queued the revert in the pinctrl fixes, you can take this one (2/2).

Is there really no dependency on patch 1? I'd feel safer if you'd take
this as well...


--l4ejUHi/YcaF17bG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoZ/T8ACgkQFA3kzBSg
KbbCHxAAqXRED5q+mH4glwASoYgXmAuP5Lw/+qaLUf0mWwPsu2HvhNbHWAatDZpX
19KciZw3pwBTuRnQgrdaqxhiyLoLR9/Grg0t7nW1IuIKYwopHcr0mv4Vxsyce2eX
oXs3TsA6gna5IM0AgLRJLc67GAm3rqedQScCA9DLPno27gWhJqFv8kaM3f/vDrBe
DvmsFdySZp8jRgumB6qwy4eeeFU4G9B0kiosKo7/5aSn+YaT62aIVWPaoG4Vl833
XhCCTdMTOjx3K2bcoem6GYBJ6T2IFOB1Clg3AtRg2+B97xmk4nNx3h89jm75yOW+
mp/KRPiO5GPzsUoD2Is33g1OTLGYO0t++4gFQfYot+M20PX8XjHiMR0PQ7QF+gkx
7e+MxG+edCrq570qGkt6KXi1QDCWKm3MLcjPD9Xp5WLkWUFV7t57MVj1vBYla//S
RjQhFHUw+TR8AW2duLn5iq7VtUoOTNW07vU5urU+iILpMaapH+bgJwrAe646Mx9P
X9Da3vDixRRXRE9tdHUmcK8tJiuYJwkypBbNkdPWVyOlmTTm2o9kqI5PSF3BJsc8
WlLcUsqdRc6zyczlYotXWc3WyHrg+Ao2Zl6edJGHCYqxyqcSA0shL5JpPWLYzltF
fD0FxNaMXf/Z8q0rDjcUTvz4jQpxjY2kRwXukakZbqc+1LK8MEk=
=YeIw
-----END PGP SIGNATURE-----

--l4ejUHi/YcaF17bG--
