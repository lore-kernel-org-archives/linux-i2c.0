From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 3/3] i2c: octeon: thunderx: TWSI software reset in recovery
Date: Mon, 14 Nov 2016 19:50:45 +0100
Message-ID: <1479149445-4663-4-git-send-email-jglauber@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35119 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933275AbcKNSv3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 13:51:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so17948644wme.2
        for <linux-i2c@vger.kernel.org>; Mon, 14 Nov 2016 10:51:28 -0800 (PST)
In-Reply-To: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

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
index 54a9c14..c3b63c1 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -760,6 +760,9 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
 	octeon_i2c_hlc_disable(i2c);
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+	/* wait for software reset to settle */
+	udelay(5);
 
 	/*
 	 * Bring control register to a good state regardless
-- 
1.9.1
