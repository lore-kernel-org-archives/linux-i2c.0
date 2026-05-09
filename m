Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389739C00A
	for <linux-i2c@vger.kernel.org>; Sat,  9 May 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348318; cv=none; b=f7EI/6gBUQpFH9vAeXB05bbsJuOrLamFRzOzzVNi8kdk7w57zBqLLqT2dNtnr3jQ04ZseWRJFSCVDvPcsIzeiS6V7KyyjQeOqQYiKIrHOqDHWPyYOul5X8Gu/KytaomUFXMYi64fTcPidjKMmXrNZrnUSGOkfnmJAqsPLr9X6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348318; c=relaxed/simple;
	bh=0khjZc+XOwNMjU9EhWRQhRfQNlmHmvpGMM+R+gtbdOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2EETRkxXUgukbEWWjUa+46mEsq9r55m4tuOBs32lQqHnvV/fjN68YqZcxv4+tvlQ/DtBn2vP+gyBFWLjDllSjiRw6u9RZJr8EVaarlxIDLq3xPZQbXxVcML6N7kRfaZmLp4G5mT4ygoVhDpQWoenjuH+MGJOEs4hZPVyXn+Uxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YCWPaZHL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YCWPaZHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=R2xN
	qNGfWLH9PqV5wVQCL5SN1QFI3soJpVVRu5Xk5EI=; b=YCWPaZHLbZDTsAac2wYq
	myiqH85FHAafK2QyZnf6NWN+8rSdppgZIYEtBjKQvEOdH/xmqJp1vQN9lBFW0NvC
	ash5EHmyiqjrpqVSClBmrWzliVe1NPmuLsRVT85/NIJ1kY0pIUTwPUEook9N1A1y
	EsBs762NFD37su/+iMuRwc92EJ979l/7Dhk+USw7lnHgOSXxxOxUACkK+3NPKbOt
	jALXWJ/nf5fgRay0YGgKMf8+cbSIYPekn63UkD2LS/TjeRb3qqDOXNiYgZszJaH2
	yriUhJgFWWGRNYOsZ09QgujRJ3QVTo+r5gYTXo/rQNqJeWAkcso1FNPKEApbrlC/
	GQ==
Received: (qmail 1945392 invoked from network); 9 May 2026 19:38:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 May 2026 19:38:34 +0200
X-UD-Smtp-Session: l3s3148p1@GTeT+2VR3rMujnuR
Date: Sat, 9 May 2026 19:38:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: markus.stockhausen@gmx.de, Bartosz Golaszewski <brgl@kernel.org>
Cc: 'Rob Herring' <robh@kernel.org>, andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
Message-ID: <af9xGlIWG_OmREzX@shikoro>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
 <20260507181711.2696783-2-markus.stockhausen@gmx.de>
 <20260508131830.GA1135235-robh@kernel.org>
 <007a01dcdef9$05ba7140$112f53c0$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B28HZTA58SX2mp1F"
Content-Disposition: inline
In-Reply-To: <007a01dcdef9$05ba7140$112f53c0$@gmx.de>


--B28HZTA58SX2mp1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

> Thats what I broke my head about the most. From testing and
> my little knowledge I came to the conclusion=20
>=20
> - two native i2c-gpio based busses can not share the same SCL
> - so mux infrastructure cannot build on top of that
>=20
> But maybe some I2C expert can advise.

I am not sure i2c-mux is the right approach here. Because every SDA is
already wired, there is no need to select/deselect something. It is only
that SCL is shared, right?

Now, the GPIO subsystem since recently allows for shared GPIOs[1]. This
sounds like the proper approach to me. Sadly, I can't help much because
I have not used this API so far. So, it seems you rather need a GPIO
expert... CCing Bart.

@Bart: is it possible to share a GPIO so that multiple i2c-gpio
instances can use the same GPIO as SCL? Use case is explained in the
cover letter[2].

Happy hacking,

   Wolfram


[1] https://lwn.net/Articles/1044022/
[2] https://lore.kernel.org/r/20260507181711.2696783-1-markus.stockhausen@g=
mx.de

--B28HZTA58SX2mp1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn/cRYACgkQFA3kzBSg
KbYivw//SUwNEYSL1ZPH8XJdZjgNLgwbwZjco1KVWtDyrCexHYsxyc0peA+zhC+j
nvBZpT07ONk86aHZGKdvJfbOuejLIiZuh3/w9tgztTIHneM6Uj9jJJkFTIRi6EGr
NcjC1PpoX6mZsr3iZS0xpUYaywCR8EJmmz51o8LquVGGxzCyFNW9gHKL9miNL0wj
wkABNHMojqFIsTcfp20cI27cMGznWpOdfMn+xnwO1Pxq/Jg9Yqpg70OPZBOPoY5c
BoMnTSyglsQOgJYbriDi8JLzKykDkA3QFtTuxHsUqwsu3XublLYPrDAEwptKpHHW
EBhheoYx+opH1EY4cEj2khjFl4/iTISlK3VmS30sJwgqPxeiyuX0IBIuvfIn7k0+
XbWSUFXASWTPa5UySwL/qtxo+wITGp3ZhVQvOfqYyVvoC062fSwgPeLpe30GlvTW
1gWd+00hmozXmkWg3YwVLEU3ryPsePBmVtw/L0f7tPDYxubpJeJ9+POc+yJlMEw3
PJtzcgVnP/JozN0nMxjfpEqxu9H2fASaxgxGtEMrI7CN2c6XI57/vQ1e6FFlADKQ
ldd9/SX/YXLirWFOg9PLAg9d0NXawPYijzzqyn+a3BQtBjS/hVFEpefIqtleiw22
SyIiEIRMKs+P1rlz90Bna5TN3NhxYwqae6O9yTYIGJjskH+7Euk=
=YRdt
-----END PGP SIGNATURE-----

--B28HZTA58SX2mp1F--
