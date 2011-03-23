From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 15:10:21 +0000
Message-ID: <20110323151021.53e187bb@lxorguk.ukuu.org.uk>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
	<20110323034524.GA11675@kroah.com>
	<20110323042507.GA9173@ericsson.com>
	<20110323045058.GA13606@kroah.com>
	<20110323054153.GA10275@regiomontanus>
	<20110323060746.GA9673@ericsson.com>
	<20110323150014.GB6284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110323150014.GB6284-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Bernhard Walle <bernhard-X9USDgGjgfuzQB+pC5nmwQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> But, if this just duplicates the cdc-acm interface, and it looks like=
 it
> does, I don't think you need a kernel driver at all for it.  Just use
> userspace commands to the serial port, like you do on Windows, and al=
l
> should be fine, right?

You want a kernel driver because you've got kernel I=B2C drivers wantin=
g to
talk to the devices down the link in question. Just needs to be an ldis=
c
and then it call comes together nicely.
