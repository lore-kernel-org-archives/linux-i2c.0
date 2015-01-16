From: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] of: Add vendor prefix 'netlogic'
Date: Fri, 16 Jan 2015 12:53:39 +0530
Message-ID: <1421393020-18807-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add vendor name "netlogic" in vendor-prefixes.txt, which will be used for
the Netlogic XLP and XLPII MIPS SoCs. These processors were from NetLogic
Microsystems which is now part of Broadcom Corporation.

Signed-off-by: Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b1df0ad..ad45908 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -111,6 +111,7 @@ mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
 neonode		Neonode Inc.
 netgear	NETGEAR
+netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
 newhaven	Newhaven Display International
 nintendo	Nintendo
 nokia	Nokia
-- 
1.9.1
