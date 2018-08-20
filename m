From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: core: ACPI: Properly set status byte to 0
 for multi-byte writes
Date: Mon, 20 Aug 2018 14:10:37 +0200
Message-ID: <20180820121037.pgfwmzm6aygahiq6@ninjato>
References: <20180812105321.2668-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xbfjvnr32bjhxely"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180812105321.2668-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xbfjvnr32bjhxely
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 12, 2018 at 12:53:20PM +0200, Hans de Goede wrote:
> acpi_gsb_i2c_write_bytes() returns i2c_transfer()'s return value, which
> is the number of transfers executed on success, so 1.
>=20
> The ACPI code expects us to store 0 in gsb->status for success, not 1.
>=20
> Specifically this breaks the following code in the Thinkpad 8 DSDT:
>=20
>             ECWR =3D I2CW =3D ECWR /* \_SB_.I2C1.BAT0.ECWR */
>             If ((ECST =3D=3D Zero))
>             {
>                 ECRD =3D I2CR /* \_SB_.I2C1.I2CR */
>             }
>=20
> Before this commit we set ECST to 1, causing the read to never happen
> breaking battery monitoring on the Thinkpad 8.
>=20
> This commit makes acpi_gsb_i2c_write_bytes() return 0 when i2c_transfer()
> returns 1, so the single write transfer completed successfully, and
> makes it return -EIO on for other (unexpected) return values >=3D 0.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-next, thanks!


--xbfjvnr32bjhxely
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt6r70ACgkQFA3kzBSg
KbYAqQ//agMIjEGntDzmmS1ldJIL9ClmmFBktdlhYJx7Q9jp36TiOf/X+JiLtCLM
Ogmg/HCx6l3fa1FUnf1uj/pGhnLbRgsRmD6LDtMO7Xk/IyFPfmseXksM/X8wYHnf
mkM8vlsrASJnYeqx/ww8Q02qqWQwXshcC+ZLK2xFnPTF90vgBQsGb61Ix6G1ABbb
d1UbxQBRUfIBRwWHU7gDPOv95K86FXXTdIwdKRAxRROEfbR/YPdhvMPE26vaNihw
wOPnhiicz0cIJlRpIGiVlmDJIQlBr0J01WCrTNtvW5+m2Bkx9T4ZXOFbQ9wvIswB
CrhEzOn4gyFl1wMCQAnA0rEP3vgw2qL/SRcapht89ROitPE2xo8IUVdJRirtQ58a
IaX6cB9rGKtlZUSOenDKOYruhBaeqedzoVoxYNyFoKjDJd0inPE2G9V0VvBbpEnE
At6VLJ/LCirpMfRMntkDcBLEH0Zr5Xt478VOdiGuiIuTAyWwjeplV4FSJxHJlXCR
0TqL3s/jaOW2g072iA4O0Krh0wctu6lplsyxhi+L30tlxEPH6xYXmcEleOHjDp2h
zUoLu9UBnU7xPT5IwD222ino6OWhaEbVvcVQmsvDp/qsdsfkotyBiewwIjJI56kI
VNsJbrV9SarrP0QK5DPhSNpJF3l4kW73GCfmoUTY0VbFqNpFm1s=
=ENTF
-----END PGP SIGNATURE-----

--xbfjvnr32bjhxely--
