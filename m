From: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] sh: i2c-sh7760: Replase from ctrl_* to __raw_*
Date: Sun, 24 Oct 2010 17:37:46 +0900
Message-ID: <1287909466-16898-1-git-send-email-iwamatsu@nigauri.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ctrl_* is deprecated. We should to use __raw_*.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sh7760.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
index 4f93da3..3cad8fe 100644
--- a/drivers/i2c/busses/i2c-sh7760.c
+++ b/drivers/i2c/busses/i2c-sh7760.c
@@ -101,12 +101,12 @@ struct cami2c {
 
 static inline void OUT32(struct cami2c *cam, int reg, unsigned long val)
 {
-	ctrl_outl(val, (unsigned long)cam->iobase + reg);
+	__raw_writel(val, (unsigned long)cam->iobase + reg);
 }
 
 static inline unsigned long IN32(struct cami2c *cam, int reg)
 {
-	return ctrl_inl((unsigned long)cam->iobase + reg);
+	return __raw_readl((unsigned long)cam->iobase + reg);
 }
 
 static irqreturn_t sh7760_i2c_irq(int irq, void *ptr)
-- 
1.7.2.3
