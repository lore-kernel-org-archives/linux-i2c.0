From: <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Subject: [PATCH 3/6] dt-bindings: i2c: dw: Add Baikal-T1 SoC I2C controller
Date: Fri, 6 Mar 2020 16:19:52 +0300
Message-ID: <20200306132018.C268A8030792@mail.baikalelectronics.ru>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200306131955.12806-1-Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>

Just add the "be,bt1-i2c" compatible string to the bindings. The rest of
the DW APB I2C properties can be freely used to describe the Baikal-T1
I2C controller dts-node.

Signed-off-by: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Signed-off-by: Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>
Cc: Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 3f348f1ce172..eab2c9293665 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -34,6 +34,8 @@ properties:
         items:
           - const: mscc,ocelot-i2c
           - const: snps,designware-i2c
+      - description: Baikal-T1 SoCs I2C controller.
+        const: be,bt1-i2c
 
   reg:
     items:
-- 
2.25.1
