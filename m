From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Tue, 21 Oct 2008 21:22:48 -0700
Message-ID: <200810212122.49121.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <20081022014243.GA19362@oksana.dev.rtsoft.ru> <1224642497.7654.319.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752709AbYJVEXE@vger.kernel.org>
In-Reply-To: <1224642497.7654.319.camel@pasglop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org, avorontsov@ru.mvista.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 21 October 2008, Benjamin Herrenschmidt wrote:
> The notifier can be registered before the devices, though it's a little
> bit fishy and fragile.
> 
> Easier I suppose to just have OF specific hooks in the bus code.

Like what I suggested:  "chip-aware OF glue drivers".  The relevant
bus code being the "of_platform_bus_type" infrastructure.

Example:  instead of Anton's patch #6 modifying the existing pca953x
driver, an of_pca953x driver that knows how to poke around in the OF
device attributes to (a) create the pca953x_platform_data, (b) call
i2c_register_board_info() to make that available later, and then
finally (c) vanish, since it's not needed any longer.

Better that than either the $SUBJECT patch, or modifying gpiolib to
grow OF-specific hooks ... hooks that can at best solve *one* of the
problems:  which GPIO numbers to use with this chip.  The platform
data does solve other problems(*) like:  (i) how to initialize the
polarity inversion register, (ii) arranging to set up other devices
only after their GPIOs are ready, (iii) initializing things that
device drivers won't always know about, or which may need to be
set up before such drivers are available.

- Dave

(*) A trivial example of (ii) would be LEDs driven by those GPIOs.

    A less trivial example:  see arch/arm/mach-davinci/board-evm.c
    in current GIT.  There are three pcf8574 I2C expanders used for
    various things ... LEDs, audio PLL, device power supplies, reset
    lines for external devices, more.
