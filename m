From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] i2c: add support for Cypress CYUSBS234 USB-I2C
 adapter
Date: Tue, 30 Sep 2014 12:09:36 +0200
Message-ID: <20140930100936.GB17834@localhost>
References: <1411378426-18387-1-git-send-email-muth@cypress.com>
 <20140922113026.GF5237@localhost>
 <6876ca326315426889d3dc596a495b23@BY2PR06MB076.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6876ca326315426889d3dc596a495b23@BY2PR06MB076.namprd06.prod.outlook.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Muthu Mani <muth@cypress.com>
Cc: Johan Hovold <johan@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 25, 2014 at 05:46:16AM +0000, Muthu Mani wrote:

> > > +static int cy_i2c_xfer(struct i2c_adapter *adapter,
> > > +                    struct i2c_msg *msgs, int num) {
> > > +     int ret = 0;
> > > +     struct cyusbs_i2c *cy_i2c;
> > > +     struct cyusbs23x *cyusbs = (struct cyusbs23x
> > > +*)adapter->algo_data;
> > > +
> > > +     dev_dbg(&adapter->dev, "%s\n", __func__);
> > > +
> > > +     if (num > 1) {
> > > +             dev_err(&adapter->dev, "i2c_msg number is > 1\n");
> > > +             return -EIO;
> > > +     }
> > 
> > Why not handle multiple messages?
> 
> This iteration of the driver is designed to handle only a single
> message at a time.
> It can be expanded to handle multiple messages in future.

No, please do that now. It's just a matter of adding a for loop.

Thanks,
Johan
