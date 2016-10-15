From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/2] i2c: bcm-iproc: constify i2c_adapter_quirks structures
Date: Sat, 15 Oct 2016 19:32:01 +0200
Message-ID: <1476552722-12352-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1476552722-12352-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476552722-12352-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Check for i2c_adapter_quirks structures that are only stored in the
quirks field of an i2c_adapter structure.  This field is declared
const, so i2c_adapter_quirks structures that have this property can be
declared as const also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct i2c_adapter_quirks i@p = { ... };

@ok@
identifier r.i;
struct i2c_adapter e;
position p;
@@
e.quirks = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct i2c_adapter_quirks e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct i2c_adapter_quirks i = { ... };
// </smpl>

The effect on the layout of the .o file is shown by the following
output of the size command, first before then after the
transformation:

   text    data     bss     dec     hex filename
   3458     744       8    4210    1072 drivers/i2c/busses/i2c-bcm-iproc.o
   3490     720       8    4218    107a drivers/i2c/busses/i2c-bcm-iproc.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/i2c/busses/i2c-bcm-iproc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 326b3db..318df55 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -395,7 +395,7 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 	.functionality = bcm_iproc_i2c_functionality,
 };
 
-static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
+static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
 	/* need to reserve one byte in the FIFO for the slave address */
 	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
 };
