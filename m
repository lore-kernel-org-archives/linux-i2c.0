From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date: Tue, 18 Sep 2018 12:41:26 -0700
Message-ID: <20180918194126.138455-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

We shouldn't attempt to DMA map the message buffers passed into this
driver from the i2c core unless the message we're mapping have been
properly setup for DMA. The i2c core indicates such a situation by
setting the I2C_M_DMA_SAFE flag, so check for that flag before using DMA
mode.

This fixes a problem where the kernel oopses cleaning pages for a buffer
that's mapped into the vmalloc space. The pages are returned from
request_firmware() and passed down directly to the i2c master to write
to the i2c touchscreen device. Mapping vmalloc buffers with
dma_map_single() won't work reliably, causing an oops like below:

 Unable to handle kernel paging request at virtual address ffffffc01391d000
 Mem abort info:
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000146
   CM = 1, WnR = 1
 swapper pgtable: 4k pages, 39-bit VAs, pgd = ffffff8009ecf000
 [ffffffc01391d000] *pgd=000000017fffa803, *pud=000000017fffa803, *pmd=0000000000000000
 Internal error: Oops: 96000146 [#1] PREEMPT SMP
 Modules linked in: i2c_dev rfcomm uinput lzo lzo_compress hci_uart zram btqca qcom_q6v5_pil bluetooth ecdh_generic qcom_common bridge qcom_q6v5 stp llc ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_mark fuse snd_seq_dummy snd_seq snd_seq_device cfg80211 rmtfs_mem smsc95xx usbnet mii joydev
 CPU: 0 PID: 1269 Comm: bash Not tainted 4.14.68 #1
 task: ffffffc0dc2a0080 task.stack: ffffff800f978000
 PC is at __clean_dcache_area_poc+0x20/0x38
 LR is at __swiotlb_map_page+0x80/0x98
 pc : [<ffffff800809bfb4>] lr : [<ffffff800809a150>] pstate: 80400149
 sp : ffffff800f97ba20
 x29: ffffff800f97ba50 x28: 0000000000000001
 x27: ffffff8008a04000 x26: ffffffc0f79a7a28
 x25: 0000000000000000 x24: ffffffbf004e4740
 x23: 0000000000000000 x22: ffffffc0f94eb290
 x21: 000000009391d000 x20: 0000000000000084
 x19: 0000000000000001 x18: 0000000000000000
 x17: 0000000000000000 x16: ffffffc0dc2a0080
 x15: 0000000000000000 x14: 0000000000000001
 x13: 00000000000c00b1 x12: 0000000000000000
 x11: 0000000002000000 x10: 0000000000000000
 x9 : 0000000080000000 x8 : 000000001391d000
 x7 : ffffff80085649dc x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000001
 x3 : 000000000000003f x2 : 0000000000000040
 x1 : ffffffc01391d084 x0 : ffffffc01391d000
 Process bash (pid: 1269, stack limit = 0xffffff800f978000)
 Call trace:
 Exception stack(0xffffff800f97b8e0 to 0xffffff800f97ba20)
 b8e0: ffffffc01391d000 ffffffc01391d084 0000000000000040 000000000000003f
 b900: 0000000000000001 0000000000000000 0000000000000000 ffffff80085649dc
 b920: 000000001391d000 0000000080000000 0000000000000000 0000000002000000
 b940: 0000000000000000 00000000000c00b1 0000000000000001 0000000000000000
 cros-ec-spi spi10.0: SPI transfer timed out
 b960: ffffffc0dc2a0080 0000000000000000 0000000000000000 0000000000000001
 b980: 0000000000000084 000000009391d000 ffffffc0f94eb290 0000000000000000
 b9a0: ffffffbf004e4740 0000000000000000 ffffffc0f79a7a28 ffffff8008a04000
 b9c0: 0000000000000001 ffffff800f97ba50 ffffff800809a150 ffffff800f97ba20
 b9e0: ffffff800809bfb4 0000000080400149 ffffffc0f94eb290 0000000000000000
 ba00: 0000007fffffffff 0000000000000001 ffffff800f97ba50 ffffff800809bfb4
 [<ffffff800809bfb4>] __clean_dcache_area_poc+0x20/0x38
 [<ffffff8008448154>] geni_se_tx_dma_prep+0x80/0x154
 [<ffffff800867eb2c>] geni_i2c_xfer+0x14c/0x3dc
 [<ffffff80086793bc>] __i2c_transfer+0x428/0x83c
 [<ffffff8008679850>] i2c_transfer+0x80/0xbc
 [<ffffff80086798e8>] i2c_master_send+0x5c/0x90
 [<ffffff8008671cc0>] elants_i2c_send+0x30/0x84
 [<ffffff8008672460>] write_update_fw+0x324/0x484
 [<ffffff80085559e4>] dev_attr_store+0x40/0x58
 [<ffffff80082c4ca4>] sysfs_kf_write+0x4c/0x64
 [<ffffff80082c36fc>] kernfs_fop_write+0x124/0x1bc
 [<ffffff8008234f04>] __vfs_write+0x54/0x14c
 [<ffffff80082352b0>] vfs_write+0xcc/0x188
 [<ffffff800823548c>] SyS_write+0x60/0xc0
 Exception stack(0xffffff800f97bec0 to 0xffffff800f97c000)
 bec0: 0000000000000001 000000000e7ede70 0000000000000002 0000000000000000
 bee0: 0000000000000002 000000000e7ede70 00000000ec049bc8 0000000000000004
 bf00: 0000000000000002 0000000000000000 000000000e7f0f10 000000000ca2bcd8
 bf20: 0000000000000000 00000000ff9df69c 00000000ebfaf229 0000000000000000
 bf40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bf60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bf80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bfa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 bfc0: 00000000ebfec978 00000000400e0030 0000000000000001 0000000000000004
 bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 [<ffffff80080832c4>] el0_svc_naked+0x34/0x38
 Code: 9ac32042 8b010001 d1000443 8a230000 (d50b7a20)

Reported-by: Philip Chen <philipchen@chromium.org>
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 36732eb688a4..48a7756de619 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -369,7 +369,11 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	unsigned long time_left = XFER_TIMEOUT;
 
 	gi2c->cur = msg;
-	mode = msg->len > 32 ? GENI_SE_DMA : GENI_SE_FIFO;
+
+	mode = GENI_SE_FIFO;
+	if (msg->len > 32 && (msg->flags & I2C_M_DMA_SAFE))
+		mode = GENI_SE_DMA;
+
 	geni_se_select_mode(&gi2c->se, mode);
 	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_RX_TRANS_LEN);
 	geni_se_setup_m_cmd(&gi2c->se, I2C_READ, m_param);
@@ -405,7 +409,11 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	unsigned long time_left;
 
 	gi2c->cur = msg;
-	mode = msg->len > 32 ? GENI_SE_DMA : GENI_SE_FIFO;
+
+	mode = GENI_SE_FIFO;
+	if (msg->len > 32 && (msg->flags & I2C_M_DMA_SAFE))
+		mode = GENI_SE_DMA;
+
 	geni_se_select_mode(&gi2c->se, mode);
 	writel_relaxed(msg->len, gi2c->se.base + SE_I2C_TX_TRANS_LEN);
 	geni_se_setup_m_cmd(&gi2c->se, I2C_WRITE, m_param);
-- 
Sent by a computer through tubes
