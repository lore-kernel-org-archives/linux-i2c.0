From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv2 2/9] i2c: xiic: move the xiic_process to thread context
Date: Fri, 10 Jul 2015 09:53:09 +0200
Message-ID: <20150710075309.GA1528@katana>
References: <1434554299-23443-1-git-send-email-shubhraj@xilinx.com>
 <1434554299-23443-3-git-send-email-shubhraj@xilinx.com>
 <20150709173158.GD4744@katana>
 <CAKfKVtGOxWU-66fQSd8D6Ue0Si0koQF-CrR0pVZ8RupMNQ=-GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfKVtGOxWU-66fQSd8D6Ue0Si0koQF-CrR0pVZ8RupMNQ=-GQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 10:38:11AM +0530, Shubhrajyoti Datta wrote:
> On Thu, Jul 9, 2015 at 11:01 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >>  static int xiic_bus_busy(struct xiic_i2c *i2c)
> >> @@ -602,16 +601,21 @@ static void xiic_start_send(struct xiic_i2c *i2c)
> >>  static irqreturn_t xiic_isr(int irq, void *dev_id)
> >>  {
> >>       struct xiic_i2c *i2c =3D dev_id;
> >> -
> >> -     spin_lock(&i2c->lock);
> >> +     u32 pend, isr, ier;
> >> +     irqreturn_t ret =3D IRQ_HANDLED;
> >> +     /* Do not processes a devices interrupts if the device has no
> >> +      * interrupts pending
> >> +      */
> >
> > Shouldn't you init 'ret' to IRQ_NONE then?
> >
>=20
> Indeed I missed it.

Can you test this change on HW and report back?

Thanks,

   Wolfram


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn3nlAAoJEBQN5MwUoCm2BFIP/RHd6wIbVDQqBPwcj23YsZJB
btNGFdlwEic1vnhYDtCf6ZGzmoPLH8XJmdtUJwF2oJAgEPUQI3QyZ9cXYhD3piap
aOX0PUzkxuN2ob/l+V23cBzVKDJ17hgeawXBcGmXogT6WqfoZSvQxs8kdPYA2Mol
IyszeC9Dnp3VI7Jni6riWoFHxf/BsK/24x3hNU1DE7AMVt3htCTcRAnD9125zmSz
zlyBNd/6vEUKZMMJ3gbLbZQKhI2wRyjGOAQGrwUDeETX3ht65cdxj9kRz+Q60r/E
Z67mRvdTPTPd4gri377hnovzKLnMh7xQ89vuvmNfFDFZwgJKZlwMVvXIRvro+ci1
rbdJ0m1oh19l1i4lBpINgCFdq6Mh+3ZyI/9xds5+JlC5j6h7zrVsJKqfIYIYmFVQ
N+bdagHip8iKi1Pe0KFKXmjyTur7vrTgqUvEBxEOrcHYdLqY8SktWaYeljtuTDan
WK7x0WvmSy9EfNkwh7Aor4WATNzVg0Y6THeKXUTkhBOmPpi6z09bQMcpnwV7DGMg
nJoK/dZUavUZRvPH779YrLIVgVYODgnp3WfSv/5W6nUsvbfi9T4+t5271L/WIkvE
xHxp0WJ00Ooyl+kMLeIqMXuTQhwD0KJwQlF590n6Vsy9Y0hZM3m2/UkBumOTz5Rf
PGVcS09tikU3PvKgpLEq
=fYHy
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
