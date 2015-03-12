From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming
Date: Thu, 12 Mar 2015 12:29:17 +0100
Message-ID: <20150312112917.GA4888@katana>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com>
 <20150312094227.GA4225@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150312094227.GA4225@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 10:42:27AM +0100, Wolfram Sang wrote:
>=20
> > [    2.951717] omap_i2c 44e0b000.i2c: failure adding adapter
> > ...snipped...
> > [    2.964249] omap_i2c: probe of 44e0b000.i2c failed with error -16
> > ... snipped ...
>=20
> Thanks! After a first glimpse, this seems to be a bug. The omap driver
> uses i2c_add_numbered_adapter here in DT context, and thus
> __i2c_first_dynamic_bus_num is not properly increased because there is
> no static board_info. Will have a look.

Using non-DT becomes so rare that my knowledge about it gets rusty :(

Yes, one can't mix i2c_add_numbered_adapter and i2c_add_adapter well,
and this is even documented. However, since you are DT only, this
doesn't apply.

I don't know all of your dts files, but I assume there is already an
alias for busses 0/2 somewhere?


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAXiNAAoJEBQN5MwUoCm2wB0P/RQolTK8wVv63fnusoIH1Op1
pP4b/XXiluCt0CvO9YtTTCJ6Ucjoxi36XMyeVNSe4Am5g6miWB4Pp0nOa+dkKfgZ
3khWZ7wjGt5DTDsS7T+fZy3IMcdkB2UIgQ7K1b+fnp9WMaIuO+Xhl+dB5lenrTZx
Uxl5I0qO0wqSXCLPshUUIzHn9alLcQTdQZyYB/Pw3xk7Jn1l4yqoxfTEwb3XSCdc
e/CAyf1ZgKdu8kgabd/QRn3EpZ9pdfcv4pQGPL/Vjfr1O+YRmpqrEvGYN7C6gzJl
OJKI8wvSOoGSzwZcZrSgVL8yeHQ83E9tb4frXjtMd6fYQ9ijYe0m6tFzvUHyWo5Y
KvzMLWPU3nXaknxUQdG8XBly/z9hx+nXrSXT/cD8vdi0ttUKt2FAx9/38BKXQv5r
e+ydbYA+m1xPamNU2hVZiqFeVnO01IMpWNBxXM4QZV38cB3bIdXTOnXHHjSCltiP
MKhOqh5B/oVrzPzfFqmIhU1Xzl6553VlXrkRN7mdiB0F7quQnpLx/GRWVY5q2HJd
1uprHrwta92Iy+KqvgK1j/XKzdoQaBy26ySE3N/BS0WrKHalxGZkgLO51dOssRKQ
Vs6/U9pR9TVKFW3lq1eVEpbMHDJFkf8idTU63glFz5T8+xNgzsnply2aytLBEtCN
5TzD58shLT2i0BPqRviw
=RsQs
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
