From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 3/6] i2cset: Abort if value mask is set for block commands
Date: Mon, 14 Feb 2011 10:06:10 -0800
Message-ID: <1297706773-26389-4-git-send-email-guenter.roeck@ericsson.com>
References: <1297706773-26389-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297706773-26389-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Specifying the value mask is not supported for block commands,
abort if it is specified anyway.

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 tools/i2cset.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tools/i2cset.c b/tools/i2cset.c
index e835465..7750c03 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -223,6 +223,10 @@ int main(int argc, char *argv[])
 				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
 				help();
 			}
+			if (maskp) {
+				fprintf(stderr, "Error: Mask not supported for block writes!\n");
+				help();
+			}
 			if (argc > (int)sizeof(block) + flags + 5) {
 				fprintf(stderr, "Error: Too many arguments!\n");
 				help();
-- 
1.7.0.4
