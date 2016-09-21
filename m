From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/5] i2c: octeon,thunderx: Avoid sending STOP during recovery
Date: Wed, 21 Sep 2016 08:51:03 +0200
Message-ID: <9791f6fb5fba70ddf9bd6b92e113e97bc0483317.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34305 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbcIUGvl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Sep 2016 02:51:41 -0400
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>, Jan Glauber <jglauber@cavium.com>

From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>

Due to a bug in the ThunderX I2C hardware sending STOP during
a recovery attempt could lock up the hardware. To work around
this problem do not send STOP at the beginning of the recovery
but use the override registers to bring the TWSI including
the high-level controller out of the bad state.

Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
[Changed commit message]
---
 drivers/i2c/busses/i2c-octeon-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index f322242..7d4df83 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -783,13 +783,14 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 {
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
+	octeon_i2c_hlc_disable(i2c);
+
 	/*
-	 * The stop resets the state machine, does not _transmit_ STOP unless
-	 * engine was active.
+	 * Bring control register to a good state regardless
+	 * of HLC state.
 	 */
-	octeon_i2c_stop(i2c);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
-	octeon_i2c_hlc_disable(i2c);
 	octeon_i2c_write_int(i2c, 0);
 }
 
@@ -797,6 +798,15 @@ static void octeon_i2c_unprepare_recovery(struct i2c_adapter *adap)
 {
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
+	/*
+	 * Generate STOP to finish the unfinished transaction.
+	 * Can't generate STOP via the TWSI CTL register
+	 * since it could bring the TWSI controller into an inoperable state.
+	 */
+	octeon_i2c_write_int(i2c, TWSI_INT_SDA_OVR | TWSI_INT_SCL_OVR);
+	udelay(5);
+	octeon_i2c_write_int(i2c, TWSI_INT_SDA_OVR);
+	udelay(5);
 	octeon_i2c_write_int(i2c, 0);
 }
 
-- 
1.9.1
