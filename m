From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 009/262] i2c: sis630: correct format strings
Date: Wed, 27 Mar 2019 13:57:44 -0400
Message-ID: <20190327180158.10245-9-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Louis Taylor <louis@kragniz.eu>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Louis Taylor <louis@kragniz.eu>

[ Upstream commit 60f7691c624b41a05bfc3493d9b0519e7951b7ef ]

When compiling with -Wformat, clang warns:

drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                        smbus_base + SMB_STS,
                        ^~~~~~~~~~~~~~~~~~~~

drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                        smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
      'unsigned short' but the argument has type 'int' [-Wformat]
                 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
                                          ~~~~~   ^~~~~~~~~~~~~~~~~~~~

This patch fixes the format strings to use the format type for int.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sis630.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 1e6805b5cef2..a57aa4fe51a4 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -478,7 +478,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
 			    sis630_driver.name)) {
 		dev_err(&sis630_dev->dev,
-			"I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
+			"I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
 			smbus_base + SMB_STS,
 			smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
 		retval = -EBUSY;
@@ -528,7 +528,7 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	sis630_adapter.dev.parent = &dev->dev;
 
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
-		 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
+		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
 
 	return i2c_add_adapter(&sis630_adapter);
 }
-- 
2.19.1
