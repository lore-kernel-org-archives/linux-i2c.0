From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] i2c: Drop I2C_CLASS_ALL
Date: Fri, 31 Oct 2008 17:09:26 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA02F99426@chinexm1.ad.analog.com>
References: <20081030153120.1c1f3476@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20081030153120.1c1f3476-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Acked-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> 

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
Sent: Thursday, October 30, 2008 10:31 PM
To: Linux I2C
Cc: Sonic Zhang
Subject: [PATCH] i2c: Drop I2C_CLASS_ALL

I2C_CLASS_ALL is almost never what bus driver authors really want.
These i2c classes are really only about which devices must be probed,
not what devices can be present. As device drivers get converted to the
new i2c device driver model, only a few device types will keep relying
on probing.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
 drivers/i2c/busses/i2c-sh7760.c   |    2 +-
 include/linux/i2c.h               |    1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.28-rc2.orig/drivers/i2c/busses/i2c-bfin-twi.c
2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc2/drivers/i2c/busses/i2c-bfin-twi.c	2008-10-30
15:11:39.000000000 +0100
@@ -656,7 +656,7 @@ static int i2c_bfin_twi_probe(struct pla
 	strlcpy(p_adap->name, pdev->name, sizeof(p_adap->name));
 	p_adap->algo = &bfin_twi_algorithm;
 	p_adap->algo_data = iface;
-	p_adap->class = I2C_CLASS_ALL;
+	p_adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	p_adap->dev.parent = &pdev->dev;
 
 	rc = peripheral_request_list(pin_req[pdev->id], "i2c-bfin-twi");
--- linux-2.6.28-rc2.orig/drivers/i2c/busses/i2c-sh7760.c
2008-10-10 09:21:53.000000000 +0200
+++ linux-2.6.28-rc2/drivers/i2c/busses/i2c-sh7760.c	2008-10-30
15:11:26.000000000 +0100
@@ -475,7 +475,7 @@ static int __devinit sh7760_i2c_probe(st
 
 	id->adap.nr = pdev->id;
 	id->adap.algo = &sh7760_i2c_algo;
-	id->adap.class = I2C_CLASS_ALL;
+	id->adap.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	id->adap.retries = 3;
 	id->adap.algo_data = id;
 	id->adap.dev.parent = &pdev->dev;
--- linux-2.6.28-rc2.orig/include/linux/i2c.h	2008-10-24
09:28:36.000000000 +0200
+++ linux-2.6.28-rc2/include/linux/i2c.h	2008-10-30
15:11:14.000000000 +0100
@@ -397,7 +397,6 @@ static inline void i2c_set_adapdata(stru
 #define I2C_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
 #define I2C_CLASS_SOUND		(1<<6)	/* sound devices */
 #define I2C_CLASS_SPD		(1<<7)	/* SPD EEPROMs and similar */
-#define I2C_CLASS_ALL		(UINT_MAX) /* all of the above */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the


--
Jean Delvare
