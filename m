From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 5/5] i2c: aspeed: added slave support for Aspeed I2C
 driver
Date: Mon, 19 Jun 2017 16:14:17 +0200
Message-ID: <20170619141417.fs7bnc6esz4uksmg@ninjato>
References: <20170603012952.2192-1-brendanhiggins@google.com>
 <20170603012952.2192-6-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7robew4ddhcjv54q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53361 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdFSOOT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:14:19 -0400
Content-Disposition: inline
In-Reply-To: <20170603012952.2192-6-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org


--7robew4ddhcjv54q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 06:29:52PM -0700, Brendan Higgins wrote:
> Added slave support for Aspeed I2C controller. Supports fourteen busses
> present in AST24XX and AST25XX BMC SoCs by Aspeed.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Nice, looks good to me!


--7robew4ddhcjv54q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH3DkACgkQFA3kzBSg
KbZt0hAAg4JI+HCvsP78ONTmLQNGuBk4S3XgDjHqqM3hR6neNwfCUsB2fHao4xlL
bjqlXHKXNUMmiOyy9ybt1TShVwOeowVPDBa84YOZHLzxqfltrmyHrWVu7FlPPejl
rP6SzHPq1ir+ZxvC6Ez79wdrjSLvxP4B1BR17zm8dP5Z6bY65x2IOQkX/jAu4B0S
9DFzq9Pi+7pGaRht+JPaxg1OprqWJOa8j+5CZR6h2csckKSai81vsmWXnGbGObHg
5KXwoQtq5jJyvFpKOF+aQgdeL+pbRbkhH2IIP7z7eah5b5P5RHsvkAObaDP0e5Wn
1QKccgH47IDFEYfkjLSskAscxHba9oPZwd7OCfr0ESld1ipSbxmUfRCesCVoKCJA
KDqKEpU49jdIS4XUcU59SGqVwLoh0a2Gyd4zVLFcVBi5XG3Ae3aJKoS7+AMrw5iZ
oEgZ/pwEIE36R+uvWA9GYzCTxGP44wAaks4KsExAPv+oFzmAHVfQbHx4GSP6ut8a
664M/sZJ1WNi3pShJLfe/Movn0B7xZsTLbCvU0/YLUPEyEKC/QKKzhtJwjyd7mSG
aadNkDGQlCiTetXdK6LhW4qnGiEtLAt3apHCCtrwHysuv+tTv3F/g8FG88Ce4+dR
sqUSEDyjQ4uArDiigKPT/Jwym/DeNYXWiWR2caGj4+ZAG+KDTj4=
=r9Dm
-----END PGP SIGNATURE-----

--7robew4ddhcjv54q--
