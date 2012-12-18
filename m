From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] at24: make module parameters changeable via sysfs
Date: Tue, 18 Dec 2012 12:53:15 +0100
Message-ID: <20121218125315.5adb1fef@endymion.delvare>
References: <1347443012-21302-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20120914102536.1ebd248d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120914102536.1ebd248d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?B?S2xlaW5lLUv2bmln?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Uwe,

On Fri, 14 Sep 2012 10:25:36 +0200, Jean Delvare wrote:
> On Wed, 12 Sep 2012 11:43:32 +0200, Uwe Kleine-K=F6nig wrote:
> > The respective values are evaluated at each read/write, so no furth=
er
> > action is required than to change the perm argument to module_param=
=2E
> >=20
> > Note there is no sanity check so root can make the driver effective=
ly
> > unusable but that's what root is for :-)
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/misc/eeprom/at24.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.=
c
> > index ab1ad41..8a5a192 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > @@ -85,7 +85,7 @@ struct at24_data {
> >   * This value is forced to be a power of two so that writes align =
on pages.
> >   */
> >  static unsigned io_limit =3D 128;
> > -module_param(io_limit, uint, 0);
> > +module_param(io_limit, uint, S_IRUGO | S_IWUSR);
>=20
> This won't work. Not only there is no validation of the value, while
> there is such a validation (and value adjustment!) in at24_init(); yo=
u
> seem to not care, but I do. But the more important problem is that
> changing io_limit at run-time will only affect reads, not writes. The
> size limit from writes is computed at device probing time:
>=20
> static int at24_probe(struct i2c_client *client, const struct i2c_dev=
ice_id *id)
> {
> (...)
> 	if (writable) {
> 	(...)
> 			if (write_max > io_limit)
> 				write_max =3D io_limit;
>=20
> So changing the value through sysfs will have no effect. If you want =
it
> to have an effect, you have to move the check from at24_probe() to
> at24_eeprom_write().
>=20
> Back to the validation issue, I think it would be worth looking into
> module_param_cb(). Using it, it may not be that difficult to get
> validation when the value is changed through sysfs. Otherwise I'll as=
k
> you to check what exactly happens if someone sets io_limit to 0. We
> can't afford infinite loops or EEPROM corruption on root mistyping.
>=20
> >  MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O (default 128)");
> > =20
> >  /*
> > @@ -93,7 +93,7 @@ MODULE_PARM_DESC(io_limit, "Maximum bytes per I/O=
 (default 128)");
> >   * it's important to recover from write timeouts.
> >   */
> >  static unsigned write_timeout =3D 25;
> > -module_param(write_timeout, uint, 0);
> > +module_param(write_timeout, uint, S_IRUGO | S_IWUSR);
>=20
> This one is OK.
>=20
> >  MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (defau=
lt 25)");
> > =20
> >  #define AT24_SIZE_BYTELEN 5

I reviewed this patch 3 months ago and did not hear back. Are you going
to update this patch and resubmit, or should I just drop it?

--=20
Jean Delvare
