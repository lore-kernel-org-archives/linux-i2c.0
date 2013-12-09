From: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c-mux: Inherit retry count and timeout from parent for muxed bus.
Date: Mon,  9 Dec 2013 19:48:28 +0100
Message-ID: <1386614908-4872-1-git-send-email-eliedebrauwer@gmail.com>
References: <1386499701-5522-2-git-send-email-eliedebrauwer@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386499701-5522-2-git-send-email-eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If a muxed i2c bus gets created the default retry count and
timeout of the muxed bus is zero. Hence it it possible that you
end up with a situation where the parent controller sets a default
retry count and timeout which gets applied and used while the muxed
bus (using the same controller) has a default retry count of zero
and a default timeout of 1s (set in i2c_add_adapter()). This can be
solved by initializing the retry count and timeout of the muxed
bus with the values used by the the parent at creation time.

Signed-off-by: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-mux.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 797e311..2d0847b 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -139,6 +139,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
+	priv->adap.retries = parent->retries;
+	priv->adap.timeout = parent->timeout;
 
 	/* Sanity check on class */
 	if (i2c_mux_parent_classes(parent) & class)
-- 
1.7.10.4
