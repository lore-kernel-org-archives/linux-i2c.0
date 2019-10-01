From: Patrick Williams <alpawi@amazon.com>
Subject: [PATCH 1/2] i2c: slave-eeprom: initialize empty eeprom properly
Date: Tue, 1 Oct 2019 11:40:05 -0500
Message-ID: <20191001164009.21610-1-alpawi@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>, Patrick Williams <alpawi@amazon.com>, Patrick Williams <patrick@stwcx.xyz>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The i2c-slave-eeprom driver emulates at24 class eeprom devices,
which come initialized with all 1s.  Do the same in the software
emulation.

Signed-off-by: Patrick Williams <alpawi@amazon.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index db9763cb4dae..efee56106251 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -131,6 +131,8 @@ static int i2c_slave_eeprom_probe(struct i2c_client *client, const struct i2c_de
 	if (!eeprom)
 		return -ENOMEM;
 
+	memset(eeprom->buffer, 0xFF, size);
+
 	eeprom->idx_write_cnt = 0;
 	eeprom->num_address_bytes = flag_addr16 ? 2 : 1;
 	eeprom->address_mask = size - 1;
-- 
2.17.2 (Apple Git-113)
