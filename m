From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF device ID table
Date: Mon, 14 Aug 2017 21:52:36 +0200
Message-ID: <20170814195236.4miomp2omul5qikt@ninjato>
References: <20170809101256.31204-1-javierm@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="axy4lceqhp2ztxms"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170809101256.31204-1-javierm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Luis Oliveira <Luis.Oliveira@synopsys.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--axy4lceqhp2ztxms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 12:12:56PM +0200, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees as shown in the following DT binding doc:
>=20
> Documentation/devicetree/bindings/i2c/i2c-designware.txt

Uhhh, that needs to be fixed to something else! I don't think i2c slave
functionality should be described in DT. The slave functionality is pure
software, so IMO it doesn't match the "HW description" requirement.

> But this works on the assumption that a I2C device registered via OF will
> always match a legacy I2C device ID and that the MODALIAS reported will
> always be of the form i2c:<device>.
>=20
> And this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for finding the issue, still NAK to this patch. Are you
interested in updating the docs?


--axy4lceqhp2ztxms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR/4QACgkQFA3kzBSg
KbY6KQ/8CAl8v5SLo488XYsCvssJBJ5RjcjwL4P3oUyM/UjbMTYK/sfXAR5zU2Gc
bWM9zeIA+Ys2kF2Jv9obgbxjQcx3tHgOsohU4OXRbRK5Y1n3bigGykuBWHA9Xt7T
vc1nqwQpwbSArByyY68f7gSLJp3FTyTvhcRfLgN+dLtPqSAjpIbzxwvT58zN6X/a
ZjoFkUlf6nfa+ZNqK0tKZnf2yjssXe/UXNYBecDTUxYih6MzAhJSn96rP5ySBIeg
jCtCVgZswk82pZgY4aWIYcERtLCsyqWWuh1Buy5j8KFsbQpUve5Kv5OmCaa0YEm3
oczUTIGXJI4oQ5xXniEQbCWyvRQORYgrJ603z5zBCs+tbgHdE92L6C/Fpuq6edMn
baWj2BKmKK4F6cKIJO0/MT8w/tC0h/f3RqIjhXt8mHZKDT0IiK9GN7g6/PatUup8
MJmq7of1PRKXVQVao2KtCRHLUQYUoD1TWtWJkTB6o5oi+Mbdci43MqB0VjOZwp4z
UkoVv0J6jvDywynRpKzKfskolso8/pm0+uSa3WWNy7c9kx5e6OWP4uQAbnnr+k8i
CNkx4Sc4kUYc74lNMIkxfHOQXEyVxA854sVQQuUz7HoB1KMkvBuAV9MuXBcGV8cx
I09uvptgNZN09DyWWmi72HksMbpvipTEUY+jJOOgJefxJoGh2rI=
=i/Xq
-----END PGP SIGNATURE-----

--axy4lceqhp2ztxms--
