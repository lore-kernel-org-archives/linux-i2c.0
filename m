Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059512;
	b=Wc5fZvPW/9wEXR73gdinVviTxToEk0nJhxxyCyO931fMWssSa9vmc9pNtSQ0ioQQudtn
	 MVDzCFx10E4ChBOkaxEY+pa8zhsnoW+/dai+JqNqiirCe1pC1/MI0XGiTHFhtm3xY/C/x
	 gbI5ECZ1EUNvZPSBgmX2uNe5PkqWo5pWBxEzeeWcUIkCXHddk6msYTmrX2xnNzOuHW08b
	 g+BCNEU5gyitVR7Mh1k9YvjHe9PgO91nqaaxS4ISNe+AXazq+H5FJmt7+tk2hHtgupj+U
	 EmJPKjfZwkduuVSXL9tveR5ohbIuIU+Q7UJPO6r2olALdiBqpchxLWGo1EDcrLzrUJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059512;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=BtYxiulsOyBJY1EU8iKU+3EwpnQFt8VhmayMvVzThrs=;
	b=ymoqSRDe091ZCVEBmxPgs0T0QcvTplRnq96GKZlRGuCnuxup5g2EHMrjV+Aw0CuC7Kfi
	 ZSTPbaT37ErpNL/MdTqkUuVroRcnRJPwyI+sZK26dHlXXjGNjBBeKB44rRqKRAmKpZHjz
	 TehZuzg6jYeM3mzKSMSPd7Gt9vU0XXH4CEZt1JD/X6gKECwi9L3den1f218Zbs5rirMWW
	 +rcmtdtu7vxk84KUJs+6fjUzWg+FjE+CPAnnAmlazccPNNq7zrWBQddlEDkEaMBHy0hZ4
	 Mh3jGA26+X8V3P5oBxFCMaVleC77TzRIHNBVyVVQnzp68wSyp51pW0OjYPIYx6oyJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yosoro.hk;
	spf=none smtp.mailfrom=yosoro.hk;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lkntVOJv;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD4606A325;
	Thu, 19 Nov 2026 03:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4DD4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yosoro.hk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yosoro.hk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lkntVOJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795059506; bh=BtYxiulsOyBJY1EU8iKU+3EwpnQFt8VhmayMvVzThrs=;
	h=From:To:Cc:Subject:Date;
	b=lkntVOJv87d2Q+Z4JvvmZIPjx2yGemuABHSkqzbITrl9Pay7zRwgUXYrXtVdQEQeI
	 8rCuutUVYrec0VNpSz/nKxEz4xh79iWPagxhg4ZBuZiTEm/F/npvVtXjus3qzWLwrg
	 2UAeFJ3rhWIvetl2whg5HsO1s+Y5RPCcTLWEi78c=
Received: from [192.168.123.32] ([122.191.232.200])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 99822AED; Thu, 19 Nov 2026 11:38:24 +0800
X-QQ-mid: xmsmtpt1795059504t9de8oi75
Message-ID: <tencent_6874806C455DB42610399513A0A95083C805@qq.com>
X-QQ-XMAILINFO: MyIG+pWbYkorB3wJ0rDaZSFQUK2xcrQ7yuNfha0Dp8ODigdgZDM4Tdlj/4S9zV
	 8UuFyEGHn+jCqBJYI6okoGVb+QqEIWBj+mQPkzQ+0r7ko9CZBg9vC0cdIekdJf7aN8oFVKAsdd/v
	 f+c1/kB6AHPmLJew96/3s87zJA+fx1eSfR7ZUdtpVaB9pUSJ6CefcB7BTvhb8y+6OWkBzUlEbQ+g
	 Uzbwb6C20HGtYMSQCTp4/Q2fEXSjyi1BhEE+36OlnBHu3LHDefgxbM/Ulv4vg1vhNqT9RZQln76W
	 pqx/MfKFjT/vmNCq8OmGDuPVCrBY2R2an464Egw/VARjewe0ftJGabeSiDsLV9JgnBasxzMRImAF
	 DlPtm4cQJk/yOYFmSk/M4R/SI97Doh6Sb1oJZmnm6BBD83X+NZWaIOBlPllA8vm0Cl2ArS9K1eec
	 JhCXQZP54K5xoNZKnoFmKPmiyupx2MEnDge9DhyS4pm2/Mq4Tshe2F7ygbLew7GNGNiPxedYuBfi
	 F3FH/chmBNBoD9G2QFAg3+HTK/ept+YftNuIyB0GBjYvmrP5FKv+c0m+TnoCswoAfeAka7CPfIeW
	 K8OuyHOowIDmYZyQlUgbE/gDvWS+RoCg1avsB1b0HS0HCwc47iynSj7+DTtHYDLbxTk32yUcZldW
	 ffQ/l1PhS7Vj7w0K1cZmXP7YvXTN+uyJUpPxQgmvNzXH/RH3kicZZ/vjyCA6ncu9Wi6nbNsFibNX
	 ia5J9n+1UocHAw9xxE3fBt6MUhAS2wO7uBXNcVeQvvMvxWrK3si2pUqNHCulp3muLTTP8cHNwe3A
	 +U+QwjQ9VN7guI7B3SkuV056ClOM2a6jJQEEhXvrs/lVgpnPIFKPHmLusWNg7682Jf45yRGBGdn7
	 /CO3D1SxTlvSWk7xdCukD1uabgC7Z3ExSj46chzj/zp0fo5Sf365dJnw6hGa6BSgAPw1OgZLQGb7
	 9TeH/59V+PVS9qKDfnlDtTUJMtWZRCNIn94Pw8ivxYaqS3CcitlKDGNzsGVOfSJ0Tk5axSFvtIsi
	 Uy7/4AnfhGD9ldqdmfOThIKcmKWHpBdLLhYuJxbrnqmdBU/jBh6VJ/M8rsCM0=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: NanamiKite <nanami@yosoro.hk>
