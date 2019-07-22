From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 03/14] mfd: ab3100-core: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:10 +0200
Message-ID: <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/ab3100-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index e350ab64238e..7e007df857b8 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -896,10 +896,10 @@ static int ab3100_probe(struct i2c_client *client,
 		 &ab3100->chip_name[0]);
 
 	/* Attach a second dummy i2c_client to the test register address */
-	ab3100->testreg_client = i2c_new_dummy(client->adapter,
+	ab3100->testreg_client = i2c_new_dummy_device(client->adapter,
 					       client->addr + 1);
-	if (!ab3100->testreg_client) {
-		err = -ENOMEM;
+	if (IS_ERR(ab3100->testreg_client)) {
+		err = PTR_ERR(ab3100->testreg_client);
 		goto exit_no_testreg_client;
 	}
 
-- 
2.20.1
