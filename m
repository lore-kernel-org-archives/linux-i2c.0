From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: piix4: Disable completely the IMC during
 SMBUS_BLOCK_DATA
Date: Fri, 13 Oct 2017 20:52:01 +0200
Message-ID: <20171013185201.243ayxbejnehar6m@ninjato>
References: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v45zlvx6hy56b3s2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41577 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbdJMSwD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 14:52:03 -0400
Content-Disposition: inline
In-Reply-To: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


--v45zlvx6hy56b3s2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 06:11:15PM +0200, Ricardo Ribalda Delgado wrote:
> SMBUS_BLOCK_DATA transactions might fail due to a race condition with
> the IMC (Integrated Micro Controller), even when the IMC semaphore
> is used.
>=20
> This bug has been reported and confirmed by AMD, who suggested as a
> solution an IMC firmware upgrade (obtained via BIOS update) and
> disabling the IMC during SMBUS_BLOCK_DATA transactions.
>=20
> Even without the IMC upgrade, the SMBUS is much more stable with this
> patch.
>=20
> Tested on a Bettong-alike board.
>=20
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

What branch is this based on? I can't apply it on v4.14-rc4 or v4.13?


--v45zlvx6hy56b3s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhC1EACgkQFA3kzBSg
KbYeohAAmVejYBeeeYjYhTkamo05sluC2pg0erJSMUQx5uhMSCCor59W8+sDVDaM
xUxPYjS/4C6WBHJ+jhc4o6e96XW7YUrlDwigzmEThVWi3z/7GbEWTAKiZmveixYn
k6M4BgPHCc040Aub2M8WpvPUzBI7HyBSIFZ4JgF0z87ZrFGRayftV+K9uEhU2Ygk
tZT04ovkk1Ui/BwSjn/iiymUFpmW0EOlQjgdgf5SstnuJXXGMzicwtmJ9/O7Tg8E
eFARz0Rhd6shu0GJlo/G/PfC6lSKT0RUgBUPl7BHiUolVN69y8voutD+ZrDSaEUr
XGrhQnnrdykhbmX2PFGvUeIc3GRzxjqKUAwzhFRco7X7qaYiqMUbSmiRu4EOUTS5
O1l3WkXKXCLqfNuMXFzl+DzYLH0Wi0CngYKLkKxj8SrUZ3Efuz70dhmV8b8imXt0
R5Iwyy9I2jV5vUF0rXvc/6dvRNDybc79PCpuzL8M0C1QY1kaenO5153Oq2WuuEyc
nGbRGhtHG04urrxfWYhGQTWYTX7NrlqHFf0P0Blp5SUMmR83EqpOZ3zv18k/TOEd
PQThCMp9pH3ypeYcduioeGJts+sAEoqIRGvtJxJroYcdXoiyAmkhVuOwwqPOaQ5P
UppB3XCWw0A2gPIXOr+1DNgT/EDBQ3oWhWQ5vI8BsK7iCwyDqrw=
=Z3+v
-----END PGP SIGNATURE-----

--v45zlvx6hy56b3s2--
