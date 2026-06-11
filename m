Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8D284896
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180760; cv=none; b=EJ7hBozGjulddG6yMtRFAFS6ayl7bg12zzYxN++iZjEFPIYFZ8mUjMr7m+QLtd59K9ek71tNljZCzkQh6NCKUId3iWPXsfE7Eihp0ta5uSo/rsXuTxYgwBtbt5iWkWCWPbkFVtvW7vNj2cqD1frfFm4IMBRY+FfZI/rU59e+xPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180760; c=relaxed/simple;
	bh=2y9y5GgH737cWdDW9MOPzFlwCufmt62EGuirBI6tVa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQud1OR0LXxPVWsrezIMHDWhUFAwm2t/wS6aPHi9YuzCyemBeTFTNBJ3sxVDFSdZUeDC1eJYRCVRa68Su/V/x+SCJNQlDQjhwctCTdVnI0/GaCuXHULOl/MCZjNQLpx5zU7Sqk1P0M5dq6y3XVosNDW94tFBqRNVK3868jke9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FrVFXRtf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FrVFXRtf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=2y9y
	5GgH737cWdDW9MOPzFlwCufmt62EGuirBI6tVa8=; b=FrVFXRtfaMutB4+9Zooe
	5rIfgazD6jxPD6iIgrbDoOMck2eUhfkbGNJySY23Mn6RqF6lEjNXU2mQsiS1/GCD
	x1EB6S2qjSzVrjC2nlygz0NOKLkJIIcjW7ClY6qDy6EU4OGuifp02D2FSZhspCVv
	Sd+5Nj4RRyis1An7plixFtHqKwXAokOof6uo1ahCNKmGKBBaeD2M5vSYvXeyoBxa
	l6UgHBzb6Azdgoww6N1zxuztmQwUNd9jYO3BZgvFmL57KQEtj39K2RCHKiczed4A
	DM0wNCsx1XP/Dpamcxb6Giji57c/xYLm46ErAhEo4HJ4bqh5CoNIshj1ksjxcteG
	8Q==
Received: (qmail 2112436 invoked from network); 11 Jun 2026 14:25:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jun 2026 14:25:56 +0200
X-UD-Smtp-Session: l3s3148p1@8s86dvlTQocujnvX
Date: Thu, 11 Jun 2026 14:25:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Peter Korsgaard <peter.korsgaard@barco.com>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: mux-gpio: name correct maintainer
Message-ID: <aiqpU-Mn0HswahCK@shikoro>
References: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VoBUupXxGIIzeo6g"
Content-Disposition: inline
In-Reply-To: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>


--VoBUupXxGIIzeo6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 02:20:53PM +0200, Wolfram Sang wrote:
> The YAML conversion added me as maintainer but I can't recall being
> asked nor do I want to maintain it. Add Peter as maintainer for the
> binding as he is maintainer of the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Peter, are you fine with this change? Sorry, forgot to put this in the
original mail.


--VoBUupXxGIIzeo6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoqqVAACgkQFA3kzBSg
KbY6tQ//SMlt9Gyv95+oCDADCAmnUcqlXOf+u4sBrf3ozvE8C8bH4Boin3Hdqj2y
C7YZzpClemiNycS4JGlpQRnlEJeYAxPvn9u1pTD35AvQ8VFxONGGGjlH1vpWDToq
JLcqpeAVVOddpiXD7N+Sqky6iNY8J9N9Ym23bj/qzcZPQvhYQeppf/Vjwo4JOoJ/
5nn0NSV+8E270XqEUD5oI+/PRcyMEIvQcScjEmo/fSdrOxcWWa99bw8DZOriT8MO
RoxT8scvFQcW4XLQPn9rHtUdNy7HVfpfqFkHW92YffpmSVooXbWeXyl/JBJVnjvb
uBu1ycbT2vk0K29Q+GOsF63khEa6aO1cnbG4Ijb82/SmAvgEd96Bb2QtZo5p4dtc
/xx9b3He6QYjZr6s8bGREntqGuidrEJN2b5uk/qHdB/5u5qGSTL4cpdYLRHveGsB
xHkUm3ZZ58jBCd4Rt/KAJ54uUTQAhfHcA8ikFHRK9EnrqUFGBiDiH5+TqH3y1h8P
jl8MdeWlArp8dkaJuDACxAekQwZN+cce/cBRh3W5xNbVne062GfO0c4DvZdGOWdR
kNULfbBpCHmkmyPzBHMAQHQQz/nTgZ/3R8Yl/sS/xsws3NH3/XpkJZIQhIEJV2ug
A8MJvWWVvC30jKvBzQgL0PQ1Gq2axuxlSzzCWrIT/y2IEMWzi+E=
=k40F
-----END PGP SIGNATURE-----

--VoBUupXxGIIzeo6g--
