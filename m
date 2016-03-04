From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: Re: [PATCH v4 16/18] i2c: allow adapter drivers to override the adapter
 locking
Date: Fri, 04 Mar 2016 10:33:14 +0100
Message-ID: <56D9565A.4020201@lysator.liu.se>
References: <1457044050-15230-1-git-send-email-peda@lysator.liu.se> <1457044050-15230-17-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457044050-15230-17-git-send-email-peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viorel Suman <viorel.suman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Terry Heo <terryheo-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tommi Rantala <tt.rantala-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

Here's a fixup for a problem found by the test robot. Sorry for the
inconvenience.

Cheers,
Peter

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 6be266c3d39b..5ecc6fc52ce0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -961,6 +961,8 @@ static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 /**
  * i2c_adapter_lock_bus - Get exclusive access to an I2C bus segment
  * @adapter: Target I2C bus segment
+ * @flags: I2C_LOCK_ADAPTER locks the root i2c adapter, I2C_LOCK_SEGMENT
+ *	locks only this branch in the adapter tree
  */
 static void i2c_adapter_lock_bus(struct i2c_adapter *adapter, int flags)
 {
@@ -970,6 +972,8 @@ static void i2c_adapter_lock_bus(struct i2c_adapter *adapter, int flags)
 /**
  * i2c_adapter_trylock_bus - Try to get exclusive access to an I2C bus segment
  * @adapter: Target I2C bus segment
+ * @flags: I2C_LOCK_ADAPTER trylocks the root i2c adapter, I2C_LOCK_SEGMENT
+ * 	trylocks only this branch in the adapter tree
  */
 static int i2c_adapter_trylock_bus(struct i2c_adapter *adapter, int flags)
 {
@@ -979,6 +983,8 @@ static int i2c_adapter_trylock_bus(struct i2c_adapter *adapter, int flags)
 /**
  * i2c_adapter_unlock_bus - Release exclusive access to an I2C bus segment
  * @adapter: Target I2C bus segment
+ * @flags: I2C_LOCK_ADAPTER unlocks the root i2c adapter, I2C_LOCK_SEGMENT
+ * 	unlocks only this branch in the adapter tree
  */
 static void i2c_adapter_unlock_bus(struct i2c_adapter *adapter, int flags)
 {
-- 
2.1.4
