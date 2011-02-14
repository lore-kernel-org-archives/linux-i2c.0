From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 2/6] i2cset: Check number of arguments for block data writes
Date: Mon, 14 Feb 2011 10:06:09 -0800
Message-ID: <1297706773-26389-3-git-send-email-guenter.roeck@ericsson.com>
References: <1297706773-26389-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297706773-26389-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 tools/i2cset.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/tools/i2cset.c b/tools/i2cset.c
index e47c9d4..e835465 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -223,7 +223,11 @@ int main(int argc, char *argv[])
 				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
 				help();
 			}
-			for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
+			if (argc > (int)sizeof(block) + flags + 5) {
+				fprintf(stderr, "Error: Too many arguments!\n");
+				help();
+			}
+			for (len = 0; len + flags + 5 < argc; len++) {
 				value = strtol(argv[flags + len + 4], &end, 0);
 				if (*end || value < 0 || value > 0xff) {
                                 	fprintf(stderr, "Error: Block data value invalid!\n");
-- 
1.7.0.4
