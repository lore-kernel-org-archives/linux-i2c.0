From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: [PATCH 1/6]: i2c-pcf: Pass adapter data into ->waitforpin()
	method.
Date: Thu, 21 Aug 2008 02:43:19 -0700 (PDT)
Message-ID: <20080821.024319.22788780.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


i2c-pcf: Pass adapter data into ->waitforpin() method.

Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 1e328d1..a8a5b6d 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -135,7 +135,7 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
 	*status = get_pcf(adap, 1);
 #ifndef STUB_I2C
 	while (timeout-- && (*status & I2C_PCF_PIN)) {
-		adap->waitforpin();
+		adap->waitforpin(adap->data);
 		*status = get_pcf(adap, 1);
 	}
 	if (*status & I2C_PCF_LAB) {
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 7f38c01..05f7d09 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -104,7 +104,7 @@ static int pcf_isa_getclock(void *data)
 	return (clock);
 }
 
-static void pcf_isa_waitforpin(void) {
+static void pcf_isa_waitforpin(void *data) {
 	DEFINE_WAIT(wait);
 	int timeout = 2;
 	unsigned long flags;
diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
index 0177d28..5de8a31 100644
--- a/include/linux/i2c-algo-pcf.h
+++ b/include/linux/i2c-algo-pcf.h
@@ -31,7 +31,7 @@ struct i2c_algo_pcf_data {
 	int  (*getpcf) (void *data, int ctl);
 	int  (*getown) (void *data);
 	int  (*getclock) (void *data);
-	void (*waitforpin) (void);
+	void (*waitforpin) (void *data);
 
 	/* Multi-master lost arbitration back-off delay (msecs)
 	 * This should be set by the bus adapter or knowledgable client
-- 
1.5.6.5.GIT


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
