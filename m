From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 18 Jan 2015 12:42:55 +0100
Message-ID: <20150118114255.GB1113@katana>
References: <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
 <54BB795C.6040402@broadcom.com>
 <20150118094741.GE22880@pengutronix.de>
 <20150118110658.GA1113@katana>
 <20150118111759.GG22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150118111759.GG22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 12:17:59PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Wolfram,
>=20
> On Sun, Jan 18, 2015 at 12:06:58PM +0100, Wolfram Sang wrote:
> > On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
> > > > On 01/17/15 00:42, Ray Jui wrote:
> > > > >+	complete_all(&iproc_i2c->done);
> > > >=20
> > > > Looking over this code it seems to me there is always a single
> > > > process waiting for iproc_i2c->done to complete. So using complete()
> > > > here would suffice.
> > > Yeah, there is always only a single thread waiting. That means both
> > > complete and complete_all are suitable. AFAIK there is no reason to p=
ick
> > > one over the other in this case.
> >=20
> > Clarity?
> And which do you consider more clear? complete_all might result in the
> question: "Is there >1 waiter?" and complete might yield to "What about
> the other waiters?". If you already know there is only one, both are on
> par on clarity. Might only be me?! I don't care much.

It is minor, I agree: If I read complete_all, I assume there is
something fishy if there is only one waiter. It doesn't match. It might
work, but I'll wonder if this is accidently or intentionally.


--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUu5w/AAoJEBQN5MwUoCm2geUQAJEnu7R/+Jk/gusjSDqXbpJu
CYFKdbI/TrT2YVaSMZBDeUAbv1/TPP3r0hrSxwRNHlUvaM/k/cCj62xm/CG9t2Xq
7YEjjyAFa6jRWeumMbreNcjCLeS2KfeH3L/TNY6C6ZfUJRFlAMyisYJc/Pn4DHdA
vsYSik2pPYF9Q0E15ZxrRiO4ixg3BuPwjbyVfhl0XdcjJafQ1WpetCz4HTxD5SJ5
rOA+sqTeClIQ6HoNalk1HytZdarN+i//C8q+WrIzkDBQA9E09CSkaErwYpqiaDU+
PzfdCzZC+wo9+/Qx0c4G+XTeKyMAi7+Qupp+ckUHQI80QIgT6tb8UB6PLSnX212f
YQVa0dnD1yUMrxwicKDCUholu5OeTmd1YyEYmIWIPZyb3xNwDPp5cs5pLu9vlTOi
Xu6Dw4bqxWQBeKG/RbBTaGunrWA0ALquumya81p6mKhvnCxlWd8B70hdjitD2OXT
TU2JugP1s2SV7LAEnFLVPH9IsoJQMGyNgea+uqBaO6shWP68/SryDhJuFRQxvJXY
2sJY22kOG1YIfQCwIRRymxTGlhRmBkU3b4yWvPgTxKfJQNj4rhgOMeNjUsc8Kcdw
enZVJRV7RCrMEtGbt3Cuk087DI0MzjBcdp+EXuP3MxZoTUf8C3KaiKsMK/4/WtWK
g4tJdmBigKm9ndgaVRRG
=KVgA
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
