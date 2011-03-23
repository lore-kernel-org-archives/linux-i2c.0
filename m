From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 09:28:29 +0000
Message-ID: <20110323092829.25d42e27@lxorguk.ukuu.org.uk>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300851827-13627-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 22 Mar 2011 20:43:47 -0700
Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> wrote:

> This patch adds support for the I2C interface of the Devantech USB-ISS
> Multifunction adapter.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
> The driver has one problem: It competes with the cdc_acm driver for device
> access. Copying the usb mailing list in the hope that someone can tell me
> if there is a way to prevent this from happening.

>From the look of the code you actually want to be sitting on top of
cdc_acm. 


> +/* Send command to device, and get response. */
> +static int devantech_usb_transfer(struct i2c_devantech_iss *dev, int len)
> +{
> +	int ret, actual;
> +
> +	if (len <= 0 || len > ISS_MAX_TRANSFER_LEN)
> +		return -EINVAL;
> +
> +	ret = usb_bulk_msg(dev->usb_dev,
> +			   usb_sndbulkpipe(dev->usb_dev, dev->ep_out),
> +			   dev->buffer, len, &actual,
> +			   ISS_USB_TIMEOUT);
> +
> +	if (!ret) {
> +		ret = usb_bulk_msg(dev->usb_dev,
> +				   usb_rcvbulkpipe(dev->usb_dev, dev->ep_in),
> +				   dev->buffer, sizeof(dev->buffer),
> +				   &actual, ISS_USB_TIMEOUT);
> +		if (!ret && actual > 0)
> +			ret = actual;
> +	}
> +	return ret;
> +}

The whole driver seems to boil down to sending and receiving message
blocks to the bulk endpoint - yes ?

> +	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
> +	dev->interface = interface;
> +
> +	/* setup i2c adapter description */
> +	dev->adapter.owner = THIS_MODULE;
> +	dev->adapter.class = I2C_CLASS_HWMON;

Doesn't seem to be HWMON ?


The rest looks like the device doesn't pretend to be CDC ACM class, but
is CDC-ACM class with the "device" the other end talking to the other end
of the serial port.

In fact it would be an interesting test to open the serial port and write
your commands to it from user space to see what happens. If I read the
code right it'll work fine.

>From a tty perspective it would probably make sense to adjust the driver
to be a line discipline sat on CDC-ACM.

I am *very* wary of removing it from the CDC_ACM side because people may
be using the CDC-ACM userspace directly for existing projects and would
get a nasty surprise and breakage.

If setting the tty to raw 8bit noecho and firing commands over the
virtual interface works then turning your driver into an ldisc is pretty
trivial. The ldisc interfaces provide data received and allow data writes
through the relevant tty.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
