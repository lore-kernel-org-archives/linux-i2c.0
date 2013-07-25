From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] i2c: davinci: Allow i2c driver available for keystone
 platforms
Date: Wed, 24 Jul 2013 20:28:19 -0400
Message-ID: <1374712099-32095-3-git-send-email-santosh.shilimkar@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Keystone SOCs uses the same I2C IP as available on DaVinci SOCs.
Update the config so that ARCH_KEYSTONE can use it.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index dc6dea6..fcdd321 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -385,7 +385,7 @@ config I2C_CPM
 
 config I2C_DAVINCI
 	tristate "DaVinci I2C driver"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	help
 	  Support for TI DaVinci I2C controller driver.
 
-- 
1.7.9.5
