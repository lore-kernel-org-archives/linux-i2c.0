From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] i2c: sirf: we need to wait I2C_RESET status in resume
Date: Tue, 13 Aug 2013 17:11:28 +0800
Message-ID: <1376385091-30597-3-git-send-email-Baohua.Song@csr.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376385091-30597-1-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>

this fixes the issue that we lost to wait the i2c reset finished.

Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 055210e..45a8881 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -425,6 +425,8 @@ static int i2c_sirfsoc_resume(struct device *dev)
 
 	clk_enable(siic->clk);
 	writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I2C_CTRL);
+	while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
+		cpu_relax();
 	writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_MODE,
 		siic->base + SIRFSOC_I2C_CTRL);
 	writel(siic->clk_div, siic->base + SIRFSOC_I2C_CLK_CTRL);
-- 
1.8.2.3
