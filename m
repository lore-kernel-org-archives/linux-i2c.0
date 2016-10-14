From: Luis.Oliveira@synopsys.com
Subject: [PATCH v2 3/4] Device bindings documentation updated ACPI-enabled platforms not currently supported
Date: Fri, 14 Oct 2016 17:52:50 +0100
Message-ID: <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59102 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbcJNQxs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Oct 2016 12:53:48 -0400
In-Reply-To: <cover.1476462204.git.lolivei@synopsys.com>
In-Reply-To: <cover.1476462204.git.lolivei@synopsys.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com

From: Luis Oliveira <lolivei@synopsys.com>

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 5 ++++-
 drivers/i2c/busses/i2c-designware-platdrv.c              | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fee26dc..d3d163c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -19,6 +19,8 @@ Optional properties :
 
  - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
    This value which is by default 300ns is used to compute the tHIGH period.
+   
+ - is-slave : indicates if the block is a I2C slave device.
 
 Example :
 
@@ -30,7 +32,7 @@ Example :
 		interrupts = <11>;
 		clock-frequency = <400000>;
 	};
-
+	
 	i2c@1120000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -42,4 +44,5 @@ Example :
 		i2c-sda-hold-time-ns = <300>;
 		i2c-sda-falling-time-ns = <300>;
 		i2c-scl-falling-time-ns = <300>;
+		is-slave;
 	};
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index b9076da..f29e657 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -238,7 +238,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 					 &dev->scl_falling_time);
 		device_property_read_u32(&pdev->dev, "clock-frequency",
 					 &dev->clk_freq);
-		is_slave = device_property_read_bool(&pdev->dev, "isslave");
+#ifndef CONFIG_ACPI
+		is_slave = device_property_read_bool(&pdev->dev, "is-slave");
+#endif
 	}
 
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
-- 
2.10.1
