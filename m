From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/3] i2c: designware-pci: refactor and add Merrifield
 support
Date: Sun, 19 Jun 2016 19:42:39 +0200
Message-ID: <20160619174239.GH2933@tetsubishi>
References: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59195 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcFSRmn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 13:42:43 -0400
Content-Disposition: inline
In-Reply-To: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 06:05:04PM +0300, Andy Shevchenko wrote:
> Tested on bare metal (Intel Edison) by enumerating I2C GPIO expanders.
>=20
> In v2:
> - leave bus 3 at STD speed for Medfield
> - be consistent with workflow, i.e. call ->setup, and _then_ assign to i2c
>   properties
> - add a comment to explain magic numbers for Merrifield
> - add an Ack for patch 3
>=20
> Andy Shevchenko (3):
>   i2c: designware-pci: Make bus number allocation robust
>   i2c: designware-pci: Introduce Merrifield support
>   i2c: designware-pci: Sort header block alphabetically
>=20
>  drivers/i2c/busses/i2c-designware-core.h   |   1 +
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 143 +++++++++++++++++------=
------
>  2 files changed, 86 insertions(+), 58 deletions(-)

Applied to for-next, thanks!


--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZtmOAAoJEBQN5MwUoCm2+zIP+wYGvIyNQZZ28Bu7l4cAeDh4
ycXo4YAuckYq93pULyj44zIe9L+8eOMeVz/yceBhsKt/B9BBiVG5WkGFjReyvOWT
AZInn4TECmERNHZ+iIh3HmwirqKDaWhnLGKk+mpbX8sYIM+PVasYGDkthutdnkZw
5ib4Uva7jvMkbkaqAH3l0k4SU4FDspa9obVQtfbf07egUZLz/zFWTNvXDvtWgtiq
X9vJ+nM4bWFOaPGYmPOIozbNV935UOOEjLwD36LhAkNnNlrr9T6zQQbWelk6rU4A
fkHv9U/eR3LI8afeWwpiIH6UdB/RMqPFsHAJsXZx7cYwr/FARW3R3RGI00wOTxsH
lfGDOx/S8K2n2JYlUEH8+v4T8hRJnXndKxG82QmCXF10Vwn8LO/lbNJVsqgahRM8
+JtCj4AQwq+/VJzStXl/QR3BkgKWYPqK8pZhiej5mlWh8eZyfXx975WYDBhJtpzu
26zqk4XEMY9v167zfhIpq1YiLbXIME2wPUMl1N25EY7greuiPcugLf61RFE5fX2i
u29MgFim+48Rx+yDTkqaG9uhKxGx+yBNNcWL/zebvaoE1lx6CPB7JhoVG6aAbHrf
EHsDF7ziXGk5O+9750RYFOBrA3qpV43phHsU2qsY0Ymi+KmUw2q3UNBhmfytX/S5
6LW1Pb+Exnpz5a8WD251
=dt5B
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
