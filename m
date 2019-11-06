From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 09/17] media: pci: smipcie: smipcie-main: convert to use i2c_new_client_device()
Date: Wed,  6 Nov 2019 22:21:09 +0100
Message-ID: <20191106212120.27983-10-wsa+renesas@sang-engineering.com>
References: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106212120.27983-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the newer API returning an ERRPTR and use the new helper to bail
out.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/pci/smipcie/smipcie-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/smipcie/smipcie-main.c b/drivers/media/pci/smipcie/smipcie-main.c
index 1fb78462e081..9ca0fc3e6f80 100644
--- a/drivers/media/pci/smipcie/smipcie-main.c
+++ b/drivers/media/pci/smipcie/smipcie-main.c
@@ -484,8 +484,8 @@ static struct i2c_client *smi_add_i2c_client(struct i2c_adapter *adapter,
 	struct i2c_client *client;
 
 	request_module(info->type);
-	client = i2c_new_device(adapter, info);
-	if (client == NULL || client->dev.driver == NULL)
+	client = i2c_new_client_device(adapter, info);
+	if (!i2c_client_has_driver(client))
 		goto err_add_i2c_client;
 
 	if (!try_module_get(client->dev.driver->owner)) {
-- 
2.20.1
