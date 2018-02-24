From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Subject: [PATCH] i2c: cadence: Fix PM device usage count
Date: Sat, 24 Feb 2018 23:42:38 +0100
Message-ID: <20180224224238.nlr3mrifwngjzkrz@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

pm_runtime_get_sync() increases the device's usage count even when
reporting an error, so add a call to pm_runtime_put_noidle() in the
error branch.

Fixes: 7fa32329ca03 ("i2c: cadence: Move to sensible power management")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This is one of a number of patches for problems found using coccinelle
scripting in the SIL2LinuxMP project. The patch has been compile-tested;
it's based on linux-next-20180223.

For a discussion of the corresponding issue, see
https://marc.info/?l=linux-pm&m=151904483924999&w=2

 drivers/i2c/busses/i2c-cadence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..898faa7fbac5 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -574,8 +574,10 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	bool hold_quirk;
 
 	ret = pm_runtime_get_sync(id->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(id->dev);
 		return ret;
+	}
 	/* Check if the bus is free */
 	if (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) & CDNS_I2C_SR_BA) {
 		ret = -EAGAIN;
-- 
2.11.0
