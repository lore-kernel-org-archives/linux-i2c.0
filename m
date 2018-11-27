From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: add PM Runtime support
Date: Tue, 27 Nov 2018 13:10:34 +0100
Message-ID: <20181127121034.GK1107@kunai>
References: <1542625464-4704-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542625464-4704-1-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 12:04:24PM +0100, Pierre-Yves MORDRET wrote:
> Use PM Runtime API to enable/disable clock
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Looks good but doesn't apply on top of your other patches for me. Can
you rebase?


--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9NDoACgkQFA3kzBSg
KbbXKg/+PaHPpeBMe3trc612jj8iCfNxTvGRTOiNYdEvePpC7TW4mvtbe9OpJew6
5qU4zxwNxu3dJPjn+jHQ88X1X0zn+xq6j2W8pJSpQgb0wf+yC5v9AkTMT5pWDnOy
aCtmhkf/YxxHD0NceJ+02T0qrtA3ufby+W/HdPoME2BXuxgwyFdLD1+gG3OyHmAQ
MADTBUYfOWd/0Z8yV6mlyB+0i8+ZOV3sU5A7kq/cNg7PCYguMwM7ypZxWgwcfrwL
1BnRjF+4QZDAOkkj3iR/Tt1u89jt7FyqVDInSTn3HjeNyuvZCuQlKs9RoVrmjDJw
f24WfeBKoApIQgHzjCDmVp6hFHBDTlB+cVQjxsT+lStZWmXDUYHpX8+VsPh52UGE
s4LeVM4zHOEb9CLx4mvxn8ToxgS3/uIeWs7QZq4xQj7Rw21Qx4hsNYIHmdgoOnVF
ebUAB4YaOzdHciUq8h6Im38flwem7NlGB8HUJ1Wy+9JfiB60CA4BVGo6Cag1bwS6
3OGamIWz/czFMovY0uSlGAupvzV1kvIY5AHcdOXgCgsT3JurKDBE6Bo1q6eJceLp
U/cdTQF3D0eFMYeE6U6zG2NHUNupy0EVtWbGpI0PnbnKY2AYTugIZCKWIiOaITP/
7ORQhlSjTAFZW+4zqWdK+oEycWQGDQEoswY/vMPpx04VPFsjBJ0=
=H8Ez
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
