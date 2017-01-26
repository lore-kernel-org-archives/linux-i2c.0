From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 2/2] dt-bindings: move trivial devices out of i2c subdir
Date: Thu, 26 Jan 2017 23:55:44 +0100
Message-ID: <20170126225544.5431-3-wsa@the-dreams.de>
References: <20170126225544.5431-1-wsa@the-dreams.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170126225544.5431-1-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c folder is for i2c bus drivers, not clients. Move the now
deprecated trivial devices file to the bindings base directory, so it
can be refactored from there to proper bindings in the relevant
subdirectories. This will ease maintenance for the I2C subsystem (less
irrelevant patches automatically CCed by get_maintainer.pl) and it will
make aware that we deal with the file differently now.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 .../bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt}         | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt} (100%)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c-trivial-devices.txt
similarity index 100%
rename from Documentation/devicetree/bindings/i2c/trivial-devices.txt
rename to Documentation/devicetree/bindings/i2c-trivial-devices.txt
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
