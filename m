From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c: img-scb: mark transaction as complete when all
 data is read
Date: Wed, 29 Jul 2015 15:21:15 +0100
Message-ID: <55B8E15B.9070002@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com> <1437998162-32724-4-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VGxtj1WGCSq5EKt33GrLDJA94CkjVNDVK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-4-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--VGxtj1WGCSq5EKt33GrLDJA94CkjVNDVK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/07/15 12:55, Sifan Naeem wrote:
> We can mark the transfer as complete without waiting for the stop
> bit. This is important when handling repeated start transfers as
> we have to start the next transfer without the stop bit being issued.
>=20
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index 24b09fe..e27c3e0 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -903,8 +903,11 @@ static unsigned int img_i2c_auto(struct img_i2c *i=
2c,
>  	if (i2c->msg.flags & I2C_M_RD) {
>  		if (int_status & INT_FIFO_FULL_FILLING) {
>  			img_i2c_read_fifo(i2c);
> -			if (i2c->msg.len =3D=3D 0)
> -				return ISR_WAITSTOP;
> +			if (i2c->msg.len =3D=3D 0) {
> +				if (i2c->last_msg)
> +					return ISR_WAITSTOP;
> +				return ISR_COMPLETE(0);

That already happens in img_i2c_isr().

Cheers
James


--VGxtj1WGCSq5EKt33GrLDJA94CkjVNDVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVuOFbAAoJEGwLaZPeOHZ6lPgP/ifF3ARPLmd01o8TytYlobBF
QPq/8Qzrz75VQQ9Nhw10YgvQGwEN/bSCSopY16nAKqqyJTcTXjA6fQHdrWPl4w6P
N4EHHz7AiXZP+EWF5qN917JdvGrus6BO1AB9mt9A9oFYbdFjVHEAB7L98gR78aI0
MJMGSq4oCngSoDL8ZBoieau7pH9BLA72XsY46J6qsSS+OPW8G6ux849vwoSIdu8+
v0Ihfki/2MUb3L/PcN+CWMpa3RVq9L76Mo2StwLsh/rhd9iSXVDn4/uzX9CCrWjg
aUUY1iwc629yNzkAGZ9mkbJw/o3Bc2WnmmvnQu89dGZPAZXdq1J4T9x7yzswxxNA
qWkgKL2+JmN1iKLne6ZIJkGBcWpdGqvBhutytDsD9mExuMIjzcdFh8hGS1aRYR4y
PHC9GEBB4l9+KUg11fuFmCVt20AxVzn60XbH1RKQqErH5PG0sn14jnnL7NKsVZ01
7v/GVzya4b6EXYTAW6szmvyQQoYEmSZob09gDm7KTCV4W5s65Z69nBimEIPxpu9D
ctHE3tYVvQBxqJmoIVlZgwb40bjavCs+tO0/bMaycK6vu496Sx5625rPO1EqYbj5
bY2RfbHzQktzuZulc0g/Rqqdt2TU/QpiRlLKxJXwEveRxJ+B6l6UzWjH5XgBId6D
/bJ/bATiP3wVEGTrkg/x
=9Hof
-----END PGP SIGNATURE-----

--VGxtj1WGCSq5EKt33GrLDJA94CkjVNDVK--
