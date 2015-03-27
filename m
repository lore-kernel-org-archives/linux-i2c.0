From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: dln2: set the device tree node of the adapter
Date: Fri, 27 Mar 2015 16:57:01 +0100
Message-ID: <20150327155700.GG27238@katana>
References: <1427470630-13378-1-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427470630-13378-1-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 05:37:10PM +0200, Octavian Purdila wrote:
> This patch makes sure the platform device tree node is inherited by
> the adapter device. This allows the DLN2 bus to work with i2c devices
> defined in the device tree.
>=20
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFX3MAAoJEBQN5MwUoCm2R3oP/RHVAGYfwnnxMTiq2YEijyP8
0QIhJG120T4aiGIB9burQTHuzQoLUozKg7em+zxVvvrvDOE+Cjc65rBx+4Od7CLI
/6K+BOl+SiTpHTGV+NURGQs2bpEOG17vY5L8KES3a5VgI1bn7wLevYwzIg1TxOXl
k/V+fWgDKIT41Obh9C6h6hwOlYOnj8bjln5mXv+vzubB1usyIXPzLdOkinDYcmbc
eYj3odyoVX5Iw2cvrah/qkvgIg9p2GpqCkGZysukrNJ9qUq3AvwutAHqRG9Co9+R
EgUjd4pFio0tRRv1NBd92f3xf8RSrJn+znPUINv5sOyaNc9oHO5u+9ax9MbUiPQl
xhzoYe3ZX6kuFHRDqVIUzl5g9pBN/KdReTGqNnr/3XS+KQQnKb8E/4KiqMOyHb2D
cB6O4Xc1XThVQBMX7pA6N9q8tUtCPumlcYiw5WOi/Q9sU7Pe9i5FFXgrv1tcM4jA
takS/dORel6do4SdssMHsSvA5OTn0EsjGxw+LA+f/Q/etcBIzAS1dJ7e7463KTbZ
6RWyJ1JesCM/00lpi4E0vEK3eiXKK/Pt/RZUPR+srVr7kZHUoyLkmI5v21GkV8GE
aFZtxX2JsrcQIoqHd9C6+4iTlGztvDashUY1lMbQB9EW2ceY/Uf106eT7a025iO0
czRB8Em5O9d38JkhgUpN
=5duc
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
