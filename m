From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 4/6] i2cset: Ensure that there is no junk after the command/mode parameter
Date: Mon, 14 Feb 2011 10:06:11 -0800
Message-ID: <1297706773-26389-5-git-send-email-guenter.roeck@ericsson.com>
References: <1297706773-26389-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297706773-26389-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since the value mask can no longer be set after the mode command,
we can make sure that there is no junk after the command/mode
parameter in the command line.

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 CHANGES        |    1 +
 tools/i2cset.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/CHANGES b/CHANGES
index 999ff26..1ffe18f 100644
--- a/CHANGES
+++ b/CHANGES
@@ -5,6 +5,7 @@ SVN
   i2c-dev.h: Make value arrays const for block write functions
   i2cset: Add support for SMBus and I2C block writes
           Remove obsolete means to specify value mask
+          More stringent parameter validation
 
 3.0.3 (2010-12-12)
   Makefile: Let the environment set CC and CFLAGS
diff --git a/tools/i2cset.c b/tools/i2cset.c
index 7750c03..a45a829 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -240,6 +240,9 @@ int main(int argc, char *argv[])
 				block[len] = value;
 			}
 			goto dofile;
+		} else if (argc != flags + 6) {
+			fprintf(stderr, "Error: Too many arguments!\n");
+			help();
 		}
 	}
 
-- 
1.7.0.4
