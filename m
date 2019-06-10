From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max8952: simplify getting the adapter of a client" to the regulator tree
Date: Mon, 10 Jun 2019 18:34:46 +0100 (BST)
Message-ID: <20190610173446.B100A440046@finisterre.sirena.org.uk>
References: <20190608105619.593-26-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-26-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-i2c@vger.kernel.org

The patch

   regulator: max8952: simplify getting the adapter of a client

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6b96092a6bfa65566dda2f5a68a559a743b8d132 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sat, 8 Jun 2019 12:56:04 +0200
Subject: [PATCH] regulator: max8952: simplify getting the adapter of a client

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8952.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index cf2a2912cb1b..451237efb359 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -192,7 +192,7 @@ static struct max8952_platform_data *max8952_parse_dt(struct device *dev)
 static int max8952_pmic_probe(struct i2c_client *client,
 		const struct i2c_device_id *i2c_id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct max8952_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct regulator_config config = { };
 	struct max8952_data *max8952;
-- 
2.20.1
