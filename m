From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Date: Tue, 26 Nov 2013 13:57:40 +0100
Message-ID: <20131126125739.GG7427@katana>
References: <529303EE.4080606@koalo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <529303EE.4080606-oZ8rN/sblLk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 09:01:50AM +0100, Florian Meier wrote:
> In order to find I2C devices in the device tree, the platform nodes
> have to be known by the I2C core. This requires setting the
> dev.of_node parameter of the adapter.
>=20
> Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>

Malformed patch, please resend.


--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJrDAAoJEBQN5MwUoCm27HgP/3H47gv1ZS4LdqjwRyT2APY1
fpTQB0bvyJzexjMKFpWUoX7s+yNwnbTHe+Lo/gl9fpzytAD456DTPiYIfRAXYvck
dgFW8+M6B8rEGRVGebqt6heDeY/ca3j70wFOggggxl6sSpSA3ourCloXQizeGjOl
3ootYQ+g4nTa47xsqIjB6VjQnLJQxYmVtmgg7wzY0CaUlH7pal8hJNSOxgjd3nTN
OVveem54ZlPY7oovV7by77zo0qMicxWEOwBO7jzPUrzPbDEb+/J9+YivW0d90MLa
XnStoAPKv/uvH/HIu4oxVSy3M10VVjoVPD2u4zlJB7Csv1iA/MZB1NKZin1sWNs8
/iWqwtFbZiiY3J2TSD1N0bpWWPY3eUQ2kGxb1C8pYjueqwHKZSVdrvRLhjpZDyLo
Da0HHf/MYrjeN8ud+R3RnobUbuz40Z4T8ipFLxsG5liOXW2qCkqURPE0GqAmMVq0
ot3wVRaMp7DlLMCvAZv7sYL29y8Js+ckV6FzhMU+on2MuVTds8HhXN8zvVIhbi1M
Eq/I70eqoAo1xT3yJPcgFUi6mYmNYIiO7DuSCrMH9YeOXWWzKyw4UqqrAZIZGoqY
o1f0WjHP4NMLw8t69QHZXY3u7lDaV4lurCwznqb2Co+3e08IotJronDnzKcHkP5U
YHi2IS3V+hQLkiMlIB1a
=krvV
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
