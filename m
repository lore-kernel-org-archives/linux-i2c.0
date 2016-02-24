From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: piix4: Support alternative port selection
 register
Date: Wed, 24 Feb 2016 11:38:54 +0100
Message-ID: <20160224103854.GG1391@katana>
References: <20160217102635.0a739bb1@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46480 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064AbcBXKi7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 24 Feb 2016 05:38:59 -0500
Content-Disposition: inline
In-Reply-To: <20160217102635.0a739bb1@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 10:26:35AM +0100, Jean Delvare wrote:
> The SB800 register reference guide says that the SMBus port selection
> bits may not always be in register Smbus0En (0x2c) but could
> alternatively be found in register Smbus0Sel (0x2e) depending on the
> settings in register Smbus0SelEn (0x2f.) Add support for this
> configuration.
>=20
> The "alternative" register is the only one working for the Bolton
> (aka Hudson-2) chipset anyway. I do not have any documentation for
> the "kerncz" chipset so we treat it the same as the Bolton for now.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Tested-by: Christian Fetzer <fetzer.ch@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWzYg+AAoJEBQN5MwUoCm2sR0QAInhYxM3nJXClYQWMrq7I1VY
H6xSTJ7rIMoWlNFuFd2ZvZUflZ8ou5U9LW1GlCBRX0WnpqTDcmQcQ6nMCnJtl4Zy
to4YJ36qm2sK7Unm1/f33NcryFYOR7gdorovM9qpIeLRDk381sK3jlCiDhTcgGAj
3kOtxKwEC+s0VJbFeDgF6UhWyxcmbcAXu4uq9Nf09mwva3L4nbmGn9w1xZ8Truat
HBS+9DVYQ3C3i0xE5l60h1cAm4fjhOv1q4tClUXCS9n8Nvx7nC3Auu6knabyO+KH
Qcm/YLpMcxOF+EtBiOWGD7u2lx3WvSN3i704NvbCl9KWe3rQJagguViL0R3AOYnh
ugcVjj/A8EraO5NAxG1nmVqkC96WX9zWPQATr4qrA9NLBG+f+qvBHZni/51rOxws
qErA/WZMU+OVvxyNEUE57BV+56aB15HW2beITtYyc+bDF8f7WIv7lo0oWkFbN9rz
WHwiA1EvSMEsiIWQfxASxFKB6s4TiHG0tmBBP9rPPkJxWF5OpPssFlpjc74Yjyi3
mCnzNesI0tiZqnPTOVJnzsDL05e+4c3LOPdun78tiAvTBMfc00B6L2gLF/WUrGru
2A1TUG4hDvwy1T2+wTPEaHmcTZn76zGW7lfGnf5pRERxyoPAJH7LBfLyOIgyLynM
DFZlHY3Xj1dVZTWLrKeu
=bBDU
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
