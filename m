From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V3 2/2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Wed, 3 Dec 2014 18:10:46 +0200
Message-ID: <20141203161046.GC28857@lahna.fi.intel.com>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-3-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417478973-25522-3-git-send-email-david.e.box@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: wsa@the-dreams.de, jdelvare@suse.de, arnd@arndb.de, maxime.ripard@free-electrons.com, dianders@chromium.org, u.kleine-koenig@pengutronix.de, laurent.pinchart+renesas@ideasonboard.com, boris.brezillon@free-electrons.com, andrew@lunn.ch, sjg@chromium.org, markus.mayer@linaro.org, jacob.jun.pan@linux.intel.com, max.schwarz@online.de, skuribay@pobox.com, Romain.Baeriswyl@abilis.com, wenkai.du@intel.com, chiau.ee.chew@intel.com, alan@linux.intel.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 01, 2014 at 04:09:33PM -0800, David E. Box wrote:
> This patch implements an I2C bus sharing mechanism between the host and platform
> hardware on select Intel BayTrail SoC platforms using the X-Powers AXP288 PMIC.
> 
> On these platforms access to the PMIC must be shared with platform hardware. The
> hardware unit assumes full control of the I2C bus and the host must request
> access through a special semaphore. Hardware control of the bus also makes it
> necessary to disable runtime pm to avoid interfering with hardware transactions.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/i2c/busses/Kconfig                   |  12 +++
>  drivers/i2c/busses/Makefile                  |   1 +
>  drivers/i2c/busses/i2c-designware-baytrail.c | 155 +++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h     |   6 ++
>  4 files changed, 174 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-designware-baytrail.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 917c358..d2bfd88 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -464,6 +464,18 @@ config I2C_DESIGNWARE_PCI
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-designware-pci.
>  
> +config I2C_DESIGNWARE_BAYTRAIL
> +	bool "Intel Baytrail I2C semaphore support"
> +	depends on I2C_DESIGNWARE_PLATFORM=y

Hmm, is there something preventing to compile this as module?

What comes to the driver itself, no objections from me.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
