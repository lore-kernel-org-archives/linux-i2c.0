From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/2] i2c: npcm7xx: add i2c controller master mode only
Date: Sun, 29 Jul 2018 14:27:21 +0300
Message-ID: <CAHp75VdKhSbAj5c_41Xm1zWDnmTnaQjCMKXQ_7Lxfz03Ktft9A@mail.gmail.com>
References: <20180729091449.385951-1-tali.perry1@gmail.com> <20180729091449.385951-3-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180729091449.385951-3-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tali Perry <tali.perry1@gmail.com>
Cc: Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, venture@google.com, yuenn@google.com, brendanhiggins@google.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, pierre-yves.mordret@st.com, cedric.madianga@gmail.com, Baolin Wang <baolin.wang@spreadtrum.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, rmk+kernel@armlinux.org.uk, Ard Biesheuvel <ard.biesheuvel@linaro.>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jul 29, 2018 at 12:14 PM, Tali Perry <tali.perry1@gmail.com> wrote:
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
> This module also includes a slave mode, which will be submitted later on.
>
> Any feedback would be appreciated.

Too much lines of code as for I2C driver.

Briefly looking it seems it doesn't utilize what kernel already has
(e.g. crc8 already is in kernel library) and doesn't follow modern
style of drivers there.

> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/jiffies.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clk/nuvoton.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>

Just wow. Are you sure you need all of them? (Also, to see better what
it's used, keep them in order)

> +#define ENABLE 1
> +#define DISABLE        0

So, what's wrong with 1, 0 or true, false?

> +#define _1Hz_          (u32)1UL
> +#define _1KHz_         (1000 * _1Hz_)
> +#define _1MHz_         (1000 * _1KHz_)
> +#define _1GHz_         (1000 * _1MHz_)

If you need such constants it would be something like for time periods we have

HZ_PER_KHZ 1000
HZ_PER_MHZ 1000000

etc.

I saw in a code some of those predefined. If they are not yet generic
(in scope of kernel) it might be worth to do in the future.

> +#ifndef ASSERT
> +#ifdef DEBUG
> +#define ASSERT(cond)  {if (!(cond)) for (;;) ; }
> +#else
> +#define ASSERT(cond)
> +#endif
> +#endif

Hmm... In production code?!

> +
> +#define ROUND_UP(val, n)       (((val)+(n)-1) & ~((n)-1))
> +#define DIV_CEILING(a, b)       (((a) + ((b)-1)) / (b))


You really need to check what kernel provides.

> +#define I2C_DEBUG2(f, x...)

???

> +
> +
> +
> +

Why to have so many blank lines?

> +
> +

Ditto.

> +// Common regs
> +#define NPCM7XX_SMBSDA(bus)            (bus->base + 0x000)
> +#define NPCM7XX_SMBST(bus)             (bus->base + 0x002)
> +#define NPCM7XX_SMBCST(bus)            (bus->base + 0x004)
> +#define NPCM7XX_SMBCTL1(bus)           (bus->base + 0x006)
> +#define NPCM7XX_SMBADDR1(bus)          (bus->base + 0x008)
> +#define NPCM7XX_SMBCTL2(bus)           (bus->base + 0x00A)
> +#define NPCM7XX_SMBADDR2(bus)          (bus->base + 0x00C)
> +#define NPCM7XX_SMBCTL3(bus)           (bus->base + 0x00E)
> +#define NPCM7XX_SMBCST2(bus)           (bus->base + 0x018)  // Control Status 2
> +#define NPCM7XX_SMBCST3(bus)           (bus->base + 0x019)  // Control Status 3
> +#define SMB_VER(bus)                   (bus->base + 0x01F)  // SMB Version reg

Usually we put just numbers here and use custom I/O accessors which
take bus as a parameter.

> +
> +// BANK 0 regs
> +#define NPCM7XX_SMBADDR3(bus)          (bus->base + 0x010)
> +#define NPCM7XX_SMBADDR7(bus)          (bus->base + 0x011)
> +#define NPCM7XX_SMBADDR4(bus)          (bus->base + 0x012)
> +#define NPCM7XX_SMBADDR8(bus)          (bus->base + 0x013)
> +#define NPCM7XX_SMBADDR5(bus)          (bus->base + 0x014)
> +#define NPCM7XX_SMBADDR9(bus)          (bus->base + 0x015)
> +#define NPCM7XX_SMBADDR6(bus)          (bus->base + 0x016)
> +#define NPCM7XX_SMBADDR10(bus)         (bus->base + 0x017)

> +#define NPCM7XX_SMBADDR(bus, i)        (bus->base + 0x008 + \
> +       (u32)(((int)i * 4) + (((int)i < 2) ? 0 : \
> +       ((int)i - 2)*(-2)) + (((int)i < 6) ? 0 : (-7))))

It's rather complicated.

> +       // Current state of SMBus

I guess more compact is to put a kernel doc descriprion.

> +       enum smb_state          state;


> +static bool NPCM7XX_smb_init_module(struct NPCM7XX_i2c *bus,
> +                                   enum smb_mode mode, u16 bus_freq);

Do you need all forward declarations? Why?


So, I stopped here.

Try to make your code twice less in a lenght (looking at it I think
it's doable).


> +static const struct of_device_id NPCM7XX_i2c_bus_of_table[] = {
> +       { .compatible = "nuvoton,npcm750-i2c-bus", },

> +       {},

Slightly better without comma for terminator lines.

> +};
> +MODULE_DEVICE_TABLE(of, NPCM7XX_i2c_bus_of_table);

-- 
With Best Regards,
Andy Shevchenko
