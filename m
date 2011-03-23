From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Tue, 22 Mar 2011 21:25:07 -0700
Message-ID: <20110323042507.GA9173@ericsson.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110323034524.GA11675-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 22, 2011 at 11:45:24PM -0400, Greg KH wrote:
> On Tue, Mar 22, 2011 at 08:43:47PM -0700, Guenter Roeck wrote:
> > This patch adds support for the I2C interface of the Devantech USB-ISS
> > Multifunction adapter.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> > ---
> > The driver has one problem: It competes with the cdc_acm driver for device
> > access. Copying the usb mailing list in the hope that someone can tell me
> > if there is a way to prevent this from happening.
> 
> Why does it "compete"?
> Is it because this driver also exposes a cdc-acm class interface?  Why

I guess so.

> is it doing that if it doesn't follow that spec?  We do already support

I don't know if it follows the cdc-acm specification or not, though I would
think it does since the cdc-acm driver recognizes it. I do see the
"This device cannot do calls on its own. It is not a modem." message.

I suspect the device exposes the cdc-acm class interface because it is
a convenient means to make it show up as COM port in Windows.
But I am not associated with the manufacturer, so that is just a wild guess.

If it does follow the cdc-acm specification, does that help me anything ?

> a number of "quirks" in the cdc-acm driver, I don't see why we couldn't
> add a "blacklist this device" one there as well to help you out here if
> it's needed.
> 
Maybe, but only as last resort.

Thanks,
Guenter
