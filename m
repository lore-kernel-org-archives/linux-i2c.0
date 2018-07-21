From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Sat, 21 Jul 2018 18:35:33 +0300
Message-ID: <CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com> <1532120272-17157-2-git-send-email-soares@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532120272-17157-2-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 20, 2018 at 11:57 PM, Vitor soares
<Vitor.Soares@synopsys.com> wrote:
> This patch add driver for Synopsys DesignWare IP on top of
> I3C subsystem patchset proposal V6

Some of comments below related to style.
But unaligned helpers I think is good to use.

> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i3c/master.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>

All of them required? Why?

> +       default:

Just return false here?

> +               break;
> +       }
> +
> +       return false;

> +       for (i = 0; i < nbytes; i += 4) {
> +               u32 data = 0;
> +

> +               for (j = 0; j < 4 && (i + j) < nbytes; j++)
> +                       data |= (u32)bytes[i + j] << (j * 8);

NIH of get_unaligned_le32()

> +
> +               writel(data, master->regs + RX_TX_DATA_PORT);
> +       }
> +}
> +
> +static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
> +                                      u8 *bytes, int nbytes)
> +{
> +       int i, j;
> +
> +       for (i = 0; i < nbytes; i += 4) {
> +               u32 data;
> +
> +               data = readl(master->regs + RX_TX_DATA_PORT);
> +


> +               for (j = 0; j < 4 && (i + j) < nbytes; j++)
> +                       bytes[i + j] = data >> (j * 8);

Ditto put_unaligned_le32() ?

> +       }
> +}

I'm wondering what else you open coded instead of using helpers we already have.

> +               writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
> +               writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);

hmm... writesl()?

> +       info->pid = (u64)readl(master->regs + SLV_PID_VALUE);

Why explicit casting?


> +       u32 r;
> +
> +
> +       core_rate = clk_get_rate(master->core_clk);

Too many blank lines in between.

> +
> +

Ditto.

> +       /* Prepare DAT before launching DAA. */
> +       for (pos = 0; pos < master->maxdevs; pos++) {
> +               if (olddevs & BIT(pos))
> +                       continue;
> +
> +               ret = i3c_master_get_free_addr(m, last_addr + 1);
> +               if (ret < 0)
> +                       return -ENOSPC;
> +               master->addrs[pos] = ret;

> +               p = (ret >> 6) ^ (ret >> 5) ^ (ret >> 4) ^ (ret >> 3) ^
> +                   (ret >> 2) ^ (ret >> 1) ^ ret ^ 1;
> +               p = p & 1;

Is it parity calculus? Do we have something implemented in kernel already?

Btw, https://graphics.stanford.edu/~seander/bithacks.html#ParityNaive
offered this

v ^= v >> 4;
v &= 0xf;
v = (0x6996 >> v) & 1;


-- 
With Best Regards,
Andy Shevchenko
