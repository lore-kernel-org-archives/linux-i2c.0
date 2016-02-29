From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 2/2] i2c: Add resource managed version of i2c_{new_dummy, unregister_device}
Date: Mon, 29 Feb 2016 19:07:03 +0530
Message-ID: <1456753023-20559-2-git-send-email-ldewangan@nvidia.com>
References: <1456753023-20559-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456753023-20559-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, corbet@lwn.net
Cc: bjorn.andersson@sonymobile.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-i2c@vger.kernel.org

i2c_new_dummy() and i2c_unregister_device() gained their devm_ wrappers.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
- New in series.

 Documentation/driver-model/devres.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 831a536..e5279fa 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -253,6 +253,10 @@ GPIO
   devm_gpiod_get_optional()
   devm_gpiod_put()
 
+I2C
+  devm_i2c_new_dummy()
+  devm_i2c_unregister_device()
+
 IIO
   devm_iio_device_alloc()
   devm_iio_device_free()
-- 
2.1.4
