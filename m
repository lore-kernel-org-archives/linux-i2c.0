From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: (unknown)
Date: Tue, 15 Mar 2011 17:08:37 -0400
Message-ID: <1300223318-31450-1-git-send-email-bengardiner@nanometrics.ca>
References: <AANLkTi=opkM3WW2v3xV=ox9HwD__WjqQuh3sM6Vh7fLj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Subject: 
In-Reply-To: <AANLkTi=opkM3WW2v3xV=ox9HwD__WjqQuh3sM6Vh7fLj-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I tried the following patch based on the description of the steps you took to 
recover the bus. Is there anything you can add? I still get lots of 
'controller timed out' errors.

Best Regards,

Ben Gardiner

Nanometrics Inc.
http://www.nanometrics.ca

---

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5795c83..52e5e60 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -89,6 +89,7 @@
 #define DAVINCI_I2C_MDR_XA	BIT(8)
 #define DAVINCI_I2C_MDR_RM	BIT(7)
 #define DAVINCI_I2C_MDR_IRS	BIT(5)
+#define DAVINCI_I2C_MDR_FDF	BIT(3)
 
 #define DAVINCI_I2C_IMR_AAS	BIT(6)
 #define DAVINCI_I2C_IMR_SCD	BIT(5)
@@ -149,6 +150,36 @@ static void generic_i2c_clock_pulse(unsigned int scl_pin)
 	}
 }
 
+static void alternate_i2c_clock_pulse(struct davinci_i2c_dev *dev)
+{
+	u32 flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
+	/* free data format mode */
+	flag |= DAVINCI_I2C_MDR_FDF;
+	/* receive byte */
+	flag &= ~DAVINCI_I2C_MDR_TRX;
+	/* repeat */
+	flag |= DAVINCI_I2C_MDR_RM;
+
+	/*
+	 * Write mode register first as needed for correct behaviour
+	 * on OMAP-L138, but don't set STT yet to avoid a race with XRDY
+	 * occuring before we have loaded DXR
+	 */
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+
+	/* Disable receive and transmit interrupts */
+	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
+	flag &= ~DAVINCI_I2C_IMR_RRDY;
+	flag &= ~DAVINCI_I2C_IMR_XRDY;
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, flag);
+
+	/* Set STT to begin transmit now DXR is loaded */
+	flag |= DAVINCI_I2C_MDR_STT;
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+
+	udelay(40*9);
+}
+
 /* This routine does i2c bus recovery as specified in the
  * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
  */
@@ -163,8 +194,10 @@ static void i2c_recover_bus(struct davinci_i2c_dev *dev)
 	flag |=  DAVINCI_I2C_MDR_NACK;
 	/* write the data into mode register */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	if (pdata)
+	if (pdata->scl_pin)
 		generic_i2c_clock_pulse(pdata->scl_pin);
+	else
+		alternate_i2c_clock_pulse(dev);
 	/* Send STOP */
 	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
 	flag |= DAVINCI_I2C_MDR_STP;
