From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/5] i2c: octeon,thunderx: Fix set SCL recovery function
Date: Wed, 21 Sep 2016 08:51:02 +0200
Message-ID: <cea4dddccc4f24d90c3783159c5236d6124facf0.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36226 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbcIUGvl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Sep 2016 02:51:41 -0400
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>, Jan Glauber <jglauber@cavium.com>

From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>

The set SCL recovery function unconditionally pulls the SCL line low.
Only pull SCL line low according to val parameter.

Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
[Changed commit message]
---
 drivers/i2c/busses/i2c-octeon-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index f45ea5e..f322242 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -767,7 +767,7 @@ static void octeon_i2c_set_scl(struct i2c_adapter *adap, int val)
 {
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
-	octeon_i2c_write_int(i2c, TWSI_INT_SCL_OVR);
+	octeon_i2c_write_int(i2c, val ? 0 : TWSI_INT_SCL_OVR);
 }
 
 static int octeon_i2c_get_sda(struct i2c_adapter *adap)
-- 
1.9.1
