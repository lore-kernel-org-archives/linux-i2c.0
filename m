From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: PMBus and SMBUS_BLOCK with "extended" lenght
Date: Fri, 31 Mar 2017 18:33:36 +0200
Message-ID: <20170331163336.4sy4br3i2o5etcoe@ninjato>
References: <1490948247.3177.233.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbke3levozltax7w"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43614 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933368AbdCaQdk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 31 Mar 2017 12:33:40 -0400
Content-Disposition: inline
In-Reply-To: <1490948247.3177.233.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>


--zbke3levozltax7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> Did anybody give thoughts to how we could support "smbus" block
> transfers with a size up to 0xff ? This is an extension of smbus
> that part of the PMbus protocol spec.

For completeness, SMBus Spec V3 (released 2015) increased the allowed
transfer size to 255 as well.

>=20
> Our current code has a lot of places where I2C_SMBUS_BLOCK_MAX is
> hard wired. Including down in almost all drivers.
>=20
> So it would have to be an evolutionary process.
>=20
> I was thinking a message flag along with a functionality bit
> maybe ?

I have never really scratched my head about this issue yet and don't
know of any on-going activity. It is notable, though, that we export
I2C_SMBUS_BLOCK_MAX to userspace, too.

Regards,

   Wolfram


--zbke3levozltax7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljehN8ACgkQFA3kzBSg
KbboDQ//dX6QVKSkFfUTUX7f0igIQp2NTFqAiANA9CsYmhFgymwvQqlifhQgdLtq
q0jx1LLHr6YAmRq883piEUtqwMuHKP7OnNIqWsh86FkZwj/oT/VO9M9XfpTmTjtH
P4QeIMnVSthiCoOlGMbpJsnduiPJHOwOHpyWxJrLvj60NuWWOhcoPEvR6i7tPrPr
fcT6UzbQ3/Jk5v4LeZgQfPuHQ/YJdAUpWd1WlK0Vzkbr3u8SDJ++kJjTdhfj4LNq
f/KghD7qoYHTR0CevzXEEruEH8MYHKQALQj2bAKLN3LqSbKdTGuSZ7xr7BYmK1O+
f8TORF3k3V4/YfM/Df1xROkfVMOIVggQIIj3yLwc8mbG8Y9UR4s4Nky1Dc94PHcT
4CEXhWHotapRMBfnRbW/wup1X3SEbOqw113Kldjxp3izuAqWT8hPt+Ss7Itb1id8
tUneyEJJ/0UU76m1jYRb2/RZVqWmqIftfGq7k19c7Q9AAHjG9CYw9JpTxczxc9ZN
lkCnqO6y1P2QhS71A0r6aFrYm4Y/4vO/qS6A6EcBmDuF2i476eKrk7nKLp6tkY7E
abSPUzEHD8JOOYHU9aKt64WxY7vtnUY/Jrv9O4VADvB/kW7l2yAltq50PEVpb+8y
pN4NVxRdwvFMKwf3Sc6Nd5h9ECgmHaJJS07tbL3VfEoKOSFhTVg=
=yvvY
-----END PGP SIGNATURE-----

--zbke3levozltax7w--
