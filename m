From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/28] Remove OF_I2C
Date: Sun,  9 Feb 2014 19:47:40 +0100
Message-ID: <1391971686-9517-3-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>
List-Id: linux-i2c@vger.kernel.org

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f5ed031..de17c55 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -387,7 +387,7 @@ config I2C_CBUS_GPIO
 
 config I2C_CPM
 	tristate "Freescale CPM1 or CPM2 (MPC8xx/826x)"
-	depends on (CPM1 || CPM2) && OF_I2C
+	depends on CPM1 || CPM2
 	help
 	  This supports the use of the I2C interface on Freescale
 	  processors with CPM1 or CPM2.
-- 
1.8.4.2
