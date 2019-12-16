From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/5] media: pci: cx88: convert to i2c_new_scanned_device
Date: Mon, 16 Dec 2019 13:29:42 +0100
Message-ID: <20191216122946.3495-3-wsa+renesas@sang-engineering.com>
References: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Here, this only means to update a comment in the driver.

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/media/pci/cx88/cx88-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx88-input.c
index 589f52d961eb..c7c2acd55266 100644
--- a/drivers/media/pci/cx88/cx88-input.c
+++ b/drivers/media/pci/cx88/cx88-input.c
@@ -613,7 +613,7 @@ void cx88_i2c_init_ir(struct cx88_core *core)
 	}
 
 	/*
-	 * We can't call i2c_new_probed_device() because it uses
+	 * We can't call i2c_new_scanned_device() because it uses
 	 * quick writes for probing and at least some RC receiver
 	 * devices only reply to reads.
 	 * Also, Hauppauge XVR needs to be specified, as address 0x71
-- 
2.20.1
