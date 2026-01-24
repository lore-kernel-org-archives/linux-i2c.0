Received: from pokefinder.org (pokefinder.org [135.181.139.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DA27A122
	for <linux-i2c@vger.kernel.org>; Sat, 24 Jan 2026 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769256354; cv=none; b=KToSDLSoFRYr/A4zVmwerI0s1Nlgb7kKBuL7HhxBeoip8xWJ/K9ysW5exONkm9Ok6XcJlGlGYOBnQXjdUy8kTCkZsrtqhI81mTNHVL4/E//TP+DWJdiMpGX8QS8u/KbcidSZukgAlVSR99qfiObcyweq9T6psH2XLlozCH5LubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769256354; c=relaxed/simple;
	bh=FWf66aSVp0MYHkEa8Uhb+KVB7/HmC9IZ2NdStc6Y0mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rodnI2gOViNZ8uvdzt9qXwh4SG75GL6GTwuDiWm/H11axBeXG2+SHNp3MeVO4jD2f8yyK6hft247moEmRH1ngyLgFHGuZs2Kma22U8LPuJiKeK3Erf9CQORLtaIBV3G2PLhhI7WuKnmD5p4SrrTdAQ0KELfTSq2uPCAUE9MIyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de; spf=pass smtp.mailfrom=the-dreams.de; arc=none smtp.client-ip=135.181.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-dreams.de
Received: from localhost (186-123-142-46.pool.kielnet.net [46.142.123.186])
	by pokefinder.org (Postfix) with UTF8SMTPSA id B2278C0274A;
	Sat, 24 Jan 2026 12:59:09 +0100 (CET)
Date: Sat, 24 Jan 2026 12:59:07 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org
Subject: Re: [GIT PULL] at24 updates for v7.0-rc1
Message-ID: <aXS0C-L433PvS7pO@ninjato>
References: <20260121095509.16678-1-bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aMpjZrXuCn9POHXq"
Content-Disposition: inline
In-Reply-To: <20260121095509.16678-1-bartosz.golaszewski@linaro.org>


--aMpjZrXuCn9POHXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Please pull the following set of at24 updates for the v7.0 cycle.

Thank you, pulled!


--aMpjZrXuCn9POHXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAml0tAsACgkQFA3kzBSg
Kbb7Yw/+IqZK49z84rrrlSBJ6f4WA/LlrEoooh9dd2YdCrbRA7bpKqEmW72KqzXY
PTdlcGdgkg4Qh8z1u/9lwox7730Ft9tLKvfaLMXyWEgPHP8yXNPxkf1FeLCXXrCI
0xdoWOJY0gF86DdqLXl4WETDE6CtiHbXAScS5KgEiSv0vN6DeCcABodA2TZrEUNU
GYFDFuoJoxedEZeQ0SOCCKCi2jLSFtsPKQKSHa1EK0YZ9bF7JU0eAWfaG5J1XMJd
iIkQojxh5V3izDXlV1VOn+LoZ6L5aMtDAT+daS/Ac2++zhMxTA4rA8f9qTS4dAIU
ZJDKkq/4Ibh2sPMLXse3FoayCWiM4dvk2NbSVlgX0fepo92SSXH8CxwxMWjkJTDM
lpqpNHHddRWiwi+oYsTrq0yqWPAZJbdhSX3idFH3eaeVRva8XZylVM2hHX7Qki98
Uq+3NZZj4nDF/Rtxt/5TwaGICdrPpsamNgICxDZvF5hb0Hc3PbENqTusGmn2DLwS
bP5n0KNQyqI5mvNW+vZTRkpfnHGtJF3zmEaqyYvFkL6gr+gIvuYmzC1nADxmSO1a
YYjP8meYPP6Nwt3WANjul6zKOwYMS4lt0ny7PV24+Z1o6IdAfH6xNvIuh44386XX
o4hLNGH8q+akU2bbK7pOx6sDxoeCIUBw9p5dqGifO5m8sW+S/Ww=
=8d1l
-----END PGP SIGNATURE-----

--aMpjZrXuCn9POHXq--
