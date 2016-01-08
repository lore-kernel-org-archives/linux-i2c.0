From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] Document: i2c: Add a dt binding for mediatek MT2701
 soc
Date: Fri, 8 Jan 2016 08:45:23 +0100
Message-ID: <20160108074523.GA1523@katana>
References: <1451888138-11471-1-git-send-email-liguo.zhang@mediatek.com>
 <20160104095511.GB1524@katana> <1452215573.2088.1.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7065712568841393457=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1452215573.2088.1.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: liguo zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============7065712568841393457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 09:12:53AM +0800, liguo zhang wrote:
> On Mon, 2016-01-04 at 10:55 +0100, Wolfram Sang wrote:
> > On Mon, Jan 04, 2016 at 02:15:37PM +0800, Liguo Zhang wrote:
> > > Add a dt binding for the MT2701 soc.
> > >=20
> > > Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >=20
> > This should probably go with the other patch via arm-soc, or?
>=20
> The patch about i2c dts info for MT2701 depends on the MT2701 clock
> patch. After the MT2701 clock patch is accepted, the i2c patch for
> MT2701 may be accepted.

OK. Still, dts changes go via arm-soc 99% of the cases if there is no
specific need to go via i2c.


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWj2kTAAoJEBQN5MwUoCm2O54P/RlUxOAPpv+DIon/rzmgqs9M
SJXYOBrjDdQXkVl1guHHFjJisHqwRksN2oqnLDLl84WyczJ0scOFnOr1982w9DkA
WUjSS5llcjEw0eIzPVeD+ofGQXI3DtFMCDqSjmZIElgFMlJ4PkgMejj2rcEcBdYl
W3+WMrwTYjm0zc8zRZdBrC3XRwPK5k0k2QGAqoVQAKMvXwIKTAjjUbXQPAOgn+Ca
+wcLqp7MDQpwKhB2sK6ybbE0sHKz+osyo3zPiVY4tZSp4InDiJbBR8A7Mdh6GQM0
0HVuZym2Sa/OepQxrat2x0IqDYHkZ4gi7LWG3f7w8U3U2ULKeQO0/157ARqAxFuS
K/6oiaCRoQreTa61OH3PlxM22sHyAqysMmtog4Y/NyZHOy5lqLKOx9ZPZPFr2dja
++/nh3glecqt1nZeKs/EiIwxU+o2qBxHXnpXCAdYTv6Zy8feK+vM9yHiyzA35wiV
E3aw9ZxEZH1ysuZdQ9Ff0r9HTGYeELc1flIS5h47Pr6ha1Vr3+ZZZGjkMxZXEik6
HWjcSGcKWJ/XoW0HUY5nk0EOqcICHRjhvKKe+1OsUE6juacNDrMzynXyPZs8lgcj
V30I3fKhAMij/lTgjLBk50YrXHcKHF5fipDhIKxkzLJ6m2VRNamXJFZSWJFLHUKe
R2Det2hMTCPBkxorqIvd
=Nd2Z
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--


--===============7065712568841393457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============7065712568841393457==--
