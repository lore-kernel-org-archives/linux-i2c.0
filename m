From: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
Subject: [PATCH] i2c writing-clients document: mention module_i2c_driver()
Date: Wed, 18 Jan 2012 14:00:29 +0100
Message-ID: <1326891629-8495-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Peter Meerwald <p.meerwald-12LT5diAjoA8TDmHOjzjNtBPR1lH4CV8@public.gmane.org>

---
 Documentation/i2c/writing-clients |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 5aa5337..71248b2 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -266,6 +266,14 @@ be removed after kernel booting (or module loading) is completed.
 Likewise, functions marked by `__exit' are dropped by the compiler when
 the code is built into the kernel, as they would never be called.
 
+The module_i2c_driver() macro can be used to reduce above code.
+
+MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>"
+MODULE_DESCRIPTION("Driver for Barf Inc. Foo I2C devices");
+MODULE_LICENSE("GPL");
+
+module_i2c_driver(foo_driver);
+
 
 Power Management
 ================
-- 
1.7.4.1
