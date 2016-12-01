From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v7 1/4] i2c: pxa: Add definition of fast and high speed
 modes via the regs layout
Date: Thu, 1 Dec 2016 23:36:15 +0100
Message-ID: <20161201223615.GB19261@katana>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:40588 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932881AbcLAWgT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 17:36:19 -0500
Content-Disposition: inline
In-Reply-To: <20161201110440.27530-2-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2016 at 12:04:37PM +0100, Romain Perier wrote:
> So far, the bit masks for the fast and high speed mode were statically
> defined. Some IP blocks might use different bits for these modes.
>=20
> This commit introduces new fields in order to enable the definition of
> different bit masks for these features. If these fields are undefined,
> ICR_FM and ICR_HS are selected to preserve backward compatibility with
> other IPs.
>=20
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>

Applied to for-next, thanks!


--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQKXfAAoJEBQN5MwUoCm2lKUP/RHWbriFoLkqyHc/3Akb33kJ
YeL5pOv2wlJ6S9sprKcymEG/cZzNcCSwO+tcB0kyyEQbdZSP4t97apiQ11+jK8kS
VnlJmAmX6WPYSFXIRH2zo2u4PFBp18C4YTIeBC0AabE1H8S5Iqui5fifbTbIi2N+
usPYC9PifYyiFkefTDowWi7b4sIaPPdX1TvVzZDdHYJPq+LDxRQCfNH8OJ/ojAek
nN+hmedTC5pAVRsnj10wa+MtDs+8v+ESIvX8TsJLMXzfBrQ7rFRdEPPCPvzZmm0z
MVdEjw9+mUdDpAOaA+rJW7GX+ZlLNYZgnThd0NocZLftb7QRxzLwWh5xhicOKo4d
UFXiTMK8TofgfMbFGT+trEMFcA2+dYnIrTidZ4qYsVHgFNLRwf79f1htf0Wn7xOC
6uxndjDyDIdFa2xXGFX+VhQx5KRUVVkKEwCV2MUr9tcuiW8f85NKb19PZUmAzj18
XfCFoD3HYC3M3D1mS/jfgcZNgqZ4R0d06yYBS6Z3zEOyY+btZgTjsK7bf1gNvuv2
w0B6pPfGkp3bFmjy4AXZpww0bHfI/PiTcLNt+LAufVpu1vU3tQPAmItnjdRi/8Vg
WwaAdZdCCizQ0anBqv+GLQFOgavZIUun0prcJbUWIKxSN273L2Z2bXGveomwW+mD
bViXJU4SxeZt+mAQGpN8
=J5ZX
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
