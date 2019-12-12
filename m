From: =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=
        <zhouyanjie@wanyeetech.com>
Subject: [PATCH 1/2] dt-bindings: I2C: Add X1000 bindings.
Date: Thu, 12 Dec 2019 23:50:49 +0800
Message-ID: <1576165850-20727-3-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, paul@crapouillou.net, paul.burton@mips.com, paulburton@kernel.org, sernia.zhou@foxmail.com, zhenwenjin@gmail.com
List-Id: linux-i2c@vger.kernel.org

Add the I2C bindings for the X1000 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
index 3738cfb..d229eff 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
@@ -1,7 +1,9 @@
 * Ingenic JZ4780 I2C Bus controller
 
 Required properties:
-- compatible: should be "ingenic,jz4780-i2c"
+- compatible: should be one of the following:
+  - "ingenic,jz4780-i2c" for the JZ4780
+  - "ingenic,x1000-i2c" for the X1000
 - reg: Should contain the address & size of the I2C controller registers.
 - interrupts: Should specify the interrupt provided by parent.
 - clocks: Should contain a single clock specifier for the JZ4780 I2C clock.
-- 
2.7.4
