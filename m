From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/4] dt-bindings: at24: add compatible for nxp,se97b
Date: Tue, 16 Jan 2018 17:06:16 +0100
Message-ID: <20180116160618.27859-3-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180116160618.27859-1-peda@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

The datasheet talks about the chip being an spd, but the chip is writable
so atmel,24c02 is more appropriate as fallback.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index abfae1beca2b..edf9247613f6 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -46,6 +46,7 @@ Required properties:
                 Some vendors use different model names for chips which are just
                 variants of the above. Known such exceptions are listed below:
 
+                "nxp,se97b" - the fallback is "atmel,24c02",
                 "renesas,r1ex24002" - the fallback is "atmel,24c02"
 
   - reg: The I2C address of the EEPROM.
-- 
2.11.0
