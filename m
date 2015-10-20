From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] dts: keystone: Use new "ti,keystone-i2c" compatible
Date: Tue, 20 Oct 2015 17:06:14 +0200
Message-ID: <20151020150614.GG5379@katana>
References: <55F68E36.2030609@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43287 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbbJTPGS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:06:18 -0400
Content-Disposition: inline
In-Reply-To: <55F68E36.2030609@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2015 at 11:07:02AM +0200, Alexander Sverdlin wrote:
> Now as "i2c-davinci" driver has special handling for Keystone it's time t=
o switch
> the device tree to use new "compatible" property. Old one is left for bac=
kwards-
> compatibility.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Shall I take this one or shall it go via the davinci tree?


--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJlhmAAoJEBQN5MwUoCm2kb4QAJHpPRi1KTJr7XjNNOhdN5dF
DazesAIt3ApGzkoGsB1K22osyJnq/gSsmuBJTk397SAB++Lb6CGm9GArNSlf3iMk
MPJcGTBj0DAC0MLj/bQr11xX7Cr+91mDB+G/t/3VaXMElBLz/ErTWw8bmD2FwcmO
C9o5rhADptB6QQXvv7csYAmNSdkS/O/5WGMzKBXuW7H+nUy+xGlCgqwgi5eFC678
Z5NS47KBWPQ04ytZsq13fN8cPNw6creT///8XBfAQ7anhBL5OdUZ0x1wDR9CV8Sj
+inBm0Xk0bisA4lRFaYCsotRU7pTAl4sFa0Tu43L91ZC8SnrRquPeGxXZ05pvNDJ
xY7+EJtN7aXR1SPNiTBPDO8DEH6T5MzVmNYlxZovZ0rsOsF1dn8pt5B0qoar3hXa
hnfkNYxk2mmyTU0PXZkJ4uI0BVfWXsRs0Ph2nFju2R4scXov0Zdup0vs9tAKdfZJ
tx/YnJeOL4LAnWqNvzoWs5eLzllQ7uhpcr+AiZCDvTawE8nbobG5aaA6UiMu4cOI
ib/JCA/4Qp4EylwFOfRIOp7MAmMI5Ia/ORBOxgHQJ8Ah5Q6lnpSIri4buEAVsD6G
xDbtXCwcxexKtLQewC/ZvHkj9MopREJkBpSCv5aZT1S3Pues2s6w2kIRtKnQowrC
wwfsxLIQxgXSx8fn14GX
=Uvjv
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
