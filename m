From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 14/16] i2c: tegra: remove unnecessary OOM messages
Date: Wed, 07 May 2014 13:30:28 +0900
Message-ID: <019201cf69ad$133b8440$39b28cc0$%han@samsung.com>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <018301cf69aa$cb7987d0$626c9770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Stephen Warren' <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-tegra.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 00f04cb..f1bb2fc 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -732,10 +732,8 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	}
 
 	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
-	if (!i2c_dev) {
-		dev_err(&pdev->dev, "Could not allocate struct tegra_i2c_dev");
+	if (!i2c_dev)
 		return -ENOMEM;
-	}
 
 	i2c_dev->base = base;
 	i2c_dev->div_clk = div_clk;
-- 
1.7.10.4
