Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304635F184
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455932; cv=none; b=ulcO9XykI6WlLVZDCl1xcmbYVi029AcyyJm5UqASfo892E14+zEy6RRwmDhMCyfhPl2dsU8dFYrwEPiS2AqLqJ75Zq/rQt+7BZmv6BPR2EGO0oKKzL3ht/EeQ1XSsjxpQJcCtJo7AL/SmbA71kSCQSyRQ6up1TtQUCP8Jtrz44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455932; c=relaxed/simple;
	bh=mNDOh1ducxV6hVZlIe4i4jtO9qH/Gg/v4DAYUhy1TfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muY9Htfo6pEUO2PDXneA7JKilqJYvOIsUzM7hAUDackGEteSaCJqoRB+M5w1GYMjklJcnpsRfedw4BxgPvkVqxHsNXReIbOfAfjfIW+F3awfgh8tu6EyrfhzWMihHm/g22273PIU2SsZtVfGkJbtAZQgv4XZwU0ojE7dPs0VCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bLtJkN/H; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bLtJkN/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mNDO
	h1ducxV6hVZlIe4i4jtO9qH/Gg/v4DAYUhy1TfU=; b=bLtJkN/HClFl+Xl5iclX
	YOfCL8/eEmYIaoILLE6BN6D5NdmPwHEKQy6yx3r6MImXCWfo1m+qDYcfxExNaT5u
	evu4pBttlQ7CI7xoEqUCjbqKSuIQm3iapwq07jFU58Wyydkwhdsl6GfA05ujpOWr
	acYUraw2qm/iDCB69MNjLHlU+wneaoZEVRjPr0qDRxam73zxJuMtqcv6ejZE/1hg
	AC9Sxq4cvGY3v2AlTmy/hL+K3P466EEJ3K5SQP31HW7U41JnRHd1Lfcb65DKiLJ0
	/PlkahTXvFBW4+Mh8WqL2LtExu4fuqTi6QGRvdE1ki5Ufmuavmlxn0G51zt/h8H6
	TQ==
Received: (qmail 412644 invoked from network); 7 Jul 2026 22:25:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2026 22:25:24 +0200
X-UD-Smtp-Session: l3s3148p1@+s7YMAtWHIxQT+F6
Date: Tue, 7 Jul 2026 22:25:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-tools: Enable cross compilation
Message-ID: <ak1gs4ayKKvSbRLE@shikoro>
References: <20260706-cross-compile-v1-1-e3ebdd485ce6@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tHRtVtplnY9LbHBE"
Content-Disposition: inline
In-Reply-To: <20260706-cross-compile-v1-1-e3ebdd485ce6@brighamcampbell.com>


--tHRtVtplnY9LbHBE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 02:02:39AM -0600, Brigham Campbell wrote:
> Currently, the Makefile fails to change CC, AR, and STRIP variables from
> their default values[^1] because it uses the conditional variable
> assignment operator. The Makefile also doesn't allow for cross
> compilation without modification.
>=20
> Modify the Makefile to use unconditional assignment and allow the user
> to cross compile the software via the CROSS_COMPILE variable.
>=20
> [^1]: https://www.gnu.org/software/make/manual/html_node/Implicit-Variabl=
es.html
>=20
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>

Applied, thanks!


--tHRtVtplnY9LbHBE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpNYK8ACgkQFA3kzBSg
KbZ+9w//QywyBUYQN74xEuWOjOpYCFPvydSsJ1nFDjzOrhNhIiPEsXX+sdaOuG9F
W+KAhOX4JNj0wIqOywCMcFmmJNQu73OHF3lIYs9Xdg1sxwBqoWeecO1dAMODHsQh
pfIlJBQLFjxuP9fCXCxnIDW9KqFbHqOJI252kAIpjV+Pu+Kt9fowKhAhjLzAdpe8
9+y3k2IaC2aFNM6TeFIcb0L5rjp6HFzZuG+ARY/mKUMVt+160M3L2+1EzzP8Duv/
Cnoa7N741Xg91UH/xC7XZ7GYT+fgov9+sdHFzytMcxdnOwcQMiFW1VEmO8+dR0p0
4Ssx2P7FczkUw82OIGxGkihWCX4YqI++Crh95h/iXq8NsbKBT/mD7zXxIku6Rz2c
Jc2V3NNQcJE2h6Kuut1Dgi7hk5bpuofjBqqcRXQME90LI94X9FUm7j64XH41Ce+K
r2cW+Wk83OsdkOl4Yumo8Ay4F/voWvgDhwQDWOeFcMxu/H97Dj3MeLDp/4kzjQA5
1ylu16JaJfwqP5NWoWNSoMJtzCX113ka7o76adGTizswJz6TXJ9VesQMZQ1AQ892
8zMM01lpt1VXgrO/beA4BBTY6ReJNXO/ee62LO/swA4IotTov4J07urvHFCmmnHx
+7TNZkz+7yCgQVQ3qz3Ua7fhRXrbDq1ebnQ+b3LZriqk1NmaPJU=
=KwIq
-----END PGP SIGNATURE-----

--tHRtVtplnY9LbHBE--
