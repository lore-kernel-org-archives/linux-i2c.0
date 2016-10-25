From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] i2c: Fix module autoload for some i2c busses
 platform drivers
Date: Tue, 25 Oct 2016 11:32:01 +0200
Message-ID: <20161025093201.GE1597@katana>
References: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49231 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756053AbcJYJcH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 05:32:07 -0400
Content-Disposition: inline
In-Reply-To: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2016 at 06:01:44PM -0300, Javier Martinez Canillas wrote:
> Hello Wolfram,
>=20
> I noticed that module autoload won't be working in some of the i2c
> busses drivers. This patch series contains the fixes for these.
>=20
> Best regards,
> Javier

Applied to for-current, thank you very much for doing this
subsystem-wide!


--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDyaRAAoJEBQN5MwUoCm2PqkP/RAW0SBuKi2Ehw+UGQ62By3E
hgbze/QMiYK9E7GPRzFdYXJQHkfO0eUt6Of2UdcT7OpZwkrdfilq9ldejnRKyFNQ
VR1qpljZi8PsrBIDWyUFX2AZf2UpbhUxw4A4+8JNtGnLxOlXslDgDYvD9Fn/axTj
ehGP18r1qc3L2U2BLyoHpH5TQ0qVnpcPmw/nbdWSAlmRSZ2ksgqOg++kATZrM467
1Wd/ETBFjLQZjPIjtVtQPmOIB4pZAAOjxxxofht/D2tmtmxosoHZm9diIhrZkX4W
QbcbuuRcigeEsyGJFAIjPb/5wKI+4GrsHPOdNBOUSBVSEB2zl7GGR/8y/TbaZFDX
0Kh1tkOXTDBpM0ye3n8JvaQp6CdlyD8WygCT7gGYHLu/W4Sg7eK6C4INPf0WCM3E
Pc4l/ulzVi7oYAC7mVCs2k2bwljUbts/A5/Cw3LNKxSzFAi9/lwPMiGyF15g1Jt2
9lVRyglstI3uNUsiVwwlmLoRpD74nVJHsJs66TYVjhg2i/U/6i9Yq1Ea8sW5bSZn
WUr8mCa3FGc2zSDdTVosSj7kSw2Hwdy5z6Zj3Qq2PrnU5GnmHn6scyJVYYjktFCB
1/+aZrg064xUPgBIlDxRXX/o9RdaZeLA5AP8TsGLAygMGWDShs8jL3hu1vR1iytI
ujlmhpPr5qwcZGbiEp69
=BTNS
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
