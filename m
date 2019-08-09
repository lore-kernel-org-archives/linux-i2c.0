From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/7] ARM: iop32x: make mach/uncompress.h independent of mach/hardware.h
Date: Fri,  9 Aug 2019 18:33:20 +0200
Message-ID: <20190809163334.489360-6-arnd@arndb.de>
References: <20190809162956.488941-1-arnd@arndb.de>
 <20190809163334.489360-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809163334.489360-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: soc@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

All supported uarts use the same address: IQ80321_UART and IQ31244_UART
are both defined to the default value of 0xfe800000. By using that as
the address unconditionally, all dependencies on other machine headers
can be avoided.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-iop32x/include/mach/uncompress.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index ed4ac3e28fa1..c8548875d942 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -6,9 +6,8 @@
 #include <asm/types.h>
 #include <asm/mach-types.h>
 #include <linux/serial_reg.h>
-#include <mach/hardware.h>
 
-volatile u8 *uart_base;
+#define uart_base ((volatile u8 *)0xfe800000)
 
 #define TX_DONE		(UART_LSR_TEMT | UART_LSR_THRE)
 
@@ -23,17 +22,4 @@ static inline void flush(void)
 {
 }
 
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
-{
-	if (machine_is_iq80321())
-		uart_base = (volatile u8 *)IQ80321_UART;
-	else if (machine_is_iq31244() || machine_is_em7210())
-		uart_base = (volatile u8 *)IQ31244_UART;
-	else
-		uart_base = (volatile u8 *)0xfe800000;
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
+#define arch_decomp_setup() do { } while (0)
-- 
2.20.0
