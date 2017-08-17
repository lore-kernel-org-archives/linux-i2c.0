From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c: taos-evm: constify serio_device_id
Date: Thu, 17 Aug 2017 17:35:52 +0530
Message-ID: <251e9103c373c0b7d9a97917e48f323f2adcf716.1502971448.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

serio_device_id are not supposed to change at runtime. All functions
working with serio_device_id provided by <linux/serio.h> work with
const serio_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-taos-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index 210ca82..addd90a 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -291,7 +291,7 @@ static void taos_disconnect(struct serio *serio)
 	dev_info(&serio->dev, "Disconnected from TAOS EVM\n");
 }
 
-static struct serio_device_id taos_serio_ids[] = {
+static const struct serio_device_id taos_serio_ids[] = {
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_TAOSEVM,
-- 
2.7.4
