From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] ALSA: ppc: keywest: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:12 +0100
Message-ID: <20200326211013.13531-2-wsa+renesas@sang-engineering.com>
References: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211013.13531-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/ppc/keywest.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 093806d735c6..9554a0c506af 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -40,6 +40,7 @@ static int keywest_probe(struct i2c_client *client,
 static int keywest_attach_adapter(struct i2c_adapter *adapter)
 {
 	struct i2c_board_info info;
+	struct i2c_client *client;
 
 	if (! keywest_ctx)
 		return -EINVAL;
@@ -50,9 +51,11 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
 	memset(&info, 0, sizeof(struct i2c_board_info));
 	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
 	info.addr = keywest_ctx->addr;
-	keywest_ctx->client = i2c_new_device(adapter, &info);
-	if (!keywest_ctx->client)
-		return -ENODEV;
+	client = i2c_new_client_device(adapter, &info);
+	if (IS_ERR(client))
+		return PTR_ERR(client);
+	keywest_ctx->client = client;
+
 	/*
 	 * We know the driver is already loaded, so the device should be
 	 * already bound. If not it means binding failed, and then there
-- 
2.20.1
