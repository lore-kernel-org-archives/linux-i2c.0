From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Thu, 24 Mar 2011 09:41:37 -0700
Message-ID: <20110324164137.GA22838@kroah.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
 <20110323042507.GA9173@ericsson.com>
 <20110323045058.GA13606@kroah.com>
 <20110323054153.GA10275@regiomontanus>
 <20110323060746.GA9673@ericsson.com>
 <20110323150014.GB6284@kroah.com>
 <20110323151021.53e187bb@lxorguk.ukuu.org.uk>
 <20110323153115.GB7106@kroah.com>
 <20110324043157.GD15395@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110324043157.GD15395-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Bernhard Walle <bernhard-X9USDgGjgfuzQB+pC5nmwQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 09:31:57PM -0700, Guenter Roeck wrote:
> On Wed, Mar 23, 2011 at 11:31:15AM -0400, Greg KH wrote:
> > On Wed, Mar 23, 2011 at 03:10:21PM +0000, Alan Cox wrote:
> > > > But, if this just duplicates the cdc-acm interface, and it look=
s like it
> > > > does, I don't think you need a kernel driver at all for it.  Ju=
st use
> > > > userspace commands to the serial port, like you do on Windows, =
and all
> > > > should be fine, right?
> > >=20
> > > You want a kernel driver because you've got kernel I=B2C drivers =
wanting to
> > > talk to the devices down the link in question. Just needs to be a=
n ldisc
> > > and then it call comes together nicely.
> >=20
> > Ah, ok, that makes more sense.
> >=20
> > Odd that windows does it all from userspace, but I guess it doesn't=
 have
> > an I2C driver subsystem.
> >=20
> Converting the driver to a line discipline as Alan suggested would me=
an to add=20
> a new line discipline to linux/tty.h.
>=20
> Doing this would be purely for the benefit of the community, since th=
e driver
> works just fine for my purpose.
>=20
> So before I spend any more time on it, I'll need to know ... is there=
 any
> interest in an i2c bus driver for this device, and would a new line d=
iscipline
> be accepted into the kernel ?

If people need/want it, a new line discipline will be accepted, no
problems with that.

thanks,

greg k-h
