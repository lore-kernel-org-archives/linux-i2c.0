From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Error ' I2C transfer at 0x48 failed' on 2.6.33
Date: Sat, 27 Feb 2010 10:04:20 +0100
Message-ID: <20100227100420.1016e0c1@hyperion.delvare>
References: <20100227004953.13369fcd@power-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100227004953.13369fcd@power-debian>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Gusev <ronne-cmBhpYW9OiY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andrey,

On Sat, 27 Feb 2010 00:49:53 +0300, Andrey Gusev wrote:
> Hello all!
> 
> Thera are errors in dmeg on 2.6.33:
> 
> [    6.259606] PowerMac i2c bus pmu 2 registered
> [    6.262123] PowerMac i2c bus pmu 1 registered
> [    6.264616] PowerMac i2c bus mac-io 0 registered
> [    6.267041] i2c i2c-6: I2C transfer at 0x48 failed, size 0, err -6                            
> [    6.269629] i2c i2c-6: I2C transfer at 0x49 failed, size 0, err -6                            
> [    6.272097] i2c i2c-6: I2C transfer at 0x4a failed, size 0, err -6
> [    6.274583] i2c i2c-6: I2C transfer at 0x4b failed, size 0, err -6                            
> [    6.277010] i2c i2c-6: I2C transfer at 0x4c failed, size 0, err -6                            
> [    6.279436] i2c i2c-6: I2C transfer at 0x4d failed, size 0, err -6                            
> [    6.281837] i2c i2c-6: I2C transfer at 0x4e failed, size 0, err -6                            
> [    6.284006] i2c i2c-6: I2C transfer at 0x4f failed, size 0, err -6                            
> [    6.286140] i2c i2c-6: I2C transfer at 0x2c failed, size 0, err -6
> [    6.288253] i2c i2c-6: I2C transfer at 0x2d failed, size 0, err -6
> [    6.290353] i2c i2c-6: I2C transfer at 0x2e failed, size 0, err -6                            
> [    6.292661] i2c i2c-6: I2C transfer at 0x2f failed, size 0, err -6
> [    6.294971] PowerMac i2c bus uni-n 1 registered
> [    6.297484] i2c i2c-7: I2C transfer at 0x48 failed, size 0, err -6
> [    6.300765] DS1775 digital thermometer [@49]
> [    6.302772] Temp: 27.0 C  Hyst: 75.0 C  OS: 80.0 C
> [    6.305581] ADM1030 fan controller [@2c]                                                      
> [    6.307896] PowerMac i2c bus uni-n 0 registered
> 
> Same log on 2.6.32.8:
> 
> [    6.252901] PowerMac i2c bus pmu 2 registered
> [    6.255852] PowerMac i2c bus pmu 1 registered
> [    6.258573] PowerMac i2c bus mac-io 0 registered
> [    6.262216] PowerMac i2c bus uni-n 1 registered
> [    6.266255] DS1775 digital thermometer [@49]
> [    6.268665] Temp: 26.5 C  Hyst: 75.0 C  OS: 80.0 C
> [    6.271728] ADM1030 fan controller [@2c]
> [    6.274272] PowerMac i2c bus uni-n 0 registered

I have good news for you: the error messages are harmless and can be
safely ignored. I presume you did not notice any functional problem. I
made the i2c-powermac driver more verbose for debugging purposes and it
appears I've made it a little too verbose in the non-debugging case.
Sorry about that.

The patch below should fix it, if you have the chance to give it a try:

* * * * *

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-powermac: Be less verbose in the absence of real errors.

Be less verbose in the absence of real errors. We don't have to report
failed probes to the users, it's only confusing them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---
 drivers/i2c/busses/i2c-powermac.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- linux-2.6.33.orig/drivers/i2c/busses/i2c-powermac.c	2010-02-25 09:12:22.000000000 +0100
+++ linux-2.6.33/drivers/i2c/busses/i2c-powermac.c	2010-02-27 09:57:51.000000000 +0100
@@ -122,9 +122,14 @@ static s32 i2c_powermac_smbus_xfer(	stru
 
 	rc = pmac_i2c_xfer(bus, addrdir, subsize, subaddr, buf, len);
 	if (rc) {
-		dev_err(&adap->dev,
-			"I2C transfer at 0x%02x failed, size %d, err %d\n",
-			addrdir >> 1, size, rc);
+		if (err == -ENXIO)
+			dev_dbg(&adap->dev,
+				"I2C transfer at 0x%02x failed, size %d, "
+				"err %d\n", addrdir >> 1, size, rc);
+		else
+			dev_err(&adap->dev,
+				"I2C transfer at 0x%02x failed, size %d, "
+				"err %d\n", addrdir >> 1, size, rc);
 		goto bail;
 	}
 
@@ -175,10 +180,16 @@ static int i2c_powermac_master_xfer(	str
 		goto bail;
 	}
 	rc = pmac_i2c_xfer(bus, addrdir, 0, 0, msgs->buf, msgs->len);
-	if (rc < 0)
-		dev_err(&adap->dev, "I2C %s 0x%02x failed, err %d\n",
-			addrdir & 1 ? "read from" : "write to", addrdir >> 1,
-			rc);
+	if (rc < 0) {
+		if (rc == -ENXIO)
+			dev_dbg(&adap->dev, "I2C %s 0x%02x failed, err %d\n",
+				addrdir & 1 ? "read from" : "write to",
+				addrdir >> 1, rc);
+		else
+			dev_err(&adap->dev, "I2C %s 0x%02x failed, err %d\n",
+				addrdir & 1 ? "read from" : "write to",
+				addrdir >> 1, rc);
+	}
  bail:
 	pmac_i2c_close(bus);
 	return rc < 0 ? rc : 1;


-- 
Jean Delvare
