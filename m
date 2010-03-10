From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Using algo-bit in another i2c algo
Date: Wed, 10 Mar 2010 10:44:01 +0100
Message-ID: <20100310104401.57fc43b2@hyperion.delvare>
References: <a728f9f91001111413t1a733e0rbc0352ddd2d9de7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a728f9f91001111413t1a733e0rbc0352ddd2d9de7c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alex,

Sorry for the late answer.

On Mon, 11 Jan 2010 17:13:50 -0500, Alex Deucher wrote:
> Hi,
> 
>     I'm adding support for the i2c controllers on radeon hardware and
> I have a few questions.  I have a radeon-algo that encapsulates all
> the various hw i2c controller functionality, however, it uses a
> bit-algo bus internally for cases where you have to use bit-banging
> rather than the hardware i2c engines.  Also, for bit banging to work
> properly, you need to do some things before the bit-algo transaction
> (basically masking the gpios for software use).

There used to be a patch floating around that added pre- and post-xfer
hooks to i2c-algo-bit... I couldn't find it again, so I rewrote it:

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-algo-bit: Add pre- and post-xfer hooks

Drivers might have to do random things before and/or after I2C
transfers. Add hooks to the i2c-algo-bit implementation to let them do
so.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    9 +++++++++
 include/linux/i2c-algo-bit.h     |    2 ++
 2 files changed, 11 insertions(+)

--- linux-2.6.34-rc1.orig/drivers/i2c/algos/i2c-algo-bit.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.34-rc1/drivers/i2c/algos/i2c-algo-bit.c	2010-03-09 18:52:50.000000000 +0100
@@ -522,6 +522,12 @@ static int bit_xfer(struct i2c_adapter *
 	int i, ret;
 	unsigned short nak_ok;
 
+	if (adap->pre_xfer) {
+		ret = adap->pre_xfer(i2c_adap, adap->data);
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
+		adap->post_xfer(i2c_adap, adap->data);
 	return ret;
 }
 
--- linux-2.6.34-rc1.orig/include/linux/i2c-algo-bit.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.34-rc1/include/linux/i2c-algo-bit.h	2010-03-09 18:53:06.000000000 +0100
@@ -32,6 +32,8 @@
  */
 struct i2c_algo_bit_data {
 	void *data;		/* private data for lowlevel routines */
+	int  (*pre_xfer)  (struct i2c_adapter *i2c_adap, void *data);
+	void (*post_xfer) (struct i2c_adapter *i2c_adap, void *data);
 	void (*setsda) (void *data, int state);
 	void (*setscl) (void *data, int state);
 	int  (*getsda) (void *data);

Would it help?

> Right now we use
> bit-algo i2c for the ddc buses, but they won't work externally to the
> driver without the proper gpio masking prior to using them.  In the
> radeon-algo patches, I use bit algo internally when I cannot use the
> hardware i2c engines, or in cases where I haven't implemented support
> yet for the hardware engine (as most gpios can be driven by sw or the
> hw engine).  The problem is, this exposes the i2c bit-algo buses as
> well as the radeon-algo buses.

This is bad, as it defeats the slave address uniqueness mechanism. Bad
things could happen. Would the patch above be sufficient to solve your
case?

> Is there a way to not expose the bit-algo buses that are used
> internally?

No, this is not possible at the time being. That being said, it
shouldn't be difficult, if the need exists. Looking at i2c-algo-bit,
the registration part is split into a preparation step and the actual
registration with i2c-core. The preparation step if done by
i2c_bit_prepare_bus(). If we exported this function, then you could
easily call it to create an internal i2c-algo-bit-based adapter, which
you wouldn't have to register if you don't want to:

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-algo-bit: Export i2c_bit_prepare_bus

This lets drivers make use of the i2c-algo-bit implementation without
actually registering the i2c adapter in question. This is useful to
drivers which need more than the i2c-algo-bit driver offers.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    3 ++-
 include/linux/i2c-algo-bit.h     |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.34-rc1.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-03-10 08:09:03.000000000 +0100
+++ linux-2.6.34-rc1/drivers/i2c/algos/i2c-algo-bit.c	2010-03-10 10:23:51.000000000 +0100
@@ -601,7 +601,7 @@ static const struct i2c_algorithm i2c_bi
 /*
  * registering functions to load algorithms at runtime
  */
-static int i2c_bit_prepare_bus(struct i2c_adapter *adap)
+int i2c_bit_prepare_bus(struct i2c_adapter *adap)
 {
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
 
@@ -617,6 +617,7 @@ static int i2c_bit_prepare_bus(struct i2
 
 	return 0;
 }
+EXPORT_SYMBOL(i2c_bit_prepare_bus);
 
 int i2c_bit_add_bus(struct i2c_adapter *adap)
 {
--- linux-2.6.34-rc1.orig/include/linux/i2c-algo-bit.h	2010-03-10 08:09:03.000000000 +0100
+++ linux-2.6.34-rc1/include/linux/i2c-algo-bit.h	2010-03-10 10:24:03.000000000 +0100
@@ -47,6 +47,7 @@ struct i2c_algo_bit_data {
 	int timeout;		/* in jiffies */
 };
 
+int i2c_bit_prepare_bus(struct i2c_adapter *);
 int i2c_bit_add_bus(struct i2c_adapter *);
 int i2c_bit_add_numbered_bus(struct i2c_adapter *);
 

With this possibility, I guess you wouldn't even need the first patch
any longer? If both are needed, that's fine with me, but if only one is
needed, that's even better.

> I've attached the patches for reference.

Please let me know if either or both of my 2 proposals above fit your
needs.

-- 
Jean Delvare
