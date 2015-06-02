From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: designware: Avoid unnecessary resuming during
 system suspend
Date: Wed, 3 Jun 2015 02:55:33 +0900
Message-ID: <20150602175532.GD1494@katana>
References: <1432132393-693-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432132393-693-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 10:33:13PM +0800, Jisheng Zhang wrote:
> Commit 1fc2fe204cb9 ("i2c: designware: Add runtime PM hooks") adds
> runtime pm support using the same ops for system pm and runtime pm.
> When suspend to ram, the i2c host may have been runtime suspended, thus
> i2c_dw_disable() hangs.
>=20
> Previously, I fixed this issue by separating ops for system pm and
> runtime pm, then in the system suspend/resume path, runtime pm apis are
> used to ensure the device is at correct state.
>=20
> But as Mika Westerberg pointed out: it sounds a bit silly to resume the
> device just because you want to call i2c_dw_disable() for it before
> suspending again. He then suggested an elegant solution which keeps the
> device runtime suspended during system suspend with the help of
> 'dev->power.direct_complete'. This patch adopted this solution, and in
> fact Mika provided the main code.
>=20
> Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Fixed the 80 char thingie and applied to for-next, thanks!


--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbe4UAAoJEBQN5MwUoCm2b90P/ihr1lVQQav0/JRx6K9n/X8F
zhbT+klu60a+YPwazGaurSLwaKWnd+GyVytPK617aKiOEGlgK4nFITFRBfFAR5AU
D4d3vtcVKAt8emxyltJHOiP1XOrHfV+pj8vDW9+IouPDN5kJwuNnZKhElpSrJPe/
ct+WsggxbpmaJPXOHwrmMt1ON/69qET6tOsM1JqyFvmbH8QkJmtIom0Z9nOR4dHu
pZ0T3VKs8bHd6UIt6SOPmbWTLVWjo0Igs2oCU+qXi2m6vhHG0SVSnTqnyRnKoIom
cGD9pXEd59B5OdiwWkmQgfvk3aid4Uoi9+B3bR2cHcaAqajyvToNTFPngmnln1jc
zEavn0QJTjof1TOXj2QVnTweQTJjn/0kSVmy1TcCZ8t94bi/AI0eNgtJdey8Q6hO
kkTP/Rs6po7mdl/JPQuR90ITDGYxv4FgUrPl7HAEKf0kfneyxB8oyw7b9dtrr1RX
rI6836e9454vcMDnvwhXMNbxwdiozJOVIJfds9rgwH4drX02hT2Qlkt9r6g5oDPS
2QFYrHNKUGWlQqiuRBrk2aANkY1kfFOquAbXeB3KqUZ2beZOFQnYE6pmm5wg20rq
+uRXJwMpzbbddQio9e0GsU8e6qjO1/3YbiA5RlzBlkacTXTC+hpEpLKnfeOI0s5M
j9WtM2vVKcQ3YeQPjeR7
=UbUg
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
