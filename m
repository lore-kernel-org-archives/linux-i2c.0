From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Error ' I2C transfer at 0x48 failed' on 2.6.33
Date: Mon, 1 Mar 2010 11:50:02 +0100
Message-ID: <20100301115002.1ead2681@hyperion.delvare>
References: <20100227004953.13369fcd@power-debian>
	<20100227100420.1016e0c1@hyperion.delvare>
	<20100228160002.14783f4a@power-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100228160002.14783f4a@power-debian>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Gusev <ronne-cmBhpYW9OiY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 28 Feb 2010 16:00:02 +0300, Andrey Gusev wrote:
> I didn't noted ant functional problem, but this looked like regression
> and I decided to report about it. I'll try patch.

Great. Here comes an updated patch, there was a mistake in the first
one that prevented it from building.

* * * * *

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-powermac: Be less verbose in the absence of real errors.

Be less verbose in the absence of real errors. We don't have to report
failed probes to the users, it's only confusing them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/i2c/busses/i2c-powermac.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/i2c/busses/i2c-powermac.c	2010-03-01 11:29:48.000000000 +0100
+++ linux-2.6.34-rc0/drivers/i2c/busses/i2c-powermac.c	2010-03-01 11:41:50.000000000 +0100
@@ -122,9 +122,14 @@ static s32 i2c_powermac_smbus_xfer(	stru
 
 	rc = pmac_i2c_xfer(bus, addrdir, subsize, subaddr, buf, len);
 	if (rc) {
-		dev_err(&adap->dev,
-			"I2C transfer at 0x%02x failed, size %d, err %d\n",
-			addrdir >> 1, size, rc);
+		if (rc == -ENXIO)
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
