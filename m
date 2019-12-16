From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/5] media: pci: cx18: convert to i2c_new_scanned_device
Date: Mon, 16 Dec 2019 13:29:44 +0100
Message-ID: <20191216122946.3495-5-wsa+renesas@sang-engineering.com>
References: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Sean Young <sean@mess.org>, Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/cx18/cx18-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-i2c.c b/drivers/media/pci/cx18/cx18-i2c.c
index 1ef7ccf4a722..a83435245251 100644
--- a/drivers/media/pci/cx18/cx18-i2c.c
+++ b/drivers/media/pci/cx18/cx18-i2c.c
@@ -88,7 +88,7 @@ static int cx18_i2c_new_ir(struct cx18 *cx, struct i2c_adapter *adap, u32 hw,
 		break;
 	}
 
-	return i2c_new_probed_device(adap, &info, addr_list, NULL) == NULL ?
+	return IS_ERR(i2c_new_scanned_device(adap, &info, addr_list, NULL)) ?
 	       -1 : 0;
 }
 
-- 
2.20.1