To: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: i801: Add support for Intel Lunar Lake-M
Date: Thu, 19 Nov 2026 11:37:46 +0800
X-OQ-MSGID: <179505946684.28079.3328810702757371160@yosoro.hk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Add the SMBus PCI ID (0xa822) for Intel Lunar Lake-M (Core Ultra 200V
series).

Tested on an Intel Core Ultra 5 226V (Lunar Lake-M) laptop via dynamic
new_id binding with FEATURES_ICH5 | FEATURE_TCO_CNL: the controller
binds with PCI interrupt support, handles SMBus transactions cleanly
(verified with i2cdetect), and initializes the version 6 iTCO_wdt
watchdog at TCOBASE 0x0400 (verified with wdctl).

Cc: stable@vger.kernel.org
Signed-off-by: NanamiKite <nanami@yosoro.hk>
---
 Documentation/i2c/busses/i2c-i801.rst | 1 +
 drivers/i2c/busses/Kconfig            | 1 +
 drivers/i2c/busses/i2c-i801.c         | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801.rst b/Documentation/i2c/busses/i2c-i801.rst
index bbbce90..2e7f3f0 100644
--- a/Documentation/i2c/busses/i2c-i801.rst
+++ b/Documentation/i2c/busses/i2c-i801.rst
@@ -53,6 +53,7 @@ Supported adapters:
   * Intel Wildcat Lake (SOC)
   * Intel Diamond Rapids (SOC)
   * Intel Nova Lake (PCH)
+  * Intel Lunar Lake (SOC)
 
    Datasheets: Publicly available at the Intel website
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 275aaa7..83d3f14 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -168,6 +168,7 @@ config I2C_I801
 	    Wildcat Lake (SOC)
 	    Diamond Rapids (SOC)
 	    Nova Lake (PCH)
+	    Lunar Lake (SOC)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 9d3cc70..63ac29c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -86,6 +86,7 @@
  * Wildcat Lake-U (SOC)		0x4d22	32	hard	yes	yes	yes
  * Diamond Rapids (SOC)		0x5827	32	hard	yes	yes	yes
  * Nova Lake-S (PCH)		0x6e23	32	hard	yes	yes	yes
+ * Lunar Lake-M (SOC)		0xa822	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -269,6 +270,7 @@
 #define PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS	0xa2a3
 #define PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS		0xa323
 #define PCI_DEVICE_ID_INTEL_COMETLAKE_V_SMBUS		0xa3a3
+#define PCI_DEVICE_ID_INTEL_LUNAR_LAKE_M_SMBUS		0xa822
 #define PCI_DEVICE_ID_INTEL_METEOR_LAKE_SOC_S_SMBUS	0xae22
 #define PCI_DEVICE_ID_INTEL_PANTHER_LAKE_H_SMBUS	0xe322
 #define PCI_DEVICE_ID_INTEL_PANTHER_LAKE_P_SMBUS	0xe422
@@ -1069,6 +1071,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, PANTHER_LAKE_P_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, WILDCAT_LAKE_U_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ PCI_DEVICE_DATA(INTEL, NOVA_LAKE_S_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
+	{ PCI_DEVICE_DATA(INTEL, LUNAR_LAKE_M_SMBUS,		FEATURES_ICH5 | FEATURE_TCO_CNL) },
 	{ 0, }
 };
 
-- 
2.56.1

