From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/6] i2cset: Check number of arguments for block data writes
Date: Sun, 13 Feb 2011 12:17:22 -0800
Message-ID: <1297628246-19367-3-git-send-email-guenter.roeck@ericsson.com>
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
 tools/i2cset.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/tools/i2cset.c b/tools/i2cset.c
index 8856d71..c59186b 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -219,11 +219,15 @@ int main(int argc, char *argv[])
 		}
 		if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_I2C_BLOCK_DATA) {
 			pec = argv[argc-1][1] == 'p';
+			if (argc > (int)sizeof(block) + flags + 5) {
+				fprintf(stderr, "Error: Bad number of arguments!\n");
+				help();
+			}
 			if (pec && size == I2C_SMBUS_I2C_BLOCK_DATA) {
 				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
 				help();
 			}
-			for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
+			for (len = 0; len + flags + 5 < argc; len++) {
 				value = strtol(argv[flags + len + 4], &end, 0);
 				if (*end || value < 0 || value > 0xff) {
                                 	fprintf(stderr, "Error: Block data value invalid!\n");
-- 
1.7.0.4
