From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: meson: allow build with COMPILE_TEST
Date: Fri, 8 Jul 2016 10:39:01 +0900
Message-ID: <20160708013901.GB10192@tetsubishi>
References: <1467836225-2427-1-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33565 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbcGHBj0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 7 Jul 2016 21:39:26 -0400
Content-Disposition: inline
In-Reply-To: <1467836225-2427-1-git-send-email-ben-linux@fluff.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2016 at 09:17:05PM +0100, Ben Dooks wrote:
> This driver should be buildable with COMPILE_TEST so
> add this to the dependency for it.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Care to explain why the first one was better? A bit confused here...


--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfwQ0AAoJEBQN5MwUoCm29HgQAJ36Z5ANdJhtPDRA2Ro6SwXD
zxzgbIXNyPzLeixXhouj4MQyC805cLKWLx6gArR+MfJjqBrUUtstKHP5VYHPIHnE
0jShXjSWFQs8uL8y0kMMuXRCkHiHzgE6GJIP/wSn8wdpNDx5bkP2FUDjIbggavK0
kDROQiJ3tWfyOccpp93uTNdeQzYj/crnTlZZeOUJGsaWhAv4aLmqR1o6IVzBDCt9
hFlFt9F1o1CfRyVoSyL6bsvRWkFU2ERCuD9Az+erRc2oKdbv9+Eu3id3VSg6Z8lp
r/zXjZwmfy+183mZor6BLkf4sYtchSTXcstJWTykpJj0KsiqKx0O8JJJ1ZrGpf61
XDi5gaV7QmElxzMFT8TBdoPCZIHL4434OdtWr4+IeVq0BFwcYjBIbz91BpRW3Lcd
WzR5fe2cS1domLsJCE93KEGO04C4ARaB0DIp9Jqukodc9iCv+eTuOMn7Hksy5l0g
K5idIyumUxGVnEt7BZLQzGMLboEbyf2EzG7NSqmQt2wyK5Mh4a1YPIQ4yHJj4FEF
oDS6faZ57sQLyOgjJzJVDWzjX+VMk1C42r0F95eA0rhv1KxajTiVqQOFQuDL+lnI
KGMnUuKnXsRqr2nbFjZGT4SH5u8vH+yxIQWq+ogWJpHdyeRIjVh6RygYyl2914T5
I89k1DLQl4Gu6NUiEELI
=z25f
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
