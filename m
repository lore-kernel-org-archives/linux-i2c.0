From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 08:00:14 -0700
Message-ID: <20110323150014.GB6284@kroah.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
 <20110323042507.GA9173@ericsson.com>
 <20110323045058.GA13606@kroah.com>
 <20110323054153.GA10275@regiomontanus>
 <20110323060746.GA9673@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110323060746.GA9673-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Bernhard Walle <bernhard-X9USDgGjgfuzQB+pC5nmwQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 22, 2011 at 11:07:46PM -0700, Guenter Roeck wrote:
> On Wed, Mar 23, 2011 at 01:41:53AM -0400, Bernhard Walle wrote:
> > * Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> [2011-03-23 05:50]:
> > >=20
> > > It should, you can talk to the device from userspace using that v=
irtual
> > > serial port, right?  Isn't that what you need to do here?
> > >=20
> > > Why try to create a new type of interface to the device from what=
 it was
> > > supposed to be by the manufacturer?
> >=20
> > The device is multi-function. It's quite common to use some (extend=
ed)
> > USB-to-serial-converters also for serial busses like I=B2C or SPI. =
I know
> > that from the FT2232C chip.
> >=20
> > Using such a device as normal Linux I=B2C device makes perfectly se=
nse,
> > IMO.
> >=20
> Correct. I use and need it as I2C bus controller. FWIW, that is what =
it is sold
> for. User space access doesn't help me there.
>=20
> Anyway, the only reason for submitting the driver was that I thought =
it might
> be useful for others. Maybe not useful enough, and defintely not wort=
h arguing
> about it. I'll make it available as stand-alone driver; that should b=
e good enough.

No need for that, we want drivers in the kernel tree.

But, if this just duplicates the cdc-acm interface, and it looks like i=
t
does, I don't think you need a kernel driver at all for it.  Just use
userspace commands to the serial port, like you do on Windows, and all
should be fine, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
