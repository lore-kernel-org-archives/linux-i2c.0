From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Fri, 18 Dec 2015 12:13:48 +0200
Message-ID: <20151218101348.GG1762@lahna.fi.intel.com>
References: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450319025-19120-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 16, 2015 at 08:23:45PM -0600, Suravee Suthikulpanit wrote:
> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
> to directly provide these values. So, the clock information should
> no longer be required during probing.
> 
> However, since clk can be invalid, additional checks must be done where
> we are making use of it.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This works fine on Intel Baytrail and Skylake. However, I think we could
do this a bit better still ;-)

> ---
> 
> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
> 
> Changes in V2:
>     In v1, I disregarded the clock if SSCN and FMCN are provided,
>     assuming that it was not needed. That was incorrect assumption,
>     and is now fixed in v2.
> 
>  drivers/i2c/busses/i2c-designware-platdrv.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 8ffc36b..4615fe3 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -44,6 +44,9 @@
>  
>  static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
>  {
> +	if (IS_ERR(dev->clk))
> +		return 0;
> +
>  	return clk_get_rate(dev->clk)/1000;
>  }

So instead of this, what if we do not assign dev->get_clk_rate_khz at
all and then do something like below in the core driver?

Of course we still need the other changes you did in this patch to cope
with the missing clock.

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 8c48b27ba059..25dccd8df772 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -271,6 +271,17 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
 		 enable ? "en" : "dis");
 }
 
+static unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
+{
+	/*
+	 * Clock is not necessary if we got LCNT/HCNT values directly from
+	 * the platform code.
+	 */
+	if (WARN_ON_ONCE(!dev->get_clk_rate_khz))
+		return 0;
+	return dev->get_clk_rate_khz(dev);
+}
+
 /**
  * i2c_dw_init() - initialize the designware i2c master hardware
  * @dev: device private data
@@ -281,7 +292,6 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, bool enable)
  */
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
-	u32 input_clock_khz;
 	u32 hcnt, lcnt;
 	u32 reg;
 	u32 sda_falling_time, scl_falling_time;
@@ -295,8 +305,6 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		}
 	}
 
-	input_clock_khz = dev->get_clk_rate_khz(dev);
-
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
 		/* Configure register endianess access */
@@ -325,12 +333,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		hcnt = dev->ss_hcnt;
 		lcnt = dev->ss_lcnt;
 	} else {
-		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
 					4000,	/* tHD;STA = tHIGH = 4.0 us */
 					sda_falling_time,
 					0,	/* 0: DW default, 1: Ideal */
 					0);	/* No offset */
-		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
 					4700,	/* tLOW = 4.7 us */
 					scl_falling_time,
 					0);	/* No offset */
@@ -344,12 +352,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 		hcnt = dev->fs_hcnt;
 		lcnt = dev->fs_lcnt;
 	} else {
-		hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
 					600,	/* tHD;STA = tHIGH = 0.6 us */
 					sda_falling_time,
 					0,	/* 0: DW default, 1: Ideal */
 					0);	/* No offset */
-		lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
 					1300,	/* tLOW = 1.3 us */
 					scl_falling_time,
 					0);	/* No offset */
