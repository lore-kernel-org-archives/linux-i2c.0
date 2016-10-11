From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 1/5] i2c: i2c-piix4: coding style fix - '*' adjacent to data name
Date: Tue, 11 Oct 2016 18:24:37 +0100
Message-ID: <20161011172441.7422-2-palminha@synopsys.com>
References: <20161011172441.7422-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011172441.7422-1-palminha@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, wsa@the-dreams.de, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/i2c/busses/i2c-piix4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index c2268cd..6b55a8e 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -482,9 +482,9 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 }
 
 /* Return negative errno on error. */
-static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+static s32 piix4_access(struct i2c_adapter *adap, u16 addr,
 		 unsigned short flags, char read_write,
-		 u8 command, int size, union i2c_smbus_data * data)
+		 u8 command, int size, union i2c_smbus_data *data)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 	unsigned short piix4_smba = adapdata->smba;
-- 
2.9.3
