From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH 3/3] i2c-ocores: add some device tree documentation
Date: Wed, 24 Nov 2010 17:26:22 +0100
Message-ID: <1290615982-1028-4-git-send-email-jonas@southpole.se>
References: <1290615982-1028-1-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1290615982-1028-1-git-send-email-jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This puts some documentation for the device tree configuration at the head
of the driver file.  Hopefully this can get moved to a common area for this
type of documentation at a later date; unfortunately, there isn't really
such a place in the kernel tree at this time.

Furthermore, the regstep and clock-frequency parameters are really bus
parameters and should probably be passed to the driver in a better way.
Consider that a TODO.

Signed-off-by: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index dee0352..ef3bcb1 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -9,6 +9,41 @@
  * kind, whether express or implied.
  */
 
+/*
+ * Device tree configuration:
+ *
+ * Required properties:
+ * - compatible      : "opencores,i2c-ocores"
+ * - reg             : bus address start and address range size of device
+ * - interrupts      : interrupt number
+ * - regstep         : size of device registers in bytes
+ * - clock-frequency : frequency of bus clock in Hz
+ * 
+ * Example:
+ *
+ *  i2c0: ocores@a0000000 {
+ *              compatible = "opencores,i2c-ocores";
+ *              reg = <0xa0000000 0x8>;
+ *              interrupts = <10>;
+ *
+ *              regstep = <1>;
+ *              clock-frequency = <20000000>;
+ *
+ * -- Devices connected on this I2C bus get
+ * -- defined here; address- and size-cells
+ * -- apply to these child devices
+ *
+ *              #address-cells = <1>;
+ *              #size-cells = <0>;
+ *
+ *              dummy@60 {
+ *                     compatible = "dummy";
+ *                     reg = <60>;
+ *              };
+ *  };
+ *
+ */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-- 
1.7.1
