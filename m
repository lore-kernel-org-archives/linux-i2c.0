From: Scott James Remnant <scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH 22/31] i2c: Auto-load i2c_dev module when device opened.
Date: Mon, 2 Mar 2009 18:41:51 +0000
Message-ID: <c9e8ec654db2ee34fc9fda29222aee9dd085ddaa.1236702228.git.scott@canonical.com>
References: <cover.1236702228.git.scott@canonical.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1236702228.git.scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The i2c_dev module is missing the char-major-89-* alias that would cause
it to be auto-loaded when a device of that type is opened.  This patch
adds the alias.

Signed-off-by: Scott James Remnant <scott-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Tim Gardner <tim.gardner-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 drivers/i2c/i2c-dev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 7e13d2d..f3f83ba 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -618,6 +618,7 @@ MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
 		"Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(I2C_MAJOR);
 
 module_init(i2c_dev_init);
 module_exit(i2c_dev_exit);
-- 
1.6.0.5
