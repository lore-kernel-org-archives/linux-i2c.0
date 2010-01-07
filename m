From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Octeon: Add I2C platform device.
Date: Thu,  7 Jan 2010 13:23:41 -0800
Message-ID: <1262899421-6670-1-git-send-email-ddaney@caviumnetworks.com>
References: <4B464A37.7020300@caviumnetworks.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4B464A37.7020300@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org
Cc: rade.bozic.ext@nsn.com, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Rade Bozic <rade.bozic.ext@nsn.com>
---

This supersedes the original '[PATCH 1/3] MIPS: Octeon: Add I2C
platform driver.' and corrects the resource end value as noted by
Sergei Shtylyov.

 arch/mips/cavium-octeon/octeon-platform.c |   72 +++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h     |    5 ++
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 20698a6..b4a0b5f 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -165,6 +165,78 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
+
+#define OCTEON_I2C_IO_BASE 0x1180000001000ull
+#define OCTEON_I2C_IO_UNIT_OFFSET 0x200
+
+static struct octeon_i2c_data octeon_i2c_data[2];
+
+static int __init octeon_i2c_device_init(void)
+{
+	struct platform_device *pd;
+	int ret = 0;
+	int port, num_ports;
+
+	struct resource i2c_resources[] = {
+		{
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+
+	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
+		num_ports = 2;
+	else
+		num_ports = 1;
+
+	for (port = 0; port < num_ports; port++) {
+		octeon_i2c_data[port].sys_freq = octeon_get_clock_rate();
+		/*FIXME: should be examined. At the moment is set for 100Khz */
+		octeon_i2c_data[port].i2c_freq = 100000;
+
+		pd = platform_device_alloc("i2c-octeon", port);
+		if (!pd) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		pd->dev.platform_data = octeon_i2c_data + port;
+
+		i2c_resources[0].start =
+			OCTEON_I2C_IO_BASE + (port * OCTEON_I2C_IO_UNIT_OFFSET);
+		i2c_resources[0].end = i2c_resources[0].start + 0x1f;
+		switch (port) {
+		case 0:
+			i2c_resources[1].start = OCTEON_IRQ_TWSI;
+			i2c_resources[1].end = OCTEON_IRQ_TWSI;
+			break;
+		case 1:
+			i2c_resources[1].start = OCTEON_IRQ_TWSI2;
+			i2c_resources[1].end = OCTEON_IRQ_TWSI2;
+			break;
+		default:
+			BUG();
+		}
+
+		ret = platform_device_add_resources(pd,
+						    i2c_resources,
+						    ARRAY_SIZE(i2c_resources));
+		if (ret)
+			goto fail;
+
+		ret = platform_device_add(pd);
+		if (ret)
+			goto fail;
+	}
+	return ret;
+fail:
+	platform_device_put(pd);
+out:
+	return ret;
+}
+device_initcall(octeon_i2c_device_init);
+
 /* Octeon SMI/MDIO interface.  */
 static int __init octeon_mdiobus_device_init(void)
 {
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 705fef2..a0cf129 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -213,6 +213,11 @@ struct octeon_cf_data {
 	int		dma_engine;	/* -1 for no DMA */
 };
 
+struct octeon_i2c_data {
+	unsigned int	sys_freq;
+	unsigned int	i2c_freq;
+};
+
 extern void octeon_write_lcd(const char *s);
 extern void octeon_check_cpu_bist(void);
 extern int octeon_get_boot_uart(void);
-- 
1.6.0.6
