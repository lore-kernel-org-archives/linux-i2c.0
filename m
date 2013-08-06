From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Tue, 6 Aug 2013 10:20:31 +0200
Message-ID: <20130806082029.GA2979@katana>
References: <1375219237-9594-1-git-send-email-marex@denx.de>
 <1375219237-9594-2-git-send-email-marex@denx.de>
 <20130805103647.GB9694@katana>
 <201308051621.51146.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201308051621.51146.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > One question: Wouldn't it be more logical to have this patch first (fix
> > pio) and then squash patches 1 and 3 as one on the top (add mx23 to now
> > working pio)? I am not pushing too hard if this means a lot of work, but
> > it sounds a bit more logical to me.
>=20
> I would prefer to keep Juergens' patch separate from mine if you don't mi=
nd to=20
> be clear on the authorship.

If you add both SoB, everything should be fine. We often work on someone
else's patches, no?

> > >  	if (msg->flags & I2C_M_RD) {
> > >=20
> > > +		/*
> > > +		 * PIO READ transfer:
> > > +		 *
> > > +		 * This transfer MUST be limited to 4 bytes maximum. It is not
> > > +		 * possible to transfer more than four bytes via PIO, since we
> > > +		 * can not in any way make sure we can read the data from the
> > > +		 * DATA register fast enough. Besides, the RX FIFO is only four
> > > +		 * bytes deep, thus we can only really read up to four bytes at
> > > +		 * time. Finally, there is no bit indicating us that new data
> > > +		 * arrived at the FIFO and can thus be fetched from the DATA
> > > +		 * register.
> > > +		 */
> > > +		BUG_ON(msg->len > 4);
> >=20
> > How could this happen? There is a check in mxs_i2c_xfer_msg.
>=20
> It cannot happen, I added the check here to make sure when someone become=
s=20
> adventurous enough to start messing with these constants, it will stop hi=
m early=20
> enough.

Then, add the comment to the check so ppl will notice there? I like to
keep BUG_ON sparse, since it is hard to tell if the occasion is really
worth stopping the machine.


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSALHNAAoJEBQN5MwUoCm2ibYQAKM93sOfrnkMhIGlFiwC4fda
pc0gXsIxH8uqFf+vs88fnhurv/+0Q1Dz3m8HmEFxnu6TRketAp5bi0IG/YOrjsZG
MqyyXWnRyJCCgazMrdL8JC6G+4CV7t6vTysfBdXebGVZkFR8EAu2erCJ24tarj8q
nVBV0zXZ3lYdw4MyT67IJ2UaM6zWd9J0ouCUKr39TWJHpfi6TRGqEElGTIKS0P8m
wZjwdr5H9CZBcjg6xCH93AI+DF4E7hsPVKrqTR/LJreAWhYfClU4X/c0JGgSNIlx
apWL5VlILqUtFyU4eSI5AyTuQpe9RJ8dRNnq4+SRRzoUba1sQmKKuRjdFKeCWLij
uCJ29FdzS5Z0RyeYKo/r+FPvVdT36eiPT9CvntT/DwESnkGCs6bVxBCCgGRCOsK0
aeRfjW92lxw1vWD0tTnOi26b8C/cOpe3/QTrTyNee+MDXnMhaxAtYASJCRdPpNxr
++xjVillw8jC+3U0HX2e5uEpqFpjKDlpQ4pbuggGI1W5zCMbBgAZwsp1uQAOURgj
MuJYhqasyxAoOeNm77b8ywb2WXcHYJcOZctQbUiFBhrv0EQAKIsxQqL+LOGSdfLD
Y4g6xLokN54rikwMPkNJ6jC6bsLAoqVCsESrgXv5UyLeHrQYXX2BxpnorG7x9/xO
cvCgn3kAlgBJfT2NRWnL
=RDax
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
