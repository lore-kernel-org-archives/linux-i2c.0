From: Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH v2 0/2] Fix I2C repeated start timing violation on Armada-38x.
Date: Fri, 29 Sep 2017 10:36:03 +1300
Message-ID: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>, Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

All the Armada 38x(380, 385, 388) have a silicon issue in
the I2C controller which violates the I2C repeated start timing
(errata FE-8471889).

Activate the compatible string "marvell,mv78230-a0-i2c" in the
device tree file of Armada-38x to fx this errata (FE-8471889).

Updated the Documentation for the compatible string
"marvell,mv78230-a0-i2c".

Thank You Gregory Clement for suggesting to reuse the
"marvell,mv78230-a0-i2c" compatible string on Armada-38x SoCs.

Changes since v1:
* "dt-bindings: i2c: Update documentation for "mv78230-a0-i2c""
   Modified commit message.
   Added details describing the compatible string "mv78230-a0-i2c"

-------
Kalyan Kinthada (2):
  ARM: dts: Fix I2C repeated start issue on Armada-38x
  dt-bindings: i2c: Update documentation for "mv78230-a0-i2c"

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 10 ++++++----
 arch/arm/boot/dts/armada-38x.dtsi                     |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
