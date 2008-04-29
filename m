From: David Milburn <dmilburn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c-piix4-inc-delay-after-starting-transaction
Date: Tue, 29 Apr 2008 12:00:53 -0500
Message-ID: <20080429170053.GA16863@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Per the PIIX4 errata, there maybe a delay between setting the
start bit in the Smbus Host Controller Register and the transaction
actually starting. If the driver doesn't delay long enough, it
may appear that the transaction is complete when actually it
hasn't started, this may lead to bus collisions.

Signed-off-by: David Milburn <dmilburn-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/libata-core.c      |    0 
 drivers/i2c/busses/i2c-piix4.c |    2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 9bbe96c..84a70ac 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -232,7 +232,7 @@ static int piix4_transaction(void)
 
 	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
 	do {
-		msleep(1);
+		msleep(2);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
