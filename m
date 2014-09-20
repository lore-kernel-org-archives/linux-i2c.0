From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c designware add support of I2C standard mode
Date: Sat, 20 Sep 2014 11:24:57 +0200
Message-ID: <20140920092456.GD1612@katana>
References: <20140820124231.GD21734@leverpostej>
 <1408544948-22339-1-git-send-email-romainba@abilis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408544948-22339-1-git-send-email-romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2014 at 04:29:08PM +0200, Romain Baeriswyl wrote:
> From: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>=20
> Some legacy devices support ony I2C standard mode at 100kHz.
> This patch allows to select the standard mode through the DTS
> with the use of the existing clock-frequency parameter.
>=20
> When clock-frequency parameter is not set, the fast mode is selected.
> Only when the parameter is set at 100000, the standard mode is selected.
>=20
> Signed-off-by: Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks to all involved!


--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHUfnAAoJEBQN5MwUoCm2t9QP/12DCp+hYOUOhe3RXptqazuS
CemJ/K01ugpHiL6/VS8iqFZ6WHNp6+1sz/rAf6xJqf65HaWDvAX5BKRQpJW37EH6
/GcxYDfsPlDFZbGcCd3kR3r+i5KBrCeWdlBHQIbWo1IiLD0OElsCJdAEothT2wZC
llXjAHJYNBYXUQbyVoeyt6HDdWvJVZdjrBi5eT5EL5oP+w3Fl5sh3vnEdHFi88cw
IYhqcUP/9MpRSsQ+4LpsNe6fGBZ6ss49ELKKnAfNPdurYAZy/X4Vv9vJZwJh6zly
c89lIfBtSikVjBq/utMXqh35Wgeb15HLaw0qxW7q7mqOLYxEYlpVTv+p9kXQrvxk
rKXwQqpkPi2SYfTmxQFEvrhbFSBZiHwCI77BZA7WZ1AbysnagCtPx5mWVNMx0q2t
jB4TVGo/hHmkDkvWKOpKxFN80Bnga8iwTZpVY2eKeXkh6MUniVrkhUnpvWSGMqRz
z+GCCLShW8mokEDCk6esPMyLR2GQzYrUDGACiglbEagxyorHncnXypBAeo+XpSwK
vjTsUXigsQGgA98fGZGWVWP8eQqUHFJIbUg42sSkHwoHKkSk1wVGwFRg/DDP3C+U
bR13tjmM9CzuGbuHSVszh9JnSYHCfAuLzgCmaxD7fnF4MuQ4EVwqz7v1b3EYxWHo
XfNsKTZIirQPmgDsgG1P
=7Dl/
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
