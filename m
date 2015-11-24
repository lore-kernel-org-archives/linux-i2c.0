From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 05/13] device property: helper macros for property entry creation
Date: Tue, 24 Nov 2015 12:22:51 +0200
Message-ID: <1448360579-79260-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Marcos for easier creation of build-in property entries.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 5d0b9b6..2528a000 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -173,6 +173,54 @@ struct property_entry {
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
+	.value.str = _val_,				\
+}
+
 /**
  * struct property_set - Collection of "built-in" device properties.
  * @fwnode: Handle to be pointed to by the fwnode field of struct device.
-- 
2.6.2
