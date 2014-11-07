From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c: mux: add mux device to the adapter name
Date: Fri, 7 Nov 2014 12:52:10 +0100
Message-ID: <20141107115210.GA3108@katana>
References: <1415048456-13456-1-git-send-email-wsa@the-dreams.de>
 <20141105183834.GB22304@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141105183834.GB22304-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2014 at 10:38:34AM -0800, Guenter Roeck wrote:
> On Mon, Nov 03, 2014 at 10:00:56PM +0100, Wolfram Sang wrote:
> > If there are multiple muxes on one bus, then specifying the channel only
> > is not sufficient for a distinguishable name. We need the actual device,
> > too.
> >=20
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> > Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> > Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> > Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> > Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> > ---
> >=20
> > This is probably the least "ABI" breaking solution? RFC for now...
> >=20
> >  drivers/i2c/i2c-mux.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> > index 5b482ea32faf..26aa84902ada 100644
> > --- a/drivers/i2c/i2c-mux.c
> > +++ b/drivers/i2c/i2c-mux.c
> > @@ -134,7 +134,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_=
adapter *parent,
> > =20
> >  	/* Now fill out new adapter structure */
> >  	snprintf(priv->adap.name, sizeof(priv->adap.name),
> > -		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
> > +		 "i2c-%d-mux (chan_id %d) (mux_device %s)",
> > +		 i2c_adapter_id(parent), chan_id, dev_name(mux_dev));
>=20
> This yields pretty long names, longer than the maximum supported length,
> if the mux is not an i2c adapter (eg i2c-mux-pinctrl).
>=20
> i2c-17-mux (chan_id 5) (mux_device i2c-mux-pinctrl)
>=20
> has 52 characters, and the maximum name length is 48.
> Maybe just use "mux" instead of "mux_adapter" ?

Argh, right. With that length limit, it doesn't make sense to use %s, at
all. For DT the name comes from the node name and that could be even
longer, so shortening to "mux" wouldn't help much.

> The result still fails for me because the application code doesn't expect
> to see "(mux...)", but I guess there will always be some problem :-(.

Yes, because it is ABI breakage. Honestly, with that size limit as
another obstacle, I think we should leave the 'name' file as it is and
use proper topology.

> I still need to figure out what causes the failure with the other patch.

Yes, please. Thanks for doing that!

   Wolfram


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXLJqAAoJEBQN5MwUoCm2lugP/2zoaz//F83Bp8j2BTezQwfu
Jzt0S5oCbWJg6EOiwHxhfYSm7WVKIw/hFW3mkkbjfPLI4rYfjZVC9HYx0y0muFa1
0+OhJiiLh5wh33i65+07Fqyr/Ec8EUbOpg6tesPDwQEq5OmAcN5oGQVhElCdKv6t
3+yJNAHlV53lIxA8SLenioFNRs2dcnrOI4FbvyKrGqo/JFGwvdhK8oU2iil1r/gx
mOrdW4652ESBQuLv96qglR0hn6/LinoH4tk67kasDCsaEmtDx/4tbHYm1lv1zxXH
43V5OafBvg/xy1uFpMHCNH8GrENbCbnSJM/H0Af1grgXtLAqxzSqDnWc4cov7+o/
MbjE7QXHD0miH4ODNWPTLgK7xENt6AJmHOXilGyyjj9xXjsP4dCZ/iDMBcjMw6AG
+TgYEg1iN5rU7x6z4oOM++6dDXmvurbWvUBn7ElWqvZei7LduYNriKF45ppSBcch
ngK/voKH4Sp5bDwKnOECVzokYuJtn142f2iS3qUYGrVWAFc+lh8C5lAjJrEZEQtl
4TxmncbgnqVXhs6gu7pqphgGxxE0yRAP/loyMzp/cWMJ5wWDYdI/dw/T7n7xqpzT
z+St+4ucweh+iEawYLACqWIfxXwCyWtO2p8TMwapj/pqTbd65PEMWwOJ5xM+oGl3
cnS0XmIXu62dOrah5onK
=/Kls
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
