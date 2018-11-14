From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/13] i2c: omap: Enable for ARCH_K3
Date: Wed, 14 Nov 2018 17:25:52 -0500
Message-ID: <20181114222558.100213-11-sashal@kernel.org>
References: <20181114222558.100213-1-sashal@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181114222558.100213-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vignesh R <vigneshr@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]

Allow I2C_OMAP to be built for K3 platforms.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d252276feadf..94669d96bd19 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -706,7 +706,7 @@ config I2C_OCORES
 
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || ARCH_K3
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.17.1
