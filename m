From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch v0 2/3] i2c-smbus: Allow building with I2C_HELPER_AUTO support
Date: Wed, 26 Mar 2014 17:42:11 -0700
Message-ID: <1395880932-19124-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395880932-19124-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Currentlty the config is conditional on !I2C_HELPER_AUTO.
I don't know their dependency, but without this we can't build.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 7b7ea32..212ed73 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -74,7 +74,7 @@ config I2C_HELPER_AUTO
 	  In doubt, say Y.
 
 config I2C_SMBUS
-	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
+	tristate "SMBus-specific protocols"
 	help
 	  Say Y here if you want support for SMBus extensions to the I2C
 	  specification. At the moment, the only supported extension is
-- 
1.8.3.2
