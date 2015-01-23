From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 3/4] i2c: designware-pci: no need to provide clk_khz
Date: Fri, 23 Jan 2015 15:36:47 +0100
Message-ID: <20150123143647.GC9592@katana>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1422014045-20584-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422014045-20584-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 01:54:04PM +0200, Andy Shevchenko wrote:
> The clk_khz field makes sense only if SS counters are not provided. Since=
 we
> provide them for Haswell and Baytrail explicitly we may omit the clk_khz
> parameter.
>=20
> Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwlx/AAoJEBQN5MwUoCm2bboP/3Ori2MxQEC3CyXTedqq8h65
Vu7UWMnKnhczDlFyJJqKEuvRoBNsp9dseJq/XMoioxKHlIHSVdO9FQHpI7nkpNQ9
7NPJCPV3lXVhgGJP/rWvMNGpeP4jcYoYWtjO7wwFOo3XuadqKw25IJ/+6SQ0IYCJ
oXPrEhAcjK5LeJDuV1QtDt9iV1PwWcZ6LOABcBZT6QX9QDKFR/mS37cydFpXkrsC
hJ9/O6BU/kxKp3QpDAdPuulX+9qrMiS9Hq8s4vcl2b2C1PHDa6a9J0U9psHiwHEB
Ggax9XajXipel6IOZcxlrDHREhjLCTtXOc56kWMC0lj/+0bziOnyA0zVzF85L1FX
gYO7ds/G83/T+G6+rwv5yvBev8oGbOLUJB48+iXm6gkcxiSvfmuMQCWA+nppbCjy
Oo2vy9Lj/ovhhINuu2pflMQ3hAdP2xrtXGXi2nLYotk5ev9H5FYmp4xhEAPoa7Gt
iE1pP54OlgxVgL7oi5v/TWUbeiTtJyBYpGqhtV+pK8gHvuWjroi/d5t2L6k0GZHH
PYJiwZQoYGIWqbkO9fYwltVC5S1aYE/ckRpE//qfjZ4N3el4UL3nqamJCCM0nOgH
eA/s19Yq2gyKt37egSxP9L0Asar0TMdbn0GGGGgfGYPraa0ZyRzSE/mcaFIDC0dm
WOZ1fz08T0TkYD8dsB/C
=4Bin
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
