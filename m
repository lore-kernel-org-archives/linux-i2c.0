From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on one bus, and mux bus
 naming
Date: Sun, 17 Nov 2013 10:56:24 -0800
Message-ID: <20131117185624.GA23639@roeck-us.net>
References: <5287B9E4.1020107@roeck-us.net>
 <20131116214116.3d035b76@endymion.delvare>
 <20131116214318.1d101d35@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131116214318.1d101d35-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Nov 16, 2013 at 09:43:18PM +0100, Jean Delvare wrote:
> Oh, I forgot to mention...
> 
> > On Sat, 16 Nov 2013 10:31:00 -0800, Guenter Roeck wrote:
> > > I understand this may require an API change, as the mux chip is not necessarily an i2c
> > > and the i2c-mux core code doesn't really care what the mux chip is.
> 
> Such an API change would be perfectly acceptable. Mux drivers are few
> and i2c-mux is still relatively new. Unique i2c adapter name is
> something important, definitely worth changing the API if needed.
> 
I managed to do it without changing the API; see patch below.
This results in

i2c-0/name:MPC adapter at 0xfff703000
i2c-1/name:MPC adapter at 0xfff703100
i2c-10/name:i2c-2-mux-75 (chan_id 7)
i2c-11/name:i2c-2-mux-76 (chan_id 0)
i2c-12/name:i2c-2-mux-76 (chan_id 1)
i2c-13/name:i2c-2-mux-76 (chan_id 2)
i2c-14/name:i2c-2-mux-76 (chan_id 3)
i2c-15/name:i2c-2-mux-76 (chan_id 4)
i2c-16/name:i2c-2-mux-76 (chan_id 5)
i2c-17/name:i2c-2-mux-76 (chan_id 6)
i2c-18/name:i2c-2-mux-76 (chan_id 7)
i2c-19/name:i2c-0-mux (chan_id 1)
i2c-2/name:i2c-0-mux (chan_id 0)
i2c-20/name:i2c-0-mux (chan_id 2)
i2c-21/name:i2c-0-mux (chan_id 3)
i2c-22/name:i2c-0-mux (chan_id 4)
i2c-23/name:i2c-0-mux (chan_id 5)
i2c-24/name:i2c-0-mux (chan_id 6)
i2c-25/name:i2c-0-mux (chan_id 7)
i2c-3/name:i2c-2-mux-75 (chan_id 0)
i2c-4/name:i2c-2-mux-75 (chan_id 1)
i2c-5/name:i2c-2-mux-75 (chan_id 2)
i2c-6/name:i2c-2-mux-75 (chan_id 3)
i2c-7/name:i2c-2-mux-75 (chan_id 4)
i2c-8/name:i2c-2-mux-75 (chan_id 5)
i2c-9/name:i2c-2-mux-75 (chan_id 6)

This retains the old mux name if the mux is not an i2c device, and adds
the i2c device address if it is. This solves the problem for me.

Comments ?

Thanks,
Guenter

---

>From 592db23cd3a769a5369e15260ffa6924acf91ddb Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Date: Sun, 17 Nov 2013 09:25:21 -0800
Subject: [PATCH] i2c: mux: Create unique i2c mux name if the parent is an i2c
 device

If an i2c mux parent is an i2c device, there can be more than one such device on
a single i2c bus. The current mux naming scheme does not take this into account
and creates multiple i2c adapters with the same name.

Expand the mux adapter name to include the i2c client's I2C address to solve the
problem.

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/i2c/i2c-mux.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 797e311..9a49fe9 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -109,7 +109,9 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				int (*deselect) (struct i2c_adapter *,
 						 void *, u32))
 {
+	struct i2c_client *client = i2c_verify_client(mux_dev);
 	struct i2c_mux_priv *priv;
+	char client_addr[8];
 	int ret;
 
 	priv = kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
@@ -133,8 +135,15 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	priv->algo.functionality = i2c_mux_functionality;
 
 	/* Now fill out new adapter structure */
+	if (client)
+		scnprintf(client_addr, sizeof(client_addr), "-%02x",
+			  client->addr);
+	else
+		client_addr[0] = '\0';
+
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
-		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
+		 "i2c-%d-mux%s (chan_id %d)", i2c_adapter_id(parent),
+		 client_addr, chan_id);
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
-- 
1.7.9.7
