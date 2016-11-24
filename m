From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH 2/2] i2c: designware: fix rx fifo depth tracking
Date: Thu, 24 Nov 2016 16:18:47 +0100
Message-ID: <20161124151847.GH4271@katana>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:58498 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965876AbcKXPSu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 10:18:50 -0500
Content-Disposition: inline
In-Reply-To: <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2016 at 07:40:10PM +0000, Russell King wrote:
> When loading the TX fifo to receive bytes on the I2C bus, we incorrectly
> count the number of bytes:
>=20
> 	rx_limit =3D dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);
>=20
> 	while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
> 		if (rx_limit - dev->rx_outstanding <=3D 0)
> 			break;
> 		rx_limit--;
> 		dev->rx_outstanding++;
> 	}
>=20
> DW_IC_RXFLR indicates how many bytes are available to be read in the
> FIFO, dev->rx_fifo_depth is the FIFO size, and dev->rx_outstanding is
> the number of bytes that we've requested to be read so far, but which
> have not been read.
>=20
> Firstly, increasing dev->rx_outstanding and decreasing rx_limit and then
> comparing them results in each byte consuming "two" bytes in this
> tracking, so this is obviously wrong.
>=20
> Secondly, the number of bytes that _could_ be received into the FIFO at
> any time is the number of bytes we have so far requested but not yet
> read from the FIFO - in other words dev->rx_outstanding.
>=20
> So, in order to request enough bytes to fill the RX FIFO, we need to
> request dev->rx_fifo_depth - dev->rx_outstanding bytes.
>=20
> Modifying the code thusly results in us reaching the maximum number of
> bytes outstanding each time we queue more "receive" operations, provided
> the transfer allows that to happen.
>=20
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-current, thanks!


--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNwTXAAoJEBQN5MwUoCm2jpwP/jUPERAydJ82VZSSRmw/RO6M
dIyiEfZzrAL56hgeFTe5QeoUYdDaQJlbdeTxvcCMBktOCbsEawLohhdX5YocZ6ac
wofb3MaEoATtxJCMZB/JkRoaRkC1ODZcZBwqkyjrqJYCqTK2rqjkl67QHFpaDqvc
V0AZr3IiQGvGm9G2MxCUPw0xcj7GfkT7gP/Sw6wESkmJspUal88oqF+R5UEw1qa5
coQ0H/dhTXxwl3E7g1mXh59N3tu9UUJmXB2MKQEBIHK5CTd0+s4xppsVuvwDKNv3
P1+OAyDlHviSpLdcaoaslXeMX67Kxj/6M/f9EH5ht2Pur+j+3ZV5LRUeC7t6KUx+
zdOALc/q4u06BRKOLH2kAsoo/Vj8Aamkx0mjzVwbPwnw+/8korQ13+J8jokIbIHW
k3izi5ajaAeW/Gvqz0LUsh9Fq3gj21TlMvemxk5Yo4EmY0CdfI+zJa2C+lIW58R1
am8ezhTPn2ULEQBa1J27wH9WT6UTDmShBFI4HYHloSjXo0gvNnUuvzMPZkG6Y+lP
5cqWQTR3/CFtRzkiEEhRLa9qHeGEV5NAVDMDl23yJ21u/LO0/QIegH6u7jpzT7kH
fDVvJ5lU8xKWJrVOgy48KuvxoIRDVUWIQ1Myboe7kqtlQb53UHgC7KSD1r0n3JDF
U4Rsaz4KsNeWLfRR6K0a
=LMf6
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
