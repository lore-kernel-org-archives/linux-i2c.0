From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] ARM: at91: sama5d3: reduce TWI internal clock frequency
Date: Fri, 22 Nov 2013 15:58:35 +0100
Message-ID: <20131122145835.GB7420@katana>
References: <1385129228-11225-1-git-send-email-ludovic.desroches@atmel.com>
 <20131122143350.GA7420@katana>
 <20131122145141.GB30749@ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131122145141.GB30749-tOglhBvtKaELqBSMlTbpHvU/3Eu2kcEP@public.gmane.org@atmel.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2013 at 03:51:41PM +0100, Ludovic Desroches wrote:
> Hi Wolfram,
>=20
> On Fri, Nov 22, 2013 at 03:33:51PM +0100, Wolfram Sang wrote:
> > On Fri, Nov 22, 2013 at 03:07:08PM +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org w=
rote:
> > > From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > >=20
> > > There are still I2C unexpected behaviors which are solved by reducing=
 TWI
> > > internal frequency.
> > >=20
> > > Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> #3.10+
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >=20
> > I think the commit message needs more details. Is this a true bugfix
> > because the real bus frequency was too high because of the wrong
> > divider? Is this a workaround which makes things work but will make the
> > bus frequency slower than it should be?
>=20
> This fix doesn't concern the i2c bus frequency, only the internal IP freq=
uency.
>=20
> TWI has been validated at 66MHz. With some devices, transfer hangs during=
 i2c
> frame transmission. This issue disappears when reducing the internal freq=
uency
> of the IP. Maybe there is some oversampling on i2c signals.
> Unfortunately, I have no clear status about the root cause that's why
> the commit message was imprecise.

This paragraph is a way better commit message IMO :)


--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSj3EbAAoJEBQN5MwUoCm2MFcQAJRqTuplGJlPhc9dAYlGwNMD
+8B6LH7ZUOH5SkWBD+uqTWvtu5EiAvGeqvQ2rxXDDf9mAdqWojoLwtXNsYAeF1Ab
mUe0z84lP6H7TnIeGm0dIvXXIZ9tJtVSuiiYqTJeCaqRIhG/KpYkyPpCvWRGC4lB
MKau8IhfYaL077DHcvcAlhZs6e83GeCST9WAdyTxNK91yPQ47sLuapIhNXR1aExL
jbXXk/TR1XhWsq/JBRGWyvA+zD1PknZnLcKeTGWoOUdKZrNkX2kmD8gccuZ0e5JS
u1TJhPpxBF5CemYnMAtCQnMYEYuZUxfLvHXAAint84TR3D0UvEpkwOnYdLL5KlLg
1u6LUPpPz8D3hXLMK+mG+tEHyNTIY1koo0ZL/oU+WERk7+afdMP+EZ0gsZTQTb/6
wemLwA0bzM58vE2dsPpFxGWEunghKFnxofdGLIfNrEw1O1fKdK8q8vrjwjKXhHrd
3whnXz5t11/9rAbwFCowUi+e8T7d87y8tKmF6xju6Brbx9U+sz/lwF7QHaYRcXAt
gzps9kVoXAkwAKonR5KZ8luUd6AcTbjDbN6zGVNe+ieTThnOrsy/UapybEZTDgYV
n3/6uN1B5TV47GcHQ+GbrgrojAlBSLNM+JuJdR03U801SZT4UZRqrxqu6ViDKrNE
VD3ffBI0oItjXkMPXecK
=Ae7Q
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
