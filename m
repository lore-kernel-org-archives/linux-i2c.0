From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 2/2] i2c: sh_mobile: rework deferred probing
Date: Tue, 16 Dec 2014 12:35:23 +0100
Message-ID: <20141216113523.GB10958@katana>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
 <1418217709-26392-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdX2u4J2Dqb2ww23F4ED2QFWu4Ev2tF9Nr6o0PXRdpxSDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2u4J2Dqb2ww23F4ED2QFWu4Ev2tF9Nr6o0PXRdpxSDA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-i2c@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 02:44:58PM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Dec 10, 2014 at 2:21 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > DMA is opt-in for this driver. So, we can't use deferred probing in
> > probe, because our driver would get endlessly deferred if DMA support is
> > compiled in but only the DMA driver is missing. Because we can't know
> > when the DMA driver might show up, we always try again when a DMA
> > transfer would be possible. The downside is that there is more overhead
> > for setting up every DMA transfer.
>=20
> ... for setting up every PIO transfer?
>=20
> Once DMA is available, it's just one extra variable check.

ACK. Mixed that up.

>=20
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  drivers/i2c/busses/i2c-sh_mobile.c | 98 +++++++++++++++++++-----------=
--------
> >  1 file changed, 48 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2=
c-sh_mobile.c
> > index 636f2297143a..ea7b99212fa6 100644
> > --- a/drivers/i2c/busses/i2c-sh_mobile.c
> > +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> > @@ -144,6 +144,7 @@ struct sh_mobile_i2c_data {
> >         int sr;
> >         bool send_stop;
> >
> > +       struct resource *res;
>=20
> I thinkk you can just store dma_addr_t port_addr here.

Yes, but I liked the resource better :)


--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkBj7AAoJEBQN5MwUoCm2X2sP/RyVZb8/w5C2Cs+39S3imllD
zaf/8f/PYdHRyr9eWuoQAsgGKIQDB/IYSj20PX6JJkHebaEJcnSpglKlgIF/YtsR
N8kEKRKaFmuuJPoiSDT9qhxqBpXahaunmsSq3nV23CLuUNGOjDROc2r5+VrFqGW+
YzNOvEOmtKQfBTxoZOhxZVFtn4WkTrn/gWGWfLxwsVtVOc54gaYfLAKtZrPv91zz
7PymjQs0E2botRcnltbX/Gjz5fZA3MQnZNhwED2KTZ4spTfmWm2lDQBt098bgwyj
sOz3sczenWwoBYpH4HjKL97xWK+wO74Kbku+IInN8iMBDjkyOmQtbkpa9uZymdSS
wvY531sWrpjjNRlSj6AdHLTeqy4MxWoEVtZ3131bTjIH90UmeFO5zoM3B73PolsI
22av9cNgpJHJ1T+tjS0IWVT1QNQfHPPNdRZwjuvy9rjUMbfWuE02flh1yIb5RWxj
0GpyF/b9BYUBTrBbhCf69BCpozSkK1/Iz9JfIJPM86qggYizt5n7M8CaC17aHT3H
npAh6CwT+hPj2RzJmwTsm68TOfE8VUhzcxR3anqW2Wbu2kvLFl/45AffaQC/fqC0
Gh82ZMp/pKRZffhX7zu5zmHDdEqzZxXr1aIoowSzISn/p+9vlGoQ6tgzuMFQPnuh
PwJ7Sj3QfHMRVT/ZA3k9
=drZ4
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
