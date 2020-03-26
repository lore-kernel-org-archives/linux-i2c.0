From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/6] media: convert to use new I2C API
Date: Thu, 26 Mar 2020 22:09:40 +0100
Message-ID: <20200326210947.12747-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (6):
  media: pci: cx88: convert to use i2c_new_client_device()
  media: pci: saa7134: convert to use i2c_new_client_device()
  media: marvell-ccic: convert to use i2c_new_client_device()
  media: usb: cx231xx: convert to use i2c_new_client_device()
  media: usb: hdpvr: convert to use i2c_new_client_device()
  media: usb: pvrusb2: convert to use i2c_new_client_device()

 drivers/media/pci/cx88/cx88-core.c                | 3 +--
 drivers/media/pci/cx88/cx88-input.c               | 2 +-
 drivers/media/pci/cx88/cx88-video.c               | 2 +-
 drivers/media/pci/saa7134/saa7134-input.c         | 2 +-
 drivers/media/platform/marvell-ccic/cafe-driver.c | 2 +-
 drivers/media/usb/cx231xx/cx231xx-input.c         | 5 ++---
 drivers/media/usb/hdpvr/hdpvr-core.c              | 4 ++--
 drivers/media/usb/hdpvr/hdpvr-i2c.c               | 2 +-
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c      | 4 ++--
 9 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.20.1
