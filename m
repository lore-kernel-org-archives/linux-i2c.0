From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rk3x: init module as subsys call
Date: Tue, 5 Jan 2016 11:01:10 +0100
Message-ID: <20160105100110.GB1525@katana>
References: <1451962938-17398-1-git-send-email-jay.xu@rock-chips.com>
 <2513923.8oltbpbAin@phil>
 <568B73E8.3010901@rock-chips.com>
 <7893052.zgDX0r4i77@phil>
 <568B837B.50607@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45455 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbcAEKBV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jan 2016 05:01:21 -0500
Content-Disposition: inline
In-Reply-To: <568B837B.50607@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Huang, Tao" <huangtao@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, "jianqun.xu" <jay.xu@rock-chips.com>, wdc@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Tomeu from Collabora is working on some better scheme to optimize devic=
e=20
> > probing order but it looks like this may be a bit off still.

=2E..

> I don't just talk about touch screen driver, most i2c device driver such
> as input sensor/camera/rtc/battery will suffer. So people will see their
> drivers do not work or slow down on rk3368 platform :(

I totally agree that the current situation is not ideal. This is why it
has to be *properly fixed* and not workarounded (which caused other side
effects in the past). If you care about it, then please help Tomeu with
his patchset.


--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWi5RmAAoJEBQN5MwUoCm2/A0P/0s9poGVcsDXgSK3Mv0j8pcG
QCxjtTPFwpS300AiydHUZ6tmwUDyQ0IQ8uH8C6tCYDtXY/aO8YqDFIqqgvvtbuQJ
QEdbh5pjtNBy5GLZKgO2E4ZxcewIgozNou0FpANGBYftLs7ardW2NfhA8fLldCLL
QSlQ3WesC/4QxnSBVhYqfaV0SBfmlpNNYXXNf+pbeHNMDy/5iY9we2O+9fISvKS4
g03076OPoeGJxHZsw9WfNLvMechUQzpSrniZJ9+RQ/scxt5KHyPTBwoGe4Y/Wb0n
ZDl3zccKThMv9kBYNHBjDbVGd1+E9PWdo4xT6G/JB38rO3wyCVKTX5C/ssMvEtPk
7qqd8NNuHIvCLOtY56jStymkt8u9DRKBRxdlTLz46aaXzovBidnPP8WeBCZtaLcP
PgkRLE1DGuGMgDd2s45svxusgqCXhkZUektgcJrC0VhuLIdeYIntKBJDRgkmUVHB
cg71UYG1hl97qlCGl9vh9Lxz0og208C0SdH3xpyOuEtd6i1+x5h7DDWJuxiigweP
HZmP6mENjOKwbq5pKB+PG7jH4uUgYLQjz2h77x3Z6VwgFkTks6I1Vdal+vpDHvWE
Q+T8fmpwN+ABw9D4yolCOTL5c/wPQ8pMEb6DezoG7J0b3QFxQwDAIuTNmBWAOFH5
1a+sgpcUkUCqreZzSc3e
=VYfO
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
