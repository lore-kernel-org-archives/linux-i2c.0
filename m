From: Jesper Juhl <jj-IYz4IdjRLj0sV2N9l4h3zg@public.gmane.org>
Subject: [PATCH 5/7] drivers/i2c: static should be at beginning of
 declaration
Date: Sat, 9 Jul 2011 23:20:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107092318590.25516@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1107092304160.25516@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-986330640-1310246442=:25516"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1107092304160.25516-h2p7t3/P30RzeRGmFJ5qR7ZzlVVXadcDXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-986330640-1310246442=:25516
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Make sure that the 'static' keywork is at the beginning of declaration
for drivers/i2c/busses/i2c-omap.c

This gets rid of warnings like
  warning: ¡static¢ is not at beginning of declaration
when building with -Wold-style-declaration (and/or -Wextra which also
enables it).

Signed-off-by: Jesper Juhl <jj-IYz4IdjRLj0sV2N9l4h3zg@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 58a58c7..1a766cf 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -204,7 +204,7 @@ struct omap_i2c_dev {
 	u16			errata;
 };
 
-const static u8 reg_map[] = {
+static const u8 reg_map[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
 	[OMAP_I2C_IE_REG] = 0x01,
 	[OMAP_I2C_STAT_REG] = 0x02,
@@ -225,7 +225,7 @@ const static u8 reg_map[] = {
 	[OMAP_I2C_BUFSTAT_REG] = 0x10,
 };
 
-const static u8 omap4_reg_map[] = {
+static const u8 omap4_reg_map[] = {
 	[OMAP_I2C_REV_REG] = 0x04,
 	[OMAP_I2C_IE_REG] = 0x2c,
 	[OMAP_I2C_STAT_REG] = 0x28,
-- 
1.7.6


-- 
Jesper Juhl <jj-IYz4IdjRLj0sV2N9l4h3zg@public.gmane.org>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

--8323328-986330640-1310246442=:25516--
