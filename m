From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 2/2] i2c: Add devm_i2c_new_dummy() in managed list
Date: Fri, 17 Jun 2016 19:12:22 +0530
Message-ID: <1466170942-21214-2-git-send-email-ldewangan@nvidia.com>
References: <1466170942-21214-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466170942-21214-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, wsa@the-dreams.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-i2c@vger.kernel.org

i2c_new_dummy() gained their devm_ wrappers. Add the
devm_i2c_new_dummy() in managed APIs list.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes form V2:
- Drop the devm_i2c_unregister_device()

 Documentation/driver-model/devres.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index f5e5223..472e446 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -259,6 +259,9 @@ GPIO
   devm_gpio_request_one()
   devm_gpio_free()
 
+I2C
+  devm_i2c_new_dummy()
+
 IIO
   devm_iio_device_alloc()
   devm_iio_device_free()
-- 
2.1.4
