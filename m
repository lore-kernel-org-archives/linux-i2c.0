From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-tools 2/2] i2ctransfer: grammar fixes in manpage
Date: Fri, 7 Apr 2017 14:13:09 +0200
Message-ID: <20170407121309.6anksmcltjgtmkex@ninjato>
References: <20170403173613.2238-1-wsa+renesas@sang-engineering.com>
 <20170403173613.2238-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdX7JayJUD5dO_WSvtp3YuKrf3JEGd3C2YAzcgW6W0zjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lfcjhvsk27yscm2z"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX7JayJUD5dO_WSvtp3YuKrf3JEGd3C2YAzcgW6W0zjNg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org


--lfcjhvsk27yscm2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 09:31:17AM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Apr 3, 2017 at 7:36 PM, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > --- a/tools/i2ctransfer.8
> > +++ b/tools/i2ctransfer.8
> > @@ -74,7 +74,7 @@ This number should correspond to one of the busses li=
sted by
> >  The next parameter is one or multiple
> >  .I desc
> >  blocks.
> > -The number of blocks is limited by the Linux Kernel and defined in I2C=
_RDWR_IOCTL_MAX_MSGS (42 as of v4.10).
> > +The number of blocks is limited by the Linux Kernel and defined with I=
2C_RDWR_IOCTL_MAX_MSGS (42 as of v4.10).
>=20
> defined by?

Thanks, yes. Fixed locally and pushed out.


--lfcjhvsk27yscm2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljnglEACgkQFA3kzBSg
KbbX8A//cKdFDOxxW93P7Zvmp3OqLkH22q4afq1qg8JVDqWu9z9QnSucFNfMOmv5
U/40JMPNVYKZyEm4CrHRRkICxpivkcqtjFCOivRRO+Uzh5TAUohi4JJXVcAI0K4K
hwoT069qs2sLcHksH5+DefzBp7nbwvltNaImkp9ZWX318JfF5MCojMNCy7vTc8IW
XNTsXknV0nrJfkDtQ51M94fKbPTmK7b2JidPKXnumS99Ml27bCx6HBBshBPje3FJ
Gt3asB8k2N8uD9gliQdv8aHsY4yYo5T0FimZNue811NDv/VxjnKvv5R8wQlju9ME
Ary7EofSI0elGbnHamecE3mKG1VNd0wntdV4Y1Hunr6vvVWKH0AmbNujB83n+2ef
APLMBd6duuQdHiwMBP7wjzfMkjuEcHLMfhcdqkCGHA+EmUxTQYctQ6RzBDMyYcI0
Z0UX+QIakrimilYqfsCfDAT8H2EF9ZKnoXSolxkjTgonL+YhgnqAbgSofWxeQAgL
hkIFSVzkbtKH1Gm3LFpjepFtCq8+kfS3G34mJCMZ7lJimGPUd45S/5t0RycFJF53
WAhvr37+MDO5u659iIZPj/KT15ynvqCwLVKUKzMjKRJpfMH1oAfPOTit7OgRmFBk
i2Q1yCeGq/LE896q4zZs3GyuW3asLX1Mg8HOPhmWKQTspTJ39m8=
=jZmC
-----END PGP SIGNATURE-----

--lfcjhvsk27yscm2z--
