From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 3/6] i2cset: Abort if value mask is set for block commands
Date: Sun, 13 Feb 2011 12:17:23 -0800
Message-ID: <1297628246-19367-4-git-send-email-guenter.roeck@ericsson.com>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297628246-19367-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Specifying the value mask is not supported for block commands,
abort if it is specified anyway.

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 tools/i2cset.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tools/i2cset.c b/tools/i2cset.c
index c59186b..bdc16f8 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -227,6 +227,10 @@ int main(int argc, char *argv[])
 				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
 				help();
 			}
+			if (maskp) {
+				fprintf(stderr, "Error: Mask not supported for block writes!\n");
+				help();
+			}
 			for (len = 0; len + flags + 5 < argc; len++) {
 				value = strtol(argv[flags + len + 4], &end, 0);
 				if (*end || value < 0 || value > 0xff) {
-- 
1.7.0.4
