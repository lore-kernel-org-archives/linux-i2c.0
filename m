From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/7] dma: iop-adma: include prefetch.h
Date: Tue, 13 Aug 2019 10:03:24 +0530
Message-ID: <20190813043324.GN12733@vkoul-mobl.Dlink>
References: <20190809162956.488941-1-arnd@arndb.de>
 <20190809163334.489360-1-arnd@arndb.de>
 <20190809163334.489360-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809163334.489360-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, kbuild test robot <lkp@intel.com>
List-Id: linux-i2c@vger.kernel.org

On 09-08-19, 18:33, Arnd Bergmann wrote:
> Compile-testing this driver fails on m68k without the
> extra header inclusion.

Please change title to "dmaengine: iop-adma: include prefetch.h"

After that:

Acked-by: Vinod Koul <vkoul@kernel.org>

> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/iop-adma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
> index c6c0143670d9..7857b54770d1 100644
> --- a/drivers/dma/iop-adma.c
> +++ b/drivers/dma/iop-adma.c
> @@ -16,6 +16,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/prefetch.h>
>  #include <linux/memory.h>
>  #include <linux/ioport.h>
>  #include <linux/raid/pq.h>
> -- 
> 2.20.0

-- 
~Vinod
