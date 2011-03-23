From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 06:57:37 -0700
Message-ID: <20110323135737.GA11566@ericsson.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323092829.25d42e27@lxorguk.ukuu.org.uk>
 <20110323134650.GA11492@ericsson.com>
 <20110323135244.202cc9bd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110323135244.202cc9bd-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 09:52:44AM -0400, Alan Cox wrote:
> > > > +	/* setup i2c adapter description */
> > > > +	dev->adapter.owner = THIS_MODULE;
> > > > +	dev->adapter.class = I2C_CLASS_HWMON;
> > > 
> > > Doesn't seem to be HWMON ?
> > > 
> > You lost me there. Why not ? Many if not all I2C bus drivers register as
> > I2C_CLASS_HWMON.
> 
> Would you expect platform hardware monitoring devices to be hanging off
> it ?
> 
Yes. That is actually my primary use for it - to connect to various hwmon devices.
This way I can connect to prototype boards to develop drivers, and I don't have
to wait for HW to come in.

Guenter
