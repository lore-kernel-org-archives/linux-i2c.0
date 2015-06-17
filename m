From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Make sure the device is suspended
 before disabling runtime PM
Date: Wed, 17 Jun 2015 12:16:45 +0200
Message-ID: <20150617101645.GA1517@katana>
References: <1434532118-119906-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434532118-119906-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 12:08:38PM +0300, Mika Westerberg wrote:
> The driver calls pm_runtime_put() right before pm_runtime_disable() in its
> ->remove() hook to make sure clock is gated etc. However, it turns out th=
at
> pm_runtime_put() only calls ->idle() hook without actually suspending
> anything. The following pm_runtime_disable() will prevent the driver from
> suspending thus leaving it "active".
>=20
> It is better to suspend the device synchronously to make sure it is
> actually suspended before disabling runtime PM from it.
>=20
> While there, undo call to pm_runtime_use_autosuspend().
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

For current? For next? stable?


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgUkNAAoJEBQN5MwUoCm2Z9MQAJyC8o/sx62y8bVQWXurckFn
SM9zt4Y/teAp29Tw0/y+Ptn7qMebyELFrOr2yc0/2DXOA7gR3rwyPlrBRqtDRVky
KgpNbN6f1vVFH9hGOGMo4ACcgQZ2OvC/F256fKEwaHjjq8Xjn8pNC9aesjVWjGhx
dm1Go51ZKOVX3cthpX2m6hEr+Ol02zJoEz3QnrCqqYL79ChhNseNk4Z6LQZ/oeou
2Kue0Oqh66SdflcjavEYqkYH4B3GQCKpNPQphYPnj/Rx8h54DX9Ct6cDf5Qjf7e+
KlFxASER50fgqNUTRP5rcblf5/4+bj7nccdCZ0blo5EDFEneCUxvzUo8h606aP2R
X0ftxaK8itgJ31Ux9+NgwxOaMre8oVZRAstQSJ3VHfB0gwqkxQLf77yMP5yCEZSG
FGoFKrXW0o+YgU+aRp+GELSRNEOGaMOs94NEmWTmS1tvlDDbjpgAnO4AHNUSLYaT
p7ilLkLLrx73ki36Zpu1WL2355ZIfxRRZGBhU/t7mezzyA9rjJB+B8hSygN3yuST
KjLCdSCSFszY7n1MnF6g1G15hNK62jfho5lKgFUBUBwDYpJGd8iPTo73PCVKny6Z
+ZBqyxvAP5x5C9RoRFgVcB1KfebWS9gd6492RXZ4lJ8k7ecyFKCRfsIGA7ZPz2mC
7pecxZ9Saxa3/S6DkYl5
=4ynV
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
