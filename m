From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] i2c: cadence: Move to sensible power management
Date: Wed, 28 Oct 2015 09:18:10 -0700
Message-ID: <20151028161810.GB6436@xsjsorenbubuntu>
References: <1446017200-30373-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446017200-30373-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, wsa@the-dreams.de, anirudh@xilinx.com, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

Hi Shubhrajyoti,


On Wed, 2015-10-28 at 12:56PM +0530, Shubhrajyoti Datta wrote:
> Currently the clocks are enabled at probe and disabled at remove.
> Which keeps the clocks enabled even if no transaction is going on.
> This patch enables the clocks at the start of transfer and disables
> after it.
>=20
> Also adapts to runtime pm.
> Remove xi2c->suspended and use pm runtime status instead.
>=20
> converts dev pm to const to silence a checkpatch warning.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

To me, this looks all good. Just one small concern below.

> ---
> changes since v2
> update the cc list
>=20
>  drivers/i2c/busses/i2c-cadence.c |   73 ++++++++++++++++++++++++----=
----------
>  1 files changed, 46 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2=
c-cadence.c
> index 84deed6..6b08d16 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
> =20
>  /* Register offsets for the I2C device. */
>  #define CDNS_I2C_CR_OFFSET		0x00 /* Control Register, RW */
> @@ -96,6 +97,8 @@
>  					 CDNS_I2C_IXR_COMP)
> =20
>  #define CDNS_I2C_TIMEOUT		msecs_to_jiffies(1000)
> +/* timeout for pm runtime autosuspend */
> +#define CNDS_I2C_PM_TIMEOUT		1000	/* ms */
> =20
>  #define CDNS_I2C_FIFO_DEPTH		16
>  /* FIFO depth at which the DATA interrupt occurs */
> @@ -128,7 +131,6 @@
>   * @xfer_done:		Transfer complete status
>   * @p_send_buf:		Pointer to transmit buffer
>   * @p_recv_buf:		Pointer to receive buffer
> - * @suspended:		Flag holding the device's PM status
>   * @send_count:		Number of bytes still expected to send
>   * @recv_count:		Number of bytes still expected to receive
>   * @curr_recv_count:	Number of bytes to be received in current trans=
fer
> @@ -141,6 +143,7 @@
>   * @quirks:		flag for broken hold bit usage in r1p10
>   */
>  struct cdns_i2c {
> +	struct device		*dev;
>  	void __iomem *membase;
>  	struct i2c_adapter adap;
>  	struct i2c_msg *p_msg;
> @@ -148,7 +151,6 @@ struct cdns_i2c {
>  	struct completion xfer_done;
>  	unsigned char *p_send_buf;
>  	unsigned char *p_recv_buf;
> -	u8 suspended;

There might have been a reason to store this flag here. Did you test
this with lockdep and CONFIG_DEBUG_ATOMIC_SLEEP? Just to make sure that
nothing that can sleep is called from atomic context.

	S=C3=B6ren
