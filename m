From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: muxes: rename first set of drivers to a standard
 pattern
Date: Fri, 27 Apr 2012 15:59:22 +0200
Message-ID: <20120427155922.4a7e41ed@endymion.delvare>
References: <1335386636-23892-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335386636-23892-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi again Wolfram,

On Wed, 25 Apr 2012 22:43:56 +0200, Wolfram Sang wrote:
> Apply a naming pattern like in the rest of the subsystem to a first set
> of mux drivers. Those drivers are the low-hanging fruit; we want to pick
> them to motivate upcoming drivers to follow the new pattern. The missing
> GPIO driver will be converted in a later patch.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> (pca9541)
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/muxes/Kconfig                          |    4 ++--
>  drivers/i2c/muxes/Makefile                         |    4 ++--
>  drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} |    0
>  drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} |    0
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename drivers/i2c/muxes/{pca9541.c => i2c-mux-pca9541.c} (100%)
>  rename drivers/i2c/muxes/{pca954x.c => i2c-mux-pca954x.c} (100%)

Oh, BTW, you'll have to update the "PCA9541 I2C BUS MASTER SELECTOR
DRIVER" entry in MAINTAINERS too.

-- 
Jean Delvare
