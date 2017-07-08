From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: core: Allow empty id_table in ACPI case as well
Date: Sat, 8 Jul 2017 21:57:09 +0200
Message-ID: <20170708195709.422s6tdxqxsz6sbo@ninjato>
References: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yogxssowf2mhhidk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--yogxssowf2mhhidk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 09:01:40PM +0300, Andy Shevchenko wrote:
> For now empty ID table is not allowed with ACPI and prevents driver to be
> probed.
>=20
> Add a check to allow empty ID table.
>=20
> Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed dev=
ices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Do we need this for 4.13 already?


--yogxssowf2mhhidk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllhORUACgkQFA3kzBSg
Kba9Xw//Zf2pFXU94RfdHBNXeB8YBa6aXXoj8PklXiuumQbMRSDuPfUN0SJZRpLL
Iqad7+7X2xzGoVTVVWtg2oFW1F22AzduRps4hDcCWRkrdK12kdkMHS2C2IybxW+f
/gX4pDE+2AQSc4ZhiIYH75wqvR2t9gt/SSSGn/csWcTtAK2Y3QLjvXGrrMx2khzZ
FA242HGJsATX3mKWHaY7gAuD/ZMuUoPmFlt0KgYQvAD9ugtuWefkeN07zPxkNZNo
o2OVNeGdtuzRszlkdJ3oo4oz9Z1jRAO6UTeJU7JGiHU4TOx+FcWsyxa/cvp9ayEd
WG7Ea3s7HYGpkC7hUSr9p45NMfo9PCLrIWeouiILBcTiRGTUD7QvPZY+ma6c5ZSu
r11m0Utf/K1FHle2hdLGX/6HreURPafVUHaq0COU4oSD9kMXUdUiy3n/JY26YI6c
4Ix30DAHZafbw6Y2vHdcSYTLIq7e3MBnK6iOZaymJfGFQwnzqZBxmR/+Je4StcWm
jPVsM2Q9dmDdbcpwwsrtpFS5Wt2pO2rffjOghCUp8rpiupA8rsovIlbwEcU28w7K
BzR+2DZYVwNqEl4RDezz1GdAamk9D/+DmD2fIppDcp/O1HUFbUvARoSRmZ7fOQd9
lv0CexH3l8gGeU5qSaUbV7Lc8AuLs2whs4I5AXpXXJYcoxiysNg=
=8Xzp
-----END PGP SIGNATURE-----

--yogxssowf2mhhidk--
