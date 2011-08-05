From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH] of: add a dummy implementation of of_get_property()
 in of.h
Date: Fri, 05 Aug 2011 16:56:14 +0800
Message-ID: <1312534574.18064.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Sam Ravnborg sam"@ravnborg.org
List-Id: linux-i2c@vger.kernel.org

Then we can avoid having #ifdef CONFIG_OF splattered around the place
calling of_get_property(), it leads to errors.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
This patch fixes below build error with "make tegra_defconfig;make".

  CC      drivers/i2c/busses/i2c-tegra.o
drivers/i2c/busses/i2c-tegra.c: In function 'tegra_i2c_probe':
drivers/i2c/busses/i2c-tegra.c:615: error: implicit declaration of function 'of_get_property'
drivers/i2c/busses/i2c-tegra.c:616: warning: assignment makes pointer from integer without a cast
make[3]: *** [drivers/i2c/busses/i2c-tegra.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Regards,
Axel
 include/linux/of.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 0085bb0..320cbad 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -256,6 +256,12 @@ static inline int of_property_read_string(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline const void *of_get_property(const struct device_node *np,
+					  const char *name, int *lenp)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 
 static inline int of_property_read_u32(const struct device_node *np,
-- 
1.7.4.1
