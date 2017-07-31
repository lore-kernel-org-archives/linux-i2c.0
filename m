From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Resend, PATCH v2] i2c: core: Allow empty id_table in ACPI case
 as well
Date: Mon, 31 Jul 2017 15:54:17 +0200
Message-ID: <20170731135417.5gwvx7g4zctgl7hl@ninjato>
References: <20170717141328.52286-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hwxgwm5btxfu3jab"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49346 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbdGaNyT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 09:54:19 -0400
Content-Disposition: inline
In-Reply-To: <20170717141328.52286-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org


--hwxgwm5btxfu3jab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 05:13:28PM +0300, Andy Shevchenko wrote:
> For now empty ID table is not allowed with ACPI and prevents driver to
> be probed.
>=20
> Add a check to allow empty ID table.
>=20
> This introduces a helper i2c_acpi_match_device().
>=20
> Note, we rename some static function in i2c-core-acpi.c to distinguish
> with public API.
>=20
> Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed dev=
ices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-current, thanks!


--hwxgwm5btxfu3jab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/NokACgkQFA3kzBSg
Kba/ChAArzFVlSNJwgMo+W3qWGvcT3bu/GWDnOhYcrQ7IhWM86ZvofCfDg9JyvES
5h1YcOhonYAM770Wr+YyYZd23f1J/TxlSLJfCprQaFI9uOjfibEMOaP5V5z9iSAl
lFvLafGHvtdBwmIM+KkYh2M057CIhFBJok/B6qz4c4AJ5/8AIvfb/OyH2ldtMomI
xFTHlmepRRLdbP7LbCSeJ7W8rykcSkuS7Nwb7V8Y1NkQe7PyICFZW2edOVYqMc4L
Jh1fL2y96RTnqOUhmkrDLILNcQijgJ6K7IuE8fxmxAJyikIVGIkz+Z4RKp/FE0g8
ebNZ5BAfGWyYET17/Bub1qQNW4cO9s9sz/mxSdBQpSZiM523KX8llkeUurt/B7l1
wVuv/ubwhUKeM6naRJL7GuD+4b/EZW+nYncq0nA3tdYgZRsLvYE2hYJTxcWrK/+a
7GySqu/WtFNVJiSnu5u8XWCkDzb9juxpkcAZeEF4xLjXKRHsvghjutkypQ1lQoSp
0k2v92EtXteAzIpA9fgPxUKR7ra2T9jn+pqUY7ZyNXYgDshz1XAxAW2ame/GoCCf
Q99dbli8tiZ+Y6JJd4PNNwomRdVA2NFuUDO8J+hCN02KdAKVHjmPN/ny94XNcorJ
lCyOZ5El3jYXaBQoFjvNOGjvBstB8pr7HLiJLYhaBI9wGh0lG04=
=XD4d
-----END PGP SIGNATURE-----

--hwxgwm5btxfu3jab--
