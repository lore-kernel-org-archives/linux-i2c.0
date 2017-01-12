From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] i2c: mux: mlxcpld: remove unused including <linux/version.h>
Date: Thu, 12 Jan 2017 14:29:04 +0000
Message-ID: <20170112142904.17582-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35387 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdALOaK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Jan 2017 09:30:10 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so3806125pfa.2
        for <linux-i2c@vger.kernel.org>; Thu, 12 Jan 2017 06:29:18 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-i2c@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Remove including <linux/version.h> that don't need it.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index b7ca249..e53f2ab 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -40,7 +40,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/i2c/mlxcpld.h>
 
 #define CPLD_MUX_MAX_NCHANS	8
