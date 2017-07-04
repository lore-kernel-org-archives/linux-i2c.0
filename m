From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] i2c: pca-platform: correctly set algo_data.reset_chip
Date: Tue, 4 Jul 2017 16:03:34 +0200
Message-ID: <20170704140333.iahb7udd22ph6awk@ninjato>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-3-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5thzgr52ilotzhge"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49175 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbdGDODg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 10:03:36 -0400
Content-Disposition: inline
In-Reply-To: <20170630005408.23968-3-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--5thzgr52ilotzhge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 12:54:04PM +1200, Chris Packham wrote:
> When device tree support was added the setting of algo_data.reset_chip
> was moved. There were two problems with this. The first being that
> i2c_pca_pf_resetchip was only used if platform data was provided. The
> second that it was unconditionally overridden with
> i2c_pca_pf_dummyreset. Ensure that however the reset gpio is defined the
> correct reset_chip function is used.
>=20
> Fixes: commit 4cc7229daa46 ("i2c: pca-platform: switch to struct gpio_des=
c")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

It's a bugfix, so I'll include it in this merge window.

Applied to for-next, thanks!


--5thzgr52ilotzhge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllboDUACgkQFA3kzBSg
KbbtPw//XQD0e7td5ohv5+ktnC70xdPFz34LrefB7y6Z34FRDvjbp1PSQirQy8Ap
cobMfdHksEQ0CDTMcdDYBsD8ijpEpr03JOVWEPjE1eFvUnea56MSl/z41Bzdnx4a
QT4iNZWfBz9GdcP7CFlUGMXoAwkHpTeyJu2S2wpe/9rgJDYDDGUAuhX8DSKNL5QV
nSuQ3KtcGNANnB/bR5sj7TrV5/ZtGSCrTdNapi3uKOPW4M3YRp9XftmDXwAkeEgv
0uNLwKdG+ac4LOWLFZyNIa8R4OUgwrc7OlOVbLDXFkQECfjBcA+0aXZtIgbz8R2f
C1Ggf00dXwIHpVjsPEw1JwcYBbcPsoiEEul1djz12+UF5sgc56f36xrIEcurkIDY
rAWGVSItKBSnlXepF8OMKR+bn3ZlXBiSyAgKpkhRdG6Zy7iIdMeLnScKL1i5wwLr
vCKVUsyq+ZL/RT13iFt7S9LwQaBxNGLwkjg1nWltEK6jWYeaBrknHSOl5WXMfCH9
DandR8XPW7Tioh4v64+kykc6b1wzN40xMquN1m+DLz6rvFIq7ZkmxNWqhFvhorO2
a/yjoppWySaV3nrVtpijZUWc1ort6ZpnMcFyC2Xh/GzarUXx1lL5Fb0YRN6YbcPR
IAbea74GUMOWbAXjfiInGDu15TQuXNEX/BglYLoMlJfwDrwal3Y=
=Iz2L
-----END PGP SIGNATURE-----

--5thzgr52ilotzhge--
