From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 8 Nov 2011 17:23:46 +0200
Message-ID: <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <4EB9477E.8070002@atmel.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EB9477E.8070002-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2011 at 04:15:10PM +0100, Nicolas Ferre wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 11/08/2011 03:41 PM, Felipe Balbi :
>=20
> >> +	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */
> >=20
> > I don't think you should be using cpu_is_* on drivers.
>=20
> It is a common pattern in at91 drivers and has worked for ages.
> Do you think it is related to the need to be able to compile the
> driver for any SoC in the case of multi-SoC zImage support?

we have drivers compiling on multiple OMAP versions without those hacks.
Generally, we check the IP revision for that. Don't you have a Revision
register of some sort ?

--=20
balbi

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOuUl/AAoJEIaOsuA1yqREQ/8QAIyXNqyfnLJQ1863qTOyPjCn
agTrRMHoYqPCN+4ez3XHuFixFj3wbpF5ohIsLaHIy79QN98vgN3H94a+z4K19KN9
OWYQ0EfxNUiMHarYP1uEHvuWJIYvULJE2v0DcqWsPROQKqBPP3PbppeLblnsIuwT
XNhWLo6XmMKHYdbI2O1LxvOKJB9uBT8G9iYWIkEieR/4RcxTfLMr+mfy9+950F35
xeXHRn74t4u21kIMJdIavky149zNwrdzzdHkCNJn2VfiDILrQMBcsUTTU3+rePOC
pZSYWZ37aS9EM2kvwFFETj1Hxpbm2ybk/AaxY+BEvkxXj2dP5oXlGy6dCgMnVivT
Dw0zy66u4vMH1eppl+vaSbo+hU7QwgRtL0InSPpxdH9/eNa+t71Le+/MYcXBeyX3
BAQ5UY9IradHsGlfEmJInZGiTjGzwl43tQBpIYDq5+ZVB9Q9GSs1nOGHcsiw7BGp
aDgPea0LCRjR425cODfBvOj0FiDWMvUqpyfpSRfKdmrwJLmRuqdCVfts+jfVhRn6
zSFMfl/3IU1oIXFcWDSTkeQTbXGyjDeXSkBQXlMh4Uzi3oIka77NBqduLn4a6a4o
y5/GFLe1HU6Ez8taYDqQyNSZc3LqNZhCQpd5fbnVvk8kh7HYKqxVJBUaqMWM6GBL
IG9FHtibdS1aJ9b7vKE2
=PHMG
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
