From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: Again on virtual i2c adapter support.
Date: Fri, 23 Jan 2009 15:34:35 +0100
Message-ID: <20090123143435.GK12256@enneenne.com>
References: <20090122150230.GA10952@enneenne.com> <20090123152434.423ba1e7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="16qp2B0xu0fRvRD7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090123152434.423ba1e7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2009 at 03:24:34PM +0100, Jean Delvare wrote:

> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index b1c9abe..3454878 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -799,10 +799,10 @@ void i2c_del_driver(struct i2c_driver *driver)
> >         class_for_each_device(&i2c_adapter_class, NULL, driver,
> >                               __detach_adapter);
> > 
> > +       mutex_unlock(&core_lock);
> > +
> >         driver_unregister(&driver->driver);
> >         pr_debug("i2c-core: driver [%s] unregistered\n",
> >         driver->driver.name);
> > -
> > -       mutex_unlock(&core_lock);
> >  }
> >  EXPORT_SYMBOL(i2c_del_driver);
> 
> What tree is this patch against? I can't get it to apply on top of
> 2.6.29-rc2.

It was against 2.6.29-rc2... let me attach a patch file, maybe I did
cut&paste. :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=PATCH

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b1c9abe..3454878 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -799,10 +799,10 @@ void i2c_del_driver(struct i2c_driver *driver)
 	class_for_each_device(&i2c_adapter_class, NULL, driver,
 			      __detach_adapter);
 
+	mutex_unlock(&core_lock);
+
 	driver_unregister(&driver->driver);
 	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
-
-	mutex_unlock(&core_lock);
 }
 EXPORT_SYMBOL(i2c_del_driver);
 

--16qp2B0xu0fRvRD7--
