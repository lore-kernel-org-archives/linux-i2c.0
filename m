From: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v4 2/3] i2c: add support for Cypress CYUSBS234 USB-I2C
 adapter
Date: Fri, 12 Dec 2014 16:03:34 +0000
Message-ID: <BN1PR06MB06912FCBAAE08006E352008CC600@BN1PR06MB069.namprd06.prod.outlook.com>
References: <1417241986-17841-1-git-send-email-muth@cypress.com>
 <20141203110755.GA1039@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203110755.GA1039@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Thanks for reviewing the code.

> > +/*
> > + * It exposes sysfs entries under the i2c adapter for getting the i2c
> > +transfer
> > + * status, reset i2c read/write module, get/set nak and stop bits.
> > + */
>
> Yes, I see that. Yet, I don't know why they are needed? The driver should
> know when to send NAK/STOP. Why expose that to the user? And why do
> we need a reset? Are there stability problems? What about unloading the
> module? And what is the use case for reading the status?

For repeated start (Sr) scenario, the STOP bit will not be set.
For dummy write scenario (writing EEPROM address from I2C EEPROM slave), the STOP bit should not be set. But, for normal I2C write, the STOP bit should be set.
We provide control to user to control when to STOP/NAK to handle different scenarios.

The reset is an additional provision given to user to reset the I2C read or write engines. It does not require unloading I2C kernel module.
The status indicates the information about the last i2c read/write operation.

>
> > +       if (num > 1) {
> > +               dev_err(&adapter->dev, "i2c_msg number is > 1\n");
> > +               return -EIO;
> > +       }
>
> Ouch! Don't you have any repeated start option somewhere?

In this version of the driver, we handle only single i2c message. In future iterations, we will add support for multiple i2c messages.

Thanks,
Muthu

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
