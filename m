From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Tue, 11 Jun 2013 20:22:51 +0200
Message-ID: <20130611182250.GB3376@katana>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130605133945.GA2934@katana>
 <20130605213144.GB14209@lukather>
 <20130610100847.GG2748@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130610100847.GG2748@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2013 at 12:08:47PM +0200, Maxime Ripard wrote:
> Hi Wolfram,
>=20
> On Wed, Jun 05, 2013 at 11:31:44PM +0200, Maxime Ripard wrote:
> > I guess it would make the code much more complicated for such simple
> > drivers, so I wouldn't push too much for merging, but I guess it's your
> > call.
>=20
> I'd like this to be in 3.11, would merging the driver separately for
> this release and merging it with mv64xxx for 3.12 be acceptable to you ?

Thanks for the offer, but the chance of a regression is too high when
switching drivers. Also, configs would need updates then, etc...


--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt2r6AAoJEBQN5MwUoCm2SR4P/0Ey9H9DLttLFHD78ShtK9IU
Qj16/RARx+Pg8NNeT0zQ/l+TzG8QBcoTP+zUVdeBUzeBghxKiUsfuSB99wq7UGlF
n1/ljxZDvR9u+o7qzze4CjnedrpASrjpcAc3VTzM6WylUV91mjsiN4en+UNE/RlQ
aSNQ5Sr87g32ZakRsth+9Y43tYf5uFHlIA1b0tKfNDeipTA5BhErrRNmWC1iSqqY
ShqEMZ3v1dYPTnbEZVn8B1pYfJM0H/l/N8efsvxJvFVByxixEIbPJ8t9zI4QMB+6
1wAdd4wmiCxLkhmQ4YquGrHG3XEQDZi4K8+Fs3/Dj2uw5AiRGuQdXYNK+8EdMwhD
K7toKYpgBJykqs7cPSXFcnAdTyPlWBbzXKATrbVC6bptQA2JzwJZWYAjDVW6VlRr
hq54D4QcoaGfcwC0KYV8ngD4inOdxxzCB7VXqaBW8+Eb8tTpuZfAyjcruIsmZGjX
V1wouaWvGtBO+REOJtgMZmixWe3V4Ash8DuQQqzlL/LSSR3KkcYrhl9q3UmJkGAO
nBUFcEtKKrQTNV95MijNGS6YYHQXm3k3T9uv8KvDz+DVhIH4idBYyUgrBD7hqltv
JciOSUnszsYRxwbbIk0J6lpg/APFFfP/XGgVnuq1Yy73Aj4KITbJTKn85PbZpiZw
pNzst3SuRUEhgs8M4OCB
=B0yN
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
