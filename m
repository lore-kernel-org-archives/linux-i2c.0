From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Tue, 25 Oct 2016 12:02:42 +0200
Message-ID: <20161025100241.GH1597@katana>
References: <20161011131327.0eabd227@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49332 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941585AbcJYKCq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 06:02:46 -0400
Content-Disposition: inline
In-Reply-To: <20161011131327.0eabd227@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2016 at 01:13:27PM +0200, Jean Delvare wrote:
> Starting with the 8-Series/C220 PCH (Lynx Point), the SMBus
> controller includes a SPD EEPROM protection mechanism. Once the SPD
> Write Disable bit is set, only reads are allowed to slave addresses
> 0x50-0x57.
>=20
> However the legacy implementation of I2C Block Read since the ICH5
> looks like a write, and is therefore blocked by the SPD protection
> mechanism. This causes the eeprom and at24 drivers to fail.
>=20
> So assume that I2C Block Read is implemented as an actual read on
> these chipsets. I tested it on my Q87 chipset and it seems to work
> just fine.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Fixed the BIT() issue mentioned by Jarkko and applied to for-current,
thanks! But please double check my commit once I pushed out.


--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDy3BAAoJEBQN5MwUoCm2cUYP/jHvpSiCC2E2wokR9VyGE0XO
XJF909b6cAY3rPuIv4NFnXBNYjnd1BSCX6T+Vb/bTp7ljYbp6lcOfvAo1iTxgxex
qxKxbzlbSCegTXw+TH7/i7LcirZ+HCXkWzTuYoHnDNuoJUMZ6m/xav4mLxwCDabt
5wX7yMJoQVOaIgAjPO+EM8WZD12ag56a7+mhDbQskjHUR2201s09HkOJNtnUos29
Cf7UuSC0mwZc+C57mLEGe3fj4pEwGIoilZ74x/znSmPlHLUcl/l++2FlEbYcEwAH
wTocOUioCPjPv7lCulNpnUJnv6fK3to3PchmkJpPeQ0O6IzM4VO/9Y8CDso1IR07
FzpagiY8cLDSKWHLufz4awSQVBTnwBpq+cGm3I7/UAbGDcC6Xqu9D3xmj7guBIRa
nfEjSuYn6EM8ocV7d1tvZQvOpq482lPFDUZmEFnI0PaxblCKUnJ1jRYANUKq8Hp1
wJh1dym9xCjpy2EPzc6MDxydmP6n3hnwBlweoBvIMvzfdBN1rGwvdXfZeXYngIHs
mgChEAhiOXx1VdMq0GYtPJJO01lY/qMKCqfxEq0uxbcsWsNgY2bcwTWxvFtgx6Hw
/AvQlfK+/C+8ixnZt/V1TcLqO/sQ3nyLhH/8+Ukg2X/wMk087dFAzaQ+d074K9IX
DcBvL1ZaAFuoapEe816u
=u068
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
