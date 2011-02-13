From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 5/6] i2cset: Replace blanks at beginning of line with tabs
Date: Sun, 13 Feb 2011 12:17:25 -0800
Message-ID: <1297628246-19367-6-git-send-email-guenter.roeck@ericsson.com>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297628246-19367-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 tools/i2cset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/i2cset.c b/tools/i2cset.c
index ad7da75..33290ef 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -35,7 +35,7 @@ static void help(void) __attribute__ ((noreturn));
 static void help(void)
 {
 	fprintf(stderr,
-	        "Usage: i2cset [-f] [-y] [-m MASK] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
+		"Usage: i2cset [-f] [-y] [-m MASK] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
 		"  I2CBUS is an integer or an I2C bus name\n"
 		"  ADDRESS is an integer (0x03 - 0x77)\n"
 		"  MODE is one of:\n"
-- 
1.7.0.4
