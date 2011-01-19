From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/2] MAINTAINERS: Add maintainer for Diolan U2C-12 I2C adapter driver
Date: Wed, 19 Jan 2011 13:26:38 -0800
Message-ID: <1295472398-705-3-git-send-email-guenter.roeck@ericsson.com>
References: <1295472398-705-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295472398-705-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1af022e..12b0be3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2089,6 +2089,12 @@ F:	Documentation/serial/digiepca.txt
 F:	drivers/char/epca*
 F:	drivers/char/digi*
 
+DIOLAN U2C-12 I2C DRIVER
+M:	Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-diolan-u2c.c
+
 DIRECTORY NOTIFICATION (DNOTIFY)
 M:	Eric Paris <eparis-FjpueFixGhCM4zKIHC2jIg@public.gmane.org>
 S:	Maintained
-- 
1.7.3.1
