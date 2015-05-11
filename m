From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/3] gpio / ACPI: Add support for retrieving GpioInt
 resources from a device
Date: Mon, 11 May 2015 11:56:44 +0200
Message-ID: <CACRpkdYxE=wFxHHrVNB64S33iB0AH6CTXUb67EjJBd46S7zM9Q@mail.gmail.com>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
	<1430908148-201129-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430908148-201129-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 6, 2015 at 12:29 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> ACPI specification knows two types of GPIOs: GpioIo and GpioInt. The latter
> is used to describe that a given device interrupt line is connected to a
> specific GPIO pin. Typical ACPI _CRS entry for such device looks like
> below:
>
>     Name (_CRS, ResourceTemplate ()
>     {
>         I2cSerialBus (0x004A, ControllerInitiated, 0x00061A80,
>                       AddressingMode7Bit, "\\_SB.PCI0.I2C6",
>                       0x00, ResourceConsumer)
>         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
>                 IoRestrictionOutputOnly, "\\_SB.GPO0",
>                 0x00, ResourceConsumer)
>         {
>             0x004B
>         }
>         GpioInt (Level, ActiveLow, Shared, PullDefault, 0x0000,
>                  "\\_SB.GPO0", 0x00, ResourceConsumer)
>         {
>             0x004C
>         }
>     })
>
> Currently drivers need to request a GPIO corresponding to the right GpioInt
> and then translate that to Linux IRQ number. This adds unnecessary lines of
> boiler-plate code.
>
> We can ease this a bit by introducing acpi_dev_gpio_irq_get() analogous to
> of_irq_get(). This function translates given GpioInt resource under the
> device in question to the suitable Linux IRQ number.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Patch applied.

Yours,
Linus Walleij
