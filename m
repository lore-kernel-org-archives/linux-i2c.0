From: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Subject: [PATCH 05/16] i2c-designware: i2c_dw_xfer_msg: Take "struct dw_i2c_dev"
 pointer
Date: Tue, 13 Oct 2009 11:50:04 +0900
Message-ID: <4AD3EADC.5070203@necel.com>
References: <4AD3E974.8080200@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4AD3E974.8080200@necel.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: baruch@tkos.co.il, linux-i2c@vger.kernel.org
Cc: ben-linux@fluff.org, linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

There's no need to interface using with "struct i2c_adapter" pointer.
Let's use a local "struct dw_i2c_dev" pointer, instead.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index c6a35bf..205f691 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -254,9 +254,8 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
  * that is longer than the size of the TX FIFO.
  */
 static void
-i2c_dw_xfer_msg(struct i2c_adapter *adap)
+i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 {
-	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct i2c_msg *msgs = dev->msgs;
 	int num = dev->msgs_num;
 	u32 ic_con, intr_mask;
@@ -394,7 +393,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		goto done;
 
 	/* start the transfers */
-	i2c_dw_xfer_msg(adap);
+	i2c_dw_xfer_msg(dev);
 
 	/* wait for tx to complete */
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
@@ -450,7 +449,7 @@ static void dw_i2c_pump_msg(unsigned long data)
 	u32 intr_mask;
 
 	i2c_dw_read(dev);
-	i2c_dw_xfer_msg(&dev->adapter);
+	i2c_dw_xfer_msg(dev);
 
 	intr_mask = DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
 	if (dev->status & STATUS_WRITE_IN_PROGRESS)
-- 
1.6.5
