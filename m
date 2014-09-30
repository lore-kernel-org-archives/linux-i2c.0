From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 3/3] gpio: add support for Cypress CYUSBS234 USB-GPIO
 adapter
Date: Tue, 30 Sep 2014 13:12:10 +0200
Message-ID: <20140930111210.GC24736@localhost>
References: <1411624319-5596-1-git-send-email-muth@cypress.com>
 <20140930110829.GB24736@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140930110829.GB24736@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Muthu Mani <muth@cypress.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Rajaram Regupathy <rera@cypress.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 30, 2014 at 01:08:29PM +0200, Johan Hovold wrote:
> On Thu, Sep 25, 2014 at 11:21:58AM +0530, Muthu Mani wrote:

> > +static int cy_gpio_direction_input(struct gpio_chip *chip,
> > +					unsigned offset)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int cy_gpio_direction_output(struct gpio_chip *chip,
> > +					unsigned offset, int value)
> > +{
> > +	return 0;
> > +}
> 
> This is not a correct implementation of these. You're are supposed to
> return what direction the gpio is configured for. You should also add a
> call back to set the direction.

That was backwards; these are supposed to set the direction, and then
you should also implement the get_direction callback.

Johan
