From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: remove unneeded assignments
Date: Thu, 3 Dec 2015 21:37:34 +0100
Message-ID: <20151203203734.GA8509@katana>
References: <1448890989-32733-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35947 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbbLCUhk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Dec 2015 15:37:40 -0500
Content-Disposition: inline
In-Reply-To: <1448890989-32733-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Christian Fetzer <fetzer.ch@gmail.com>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 02:43:09PM +0100, Wolfram Sang wrote:
> smatch rightfully says:
> drivers/i2c/busses/i2c-piix4.c:504 piix4_access warn: unused return: i =
=3D inb_p()
> drivers/i2c/busses/i2c-piix4.c:537 piix4_access warn: unused return: i =
=3D inb_p()
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYKgOAAoJEBQN5MwUoCm2tegQAJNnATz0p9xUbdui9fP3bGO0
tlL9qbZiyudT5O+tcUzFhoktPuRtOXXmrJNjDyyvSIwNvNozepGVkeHzvlDQGVOn
tG3zv35hu3Gh2COEv7vB/XkAQxbVrv6ziSv3N3sOO0bByKdezY8jBFG62YWiioQn
F/W2x5JhqnCvB83w2iXqRBzszM7Cc1CW/oPiG0jlbf60I50aFC5iDHEdD9FYFZj0
Fom2vNAHjh8KSsAZ0VleRCiu+ZAi8S26bAGulSPRUKGreE5JL8hfeEI0OedA/4iP
Bw5zlQC2xd9tDGpx0A8Ut9wvqzlX1WN4IAOifKSHeCtrRsy9Kaa8TLCfFNTcNMe+
uoJKaW3mU4P/Ha60fYdE2hQAXJ2Zvny6T+RuRdguvq1yNa+8HAbL5Q7Fn5yRBO3B
e02qHlKlvl6Lc+5tj724mnSs0rEuf5J+Fo9/I5OYuhYMMyrmJFT6n/IsgTShdRoB
IE9MyuNOk+OEDawdQ8FkpaYdONV5NW2+qoO62LRP4dJoftkgKZxipzgUp3F8+JQD
jJzrbbOnmsUinV9Z8bp2UKZ93NrtcGsyy/TsdAtEVlVgFuMXZ+Mb/NIOuAz/k+oI
k2EClqg/BOTuqvwXsr1Q+mp1sfuuK7V8EqnYNYSbPc1PkELRVB+xcQKXWwlrWqOl
RUygStty/FrCSDzBF6QV
=+dJe
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
