From: Christophe Henri RICARD <christophe-h.ricard@st.com>
Subject: RE: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt
Date: Mon, 7 Dec 2015 11:53:56 +0100
Message-ID: <8646C2A85C5D44419E1B33F16B0BD5010245661EE1@SAFEX1MAIL1.st.com>
References: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
 <20151201112127.GA1593@lahna.fi.intel.com>
 <CALD+uuxJw5tQ2XY99nHigXdNkcXGnng+r9NZ8H9TqUF9GbgW=A@mail.gmail.com>
 <20151201130324.GE1593@lahna.fi.intel.com> <56622373.7020406@gmail.com>
 <20151207105221.GI16813@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151207105221.GI16813@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Christophe Ricard <christophe.ricard@gmail.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

Ok, i will send a RFC serie tonight. I have also noticed the spi core s=
et the irq field to -1 in acpi. This will be fixed in this serie.

Best Regards
Christophe

-----Original Message-----
=46rom: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]=20
Sent: lundi 7 d=E9cembre 2015 11:52
To: Christophe Ricard
Cc: rjw@rjwysocki.net; Len Brown; Linus Walleij; Alexandre Courbot; and=
riy.shevchenko@linux.intel.com; linux-i2c@vger.kernel.org; linux-gpio@v=
ger.kernel.org; linux-acpi@vger.kernel.org; Christophe Henri RICARD
Subject: Re: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt

On Sat, Dec 05, 2015 at 12:36:19AM +0100, Christophe Ricard wrote:
> >No, but I wonder if it would be better to do this in=20
> >acpi_dev_gpio_irq_get() instead of acpi_find_gpio() which gets calle=
d everytime a GPIO is looked up?
> I believe, setting the irq type requires triggering and polarity data=
=20
> stored into a struct acpi_resource_gpio.
>=20
> acpi_dev_gpio_irq_get call acpi_get_gpiod_by_index which run acpi_fin=
d_gpio.
>=20
> Actually acpi_dev_gpio_irq_get is called everytime an i2c device slav=
e=20
> is probed, acpi_find_gpio will get called to "register" gpios.
> If done correctly, i think this will be done only once...
>=20
> The only improvement i may see would be to add an extra field in the=20
> acpi_gpio_info structure in drivers/gpio/gpiolib.h (for example int=20
> irq_type).
> And call irq_set_irq_type in acpi_dev_gpio_irq_get if the gpio is an=20
> interrupt.
>=20
> I guess the current proposal and this one are equivalent...
>=20
> What do you think ?

Actually I think it may be useful to add triggering flags to acpi_gpio_=
info.
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
