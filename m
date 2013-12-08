From: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-mux: Inherit retry count from parent controller for muxed bus.
Date: Sun,  8 Dec 2013 11:48:20 +0100
Message-ID: <1386499701-5522-2-git-send-email-eliedebrauwer@gmail.com>
References: <1386499701-5522-1-git-send-email-eliedebrauwer@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386499701-5522-1-git-send-email-eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Today if a mux i2c bus gets created the default retry count of the
muxed bus is zero. Hence it it possible that you end up with a
situation where the parent controller sets a default retry count
which gets applied and used while the muxed bus (using the same
controller) has a default retry count of zero. This can be solved
by initializing the retry count of the muxed bus by the retry count
of the parent at creation time.

Signed-off-by: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-mux.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 797e311..1f879d8 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -139,6 +139,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
+	priv->adap.retries = parent->retries;
 
 	/* Sanity check on class */
 	if (i2c_mux_parent_classes(parent) & class)
-- 
1.7.10.4
