From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: [PATCH 1/3] of: define dummy of_get_property if not CONFIG_OF
Date: Mon, 31 Jan 2011 23:25:49 +0800
Message-ID: <1296487551-30938-1-git-send-email-thomas@wytron.com.tw>
References: <AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO@mail.gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This will help to reduce the ifdef CONFIG_OF needed in most
platform data probing.

Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
---
 include/linux/of.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index cad7cf0..5e122cb 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -222,5 +222,13 @@ extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
 #endif
 
+#else /* !CONFIG_OF */
+
+static inline const void *of_get_property(const struct device_node *node,
+				const char *name, int *lenp)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 #endif /* _LINUX_OF_H */
-- 
1.7.3.5
