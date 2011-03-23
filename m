From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 13:52:44 +0000
Message-ID: <20110323135244.202cc9bd@lxorguk.ukuu.org.uk>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
	<20110323092829.25d42e27@lxorguk.ukuu.org.uk>
	<20110323134650.GA11492@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110323134650.GA11492-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > > +	/* setup i2c adapter description */
> > > +	dev->adapter.owner = THIS_MODULE;
> > > +	dev->adapter.class = I2C_CLASS_HWMON;
> > 
> > Doesn't seem to be HWMON ?
> > 
> You lost me there. Why not ? Many if not all I2C bus drivers register as
> I2C_CLASS_HWMON.

Would you expect platform hardware monitoring devices to be hanging off
it ?

> > If setting the tty to raw 8bit noecho and firing commands over the
> > virtual interface works then turning your driver into an ldisc is pretty
> > trivial. The ldisc interfaces provide data received and allow data writes
> > through the relevant tty.
> > 
> I'll try.

Any queries on the ldisc internals drop me an email

Alan
