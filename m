From: Ruqiang Ju <juruqiang@huawei.com>
Subject: [PATCH] i2c: hix5hd2: allow build with ARCH_HISI
Date: Mon, 24 Oct 2016 16:39:49 +0800
Message-ID: <1477298389-13462-1-git-send-email-juruqiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:17820 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbcJXJhB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Oct 2016 05:37:01 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, xuejiancheng@hisilicon.com, yanhaifeng@hisilicon.com, juruqiang@huawei.com

This driver should be buildable with ARCH_HISI,
because some of other HiSilicon SoCs also use it.

Signed-off-by: Ruqiang Ju <juruqiang@huawei.com>
---
 drivers/i2c/busses/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6d94e2e..41abb20 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -79,12 +79,12 @@ config I2C_AMD8111
 
 config I2C_HIX5HD2
 	tristate "Hix5hd2 high-speed I2C driver"
-	depends on ARCH_HIX5HD2 || COMPILE_TEST
+	depends on ARCH_HISI || ARCH_HIX5HD2 || COMPILE_TEST
 	help
-	  Say Y here to include support for high-speed I2C controller in the
-	  Hisilicon based hix5hd2 SoCs.
+	  Say Y here to include support for the high-speed I2C controller
+	  used in HiSilicon hix5hd2 SoCs.
 
-	  This driver can also be built as a module.  If so, the module
+	  This driver can also be built as a module. If so, the module
 	  will be called i2c-hix5hd2.
 
 config I2C_I801
-- 
1.9.1
