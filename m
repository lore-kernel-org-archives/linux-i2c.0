From: Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 0/3] Add ST lsm6dso i3c support
Date: Thu,  6 Jun 2019 17:12:01 +0200
Message-ID: <cover.1559831663.git.vitor.soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, bbrezillon@kernel.org, Joao.Pinto@synopsys.com, lorenzo.bianconi83@gmail.com, Vitor Soares <Vitor.Soares@synopsys.com>
List-Id: linux-i2c@vger.kernel.org

This patch series add i3c support for STM LSM6DSO and LSM6DSR sensors.

It is also introduced i3c support on regmap api. Due the lack of
i3c devices HDR capables on the market the support for now is only for
i3c sdr mode by using i3c_device_do_priv_xfers() method.

Changes in v2:
  Change i3c_get_device_id() to drivers/i3c/device.c
  Add support for LSM6DSR

Vitor Soares (3):
  regmap: add i3c bus support
  i3c: Add i3c_get_device_id helper
  iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR

 drivers/base/regmap/Kconfig                 |  6 ++-
 drivers/base/regmap/Makefile                |  1 +
 drivers/base/regmap/regmap-i3c.c            | 60 +++++++++++++++++++++++
 drivers/i3c/device.c                        |  8 +++
 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 ++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 76 +++++++++++++++++++++++++++++
 include/linux/i3c/device.h                  |  1 +
 include/linux/regmap.h                      | 20 ++++++++
 9 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

-- 
2.7.4
