Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7C3A450A
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621239; cv=none; b=VneUMEOwIQG3h3824Zl+vIrLheH4aES1ix33AWo4X15zujxbrkOfZSL5wgUE8P1VFYvOyb9WAsC59TRWW1ZnMRGtxDXz146Ub/PCHMDw9h1SbHp9pLDbN99+Nd6n5e/EsBZ76VURuU4EOJaLsmqlFohZn6BXUe6tw0NBd01szNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621239; c=relaxed/simple;
	bh=qEkP6EvZgqPAWYyGozNhbcyrFFsyOM1IyjhBGTK5+9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpL6/Pte/AzF5MQnGP2EPh+wLsjvFtUzTbUX4vSet2lKg36JJjzuK1x+rv7epwmwZWCdeXReqkzxpvYxy9GSXccVuquQT301ax/N0C9IvkymtAqydVFzBvA2plqOufxhpijxMFyuuBhGlJ9tcpALFTvV0LPHh7ZNGmVfgAHwrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gbVyftsg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gbVyftsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=JU4b
	1xuhqzq7jdWkQKanWTwRR1a0T1se45ZjOeNqLXw=; b=gbVyftsg1hhfndvKPh68
	16tZj5E0FOg2hl+66PfyCQNHkRqgXiXYuKXSubdrMJQwkPSW6I1FClbb6LyymboK
	fm2JQybw6gduzVUi9jpgFwOZzG/48kpAzpYqMZBJpZI5FIcF2KUhfMouYFDVKw4q
	Wn4xbrz2reulJQI83Nm32wOQgRj40hebkVXg9pjvORXXmrXKnVBbd3WmXqdU/zpR
	lFOCzEkuaeuioAX8SqxqjPAeY+na2Vk3uoELfuu6hdWWKh1Cdv+RyWCdWyYE8xFH
	019JYpRSWAqFLDI+epCVc45rZXoV/kaU+Zdff7QnpwLhxWtPzzcSMy8vUhhd4sGn
	zA==
Received: (qmail 695206 invoked from network); 4 Mar 2026 11:47:10 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Mar 2026 11:47:10 +0100
X-UD-Smtp-Session: l3s3148p1@Tci9ijBManFtKXG7
Date: Wed, 4 Mar 2026 11:47:09 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Frank Li <Frank.Li@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>
Subject: Re: [PATCH] i2c: i2c-core-base: fix devicetree alias handling
Message-ID: <aagNrTJYj-MdeBRO@shikoro>
References: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4uJeZTSU1o5OHTU"
Content-Disposition: inline
In-Reply-To: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info>


--s4uJeZTSU1o5OHTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas, Bart, all

On Mon, Mar 02, 2026 at 06:04:42PM +0100, Andreas Kemnade wrote:
> Parent device is not set up there, so use the new of_node pointer to
> handle aliases.
>=20
> Fixes: 0ab80451c70f ("i2c: allow setting the parent device and OF node th=
rough the adapter struct")
> Reported-by: Kalle Niemi <kaleposti@gmail.com>
> Closes: https://lore.kernel.org/lkml/EDF3FB58-4747-442E-8463-6F1C6E568962=
@gmail.com/
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Thank you a lot for this fix! I will apply the patch. Plus, I want to
describe what it also made me do.

Bart's patches are in for-current and were planned to be sent to Linus
as an "after -rc1 cleanup". This patch tells me that we are not there
yet and the patch series should have a full cycle in -next, so we (read:
I) have more trust that we didn't overlook side-effects. As a
conclusion, I will move Bart's patch series to for-mergewindow and apply
your patch on top of it.

Bart, I am sorry for the delay it introduces, but I think the smoother
the transition the better. Maybe we can save some time somewhere else?

Happy hacking,

   Wolfram


--s4uJeZTSU1o5OHTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmoDakACgkQFA3kzBSg
KbaKwhAAh7IHhg+lHafQ6oo0oHwFmr4BO3b1XqA4xtCaOGaF/gAHpm1lz3QNHGzX
ZdTUKOkHtIdpJNo7/YWjFwDBpCWSfiiWsdo9IUlIPugCfBGdh3hhAGIjCpXihQL6
nfgn2A202JxaduHEIP+4qG/FtJ3mko96Ohd0aidlY3x0CUYzu+6E2Klb8wizbEG/
tyAos5YB6468gJNyOwawb4Lj9aZSPpwZIvw5k1k8w7GoRdcvkt+1Rf2QZ311Zlvd
SJIZZzaP8GA38Xfu9Q+xfgqOOx7TJeS8GwTOB9Dtc0awHPr1TDPPzvA2Y5mSlQQu
dQk4GKyTu7rhPEvMG+bhwPYfo4vEEVKQbdzx/Gyt6tvtSrzell8k2vt3GAW28pCE
0rOaHgDNeoHajmsu8jAG0kYUew3LXxLprGdPjayCGO+zjqP2gJ1HeUcMtdOU3/PW
o8CRbJD6pnhZzwzToakKze3XJs4ppH2Eqn2/Gb2U26yMtpiy6kMdspijGJAGWpqG
AarRTsOwXUds/99LNCxFQKSHnY0qmLVRpZQDXHmW3rDWt5F5BqZeQ/PtHzv6NtIz
T/1z9u/nAT2jjHpXh5dJ5BUr3Nj5RxkKq3LVRHI/VUCEWN0t8PSgPUp+DwvrsVmg
F/zJu1JJ4t3P/mMNUK+JA4/vD4woRsN83lble6AlhN5P7nv/d8k=
=OcbA
-----END PGP SIGNATURE-----

--s4uJeZTSU1o5OHTU--
