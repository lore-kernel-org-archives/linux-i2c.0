From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH RESEND 1/2] dt-bindings: eeprom: rename to at24.txt
Date: Thu,  7 Dec 2017 11:38:28 +0100
Message-ID: <20171207103829.3342-2-wsa@the-dreams.de>
References: <20171207103829.3342-1-wsa@the-dreams.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171207103829.3342-1-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This binding documentation is for the at24 driver, so the filename
should reflect it. This avoids confusion because we also have an
"eeprom" driver in Linux but it doesn't support DT even.

Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} (100%)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
similarity index 100%
rename from Documentation/devicetree/bindings/eeprom/eeprom.txt
rename to Documentation/devicetree/bindings/eeprom/at24.txt
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
