From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: bcm2835: Set up the rising/falling edge delays
Date: Wed, 21 Feb 2018 09:42:59 +0100
Message-ID: <20180221084259.o6754bfe4k2hcwhj@ninjato>
References: <20180208135405.25446-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5389298864436729333=="
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180208135405.25446-1-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============5389298864436729333==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fe4w5l7zjwdsjedb"
Content-Disposition: inline


--fe4w5l7zjwdsjedb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 02:54:05PM +0100, Boris Brezillon wrote:
> From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>=20
> We were leaving them in the power on state (or the state the firmware
> had set up for some client, if we were taking over from them).  The
> boot state was 30 core clocks, when we actually want to sample some
> time after (to make sure that the new input bit has actually arrived).
>=20
> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> Signed-off-by: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> Cc: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Hello,
>=20
> I'm reviving this patch that has been posted a while ago by Gerd.
> It fixes EDID retrieval on some (broken?) HDMI displays, but I'm pretty
> sure it will fix other I2C setup.
>=20
> Note that I also tested the change with a regular I2C device and it
> worked just fine.

Applied to for-current, thanks!

Could you provide a Fixes tag if you think this should go to stable?


--fe4w5l7zjwdsjedb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqNMRMACgkQFA3kzBSg
KbZ/CA/+KqTtEPeLBCC+tUOol9+4roQFWOv3vSpe5uKKsUaiuAuDOmPLmZ7LzK8D
CExQU5+uua/nSVf++EZXkzzsOA7gDUPOVgDwCpfqs873cgxHu6Lvk19oi1+HRHhn
teYIn67JKQ0KF5M1kwet8Mgr1f0yoadG1Yd6aIhrJY+GlR1vnlDdkkqSnp7TIa77
W/E9bPTJB1kLUyMXILOBoSNQfFJFlNFvTDS/FMrzkL6gRN7Ve9XLKArLW8j841oo
3k/grWtbtJMETKToK5BQmJS7IgGMEqwvvIaEC8fs4mG34J9LMCFQiPux4pl6kj++
BEDzoC7ylYIzwHadj+fc8lKkETLFb+GMPkmeuDFQlJgkHd7q+jcXrMvg/bBWkd2E
YMO9/qxeVz1yAnOkffRC75QPov/UOqx1iRa41QlLy+963nXhkq/YxKn00OdMHD+B
KVXGzYKfL/g/hGz9ZLbi7dCFeKBUIS2qVA+2xNOtFgjJKVLYgNGGPScFabh+/dxN
6Z2BuD7itmpfiwPx4+fT+nhl127UAS1xYchA4ugLhaMDeUyI5H7f0hRtHg+h6yRJ
MHA7GRYvJ209wBJOqO5v7e0LR+pIAopitdcJ7m10W6DWLImpvkbthbkGOneawj7J
DPX4kdjYZ8zzpTFvqyCEF+1X9pbv8IqnZghd/iLnkao1jvPA1n0=
=Eyy9
-----END PGP SIGNATURE-----

--fe4w5l7zjwdsjedb--


--===============5389298864436729333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============5389298864436729333==--
