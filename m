From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH] i2c: i2c-tiny-usb: fix buffer not being DMA capable
Date: Thu,  4 May 2017 14:56:32 +0200
Message-ID: <20170504125632.7034-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36859 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbdEDM51 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 4 May 2017 08:57:27 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Till Harbaum <till@harbaum.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, "# Kernel 4 . 9+" <stable@vger.kernel.org>

The i2c-tiny-usb driver generates the following trace and fails to
read or write data on a v4.9 or newer kernels. This patch avoids the
problem by allocating a DMA capable buffer for data transfer.

[   17.504959] ------------[ cut here ]------------
[   17.505488] WARNING: CPU: 0 PID: 93 at drivers/usb/core/hcd.c:1587 usb_hcd_map_urb_for_dma+0x37c/0x570
[   17.506545] transfer buffer not dma capable
[   17.507022] Modules linked in:
[   17.507370] CPU: 0 PID: 93 Comm: i2cdetect Not tainted 4.11.0-rc8+ #10
[   17.508103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   17.509039] Call Trace:
[   17.509320]  ? dump_stack+0x5c/0x78
[   17.509714]  ? __warn+0xbe/0xe0
[   17.510073]  ? warn_slowpath_fmt+0x5a/0x80
[   17.510532]  ? nommu_map_sg+0xb0/0xb0
[   17.510949]  ? usb_hcd_map_urb_for_dma+0x37c/0x570
[   17.511482]  ? usb_hcd_submit_urb+0x336/0xab0
[   17.511976]  ? wait_for_completion_timeout+0x12f/0x1a0
[   17.512549]  ? wait_for_completion_timeout+0x65/0x1a0
[   17.513125]  ? usb_start_wait_urb+0x65/0x160
[   17.513604]  ? usb_control_msg+0xdc/0x130
[   17.514061]  ? usb_xfer+0xa4/0x2a0
[   17.514445]  ? __i2c_transfer+0x108/0x3c0
[   17.514899]  ? i2c_transfer+0x57/0xb0
[   17.515310]  ? i2c_smbus_xfer_emulated+0x12f/0x590
[   17.515851]  ? _raw_spin_unlock_irqrestore+0x11/0x20
[   17.516408]  ? i2c_smbus_xfer+0x125/0x330
[   17.516876]  ? i2c_smbus_xfer+0x125/0x330
[   17.517329]  ? i2cdev_ioctl_smbus+0x1c1/0x2b0
[   17.517824]  ? i2cdev_ioctl+0x75/0x1c0
[   17.518248]  ? do_vfs_ioctl+0x9f/0x600
[   17.518671]  ? vfs_write+0x144/0x190
[   17.519078]  ? SyS_ioctl+0x74/0x80
[   17.519463]  ? entry_SYSCALL_64_fastpath+0x1e/0xad
[   17.519959] ---[ end trace d047c04982f5ac50 ]---

Cc: <stable@vger.kernel.org> # Kernel 4.9+
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 0ed77eeff31e..ca30a1a93d29 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -178,22 +178,33 @@ static int usb_read(struct i2c_adapter *adapter, int cmd,
 		    int value, int index, void *data, int len)
 {
 	struct i2c_tiny_usb *dev = (struct i2c_tiny_usb *)adapter->algo_data;
+	void *dmadata = kmalloc(len, GFP_KERNEL);
+	int ret;
 
 	/* do control transfer */
-	return usb_control_msg(dev->usb_dev, usb_rcvctrlpipe(dev->usb_dev, 0),
+	ret = usb_control_msg(dev->usb_dev, usb_rcvctrlpipe(dev->usb_dev, 0),
 			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE |
-			       USB_DIR_IN, value, index, data, len, 2000);
+			       USB_DIR_IN, value, index, dmadata, len, 2000);
+
+	memcpy(data, dmadata, len);
+	kfree(dmadata);
+	return ret;
 }
 
 static int usb_write(struct i2c_adapter *adapter, int cmd,
 		     int value, int index, void *data, int len)
 {
 	struct i2c_tiny_usb *dev = (struct i2c_tiny_usb *)adapter->algo_data;
+	void *dmadata = kmemdup(data, len, GFP_KERNEL);
+	int ret;
 
 	/* do control transfer */
-	return usb_control_msg(dev->usb_dev, usb_sndctrlpipe(dev->usb_dev, 0),
+	ret = usb_control_msg(dev->usb_dev, usb_sndctrlpipe(dev->usb_dev, 0),
 			       cmd, USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
-			       value, index, data, len, 2000);
+			       value, index, dmadata, len, 2000);
+
+	kfree(dmadata);
+	return ret;
 }
 
 static void i2c_tiny_usb_free(struct i2c_tiny_usb *dev)
-- 
2.11.0
