From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: core: Allow empty id_table in ACPI case as well
Date: Sat, 8 Jul 2017 22:58:48 +0200
Message-ID: <20170708205848.c554fbyztvxavldv@ninjato>
References: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ja5pdzfin35uvoav"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--ja5pdzfin35uvoav
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

Applied to for-4.13, thanks!


--ja5pdzfin35uvoav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllhR4QACgkQFA3kzBSg
KbanIA//VZh2BoIbOgW6FrrGiVYx7+uU2EaoJJL+ggQWUIndr0yQYZtH6uzKHr2F
Cv9penv18rkEsYgfVlP97L9NRWNossT7ecuhSQgSj0hb4bOC8XGzlOaLiI0nlK2A
g4Yh908A0qJw4J6Ph3qpyqOGMKI7bCvmrflcbfZylkHnBb1DIm5lIFK6LPpr8MnG
WSkUGWEpxmolBPv37PboRRbpuMmnoD3zXbA8YPrhceVagiiJ9RTl/S7TTQKko+/A
epRXDtvwI0wbu9SMp0VhhAfcby9FTNGpPoTuYOUN9DQXOdONXJZG0D5lMcN7V1ZZ
yl5kwE4fdRLIpKRX7rmRZhDDGrGPZBOPZrG/fMJoxVMIA6Q4DzR1VvIaVIISrcu5
WOAKgZPMF7pBc/rUjs+wCLVowLu+40UVgTt1NjBI17BsKkEXl2oB+9KoevWrEZT4
AJXRUvzpAtn/nlDSOa7TyMKR/lKrPImSgmwD3qW4/R1Xuis0bXjkkhmYwBYy2onB
7qLra/knmbnGcfsjli/vKgOSys+Y9/Xfnx5bh4UT7Jm3ZmQQaLZenYwmhQNDIvqP
fS44TUAfDnj1Kqzmw8x4iGm9ZTybrVRnO/Gh03VMeaa0kzMCbRNbf2VM4o56gOnA
VFp6wMB4G32SfwemY2aaOkBP/g/YPyq4kOXUhOfjPdPYM2d3A/U=
=d21h
-----END PGP SIGNATURE-----

--ja5pdzfin35uvoav--
