From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Date: Wed, 18 Nov 2015 08:31:07 +0100
Message-ID: <20151118073107.GB1047@tetsubishi>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <2420286.JI0i0lloO0@avalon>
 <20151117070053.GA952@tetsubishi>
 <2998465.01LOgISn2O@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54221 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbbKRHbQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 18 Nov 2015 02:31:16 -0500
Content-Disposition: inline
In-Reply-To: <2998465.01LOgISn2O@avalon>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> can continue that on Lager. In the meantime I could also capture I2C trac=
es=20
> using a scope and send them to you.

Cool, thanks! I think I'll start with sending you another trace-printk
patch soon.

And can you push the branch you were using somewhere? With the config as
an additional commit?


--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTCk7AAoJEBQN5MwUoCm2vcwP/1SVZglEhr/Ic+YcIamkOEQY
Od93G2zCrCEIXl0RpPjgBdWK9cxido3lmConWyTqO37+/16xdpRD6zjJYmgpX1sl
sp+Sbj5lVDGhvJEoeTQU18gvgpxxKdkWNU6YP3Bym9Qsj/vETVCB/mFB7Ul3kATX
flSpYGtn5H1ABcdstNAuvfxaYFDKABBwYR60UteJznGB+4ByIx1i+m7UglWqO+dF
IR2ikvNrJkJI8Xl0n4VvylY0t2YyhI5BHYLsbOWxRH2OKZJO1U2YiTztlxFubRDe
BZlrvXmKe18Ju03dkiHfLXrITpeRij8mhBhE1rZdaKVE/3MEXrx7gR2+dhn6Qy6Z
y+3ADrN/zrzCKhd+epPiI9ASUH/NLqJ5gpOOLdvb9DxOtH3W6Wep1GrB00toao9C
IpIEuEPvj6jll0mLEagYPk5zfaOvNdj+YuS27MwyoZ2MXvcibYU1/j/pwrRqbrRc
s9cwbaPGiyAtEUa1MUYdqKEOv0lsboZP2UUDqxdw7+wlL7T4pfd49wm3r+Gg26EP
64M3EBebL6Xa+wJFmBlUUlH+p56WSB6/uAD5d50X7Uy4OMYZ4QiwTTD9yGwlnklO
Kc/AmI4wsgMPhzlU8LSOKlAf1/MWvUApT/dCCewzC4anbvL6skrsd78+Ze3QqNUh
MxmPyjRxCrO03ftYpDX+
=VE6K
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
