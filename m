Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6F2F691F
	for <linux-i2c@vger.kernel.org>; Tue, 14 Apr 2026 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197329; cv=none; b=hchi4/gW7iTGm5/swZXX2PHWbpJNlEmCWeK3ecAcAvfwuyHGTFoh5FJ724FYNrxEFwIS2qNzJUKzMuHU25JoZS7/yQYeF0C2R7M3hILPRn3473Q0wtsNgzdeMP1MlCd+vxNaaLbt6ggiJ5OxJoWC4rdfiTTzvu9vSCwhr4dRPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197329; c=relaxed/simple;
	bh=I7ckvsBwkTAIJSHRta54E6Fgi2DZDKFXCZ9MXymJEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTtMC0cPI0IyOz2JVyeGq59B4F6U1o2szbg0oh7v9Qa1fLJSNvvsOQFxeY+Fi6J/HGG58ebVSlHmVdLYCAlz2YUF1aFoRpu2tO1K2PCfiKU4+O1QmpQ6UWxyURDsuBxQM6gfCVA92Tl06pAYy9vxv5uAgDmi3S9NPONvNXcqCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Hqfe3hLM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Hqfe3hLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bOaI
	T6l+b15ZMrY0rU9MjHSDNQsfrgbR2GN2HY2vz2c=; b=Hqfe3hLMPcqQ5EUejA0E
	2nEr2ZFKh7Lpn9y91dq+X5ujrI+rFUNWYlBGNHjJubozNrTItmjlW6VnGt0ICdhR
	6IPl3LhoQeeNMzL5CIpXZNC1Lz5GW8zQUXTd2AycrcAjcarQzhcgXevx0HYoc+rE
	3DCfZDumg9KTyf1aUSTmA7ZEYyJPluBVrA7LC4h/gcdyumbOW4XiHbtTjZ4Vvgas
	PlIMtSOnFqxWGZ5SOCKzexwVLpddlH4CnJT4z1XDFhKv4b1MqDMRhN7hvaex3Tg3
	i1V4AFCDXSAEpx2gbOhCurNW8kYVupivd10aE9sduObWGtzixkkkr+O/i61n693M
	/w==
Received: (qmail 2852596 invoked from network); 14 Apr 2026 22:08:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Apr 2026 22:08:45 +0200
X-UD-Smtp-Session: l3s3148p1@JrOXKnFPnJUujntG
Date: Tue, 14 Apr 2026 22:08:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [GIT PULL] rust-i2c-next for v8.0
Message-ID: <ad6ezNsXbwpBdSNP@shikoro>
References: <3f459ba1-3d03-4c44-a8f1-5ec939f9c0e5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fs+a+gNcpaP0ao3w"
Content-Disposition: inline
In-Reply-To: <3f459ba1-3d03-4c44-a8f1-5ec939f9c0e5@linux.dev>


--fs+a+gNcpaP0ao3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Igor,

> As discussed, here's the first pull request from rust-i2c subsystem tree

Thanks! Because of dependencies, I will only include it in my second
pull request to Linus. Please wait a little.

For the next pull request, please use the latest -rc at that time, and
not my i2c/for-next.

Also, the next Linux version is 7.1, not 8.0 ;)

Happy hacking,

   Wolfram


--fs+a+gNcpaP0ao3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnenswACgkQFA3kzBSg
KbaBIhAAgZSQ4A39GJEm3gn5uWCXnTCB7zJtD7AhjiDjQ79VlBZPVfKuLqusxvkN
vmkvB503Vnv6tIWP4Lc/T42lOu7Nhz8/oUtAWIks4Uuv+R2lbuytuB4990ynrfgG
LwjkodB76Rx72WtLVj9ii9/i9ctWkTe0v6kMKKloG5qCrOlxIODAIhWQxGnrSenq
2KC/yuMLGvqVpuaDf46jSmGDYXbfbJq6ToO4BiB4wxzQ2uqQ44R0phpZ1WuBtHlD
YYzeeFLk0S5TrJdHmh9IVs7YRLZoKoZxCfWmUbX9O0LRlqUzfcJuAEWtk+tbzQAo
tD0SHxbTzDe6gYWMdD8WLfvBPDyWeAUOrm3OdHLxJVuG5j34XLkpcPIZbBUSzgj4
jLA2UIekg8yqcOfxhi5jihE6S2XAi0WWbG+SKOMFvg1dGcp4fx4EkI3oSw5exIyu
xKA64pIKAHnXYQT9msBnUxZpKXVD2hv9U+7t3xGcmEKJpI+pM9zbJyPsdTvAolh3
yCNIxNaPz/wYpZwNHmc7SeiVnmRESlHvbaJltFpe1RYn/LycPrzk7pOoD9UrUcRb
tmgxE9MNYd0blsOvtGfViaohsR8jSnvXkibqt0aOJnWqF+Xmn9DIvqbCesP4VIZs
eeqNKAe7Zf0zWGLcl5pgRn+f0ZxwzjC6tDKdjpXQTHWn6DtbHFw=
=qwYk
-----END PGP SIGNATURE-----

--fs+a+gNcpaP0ao3w--
