From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/9] eeprom: at24: platform_data: use BIT() macro
Date: Tue, 27 Oct 2015 12:43:45 +0100
Message-ID: <1445946233-6071-2-git-send-email-bgolaszewski@baylibre.com>
References: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33396 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbJ0LoL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Oct 2015 07:44:11 -0400
Received: by wijp11 with SMTP id p11so209412873wij.0
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2015 04:44:10 -0700 (PDT)
In-Reply-To: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use BIT() macro to replace the 0xXX constants in platform_data flags
definitions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index c42aa89..8d90f52 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -43,10 +43,10 @@ struct at24_platform_data {
 	u32		byte_len;		/* size (sum of all addr) */
 	u16		page_size;		/* for writes */
 	u8		flags;
-#define AT24_FLAG_ADDR16	0x80	/* address pointer is 16 bit */
-#define AT24_FLAG_READONLY	0x40	/* sysfs-entry will be read-only */
-#define AT24_FLAG_IRUGO		0x20	/* sysfs-entry will be world-readable */
-#define AT24_FLAG_TAKE8ADDR	0x10	/* take always 8 addresses (24c00) */
+#define AT24_FLAG_ADDR16	BIT(7)	/* address pointer is 16 bit */
+#define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
+#define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
+#define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
 
 	void		(*setup)(struct memory_accessor *, void *context);
 	void		*context;
-- 
2.1.4
