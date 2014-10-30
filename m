From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: I2C OF IRQ parsing issue due to probe ordering
Date: Thu, 30 Oct 2014 08:58:28 -0300
Message-ID: <545227E4.5070507@vanguardiasur.com.ar>
References: <2287003.09eTeKUr1V@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gOgA5SvUduQpahb5QIkSQIjTbDLtWOjWu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2287003.09eTeKUr1V@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gOgA5SvUduQpahb5QIkSQIjTbDLtWOjWu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On 10/25/2014 07:13 PM, Laurent Pinchart wrote:
> Hello,
>=20
> I recently ran into an issue with the OF IRQ parsing code in the I2C co=
re
> (of_i2c_register_devices in drivers/i2c/i2c-core.c).
>=20
> My DT contains the following nodes.
>=20
>         gpio1: gpio@e6051000 {
>                 ...
>                 #interrupt-cells =3D <2>;
>                 interrupt-controller;
>                 clocks =3D <&mstp9_clks R8A7790_CLK_GPIO1>;
>         };
>=20
>         iic2: i2c@e6520000 {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 ...
>                 hdmi@39 {
>                         compatible =3D "adi,adv7511w";
>                         reg =3D <0x39>;
>                         interrupt-parent =3D <&gpio1>;
>                         interrupts =3D <15 IRQ_TYPE_EDGE_FALLING>;
>                         ...
>                 };
>         };
>=20
>         mstp9_clks: mstp9_clks@e6150994 {
>                 ...
>         };
>=20
> The i2c@e6520000 node is probed before the gpio@e6051000 node. The
> of_i2c_register_devices() function tries to register all children, incl=
uding
> hdmi@39. It tries to parse and map the I2C client IRQ by calling
> irq_of_parse_and_map(), which returns 0 as the interrupt controller isn=
't
> probed yet. The adv7511 driver later probes the hdmi@39 device and gets=

> client->irq set to 0.
>=20
> We can't control the probe order.

Maybe I'm missing something, but I think your i2c adapter is probed with
a subsys_initcall (as many other adapters). Otherwise, I can't see why
it would be probed before the the gpio controller.

I think this initcall is your problem. Have you tried just using
platform_driver's probe?

--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--gOgA5SvUduQpahb5QIkSQIjTbDLtWOjWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUifpAAoJEIOKbhOEIHKiM08QAI8DAOiiz5oia4PV7XsnBUMD
gAqU5UuFn5rbGNyrZbElWBDOOIq8E2hnDeyVtgu5fQCHG0kFEUPl5d+NSoScQqBI
vrIbKZDhsJO6vRxtFxiKYbGxA//xX7jTkjZvw8eY7Sq7OE3ic0lxn7sDwBSnGR0e
9aQbeiIU/UN3XORbANVwTraz3MZrDeumelkmgsPyO+QWhsgBTB/yODmvjULM9wPa
GLfdR/83wr4RAydIPK/Lz6CySghyHmC+81sPydHsCL/buQdcAKHc/2VjfmPJ37za
navml0bNKybL56yOBInEuObGyE4SF3bvNJvFiPLa9vUpPyYoeB2s1kViey+783KQ
/DzwA3wTtfvQ+//xK0ScCyo4nVbZaQAB31zC/PN/shb1R3hdO7aYUkFgcWZdr+SQ
rPXemjTcxANLqPWtLXZcgV1smdygLIusgBbeoAoadq8m+sgo9jWJgl3EAYkWjr23
1w4eHxJAuKNUUVzorDK/jSrxzcclgc1ZRFZFumhbI3k9yj4hddDlkufrkxntllTK
jKJFyLmLTK5kG2v92esBsO3TWExWtiNsHw6ozs67xxpuim8Q+aSlUitq39Z2tlHV
wSzzqDzqxnYSbe/RUKYeZWLKiEb5UoFwOrFyX5uY9fTs8sUSE7N2qT8F49numMCl
i+bJbuSi5KNPP4h1Tzto
=LEV6
-----END PGP SIGNATURE-----

--gOgA5SvUduQpahb5QIkSQIjTbDLtWOjWu--
