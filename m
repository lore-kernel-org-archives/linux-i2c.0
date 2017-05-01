From: Tim Sander <tim@krieglstein.org>
Subject: Re: RFC: i2c designware gpio recovery
Date: Mon, 01 May 2017 15:31:39 +0200
Message-ID: <1658050.mjbUFfzRWa@virgo>
References: <2259005.m0altzP21Z@dabox> <2269277.HqpbCE3B5H@dabox> <25752a11-3b13-762f-5916-66893d223988@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from krieglstein.org ([176.28.13.145]:35304 "EHLO krieglstein.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968371AbdEANbm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 1 May 2017 09:31:42 -0400
In-Reply-To: <25752a11-3b13-762f-5916-66893d223988@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Good Day Phil

Am Montag, 1. Mai 2017, 09:57:35 CEST schrieb Phil Reid:
> > So i took a look into the device tree file socfpga.dtsi and found that the
> > reset lines where not defined (although available in the corresponding
> > reset manager). Is there a reason for this? Other components are
> > connected.
> 
> There's a few thing like that where the bootloader has been expected to
> setup the resets etc.
Yes, but if the resets are not connected in the device tree, the linux drivers
are not going to use them?

> > However with the patch below my previously sent patch works!
> > 
> > If there is interest in would cleanup the patch and send it in for
> > mainlining. I think the most unacceptable part would be this line:
> > +       ret = gpio_request_one(bri->scl_gpio, //GPIOF_OPEN_DRAIN |
> > My gpio drivers refuse to work as output as they have no open drain mode.
> > So i wonder how to get this solved in a clean manner.
> 
> I thought the gpio system would emulate open drain by switching the pin
> between an input and output driven low in this case. How are you
> configuring the GPIO's in the FPGA?
I don't switch to GPIO mode. As the I2C logic is only pulling active low, i only do
a wired and with the gpio (implemented in the fpga) port output on the output
enable line for the SCL output.  SDA is only an additional input for the second in
fpga gpio port. 

A picture should make it a clearer:

gpio scl--\
i2c   scl --&---i2c mode output pin (configured as fpga loan)

In my case the original i2c pins where occupied by some other logic conflicting
so the i2c pins had to be shifted to some other pins using fpga logic. So it was
just a matter of adding a two port gpio port.

> Given a couple of days I can test this on some flack i2c hardware I have
> with a Cyclone-V SOC. I'm interested in the functionality as well.
Sounds good. If you need some further input how i have configured the fpga
drop me a line.

> For i2c that are connected to the dedicated HPS pins it should be possible
> to reconfigure the pin mux controller (see system manager) in the HPS to
> avoid the need to go thru the fpga to get direct control. The docs say this
> is "unsupport" but I've done some test and it does seem to work. 
As far as i know the internal jtag chain is only used in the bootloader and there 
is no linux driver? But it shouldn't be a too big problem to port it to linux.

What i am unsure about is the fact that the internal jtag chain which controls the
pinmuxing might wreak havoc on other pin states if you reconfigure it?

> I'm guess
> the no support is in a similar vain to the emac ptp FPGA interface couldn't
> be used when the HPS pin where used. But that got changed when the user's
> proved otherwise. There's just no pin ctrl driver yet to manage it.
I am interested in this ptp solution too. Is there anything on the way to mainline?

Best regards
Tim
