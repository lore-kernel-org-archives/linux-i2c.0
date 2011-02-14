From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 6/6] i2cset: Check range for data value mask
Date: Mon, 14 Feb 2011 10:06:13 -0800
Message-ID: <1297706773-26389-7-git-send-email-guenter.roeck@ericsson.com>
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
 tools/i2cset.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/i2cset.c b/tools/i2cset.c
index ed6ada2..b512081 100644
--- a/tools/i2cset.c
+++ b/tools/i2cset.c
@@ -300,6 +300,11 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Error: Data value mask invalid!\n");
 			help();
 		}
+		if (((size == I2C_SMBUS_BYTE || size == I2C_SMBUS_BYTE_DATA)
+		     && vmask > 0xff) || vmask > 0xffff) {
+			fprintf(stderr, "Error: Data value mask out of range!\n");
+			help();
+		}
 	}
 
 	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
-- 
1.7.0.4
