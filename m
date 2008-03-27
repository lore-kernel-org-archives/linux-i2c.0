From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/7] Blackfin I2C/TWI driver: fix bug - missmatch in
	add timer and delete timer
Date: Wed, 26 Mar 2008 17:46:49 -0700
Message-ID: <1206578809-16038-8-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Hans Schillstrom <hans.schillstrom-j/w4dDtn67bQT0dZR+AlfA@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Hans Schillstrom <hans.schillstrom-j/w4dDtn67bQT0dZR+AlfA@public.gmane.org>

Move init_completion to just before i2c transfer.
http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3385

Signed-off-by: Hans Schillstrom <hans.schillstrom-j/w4dDtn67bQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 9a8ab6c..6560df5 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -308,6 +308,7 @@ static int bfin_twi_master_xfer(struct i2c_adapter *adap,
 	iface->writeNum = iface->readNum = pmsg->len;
 	iface->result = 0;
 	iface->timeout_count = 10;
+	init_completion(&(iface->complete));
 	/* Set Transmit device address */
 	write_MASTER_ADDR(iface, pmsg->addr);
 
@@ -447,6 +448,7 @@ int bfin_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 	iface->read_write = read_write;
 	iface->command = command;
 	iface->timeout_count = 10;
+	init_completion(&(iface->complete));
 
 	/* FIFO Initiation. Data in FIFO should be discarded before
 	 * start a new operation.
@@ -608,7 +610,6 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&(iface->lock));
-	init_completion(&(iface->complete));
 
 	/* Find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.5.4.3

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
