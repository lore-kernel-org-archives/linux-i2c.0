From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: [PATCH, fix 1/2] Add the platform data include for the Xilinx XPS
 IIC Bus Interface
Date: Sun, 14 Mar 2010 23:05:25 +1100
Message-ID: <20100314230525.352410e5.sfr@canb.auug.org.au>
References: <4B94C951.6050703@pelagicore.com>
	<20100308150121.GW10014@trinity.fluff.org>
	<4B956F9E.8020304@oracle.com>
	<4B960420.8040804@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B960420.8040804-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: =?UTF-8?B?IlJpY2hhcmQgUsO2amZvcnMi?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, xtfeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom:	Richard R=C3=B6jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Date:	Tue, 09 Mar 2010 09:17:36 +0100

This file was missed in the original patch that went into Linus' tree.

Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Richard R=C3=B6jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Signed-off-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
---

Hi Linus,

This missing include file has been killing most (if not all) the
allmodconfig builds since March 9.  Please apply.  I have had the
equivalent of this patch in linux-next since then.

diff --git a/include/linux/i2c-xiic.h b/include/linux/i2c-xiic.h
new file mode 100644
index 0000000..4f9f225
--- /dev/null
+++ b/include/linux/i2c-xiic.h
@@ -0,0 +1,43 @@
+/*
+ * i2c-xiic.h
+ * Copyright (c) 2009 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* Supports:
+ * Xilinx IIC
+ */
+
+#ifndef _LINUX_I2C_XIIC_H
+#define _LINUX_I2C_XIIC_H
+
+/**
+ * struct xiic_i2c_platform_data - Platform data of the Xilinx I2C dri=
ver
+ * @num_devices:	Number of devices that shall be added when the driver
+ *			is probed.
+ * @devices:		The actuall devices to add.
+ *
+ * This purpose of this platform data struct is to be able to provide =
a number
+ * of devices that should be added to the I2C bus. The reason is that =
sometimes
+ * the I2C board info is not enough, a new PCI board can for instance =
be
+ * plugged into a standard PC, and the bus number might be unknown at
+ * early init time.
+ */
+struct xiic_i2c_platform_data {
+	u8				num_devices;
+	struct i2c_board_info const	*devices;
+};
+
+#endif /* _LINUX_I2C_XIIC_H */

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/
