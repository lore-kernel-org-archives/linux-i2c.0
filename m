From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 02/12] i2c: icy: convert to i2c_new_scanned_device
Date: Wed,  6 Nov 2019 10:50:20 +0100
Message-ID: <20191106095033.25182-3-wsa+renesas@sang-engineering.com>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Max Staudt <max@enpas.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-icy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-icy.c b/drivers/i2c/busses/i2c-icy.c
index 8382eb64b424..07baa4d8de39 100644
--- a/drivers/i2c/busses/i2c-icy.c
+++ b/drivers/i2c/busses/i2c-icy.c
@@ -188,10 +188,10 @@ static int icy_probe(struct zorro_dev *z,
 		ltc2990_info.fwnode = new_fwnode;
 
 		i2c->ltc2990_client =
-			i2c_new_probed_device(&i2c->adapter,
-					      &ltc2990_info,
-					      icy_ltc2990_addresses,
-					      NULL);
+			i2c_new_scanned_device(&i2c->adapter,
+					       &ltc2990_info,
+					       icy_ltc2990_addresses,
+					       NULL);
 	}
 
 	return 0;
-- 
2.20.1
