From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
Date: Wed, 31 Oct 2018 23:34:50 +0000
Message-ID: <20181031233449.GA8321@kunai>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 09:59:57AM +0100, Charles Keepax wrote:
> irq_create_mapping calls irq_find_mapping internally and will use the
> found mapping if one exists, so there is no need to manually call this
> from i2c_smbus_host_notify_to_irq.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Applied to for-current, thanks!


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvaPBUACgkQFA3kzBSg
KbYfxBAAtKkdgSH7diyovqtOOPfMLlgAYE2m7svqntlXaDoBV3uUZJZJX7h7EgfO
MqFupkK70VWjOYO6hMl/Jsk5NPtjOcvQb0TLQFXOAo+KDIK3P0iFuWl0o51CZKJq
WFgXea/IublAzqCBFSsceZp5BX21/41f9syvXCBFwR7e49+LNEObVBsYjhOqMiof
HvxcQ5+EzMZLg3IRSN/0qx/HLGTH/AcqTnHCBWn0elt87msk+hpDAJ19tgpdZ5Ho
BaCA1Jx3wUxrdhJwCfgvYNDXw6M+5FJ7pQVUmcjiJmIp4mp81vEkXfGO/KgLR/hz
dVCPP2eBw+AEGoYfsFixFU/eiG4/zyhH4F91Ykz+2c7qwOm/rMNThRaxvTD2Q9wk
o60anL3+UgLtcrO5U/VuYryKfEONlGYtK2dYH8ccKyvN0l/JexyvdG7O2bjU5KWX
/3Ywa5KoFCJRurYkHN2+19505H/u4XiMFQonNE6kTWaLJi7xemMKb5bpNiAKwayz
L+0Em7ZoD94H/xbh+L2grFZJTOOGNqf4hFF+epLg6eV3UnwySEmPLdcgGR6J3ygn
iisuoJnxIRUL1M87Q2vQmKZwCkWbqTkx5fY+NlQZ+jhJWAvDrMbYinIRC9Se9XLa
uy7jtlTGBfZbCwjVzCVn5QeSVcA6L3MoBNhyhVwnx4dBbdOuk5I=
=g1oi
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
