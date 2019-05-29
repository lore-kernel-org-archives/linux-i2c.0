From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: mux: Use struct_size() in devm_kzalloc()
Date: Wed, 29 May 2019 11:20:14 -0500
Message-ID: <20190529162014.GA27389@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-i2c@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/i2c-mux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 603252fa1284..8d5e4c6fdd8e 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -243,8 +243,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 {
 	struct i2c_mux_core *muxc;
 
-	muxc = devm_kzalloc(dev, sizeof(*muxc)
-			    + max_adapters * sizeof(muxc->adapter[0])
+	muxc = devm_kzalloc(dev, struct_size(muxc, adapter, max_adapters)
 			    + sizeof_priv, GFP_KERNEL);
 	if (!muxc)
 		return NULL;
-- 
2.21.0
