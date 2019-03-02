From: Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] i2c: sis630: correct format strings
Date: Sat,  2 Mar 2019 14:18:36 +0000
Message-ID: <20190302141836.24638-1-louis@kragniz.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, ndesaulniers@google.com, jflat@chromium.org, Louis Taylor <louis@kragniz.eu>
List-Id: linux-i2c@vger.kernel.org

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
2.20.1
