From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] i2c: imx: Initialize DMA before registering I2C adapter
Date: Thu, 11 Jul 2019 20:25:19 -0700
Message-ID: <CAHQ1cqG0=_ONFALzqCmsvKU-Lm4TFqjuiNWF=qz-GGm+5EJGag@mail.gmail.com>
References: <20190609055658.3446-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190609055658.3446-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Chris Healy <cphealy@gmail.com>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 8, 2019 at 10:57 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Allocating DMA after registering I2C adapter can lead to infinite
> probing loop, for example, consider the following scenario:
>
>     1. i2c_imx_probe() is called and successfully registers an I2C
>        adapter via i2c_add_numbered_adapter()
>
>     2. As a part of i2c_add_numbered_adapter() new I2C slave devices
>        are added from DT which results in a call to
>        driver_deferred_probe_trigger()
>
>     3. i2c_imx_probe() continues and calls i2c_imx_dma_request() which
>        due to lack of proper DMA driver returns -EPROBE_DEFER
>
>     4. i2c_imx_probe() fails, removes I2C adapter and returns
>        -EPROBE_DEFER, which places it into deferred probe list
>
>     5. Deferred probe work triggered in #2 above kicks in and calls
>        i2c_imx_probe() again thus bringing us to step #1
>
> To avoid having this problem, move i2c_imx_dma_request() to happen
> before i2c_add_numbered_adapter().
>
> This problem was encountered on VF610 CFU1 board with
> CONFIG_FSL_EDMA=n.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Gentle ping. Any feedback on this?

Thanks,
Andrey Smirnov
