From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/6] i2c: designware: Make dw_readl() and dw_writel() static
Date: Mon, 31 Aug 2015 17:31:31 +0300
Message-ID: <1441031493-18938-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

dw_readl() and dw_writel() are not used outside of i2c-designware-core and
they are not exported so make them static and remove their forward
declaration.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c | 4 ++--
 drivers/i2c/busses/i2c-designware-core.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c9e93a76a455..52272a01c679 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -165,7 +165,7 @@ static char *abort_sources[] = {
 		"lost arbitration",
 };
 
-u32 dw_readl(struct dw_i2c_dev *dev, int offset)
+static u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 {
 	u32 value;
 
@@ -181,7 +181,7 @@ u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 		return value;
 }
 
-void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
+static void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 {
 	if (dev->accessor_flags & ACCESS_SWAP)
 		b = swab32(b);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 10c79038834d..0e73b8672402 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -112,8 +112,6 @@ struct dw_i2c_dev {
 #define ACCESS_SWAP		0x00000001
 #define ACCESS_16BIT		0x00000002
 
-extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
-extern void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset);
 extern int i2c_dw_init(struct dw_i2c_dev *dev);
 extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		int num);
-- 
2.5.0
