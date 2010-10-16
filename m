From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] i2c/mux: Driver for PCA9541 I2C Master Selector
Date: Fri, 15 Oct 2010 18:58:29 -0700
Message-ID: <20101016015829.GA30128@ericsson.com>
References: <1286932516-20689-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1286932516-20689-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 12, 2010 at 09:15:16PM -0400, Guenter Roeck wrote:
> This patch adds support for PCA9541, an I2C Bus Master Selector.
> The driver is modeled as single channel I2C Multiplexer to be able to utilize
> the I2C multiplexer framework.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Tom Grennan <tom.grennan-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
> v2 changes:
> - Added more detailed description and reasoning why the driver was implemented
>   as single-channel multiplexer.
> - Modified arbitration algorithm, since access to i2c masters from interrupt
>   level is not a good idea. Instead of using hrtimers and handling arbitration
>   in interrupt, handle it from select_chan and either delay for short retry
>   periods or sleep for long (millisecond) periods.
> 
>  drivers/i2c/muxes/Kconfig   |   10 +
>  drivers/i2c/muxes/Makefile  |    1 +
>  drivers/i2c/muxes/pca9541.c |  397 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 408 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/muxes/pca9541.c
> 
Any comments / thoughts / feedback ?

Thanks,
Guenter
