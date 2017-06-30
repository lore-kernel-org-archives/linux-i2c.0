From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/6] i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
Date: Fri, 30 Jun 2017 12:54:05 +1200
Message-ID: <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-sh-owner@vger.kernel.org
To: wsa@the-dreams.de, andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org
Cc: ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Rather than returning -ENODEV if i2c_pca_add_numbered_bus() fails,
propagate the error to aid debugging.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index daccef6865e8..853a2abedb05 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -232,9 +232,9 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
-		return -ENODEV;
-	}
+	ret = i2c_pca_add_numbered_bus(&i2c->adap);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, i2c);
 
-- 
2.13.0

