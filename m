From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 01:39:38 -0800
Message-ID: <200901230139.38785.david-b@pacbell.net>
References: <20090122150230.GA10952@enneenne.com> <20090123095110.7b0c7b82@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090123095110.7b0c7b82-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 23 January 2009, Jean Delvare wrote:
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -799,10 +799,10 @@ void i2c_del_driver(struct i2c_driver *driver=
)
> > =A0 =A0 =A0 =A0 class_for_each_device(&i2c_adapter_class, NULL, dri=
ver,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __detac=
h_adapter);
> >=20
> > + =A0 =A0 =A0 mutex_unlock(&core_lock);
> > +
> > =A0 =A0 =A0 =A0 driver_unregister(&driver->driver);
> > =A0 =A0 =A0 =A0 pr_debug("i2c-core: driver [%s] unregistered\n",
> > =A0 =A0 =A0 =A0 driver->driver.name);
> > -
> > - =A0 =A0 =A0 mutex_unlock(&core_lock);
> > =A0}
> > =A0EXPORT_SYMBOL(i2c_del_driver);
> >=20
> > Unluckely I'm not an i2c guru so I'd like to ask to you. If such
> > modification is correct I can provide a simple support with no
> > modifications to the i2c core! Apart this one, of course... :)
>=20
> Honestly, I am not sure either. The locking model isn't completely
> cleared yet,

All legacy locking in the I2C core is problematic -- courtesy
of the original (lack-of-)design.  The core_lock is the worst
offender; it's mostly there to support some wierdness when
removing legacy drivers, and I recall thinking that it works
more by luck (and lack of heavy use!) than correctness.


> we still need to get rid of the 3 dozen remaining legacy=20
> i2c chip drivers before we can finish it. I _think_ the above it
> correct, after all we do not hold the lock when calling
> driver_register() so I can't see why we would need to hold it when
> calling driver_unregister()... unless either i2c_client_release() or
> i2c_client_dev_release() needs this.
>=20
> David should know better, as he designed the thing in the first place=
=2E

No I didn't ... I worked on making it play better with the
driver model, and simplifying a bunch of the rest.  I gave
up on fixing the legacy locking ... other than that patch
to remove i2c_adapter.clist_lock, a while back, I think the
only real fix is getting rid of those legacy calls (thus
using only the driver-model internal locks).


> David, can you please comment on the proposed change?

If it's a legacy driver, it will already have been decoupled
from devices, so the nastiest bit of stuff will have gotten
the protection it needs.  New-style drivers shouldn't care
about the legacy stuff at all.  So that much looks plausible.

But I don't have the patience to really analyse the other
locking implications; there were some rude and un-obvious
things lurking there, including abuse of complete() for
the legacy i2c_client lifecycle.

- Dave
