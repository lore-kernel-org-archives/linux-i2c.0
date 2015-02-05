From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] at91: i2c-at91: improve time-out handling
Date: Thu, 5 Feb 2015 20:40:18 +0100
Message-ID: <20150205194017.GI15307@katana>
References: <54A58BA5.3080003@interlog.com>
 <20150107103113.GA30897@ldesroches-Latitude-E6320>
 <20150113152752.GK7660@katana>
 <54C41FD0.2010607@interlog.com>
 <CAJjB1qJSBzwviN7Ey+9AHmiEy1PcTKOnPOWVc8xFCZmfkW-BRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJjB1qJSBzwviN7Ey+9AHmiEy1PcTKOnPOWVc8xFCZmfkW-BRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, patchwork-notifications-2CcfMPLixEJ8D7ILJbWmE2D2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 12:19:23PM -0500, Mark Roszko wrote:
> You can check if ret =3D=3D -ETIMEDOUT in the error path instead of
> allocating another variable.
>=20
> You also generated the patch with your /arch/arm/boot/dts/Makefile change=
s.

True. Someone cares to respin this patch?


--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08chAAoJEBQN5MwUoCm2918QAJnCh9gdQ2/4pNKInwnMrSUY
oF3ytHs39NtWmXBfSFfrWv20qO9xovwe/ArZ9Ee9MB7XpeZqNx/fvJJNb2biWYDa
HAbJEQHj+ns67ybYzXUUPZVgKN0hp9UNqmAEBOzZMhfsg/QNDuk85ZCsQn8Uw34q
hJOadV8iMA3pfcDFp+uhbVkblcslSIr3XLh7Nqu/H3c3DbbXYxrqR5yic4uRV9Qz
NCbgCl+sV2/Z95X/GLZo3w+m562uKkmwa/I4p+K8IOrcuHmhLQeiMCh+XbkRxrUf
AFrJYXK73Jxc2NDkfIEQhzNuO1nQ+AxDZcYtiF68a9Okwc2qEO+L/g7/BqYPZ4c/
3UtpdAbZkydnemGWSbSW+LyPWhJpB6CTegxKr/gEwuodP8h9diq3pCmbJKytVMMg
nBln9vIEwU3N2QWMwoqVpgRK3KUjWItMr5FISzbc5rEzbjkK6bCeMd8s74rMEOyv
GNqfwR0pX2B/AeNi/jFBk4l4PFvtWfTGFS4aKJ4TDs13B4wSIGCg/p7JjkFqh5n3
7eFngAtYBj5gZpktdAy39AFiBNOiEXVxndtZU7gK4gawmPtnfeuDxcRQz3OoH49J
YN/hV5sWqAHDCN/ruAEXN5LtsiRIw5EX9iQQ1a/yLP7WkojgXhJG3OOx7S6m3FNO
OFakscGT45l0gIJNCGps
=/eQw
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--
