From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: set THIS_MODULE to the owner of the adapter
Date: Sun, 9 Aug 2015 09:43:12 +0200
Message-ID: <20150809074312.GD1526@katana>
References: <1437462876-13755-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437462876-13755-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2015 at 04:14:36PM +0900, Masahiro Yamada wrote:
> The owner of the adapter is missing, while this driver is tristate.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>

Applied to for-next, thanks!


--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxwSQAAoJEBQN5MwUoCm2x9YP/0WqYeCLDkjDJIyhLuUpYv8p
BxkxjQd+eIKEofLCuFx51Esriyoraj2GtpjGj9JQIxqfJgUNIh0t8ONhTpPa/o+l
X5fLOFuzOqIQCGKpYTl+r5/vt7tS6TSyY+QxopQ0T/0zb5WcdKqYM6XkOQJUCKIm
xnkciUHR13XaBiOhXPEzlcQpKJnhpdArQdNbUTkn2wr3hYa3OAbBa9Sy+SK906xA
7Ko67etUH87VD0g3viRbnCSf0iLRm1huNNZKX/FwdAFlJ/rSowb7wJhCu5nittSj
XgZ7qOxTwSTY4dzYOf3B/hU5/Vg0kj2vs/4Dr2nL4bUUGxf8TB74ImKBITK6XeDG
HQyJFjsr3DYr2iwl7FX+dOihtA8ceQbqP0wyG2vSR81Hvb0NkxoNMe7oT/8+d5uG
eMiVvBFbd4398ZYrfFQc3h1FBzN6gXWXTxKg+AikUXdan3Q+p/zAFX/H1WjltYLK
jSV152YjEM5q6DHJoPxX+FlmePgtVDemH07PpAzma5/udgHjcX15rOeYEs+i+rnt
+Ct9hE+Cq37xsE8dP/7IyhecTp4vAab6ZtI7RF67GyrfxCP3urpmFsb3z78eEiWQ
ae2i4MOHr2lAISXZd7JwZU+YpxyaLKU0tvWCtXHFnyVgb7rGptSCq+a/fkuMq+xI
HAXLUJoYv/Q//sJoOjkg
=LmjG
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
