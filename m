From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 08:17:29 +0100
Message-ID: <201103230817.29984.oneukum@suse.de>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com> <20110323045058.GA13606@kroah.com> <20110323054153.GA10275@regiomontanus>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20110323054153.GA10275@regiomontanus>
Sender: linux-doc-owner@vger.kernel.org
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Greg KH <greg@kroah.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, 23. M=E4rz 2011, 06:41:53 schrieb Bernhard Walle:
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

Yes, but not the approach of kicking off the class driver. As those dev=
ices
presumably use some form of I2C over Serial, you ought to handle them i=
n the
way PPP handles IP over Serial, especially if thy use a common encapsul=
ation.

	Regards
		Oliver
