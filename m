From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 21:31:57 -0700
Message-ID: <20110324043157.GD15395@ericsson.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
 <20110323042507.GA9173@ericsson.com>
 <20110323045058.GA13606@kroah.com>
 <20110323054153.GA10275@regiomontanus>
 <20110323060746.GA9673@ericsson.com>
 <20110323150014.GB6284@kroah.com>
 <20110323151021.53e187bb@lxorguk.ukuu.org.uk>
 <20110323153115.GB7106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110323153115.GB7106@kroah.com>
Sender: linux-doc-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bernhard Walle <bernhard@bwalle.de>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 11:31:15AM -0400, Greg KH wrote:
> On Wed, Mar 23, 2011 at 03:10:21PM +0000, Alan Cox wrote:
> > > But, if this just duplicates the cdc-acm interface, and it looks =
like it
> > > does, I don't think you need a kernel driver at all for it.  Just=
 use
> > > userspace commands to the serial port, like you do on Windows, an=
d all
> > > should be fine, right?
> >=20
> > You want a kernel driver because you've got kernel I=B2C drivers wa=
nting to
> > talk to the devices down the link in question. Just needs to be an =
ldisc
> > and then it call comes together nicely.
>=20
> Ah, ok, that makes more sense.
>=20
> Odd that windows does it all from userspace, but I guess it doesn't h=
ave
> an I2C driver subsystem.
>=20
Converting the driver to a line discipline as Alan suggested would mean=
 to add=20
a new line discipline to linux/tty.h.

Doing this would be purely for the benefit of the community, since the =
driver
works just fine for my purpose.

So before I spend any more time on it, I'll need to know ... is there a=
ny
interest in an i2c bus driver for this device, and would a new line dis=
cipline
be accepted into the kernel ?

Thanks,
Guenter
