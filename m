From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Wed, 10 Jun 2015 22:14:03 +0900
Message-ID: <20150610131402.GI1592@katana>
References: <55534BA0.3000506@nokia.com>
 <5576C6D5.9070800@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5576C6D5.9070800-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2015 at 12:58:29PM +0200, Alexander Sverdlin wrote:
> There are several problems in the function:
> - "to_cnt" variable does nothing
> - schedule_timeout() call without setting current state does nothing
> - "allow_sleep" parameter is not really used
>=20
> Refactor the function so that it really tries to wait. In case of timeout=
 try
> to recover the bus.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDgaAAoJEBQN5MwUoCm2hDQQAJoQ1rtvNpCtj4POAaAqTuJn
KW6cFUyX0+8YRSQcYMAqxwJgHDkQ9jjfDgxFuphnDKIZ6VOpAT90In7TXIRZ0gsS
vYiOCizXHua/44AvYOutsYE37sSlYRXYSQZqt7AzdAfvSMXamPOkofp58yBa4Q9F
gby6aP0ROI957l93Sdfpo/qJfHivXn31S/QHNVTK9yVEiVZuoqw22F58qiyAZJp1
arH+pgjvCGw8VMVC3OpxgqW2PnaV6pUXOt5ay8+MkMmLOXpG+5LGfz7BNYOFktdj
xgHuLeGaaUBxer+VG90qG2G7+PvMRH7SD/5DJNsbhxJKP0ICVjvbxxILBbKty7wb
ARr8Q7CdoCwUdaPZ0QjKBpECifFBDI8DzSzoWpQ7MjepvgPd7TxAFPa7PxGFNsqY
4IuH05DvlJ8HrDKbWJ6H7Q/Tojgq0ZZ9eUblC0Q9nJ7ed5eF+PzPyYS3EBDZjbGe
VrHf1D7iB/We4fNOmqn0ugOwdP8oua+JnWuuJ5VtEGm7zU4G/Nxym4lVcuw/VjNu
l9CfLy9svxQQ3Yj/E9qZxtEHYThsma4JN7K3kmiYOZPvv+mVx8+8E17txP86vR8x
VLCYgXfwfyUi+W/c9vDAkT+4skEVjd5mTS3/mTPzXQKh11b1r9LQl8DVKJ2K/M5b
yLqs3O5HCxNDosSKMLhK
=PPLv
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
