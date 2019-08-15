From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] i2c: iproc: Make bcm_iproc_i2c_quirks constant
Date: Thu, 15 Aug 2019 11:25:50 +0530
Message-ID: <20190815055550.1588-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Static structure bcm_iproc_i2c_quirks, of type i2c_adapter_quirks, is
only used when being assigned to constant field quirks of a variable
having type i2c_adapter. Hence make bcm_iproc_i2c_quirks constant as
well to prevent it from unintended modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index d7fd76baec92..e9f0e5b6eadc 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -805,7 +805,7 @@ static struct i2c_algorithm bcm_iproc_algo = {
 	.unreg_slave = bcm_iproc_i2c_unreg_slave,
 };
 
-static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
+static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
 	.max_read_len = M_RX_MAX_READ_LEN,
 };
 
-- 
2.19.1
