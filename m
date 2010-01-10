From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: make PCI device id constant
Date: Sun, 10 Jan 2010 16:33:31 +0100
Message-ID: <20100110163331.0fca7abf@hyperion.delvare>
References: <4B49E524.1090404@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B49E524.1090404-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, cocci-dAYI7NvHqcQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi M=C3=A1rton,

On Sun, 10 Jan 2010 15:33:08 +0100, N=C3=A9meth M=C3=A1rton wrote:
> From: M=C3=A1rton N=C3=A9meth <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
>=20
> The id_table field of the struct pci_driver is constant in <linux/pci=
=2Eh>
> so it is worth to make initialization data also constant.
>=20
> The semantic match that finds this kind of pattern is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @r@
> disable decl_init,const_decl_init;
> identifier I1, I2, x;
> @@
> 	struct I1 {
> 	  ...
> 	  const struct I2 *x;
> 	  ...
> 	};
> @s@
> identifier r.I1, y;
> identifier r.x, E;
> @@
> 	struct I1 y =3D {
> 	  .x =3D E,
> 	};
> @c@
> identifier r.I2;
> identifier s.E;
> @@
> 	const struct I2 E[] =3D ... ;
> @depends on !c@
> identifier r.I2;
> identifier s.E;
> @@
> +	const
> 	struct I2 E[] =3D ...;
> // </smpl>
>=20
> Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
> Cc: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> Cc: cocci-dAYI7NvHqcQ@public.gmane.org
> ---

Applied, thanks.

--=20
Jean Delvare
