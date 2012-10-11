From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] i2c-ocores: Add support for custom getreg and setreg functions
Date: Thu, 11 Oct 2012 16:11:18 +0200
Message-ID: <1349964679-23244-3-git-send-email-andreas@gaisler.com>
References: <1349964679-23244-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349964679-23244-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index d62cb3f..de93b2d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -39,6 +39,8 @@ struct ocores_i2c {
 	int nmsgs;
 	int state; /* see STATE_ */
 	int clock_khz;
+	void (*setreg)(struct ocores_i2c *i2c, int reg, u8 value);
+	u8 (*getreg)(struct ocores_i2c *i2c, int reg);
 };
 
 /* registers */
@@ -72,9 +74,12 @@ struct ocores_i2c {
 #define STATE_READ		3
 #define STATE_ERROR		4
 
+
 static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
 {
-	if (i2c->reg_io_width == 4)
+	if (i2c->setreg)
+		i2c->setreg(i2c, reg, value);
+	else if (i2c->reg_io_width == 4)
 		iowrite32(value, i2c->base + (reg << i2c->reg_shift));
 	else if (i2c->reg_io_width == 2)
 		iowrite16(value, i2c->base + (reg << i2c->reg_shift));
@@ -84,7 +89,9 @@ static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
 
 static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 {
-	if (i2c->reg_io_width == 4)
+	if (i2c->getreg)
+		return i2c->getreg(i2c, reg);
+	else if (i2c->reg_io_width == 4)
 		return ioread32(i2c->base + (reg << i2c->reg_shift));
 	else if (i2c->reg_io_width == 2)
 		return ioread16(i2c->base + (reg << i2c->reg_shift));
-- 
1.7.0.4
