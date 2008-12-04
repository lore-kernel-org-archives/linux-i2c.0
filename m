From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
Date: Thu, 04 Dec 2008 16:37:15 +0100
Message-ID: <4937F92B.6050701@scram.de>
References: <200811281724.49620.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811281724.49620.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

> The two messages making up the transaction are parsed. The driver fills a TX 
> buffer descriptor for the first one, and a TX and an RX buffer descriptor for 
> the second one.
> 
>> rbase 0x01e0 tbase 0x01c0 rfcr 0x30 tfcr 0x30 mrblr 0x0201
>> rstate 0x00000000 rptr 0x00000000 rbptr 0x01e0 rcount 0x0000 rtmp 0x00000000
>> tstate 0x00000000 tptr 0x00000000 tbptr 0x01c0 tcount 0x0000 ttmp 0x00000000
>> i2mod 0x00, i2add 0xfe i2brg 0x03 i2com 0x01 i2cer 0x00 i2cmr 0x00
>> rx 0 sc 0x9000 tx 0 sc 0x9400
>> rx 1 sc 0x7da4 tx 1 sc 0xac00
>> rx 2 sc 0xefef tx 2 sc 0x743b
>> rx 3 sc 0xf264 tx 3 sc 0x10e6

Just to rule out some possible issues with the rx queue,
could you check if this patch improves anything?

Thanks,
Jochen

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 228f757..b83b733 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -231,12 +231,6 @@ static void cpm_i2c_parse_message(struct i2c_adapter *adap,

 		dev_dbg(&adap->dev, "cpm_i2c_read(abyte=0x%x)\n", addr);

-		out_be16(&rbdf->cbd_datlen, 0);
-		out_be16(&rbdf->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT);
-
-		if (rx + 1 == CPM_MAXBD)
-			setbits16(&rbdf->cbd_sc, BD_SC_WRAP);
-
 		eieio();
 		setbits16(&tbdf->cbd_sc, BD_SC_READY);
 	} else {
@@ -328,6 +322,16 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			return -EINVAL;
 	}

+	/* Initialize rx queue */
+	for (i = 0; i < CPM_MAXBD; i++) {
+		rbdf = cpm->rbase + i;
+		out_be16(&rbdf->cbd_datlen, 0);
+		out_be16(&rbdf->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT);
+
+		if (i + 1 == CPM_MAXBD)
+			setbits16(&rbdf->cbd_sc, BD_SC_WRAP);
+	}
+
 	/* Reset to use first buffer */
 	out_be16(&i2c_ram->rbptr, in_be16(&i2c_ram->rbase));
 	out_be16(&i2c_ram->tbptr, in_be16(&i2c_ram->tbase));
