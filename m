From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: mux: demux-pinctrl: use struct_size() in devm_kzalloc()
Date: Fri, 4 Jan 2019 11:43:27 -0600
Message-ID: <20190104174327.GA30932@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-i2c@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 035032e20327..012b45e447c3 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -219,8 +219,8 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv)
-			   + num_chan * sizeof(struct i2c_demux_pinctrl_chan), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, chan, num_chan),
+			    GFP_KERNEL);
 
 	props = devm_kcalloc(&pdev->dev, num_chan, sizeof(*props), GFP_KERNEL);
 
-- 
2.20.1
