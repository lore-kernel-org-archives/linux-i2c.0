From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/5] media: pci: cx23885: convert to i2c_new_scanned_device
Date: Mon, 16 Dec 2019 13:29:41 +0100
Message-ID: <20191216122946.3495-2-wsa+renesas@sang-engineering.com>
References: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/cx23885/cx23885-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-i2c.c b/drivers/media/pci/cx23885/cx23885-i2c.c
index 4f327ee9659e..f51fad33dc04 100644
--- a/drivers/media/pci/cx23885/cx23885-i2c.c
+++ b/drivers/media/pci/cx23885/cx23885-i2c.c
@@ -337,8 +337,8 @@ int cx23885_i2c_register(struct cx23885_i2c *bus)
 		strscpy(info.type, "ir_video", I2C_NAME_SIZE);
 		/* Use quick read command for probe, some IR chips don't
 		 * support writes */
-		i2c_new_probed_device(&bus->i2c_adap, &info, addr_list,
-				      i2c_probe_func_quick_read);
+		i2c_new_scanned_device(&bus->i2c_adap, &info, addr_list,
+				       i2c_probe_func_quick_read);
 	}
 
 	return bus->i2c_rc;
-- 
2.20.1
