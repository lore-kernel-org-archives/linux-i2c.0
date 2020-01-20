From: Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v1 0/1] HID: mcp2221: add usb to i2c-smbus host bridge driver
Date: Mon, 20 Jan 2020 10:57:37 +0530
Message-ID: <cover.1579497275.git.gupt21@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, wsa+renesas@sang-engineering.com
Cc: gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
List-Id: linux-i2c@vger.kernel.org

MCP2221 is a USB HID to I2C/SMbus host bridge device. This
commit implements i2c and smbus host adapter support. 7-bit
address and i2c multi-message transaction is also supported.

Different transactions have been tested with various common
hardwares, linux driver and user space tools.

Host PC communicates with mcp2221a over usb using raw hid protocol.
Reports are exchanged using interrupt end points. Command and responses
are mcp2221a specific and documented in datasheet:
http://ww1.microchip.com/downloads/en/DeviceDoc/20005565B.pdf

There is only 1 patch in this driver submission.

Rishi Gupta (1):
  HID: mcp2221: add usb to i2c-smbus host bridge driver

 drivers/hid/Kconfig       |  10 +
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   1 +
 drivers/hid/hid-mcp2221.c | 773 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-quirks.c  |   3 +
 5 files changed, 788 insertions(+)
 create mode 100644 drivers/hid/hid-mcp2221.c

-- 
2.7.4
