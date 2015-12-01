From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt
Date: Tue, 1 Dec 2015 15:03:24 +0200
Message-ID: <20151201130324.GE1593@lahna.fi.intel.com>
References: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
 <20151201112127.GA1593@lahna.fi.intel.com>
 <CALD+uuxJw5tQ2XY99nHigXdNkcXGnng+r9NZ8H9TqUF9GbgW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALD+uuxJw5tQ2XY99nHigXdNkcXGnng+r9NZ8H9TqUF9GbgW=A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Christophe Ricard <christophe.ricard@gmail.com>
Cc: rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 01, 2015 at 01:25:50PM +0100, Christophe Ricard wrote:
>    For example during an i2c_device_probe where an i2c slave device
>    describe in devicetree has an interrupts property.
>    i2c_device_probe (drivers/i2c/i2c-core.c), retrieves irq property from
>    of_irq_get which will looks for an "interrupts" property in
>    of_irq_parse_of (drivers/of/irq.c).
>    of_irq_get will then call irq_create_mapping (kernel/irq/irqdomain.c)
>    which will set the irq_type retrieved during the interrupts node
>    parsing.

Found it now thanks.

>    This will allow from an i2c slave drivers to configure an interrupt
>    handler matching the exact devicetree data for the interrupts property
>    of the i2c slave node.

Makes sense.

>    Now for the same kind of i2c driver using acpi description, the GpioInt
>    polarity/type is at the moment never kept in the irq property.
>    It is possible to check that following about the same path...
>    i2c_device_probe (drivers/i2c/i2c-core.c), retrieves irq property from
>    acpi_dev_gpio_irq_get but does not save the irq_type.
>    This would allow not to have to use an additional gpio field and all
>    the configuration step to configure the gpio interrupt correctly in a
>    device driver and taking a real benefit of the GpioInt acpi keyword
>    compare to GpioIo keyword.
>    Most the of the drivers based on acpi description retrieve gpio number
>    to assign an interrupt and a fix polarity. I believe my patchset
>    proposal would improve this and allow to
>    be much closer with devicetree.
>    Do you see any issue with this ?

No, but I wonder if it would be better to do this in acpi_dev_gpio_irq_get()
instead of acpi_find_gpio() which gets called everytime a GPIO is looked up?
