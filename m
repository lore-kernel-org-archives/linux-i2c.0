From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Fix for Dell P57G touchpad found, need advice on patch
Date: Thu, 17 Sep 2015 12:32:39 +0300
Message-ID: <20150917093239.GH1536@lahna.fi.intel.com>
References: <CAN_72e1BBk_s1BRBHJYuA7+2nbfYf1bCoD9fqatmTxRM_w=myg@mail.gmail.com>
 <20150915164214.GD1525@katana>
 <20150915171151.GF1525@katana>
 <20150916084039.GC1536@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150916084039.GC1536-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Roskin <plroskin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 16, 2015 at 11:40:39AM +0300, Mika Westerberg wrote:
> Can you send me acpidump of that machine (or contents of
> /sys/firmware/acpi/tables/DSDT)? It may be that the ACPI I2cSerialBus
> connector actually has 100kHz there - we just don't use it currently.

Thanks for the DSDT.

All touchpads seem to have 400kHz set in their I2cSerialBus connectors :-(

Can you try the below patch and see if it changes anything? One suspect
is that instead of running wrong frequency, timings for fast mode are
not correct. The below patch will force the driver to use calculated
ones (based on the DW I2C datasheet).

Please also attach dmesg from the test run.

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3dd2de31a2f8..3ef19477e37e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -91,6 +91,15 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	dw_i2c_acpi_params(pdev, "FMCN", &dev->fs_hcnt, &dev->fs_lcnt,
 			   &dev->sda_hold_time);
 
+	dev_info(&pdev->dev, "ACPI SSCN %u:%u\n", dev->ss_hcnt, dev->ss_lcnt);
+	dev_info(&pdev->dev, "ACPI FMCN %u:%u\n", dev->fs_hcnt, dev->fs_lcnt);
+	dev_info(&pdev->dev, "ACPI SDA hold %u\n", dev->sda_hold_time);
+
+	/* Use defaults */
+	dev->ss_hcnt = dev->ss_lcnt = 0;
+	dev->fs_hcnt = dev->fs_lcnt = 0;
+	dev->sda_hold_time = 0;
+
 	/*
 	 * Provide a way for Designware I2C host controllers that are not
 	 * based on Intel LPSS to specify their input clock frequency via
