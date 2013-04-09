From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] gpio: Kontron PLD gpio driver
Date: Tue, 9 Apr 2013 10:46:15 +0200
Message-ID: <CACRpkdYrGK_SPbiRssFUrg2vMvWbYO_iXsy+aZr99tyFtk88Uw@mail.gmail.com>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
	<1365441321-21952-3-git-send-email-kevin.strasser@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365441321-21952-3-git-send-email-kevin.strasser@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Brunner <michael.brunner@kontron.com>, Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Ben Dooks <ben-linux@fluff.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, Michael Brunner <mibru@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 8, 2013 at 7:15 PM, Kevin Strasser
<kevin.strasser@linux.intel.com> wrote:

> From: Michael Brunner <michael.brunner@kontron.com>
>
> Add gpio support for the on-board PLD found on some Kontron embedded
> modules.
>
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> Signed-off-by: Kevin Strasser <kevin.strasser@linux.intel.com>

This looks very generic, setting and clearing bits in bytesized
registers.

Can you please attempt to use generic GPIO for this?

drivers/gpio/gpio-generic.c
<linux/basic_mmio_gpio.h>

See for example:
gpio-ep93xx.c, gpio-sodaville.c ...

Since you don't even have IRQ support in this it will be even simpler.

Yours,
Linus Walleij
