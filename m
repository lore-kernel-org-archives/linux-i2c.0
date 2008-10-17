From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Fri, 17 Oct 2008 13:43:53 +0200
Message-ID: <20081017134353.013ce033@hyperion.delvare>
References: <20080821.024322.35962617.davem@davemloft.net>
	<20081015141914.7d6c3dd5@hyperion.delvare>
	<20081015.143212.196108134.davem@davemloft.net>
	<20081016145741.1d94f482@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081016145741.1d94f482-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 16 Oct 2008 14:57:41 +0200, Jean Delvare wrote:
> On Wed, 15 Oct 2008 14:32:12 -0700 (PDT), David Miller wrote:
> > I think it's more elegant to remove as many conditionals from
> > generic code as possible.
> 
> I see many good reasons to prefer having conditionals in a central
> place over empty callback functions in virtually every i2c bus driver.
> 
> First reason: I don't expect many drivers to make use of the pre/post
> transaction hooks. Given that a test is cheaper than a function call,
> overall performance with conditionals should be better. I suspect this
> will also make the builds faster and the binary code smaller (although
> I'm not going to benchmark it.)
> 
> Second reason: with empty callback functions, it's not immediately
> obvious which i2c bus drivers use these hooks and which do not. This
> case is specific enough that I think there is value in being able to
> trace it.
> 
> Third reason: changing things in a central place is easier. You may
> not think it's important because there is a rather small number of
> PCF8454-based bus drivers are the moment, but if we do the same for
> i2c-algo-bit, it has no less than 27 users and I don't feel like
> changing them all. If the prototype of the hooks ever changes, having
> to go through several dozen drivers to update otherwise useless
> callback functions sounds plain wrong. Same if we implement the hooks in
> i2c-algo-pcf and i2c-algo-bit today and later decide to move them to
> i2c-core: having 2 i2c algo drivers to update is fairly easy, having 30
> i2c bus drivers to update is much more work.
> 
> I'm not sure what are your reasons for preferring empty callback
> functions? I can't remember seeing this approach used in any part of
> the kernel I touched. And for what it's worth, i2c-core is full of
> tests for callback functions, and I can't remember anyone objecting.

I've applied the modified patch below:

From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: i2c-algo-pcf: Add adapter hooks around xfer begin and end

Some I2C bus implementations need to synchronize with external
entities, such as system firmware, which might also be programming the
same I2C bus.

In order to facilitate this add ->xfer_begin() and ->xfer_end() hooks
which are invoked around pcf_xfer().

[JD: Make these hooks optional.]

Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pcf.c |   17 +++++++++++++----
 include/linux/i2c-algo-pcf.h     |    3 +++
 2 files changed, 16 insertions(+), 4 deletions(-)

--- linux-2.6.28-rc0.orig/drivers/i2c/algos/i2c-algo-pcf.c	2008-10-17 13:21:29.000000000 +0200
+++ linux-2.6.28-rc0/drivers/i2c/algos/i2c-algo-pcf.c	2008-10-17 13:22:59.000000000 +0200
@@ -331,13 +331,16 @@ static int pcf_xfer(struct i2c_adapter *
 	int i;
 	int ret=0, timeout, status;
     
+	if (adap->xfer_begin)
+		adap->xfer_begin(adap->data);
 
 	/* Check for bus busy */
 	timeout = wait_for_bb(adap);
 	if (timeout) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
 		            "Timeout waiting for BB in pcf_xfer\n");)
-		return -EIO;
+		i = -EIO;
+		goto out;
 	}
 	
 	for (i = 0;ret >= 0 && i < num; i++) {
@@ -359,12 +362,14 @@ static int pcf_xfer(struct i2c_adapter *
 		if (timeout) {
 			if (timeout == -EINTR) {
 				/* arbitration lost */
-				return (-EINTR);
+				i = -EINTR;
+				goto out;
 			}
 			i2c_stop(adap);
 			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
 				    "for PIN(1) in pcf_xfer\n");)
-			return (-EREMOTEIO);
+			i = -EREMOTEIO;
+			goto out;
 		}
     
 #ifndef STUB_I2C
@@ -372,7 +377,8 @@ static int pcf_xfer(struct i2c_adapter *
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
 			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
-			return (-EREMOTEIO);
+			i = -EREMOTEIO;
+			goto out;
 		}
 #endif
     
@@ -404,6 +410,9 @@ static int pcf_xfer(struct i2c_adapter *
 		}
 	}
 
+out:
+	if (adap->xfer_end)
+		adap->xfer_end(adap->data);
 	return (i);
 }
 
--- linux-2.6.28-rc0.orig/include/linux/i2c-algo-pcf.h	2008-10-17 13:21:29.000000000 +0200
+++ linux-2.6.28-rc0/include/linux/i2c-algo-pcf.h	2008-10-17 13:22:05.000000000 +0200
@@ -33,6 +33,9 @@ struct i2c_algo_pcf_data {
 	int  (*getclock) (void *data);
 	void (*waitforpin) (void *data);
 
+	void (*xfer_begin) (void *data);
+	void (*xfer_end) (void *data);
+
 	/* Multi-master lost arbitration back-off delay (msecs)
 	 * This should be set by the bus adapter or knowledgable client
 	 * if bus is multi-mastered, else zero

This will go to Linus as part of my second i2c pull request (which is
still blocked by a missing pci_ids patch at the moment.)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
