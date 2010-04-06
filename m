From: Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: [PATCH] omap: Add I2C bus 1 initialisation for OMAP2430
Date: Tue, 6 Apr 2010 11:53:33 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B9973430254343A3A@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Initialize isp1301 FS USB transceiver and
add I2C bus1 initialization code for OMAP2430

Signed-off-by: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
---
 arch/arm/mach-omap2/board-2430sdp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..346e1d2 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -174,9 +174,17 @@ static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
        },
 };

+static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
+       {
+               I2C_BOARD_INFO("isp1301_omap", 0x2D),
+               .flags = I2C_CLIENT_WAKE,
+               .irq = OMAP_GPIO_IRQ(78),
+       },
+}
 static int __init omap2430_i2c_init(void)
 {
-       omap_register_i2c_bus(1, 400, NULL, 0);
+       omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
+                       ARRAY_SIZE(sdp2430_i2c1_boardinfo));
        omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
                        ARRAY_SIZE(sdp2430_i2c_boardinfo));
        return 0;
--
1.6.6

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
