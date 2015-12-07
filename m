From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt
Date: Mon, 7 Dec 2015 12:52:21 +0200
Message-ID: <20151207105221.GI16813@lahna.fi.intel.com>
References: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
 <20151201112127.GA1593@lahna.fi.intel.com>
 <CALD+uuxJw5tQ2XY99nHigXdNkcXGnng+r9NZ8H9TqUF9GbgW=A@mail.gmail.com>
 <20151201130324.GE1593@lahna.fi.intel.com>
 <56622373.7020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56622373.7020406@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Christophe Ricard <christophe.ricard@gmail.com>
Cc: rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 05, 2015 at 12:36:19AM +0100, Christophe Ricard wrote:
> >No, but I wonder if it would be better to do this in acpi_dev_gpio_irq_get()
> >instead of acpi_find_gpio() which gets called everytime a GPIO is looked up?
> I believe, setting the irq type requires triggering and polarity data stored
> into a struct acpi_resource_gpio.
> 
> acpi_dev_gpio_irq_get call acpi_get_gpiod_by_index which run acpi_find_gpio.
> 
> Actually acpi_dev_gpio_irq_get is called everytime an i2c device slave is
> probed, acpi_find_gpio will get called to "register" gpios.
> If done correctly, i think this will be done only once...
> 
> The only improvement i may see would be to add an extra field in the
> acpi_gpio_info structure in drivers/gpio/gpiolib.h (for example int
> irq_type).
> And call irq_set_irq_type in acpi_dev_gpio_irq_get if the gpio is an
> interrupt.
> 
> I guess the current proposal and this one are equivalent...
> 
> What do you think ?

Actually I think it may be useful to add triggering flags to
acpi_gpio_info.
