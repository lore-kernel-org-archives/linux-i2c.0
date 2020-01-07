From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 10/12] i2c: i2c-core-of: convert to use i2c_new_client_device()
Date: Tue,  7 Jan 2020 18:47:44 +0100
Message-ID: <20200107174748.9616-11-wsa+renesas@sang-engineering.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/i2c/i2c-core-of.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index e4d296b40baa..6787c1f71483 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -75,11 +75,10 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	if (ret)
 		return ERR_PTR(ret);
 
-	client = i2c_new_device(adap, &info);
-	if (!client) {
+	client = i2c_new_client_device(adap, &info);
+	if (IS_ERR(client))
 		dev_err(&adap->dev, "of_i2c: Failure registering %pOF\n", node);
-		return ERR_PTR(-EINVAL);
-	}
+
 	return client;
 }
 
-- 
2.20.1
