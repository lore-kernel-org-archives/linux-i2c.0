From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Fri, 6 Apr 2012 08:37:51 +0200
Message-ID: <20120406083751.46fd23c5@endymion.delvare>
References: <20120315180835.2e669111@endymion.delvare>
	<20120331081927.2438ea9e@endymion.delvare>
	<4F7CD11C.2090801@interlog.com>
	<20120405092422.453edecf@endymion.delvare>
	<4F7E3267.9040306@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F7E3267.9040306-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Apr 2012 20:01:43 -0400, Douglas Gilbert wrote:
> On 12-04-05 03:24 AM, Jean Delvare wrote:
> > As the bus driver side implementation of I2C_M_RECV_LEN is heavily
> > tied to SMBus, we can't support received length over 32 bytes, but
> > let's at least support that.
> >
> > In practice, the caller will have to setup a buffer large enough to
> > cover the case where received length byte has value 32, so minimum
> > 32 + 1 = 33 bytes, possibly more if there is a fixed number of bytes
> > added for the specific slave (for example a checksum.)
> 
> Either I am misunderstanding how to use this new patch or it is
> broken. After replacing the original patch with this one, setting
> msg->buf[0] to 2, my test program only sees the first two bytes
> of expected data:
>    08 81
> That is down from 8 bytes from the previous patch and 10 bytes
> expected from the SM130.

Does your I2C bus driver process I2C_M_RECV_LEN at all? I bet not.
You'll have to fix that. It's fairly easy, see the reference
implementation in i2c-algo-bit.c:readbytes(). The completely untested
attempt below may do, if not you'll have to fix my code:

---
 drivers/i2c/busses/i2c-at91.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- linux-3.4-rc1.orig/drivers/i2c/busses/i2c-at91.c	2012-04-06 08:27:38.000000000 +0200
+++ linux-3.4-rc1/drivers/i2c/busses/i2c-at91.c	2012-04-06 08:36:47.379360574 +0200
@@ -159,13 +159,14 @@ static short at91_poll_status(unsigned l
 	return (loop_cntr > 0);
 }
 
-static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
+static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length,
+		     int recv_len)
 {
 	int nack_seen = 0;
 	int sent_stop = 0;
 
 	/* Send Start */
-	if (1 == length) {
+	if ((1 == length) && !recv_len) {
 	    at91_twi_write(AT91_TWI_CR, AT91_TWI_START | AT91_TWI_STOP);
 	    sent_stop = 1;
 	} else
@@ -174,7 +175,7 @@ static int xfer_read(struct i2c_adapter
 	/* Read data */
 	while (length--) {
 		/* send Stop before reading last byte (if not already done) */
-		if ((0 == length) && (0 == sent_stop))
+		if ((0 == length) && (0 == sent_stop) && !recv_len)
 			at91_twi_write(AT91_TWI_CR, AT91_TWI_STOP);
 		if (!at91_poll_status(AT91_TWI_RXRDY, &nack_seen)) {
 			dev_dbg(&adap->dev, "RXRDY timeout\n");
@@ -184,7 +185,12 @@ static int xfer_read(struct i2c_adapter
 			/* NACK supplies Stop */
 			return -EREMOTEIO;
 		}
-		*buf++ = (at91_twi_read(AT91_TWI_RHR) & 0xff);
+		*buf = (at91_twi_read(AT91_TWI_RHR) & 0xff);
+		if (recv_len) {
+			length += *buf;
+			recv_len = 0;
+		}
+		buf++;
 	}
 
 	return 0;
@@ -257,7 +263,8 @@ static int at91_xfer(struct i2c_adapter
 
 		if (pmsg->len && pmsg->buf) {	/* sanity check */
 			if (pmsg->flags & I2C_M_RD)
-				ret = xfer_read(adap, pmsg->buf, pmsg->len);
+				ret = xfer_read(adap, pmsg->buf, pmsg->len,
+						pmsg->flags & I2C_M_RECV_LEN);
 			else
 				ret = xfer_write(adap, pmsg->buf, pmsg->len);
 

-- 
Jean Delvare
