From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 05/16] device property: helper macros for property entry creation
Date: Mon, 30 Nov 2015 17:11:33 +0200
Message-ID: <1448896304-87928-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47792 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723AbbK3PMF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 10:12:05 -0500
In-Reply-To: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Marcos for easier creation of build-in property entries.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 69a8a08..e4f29d8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -175,6 +175,61 @@ struct property_entry {
 	};
 };
 
+#define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
+{								\
+	.name = _name_,						\
+	.length = ARRAY_SIZE(_val_) * sizeof(_type_),		\
+	.is_array = true,					\
+	.pointer._type_##_data = _val_,				\
+}
+
+#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u8, _val_)
+#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u16, _val_)
+#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u32, _val_)
+#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, _val_)
+
+#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
+{								\
+	.name = _name_,						\
+	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
+	.is_array = true,					\
+	.is_string = true,					\
+	.pointer.str = _val_,					\
+}
+
+#define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
+{							\
+	.name = _name_,					\
+	.length = sizeof(_type_),			\
+	.value._type_##_data = _val_,			\
+}
+
+#define PROPERTY_ENTRY_U8(_name_, _val_)		\
+	PROPERTY_ENTRY_INTEGER(_name_, u8, _val_)
+#define PROPERTY_ENTRY_U16(_name_, _val_)		\
+	PROPERTY_ENTRY_INTEGER(_name_, u16, _val_)
+#define PROPERTY_ENTRY_U32(_name_, _val_)		\
+	PROPERTY_ENTRY_INTEGER(_name_, u32, _val_)
+#define PROPERTY_ENTRY_U64(_name_, _val_)		\
+	PROPERTY_ENTRY_INTEGER(_name_, u64, _val_)
+
+#define PROPERTY_ENTRY_STRING(_name_, _val_)		\
+{							\
+	.name = _name_,					\
+	.length = sizeof(_val_),			\
+	.is_string = true,				\
+	.value.str = _val_,				\
+}
+
+#define PROPERTY_ENTRY_BOOL(_name_)		\
+{						\
+	.name = _name_,				\
+}
+
 /**
  * struct property_set - Collection of "built-in" device properties.
  * @fwnode: Handle to be pointed to by the fwnode field of struct device.
-- 
2.6.2
