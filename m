From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mv64xxx: Abort the mv64xxx_of_config if
 clock-frequency is not provided
Date: Fri, 14 Jun 2013 17:23:21 +0200
Message-ID: <20130614152321.GE2929@katana>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
 <1370620140-17177-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370620140-17177-3-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 05:49:00PM +0200, Gregory CLEMENT wrote:
> From: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>=20
> This commit adds checking whether clock-frequency property acquisition
> has succeeded. Do not waste time to find baud factors if there is no
> information about the desired bus frequency in dts.
>=20
> [gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: Reword the commit log]
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

Please run checkpatch.pl on your patches!


--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuzVpAAoJEBQN5MwUoCm2CSAP/irODxSBxuj5IP/oFtEIofAz
aBHOfZ8gGu1/yG49gQlVnfts0h1cEHzgoeWPiiPdmQOqsJNi4DaOCTxDYoFLSJFv
H5ttu8xxkRuUzmKpQ3QsZ7GLOn4Qo+qh06yNlioc/bCZudBF5EC0xyPPXYYb09NV
qiUVIOtsmvdoGVhV5BfY6pXR8shmekpbXlumRKZFbujy/Z6oaWxxrww4FRiha3BN
Cp8esJPreUKFotLY0X5zyonP3q2BoIzLsT8N2bl84lhgyK3KTkflCm6QuNTcYkKX
OKgap/ow3begYByDFTCFRjgyot/xcIXBgaoJ+exJe4yD4wHwfp4zRgE8SkwKKxHy
BZbme6dDXJDXeOE8+mNmGYIZeLMLkeUPwpW4FEiQSnBxq4YRHYq/fdTyp2bzGV3i
scWdeH5WdCGDab487r4c8Nt7NBFIXyuLjSoNX1LUcTTa80kyRotwOcTPcAUI5PID
Wb0Te5o3ALDlC2+teDTYrYmA9jApU31Tjqqz3yfXYZNaaYzrSbSCLSDWm1lQ/gFa
07j2iHzEFg2FUagCrDyDBMipJh3w5/NPXYbB1rSmYwmmTlSkkKX40w7BbNGc/o6M
NK5dGIznYVufWVElWEILe0gygBimnboj37/B14Ev9arUOj1j9zZbs/DAF8g67pGf
dWgpfuoqUDxh2L+8cuoL
=1AoX
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
