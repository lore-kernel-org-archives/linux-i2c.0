From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Tue, 22 Mar 2011 23:07:46 -0700
Message-ID: <20110323060746.GA9673@ericsson.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
 <20110323042507.GA9173@ericsson.com>
 <20110323045058.GA13606@kroah.com>
 <20110323054153.GA10275@regiomontanus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110323054153.GA10275@regiomontanus>
Sender: linux-doc-owner@vger.kernel.org
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 01:41:53AM -0400, Bernhard Walle wrote:
> * Greg KH <greg@kroah.com> [2011-03-23 05:50]:
> >=20
> > It should, you can talk to the device from userspace using that vir=
tual
> > serial port, right?  Isn't that what you need to do here?
> >=20
> > Why try to create a new type of interface to the device from what i=
t was
> > supposed to be by the manufacturer?
>=20
> The device is multi-function. It's quite common to use some (extended=
)
> USB-to-serial-converters also for serial busses like I=B2C or SPI. I =
know
> that from the FT2232C chip.
>=20
> Using such a device as normal Linux I=B2C device makes perfectly sens=
e,
> IMO.
>=20
Correct. I use and need it as I2C bus controller. FWIW, that is what it=
 is sold
for. User space access doesn't help me there.

Anyway, the only reason for submitting the driver was that I thought it=
 might
be useful for others. Maybe not useful enough, and defintely not worth =
arguing
about it. I'll make it available as stand-alone driver; that should be =
good enough.

Thanks,
Guenter

