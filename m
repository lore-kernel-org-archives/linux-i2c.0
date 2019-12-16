From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/5] media: replace i2c_new_probed_device with an ERR_PTR variant
Date: Mon, 16 Dec 2019 13:29:40 +0100
Message-ID: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

In the on-going mission to let i2c_new_* calls return an ERR_PTR instead of
NULL, here is a series for this subsystem converting i2c_new_probed_device() to
the newly introduced i2c_new_scanned_device(). Based on v5.5-rc1 and build tested.
Please apply via your tree.

Thanks,

   Wolfram

Changes since RFC:
* changed commit message of cx88 patch to match the change
  (Thanks Hans!)
* added acks (Thanks Hans and Sean!)
* rebased to v5.5-rc1

Wolfram Sang (5):
  media: pci: cx23885: convert to i2c_new_scanned_device
  media: pci: cx88: convert to i2c_new_scanned_device
  media: pci: bt8xx: convert to i2c_new_scanned_device
  media: pci: cx18: convert to i2c_new_scanned_device
  media: pci: ivtv: convert to i2c_new_scanned_device

 drivers/media/pci/bt8xx/bttv-input.c    | 6 +++---
 drivers/media/pci/cx18/cx18-i2c.c       | 2 +-
 drivers/media/pci/cx23885/cx23885-i2c.c | 4 ++--
 drivers/media/pci/cx88/cx88-input.c     | 2 +-
 drivers/media/pci/ivtv/ivtv-i2c.c       | 6 +++---
 drivers/media/pci/ivtv/ivtv-i2c.h       | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.20.1
