From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 08:31:15 -0700
Message-ID: <20110323153115.GB7106@kroah.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
 <20110323042507.GA9173@ericsson.com>
 <20110323045058.GA13606@kroah.com>
 <20110323054153.GA10275@regiomontanus>
 <20110323060746.GA9673@ericsson.com>
 <20110323150014.GB6284@kroah.com>
 <20110323151021.53e187bb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110323151021.53e187bb-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Bernhard Walle <bernhard-X9USDgGjgfuzQB+pC5nmwQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 03:10:21PM +0000, Alan Cox wrote:
> > But, if this just duplicates the cdc-acm interface, and it looks li=
ke it
> > does, I don't think you need a kernel driver at all for it.  Just u=
se
> > userspace commands to the serial port, like you do on Windows, and =
all
> > should be fine, right?
>=20
> You want a kernel driver because you've got kernel I=B2C drivers want=
ing to
> talk to the devices down the link in question. Just needs to be an ld=
isc
> and then it call comes together nicely.

Ah, ok, that makes more sense.

Odd that windows does it all from userspace, but I guess it doesn't hav=
e
an I2C driver subsystem.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
