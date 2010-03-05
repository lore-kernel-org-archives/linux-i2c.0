From: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri,  5 Mar 2010 15:08:15 +0800
Message-ID: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

An EEPROM resides on 0x50 of I2C bus on CN56xx/57xx board,
register this device.

Signed-off-by: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
 arch/mips/cavium-octeon/octeon-platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 62ac30e..5bfa513 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -164,6 +164,9 @@ static struct i2c_board_info __initdata octeon_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
 	},
+	{
+		I2C_BOARD_INFO("eeprom", 0x50),
+	},
 };
 
 static int __init octeon_i2c_devices_init(void)
-- 
1.6.3.3
