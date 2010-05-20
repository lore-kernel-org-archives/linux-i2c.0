From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH 05/11] omap: i2c: Storage class should be before const qualifier
Date: Thu, 20 May 2010 10:35:28 +0200
Message-ID: <1274344528-8975-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7674efb..de79286 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -205,7 +205,7 @@ struct omap_i2c_dev {
 	u16			errata;
 };
 
-const static u8 reg_map[] = {
+static const u8 reg_map[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
 	[OMAP_I2C_IE_REG] = 0x01,
 	[OMAP_I2C_STAT_REG] = 0x02,
@@ -226,7 +226,7 @@ const static u8 reg_map[] = {
 	[OMAP_I2C_BUFSTAT_REG] = 0x10,
 };
 
-const static u8 omap4_reg_map[] = {
+static const u8 omap4_reg_map[] = {
 	[OMAP_I2C_REV_REG] = 0x04,
 	[OMAP_I2C_IE_REG] = 0x2c,
 	[OMAP_I2C_STAT_REG] = 0x28,
-- 
1.6.3.3
