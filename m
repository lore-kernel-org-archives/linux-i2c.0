From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help to fix some issues with the linux driver   "i2c-gpio"
Date: Thu, 16 Dec 2010 13:52:02 +0100
Message-ID: <20101216135202.38ce671a@endymion.delvare>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
	<20101130182150.3bbc8f01@endymion.delvare>
	<4CF62AFD020000AA000080E3@center.bmk-electronics.de>
	<20101202172322.43ea4698@endymion.delvare>
	<4CFCB095020000AA00008187@center.bmk-electronics.de>
	<20101206112557.3dc8ffe3@endymion.delvare>
	<4D025397020000AA00008248@center.bmk-electronics.de>
	<20101211172336.35c434ef@endymion.delvare>
	<4D0789C5020000AA00008346@center.bmk-electronics.de>
	<20101214175828.0a62ce3f@endymion.delvare>
	<4D08C6B2020000AA0000835E@center.bmk-electronics.de>
	<20101215154255.20d471a4@endymion.delvare>
	<4D09F8B7020000AA00008369@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D09F8B7020000AA00008369-PZWwcLLCDcw8dQ1qNLwSjGRXbTvXh2ZWs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 16 Dec 2010 11:32:07 +0100, Matthias Zacharias wrote:
> With the new patch the driver is working fine, also with i2c_debug =
> 3.
> 
> See the screenshot in my dropbox
> (http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=8e2a46)

Looks good, great. I'll send the patch for review and comments to both
the linux-i2c list and LKML later today.

Do you want me to list you as a tester in the patch header? If I do
that, I'll have to include your name and e-mail address, so I need to
know if this is OK with you.

> > (...)
> > Just publish it as is, and I'll review it publicly. It will
> > certainly take a number of round trips to get it right, if this is
> > your first contribution, but that's OK.
> >
> 
> This MLX90614 driver has a reduced functionality. It was tailored for
> our application which use only the temperature read function.
> Also the SMBus address is fix defined in the source code, and no
> checkes if the factory preprogramming is correct are done.
> The option to manage the configuration of the MLX90614 as described in
> the datasheets is not yet implemented, because we don't need it.

This is totally OK. Others can add functionalities to the driver later
if needed.

> > (...)
> > FYI, I have asked Melexis for an MLX90614 evaluation board, they
> > have sent something to me, so as soon as I receive it I should be
> > able to test your driver.
> 
> The evalutionboard (EVB) shiped by Melexis uses his own microcontroller
> on that board and communicate to the PC via USB. In our system the
> MLX90614 sensor is connected directly to the port pins of the
> microcontroller.

I know that. I don't plan to actually use the micro-controller on the
evaluation board. There are I2C pins on the board, and I'll connect an
external I2C master [1] to them.

[1] http://www.harbaum.org/till/i2c_tiny_usb/index.shtml

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
