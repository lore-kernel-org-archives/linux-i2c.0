From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-algo-bit: Add pre- and post-xfer hooks
Date: Sat, 13 Mar 2010 17:47:57 +0100
Message-ID: <20100313174757.4a9f40d7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Drivers might have to do random things before and/or after I2C
transfers. Add hooks to the i2c-algo-bit implementation to let them do
so.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
---
Alex, compared to the first version I sent, I have removed the second
parameter of the hooks. You did not use it, I'm not really sure why
anybody would, and if one really needs the private data, it can be
reached from the i2c_adapter struct itself. So I'd rather start simple,
and add parameters only if a clear need appears over time. You'll have
to update your patch to the radeon driver accordingly.

Michael, I seem to recall you wanted something like that a couple years
ago?

 drivers/i2c/algos/i2c-algo-bit.c |    9 +++++++++
 include/linux/i2c-algo-bit.h     |    2 ++
 2 files changed, 11 insertions(+)

--- linux-2.6.34-rc1.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-03-13 16:26:30.000000000 +0100
+++ linux-2.6.34-rc1/drivers/i2c/algos/i2c-algo-bit.c	2010-03-13 16:41:05.000000000 +0100
@@ -522,6 +522,12 @@ static int bit_xfer(struct i2c_adapter *
 	int i, ret;
 	unsigned short nak_ok;
 
+	if (adap->pre_xfer) {
+		ret = adap->pre_xfer(i2c_adap);
+		if (ret < 0)
+			return ret;
+	}
+
 	bit_dbg(3, &i2c_adap->dev, "emitting start condition\n");
 	i2c_start(adap);
 	for (i = 0; i < num; i++) {
@@ -570,6 +576,9 @@ static int bit_xfer(struct i2c_adapter *
 bailout:
 	bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n");
 	i2c_stop(adap);
+
+	if (adap->post_xfer)
+		adap->post_xfer(i2c_adap);
 	return ret;
 }
 
--- linux-2.6.34-rc1.orig/include/linux/i2c-algo-bit.h	2010-03-13 16:26:30.000000000 +0100
+++ linux-2.6.34-rc1/include/linux/i2c-algo-bit.h	2010-03-13 17:23:03.000000000 +0100
@@ -36,6 +36,8 @@ struct i2c_algo_bit_data {
 	void (*setscl) (void *data, int state);
 	int  (*getsda) (void *data);
 	int  (*getscl) (void *data);
+	int  (*pre_xfer)  (struct i2c_adapter *);
+	void (*post_xfer) (struct i2c_adapter *);
 
 	/* local settings */
 	int udelay;		/* half clock cycle time in us,


-- 
Jean Delvare
