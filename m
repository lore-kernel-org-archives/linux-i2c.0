From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 06:46:50 -0700
Message-ID: <20110323134650.GA11492@ericsson.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323092829.25d42e27@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110323092829.25d42e27-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 05:28:29AM -0400, Alan Cox wrote:
> On Tue, 22 Mar 2011 20:43:47 -0700
> Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> wrote:
> 
> > This patch adds support for the I2C interface of the Devantech USB-ISS
> > Multifunction adapter.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> > ---
> > The driver has one problem: It competes with the cdc_acm driver for device
> > access. Copying the usb mailing list in the hope that someone can tell me
> > if there is a way to prevent this from happening.
> 
> From the look of the code you actually want to be sitting on top of
> cdc_acm. 
> 
Ok, I'll see if I can do that.

> 
> > +/* Send command to device, and get response. */
> > +static int devantech_usb_transfer(struct i2c_devantech_iss *dev, int len)
> > +{
> > +	int ret, actual;
> > +
> > +	if (len <= 0 || len > ISS_MAX_TRANSFER_LEN)
> > +		return -EINVAL;
> > +
> > +	ret = usb_bulk_msg(dev->usb_dev,
> > +			   usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
> > +			   dev->buffer, len, &actual,
> > +			   ISS_USB_TIMEOUT);
> > +
> > +	if (!ret) {
> > +		ret = usb_bulk_msg(dev->usb_dev,
> > +				   usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
> > +				   dev->buffer, sizeof(dev->buffer),
> > +				   &actual, ISS_USB_TIMEOUT);
> > +		if (!ret && actual > 0)
> > +			ret = actual;
> > +	}
> > +	return ret;
> > +}
> 
> The whole driver seems to boil down to sending and receiving message
> blocks to the bulk endpoint - yes ?
> 
Yes

> > +	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
> > +	dev->interface = interface;
> > +
> > +	/* setup i2c adapter description */
> > +	dev->adapter.owner = THIS_MODULE;
> > +	dev->adapter.class = I2C_CLASS_HWMON;
> 
> Doesn't seem to be HWMON ?
> 
You lost me there. Why not ? Many if not all I2C bus drivers register as
I2C_CLASS_HWMON.

> 
> The rest looks like the device doesn't pretend to be CDC ACM class, but
> is CDC-ACM class with the "device" the other end talking to the other end
> of the serial port.
> 
> In fact it would be an interesting test to open the serial port and write
> your commands to it from user space to see what happens. If I read the
> code right it'll work fine.
> 
Yes, it should work. That is what is done in Windows.

> From a tty perspective it would probably make sense to adjust the driver
> to be a line discipline sat on CDC-ACM.
> 
> I am *very* wary of removing it from the CDC_ACM side because people may
> be using the CDC-ACM userspace directly for existing projects and would
> get a nasty surprise and breakage.
> 
Same here. Not likely for existing projects (the device is brand new),
but at some point someone might want to use it.

> If setting the tty to raw 8bit noecho and firing commands over the
> virtual interface works then turning your driver into an ldisc is pretty
> trivial. The ldisc interfaces provide data received and allow data writes
> through the relevant tty.
> 
I'll try.

Thanks,
Guenter
