From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] mtd: maps: pismo: simplify getting the adapter of a client
Date: Mon, 22 Jul 2019 20:15:49 +0200
Message-ID: <20190722181549.6798-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V1:

* remove 'adapter' variable entirely

 drivers/mtd/maps/pismo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
index 788d4996e2c1..946ba80f9758 100644
--- a/drivers/mtd/maps/pismo.c
+++ b/drivers/mtd/maps/pismo.c
@@ -211,13 +211,12 @@ static int pismo_remove(struct i2c_client *client)
 static int pismo_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct pismo_pdata *pdata = client->dev.platform_data;
 	struct pismo_eeprom eeprom;
 	struct pismo_data *pismo;
 	int ret, i;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(&client->dev, "functionality mismatch\n");
 		return -EIO;
 	}
-- 
2.20.1
