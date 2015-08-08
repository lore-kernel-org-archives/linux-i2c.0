From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 2/4] hwmon: max6697: move binding docs to proper place
Date: Sat,  8 Aug 2015 20:30:34 +0200
Message-ID: <1439058636-3082-3-git-send-email-wsa@the-dreams.de>
References: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439058636-3082-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The I2C dir is not for I2C client devices! Move it to the proper folder.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{i2c => hwmon}/max6697.txt (100%)

diff --git a/Documentation/devicetree/bindings/i2c/max6697.txt b/Documentation/devicetree/bindings/hwmon/max6697.txt
similarity index 100%
rename from Documentation/devicetree/bindings/i2c/max6697.txt
rename to Documentation/devicetree/bindings/hwmon/max6697.txt
-- 
2.1.4
