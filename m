From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/4] i2c: octeon: thunderx: TWSI software reset in recovery
Date: Fri,  9 Dec 2016 10:31:55 +0100
Message-ID: <20161209093158.3161-2-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35820 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbcLIJc2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Dec 2016 04:32:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so2757119wme.2
        for <linux-i2c@vger.kernel.org>; Fri, 09 Dec 2016 01:32:28 -0800 (PST)
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

I've seen i2c recovery reporting long loops of:

[ 1035.887818] i2c i2c-4: SCL is stuck low, exit recovery
[ 1037.999748] i2c i2c-4: SCL is stuck low, exit recovery
[ 1040.111694] i2c i2c-4: SCL is stuck low, exit recovery
...

Add a TWSI software reset which clears the status and
STA,STP,IFLG in SW_TWSI_EOP_TWSI_CTL.

With this the recovery works fine and above message is not seen.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 5e63b17..2b8a7bf 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -789,6 +789,9 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
 	octeon_i2c_hlc_disable(i2c);
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+	/* wait for software reset to settle */
+	udelay(5);
 
 	/*
 	 * Bring control register to a good state regardless
-- 
2.9.0.rc0.21.g7777322
