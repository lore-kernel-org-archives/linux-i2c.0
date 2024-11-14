Received: from pokefinder.org (pokefinder.org [135.181.139.117])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F831D86CB
	for <linux-i2c@vger.kernel.org>; Thu, 14 Nov 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577629; cv=none; b=DyqgnfBj6SH1cS+2gWpSDGJwN9HEKKHHA6LU6HFUX6e24odFrqM32S395SSJ37RC3HfR4813/C+ifnKP1pYr3AjrzZNjsulesEbKKQRY76GzcscqfkDU28c7JNix7cqcO2omEUH6k2B9/aUR8149Vufj+uJWr8nGxFg2Yjr0kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577629; c=relaxed/simple;
	bh=ARMOYlN3CeStSj9/nNiXrYZMJB0oV8pq82Vwpa7FnfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INzpH/c17d0Z+zd2wFvIUEjdqlM2I2zhdJthWA3ShxAxQA1MzWHc8eUtCkl/FKzc8nVSvBuc1Fz5eScIeMhSwxrqBg2fkxW2ndQE4wze5efGpg9hySLnGEoUbSg/0SY+kOD/+CCV9LYvC9iFek7SrJ5MY8PQUnqaPTy7M5n85WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de; spf=pass smtp.mailfrom=the-dreams.de; arc=none smtp.client-ip=135.181.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-dreams.de
Received: from localhost (i5E861B47.versanet.de [94.134.27.71])
	by pokefinder.org (Postfix) with ESMTPSA id D6E82A4A9FE;
	Thu, 14 Nov 2024 10:38:34 +0100 (CET)
Date: Thu, 14 Nov 2024 10:38:34 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c@vger.kernel.org
Subject: Re: [GIT PULL] at24 updates for v6.13-rc1
Message-ID: <ZzXFGv8FcblhaiyN@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c@vger.kernel.org
References: <20241106090559.4907-1-bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IKf9N4E/UTEUqMJy"
Content-Disposition: inline
In-Reply-To: <20241106090559.4907-1-bartosz.golaszewski@linaro.org>


--IKf9N4E/UTEUqMJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>=20
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-=
updates-for-v6.13-rc1
>=20
> for you to fetch changes up to 339cb28b9ee6679aea359620b0508170d815a1b1:
>=20
>   eeprom: at24: add ST M24256E Additional Write lockable page support (20=
24-10-22 09:11:30 +0200)

Thanks, pulled!


--IKf9N4E/UTEUqMJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmc1xRkACgkQFA3kzBSg
KbZEYg//foU9SFPRwtft1MF0+lEKYpvc4D/rrnN7cgWEnnNEA2Zz7Q1uh95Xsj93
krKcBK1d98CWPHa6PnOTkHJD1GqeeYPpGcxtkKaUY6NEqMVNm+38CDQlCUDmoSLX
HZ/fdy35IjAMqSOpWKIpari6a4QLMOUNUIbXbXxWEzuJwuwr/PFIcj4RtS1rc5dW
fuCJOCnQc3DQ8E2GFiC5TA8RJdpV6WayTPfj+REhiWkVvn6SmaMB1UivXaMu+Bkb
LoGtVO8U530Ladyk7EJ4jdQqhPL6/8sU9hMOEGNUGnVX7MC0I9JCvTf5DnI6m32G
mNlL1UJIGdFboWiXFKQc3e/HY5iiHr32CJwqSbj3B77lKyYnyci/PWdHrPbs5sCp
lecs3zFn2Dww1DNDaarZ893sR8SEBY194geeeb3MQf8LV+oP2hCYCSE9S5T1MVnn
uzd0xSDOvtRfHXrzdmIDdljQVCut3Nck2WL2Ig9XcQB3hzyDryPI9XQLv7UVUpuZ
mCyE8cTo4bP4w2Fl08p5VavThTcHtSLhgcxsCzoF9atDr1EuYLmcMKa5+r+mimpV
DuA2UIsNJO9BLIlns555zOP7lVT0JtQvEApSmlYoO+Ty6ocyrOZwvMz9J9Eiy2Fm
sUJzwHyNQpNFfWVMT28ByU0VRTjMVV36IX6JkklpN2TS4x0s/Ss=
=wm57
-----END PGP SIGNATURE-----

--IKf9N4E/UTEUqMJy--
