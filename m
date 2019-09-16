From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: [PATCH 2/3] i2c: qup: Remove dev_err() log after platform_get_irq*()
 failure
Date: Tue, 17 Sep 2019 00:28:58 +0530
Message-ID: <20190916185857.GA14093@SD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The debug message after platform_get_irq() failure is redundant
because platform_get_irq() already prints an error. Thus remove it.

The semantic patch that makes this report is available
in scripts/coccinelle/api/platform_get_irq.cocci.

Found using - http://coccinelle.lip6.fr/

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/i2c/busses/i2c-qup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 5519c19bfd9c..23c4893512b2 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1767,7 +1767,6 @@ static int qup_i2c_probe(struct platform_device *pdev)

 	qup->irq = platform_get_irq(pdev, 0);
 	if (qup->irq < 0) {
-		dev_err(qup->dev, "No IRQ defined\n");
 		return qup->irq;
 	}

--
2.20.1
