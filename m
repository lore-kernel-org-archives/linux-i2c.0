From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/6] i2cset: Remove deprecated method to provide the value mask
Date: Sun, 13 Feb 2011 12:17:21 -0800
Message-ID: <1297628246-19367-2-git-send-email-guenter.roeck@ericsson.com>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297628246-19367-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The old method to provide the value mask has long since been deprecated,
remove it.
---
 CHANGES        |    1 +
 tools/i2cset.c |   12 ------------
 2 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/CHANGES b/CHANGES
index 5aee418..999ff26 100644
--- a/CHANGES
+++ b/CHANGES
@@ -4,6 +4,7 @@ i2c-tools CHANGES
 SVN
   i2c-dev.h: Make value arrays const for block write functions
   i2cset: Add support for SMBus and I2C block writes
+          Remove obsolete means to specify value mask
 
 3.0.3 (2010-12-12)
   Makefile: Let the environment set CC and CFLAGS
diff --git a/tools/i2cset.c b/tools/i2cset.c
index 392262b..8856d71 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -265,18 +265,6 @@ int main(int argc, char *argv[])
 		pec = argv[flags+5][1] == 'p';
 	}
 
-	/* Old method to provide the value mask, deprecated and no longer
-	   documented but still supported for compatibility */
-	if (argc > flags + 6) {
-		if (maskp) {
-			fprintf(stderr, "Error: Data value mask provided twice!\n");
-			help();
-		}
-		fprintf(stderr, "Warning: Using deprecated way to set the data value mask!\n");
-		fprintf(stderr, "         Please switch to using -m.\n");
-		maskp = argv[flags+6];
-	}
-
 	if (maskp) {
 		vmask = strtol(maskp, &end, 0);
 		if (*end || vmask == 0) {
-- 
1.7.0.4
