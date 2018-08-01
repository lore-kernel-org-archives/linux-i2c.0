From: Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] i2c: enable buses to save their clock frequency in adapter
Date: Wed, 1 Aug 2018 16:35:11 +0300
Message-ID: <20180801133512.12276-2-tudor.ambarus@microchip.com>
References: <20180801133512.12276-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801133512.12276-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, ludovic.desroches@microchip.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org, Tudor Ambarus <tudor.ambarus@microchip.com>
List-Id: linux-i2c@vger.kernel.org

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwise,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and enable the buses to save their clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index bc8d42f..fe65768 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -677,6 +677,7 @@ struct i2c_adapter {
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
 
+	u32 bus_freq_hz;
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
-- 
2.9.4
