From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: cht-wc: drop check because i2c_unregister_device()
 is NULL safe
Date: Wed, 4 Sep 2019 23:12:03 +0200
Message-ID: <20190904211203.GB23608@ninjato>
References: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190820153441.7693-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 05:34:40PM +0200, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1wKKMACgkQFA3kzBSg
KbYBDQ/8C7xWw763amsEzI5uNNh/GKrdnW5DZvBWQTN8XfrC5XZf45XAWdYENpcg
aJ0PU0Sec+MuTg/QanFx+toiNG/4DjWBY2Aa8PGzWYSWrsXtMIWPyrZqPkVreecH
5ySkJUnajWfMC442E63YZkUxgdB1GTsC+68QxHA0Imn0GkNrFRQuqwq1ugQ90k6r
UUYZKRv1DIRmSvON1X3t4A+9HURpUimHGdGmfNDw6T//FnolEWI8QEM+R351H9sq
jx0bCpe2HU0s4J36R1/kFvgvifxMMQ/qQCzswlkFVh5rkK0yeLWjLH2DVEfMV4rT
Bb73wEZyCznj+/mdVd6yKDR7jLjWlW5qFbF/SDslkoMrrBIQ5UVtjH+MWEqhfW8a
S/2ZlSR+fdHG2aWOGFxrquKGKocIEMY587wCtXLc7w0tpyRSYnPN2HJ5zw2utXGC
b2zjB5pmJC+ri5WUM/O0oSIy6yJF7/lehksEjoJaHk07PBPpZNL/KBvKMrdkVyOQ
/dkWqJD+R7IwS2Mq8sragO+3HD2HSiRKgVtQFojIu0uoQbSX2U/lYm/9LX34Sdri
O3H7Fs/W1z9PsI0qDEzVEng79mfqHqA1TcFnKB/FJ5x1e0EM+fHGtrBXAj6nMwN/
9SBAb3duuF35OuJiA0117kBh/T5iWxrITWtu77289rFRoCPDF1U=
=+L1D
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
