From: Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH 0/4] at24: move write-protect pin handling to nvmem core
Date: Wed, 20 Nov 2019 15:20:34 +0100
Message-ID: <20191120142038.30746-1-ktouil@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

The write-protect pin handling looks like a standard property that
could benefit other users if available in the core nvmem framework.

Instead of modifying all the drivers to check this pin, make the
nvmem subsystem check if the write-protect GPIO being passed
through the nvmem_config or defined in the device tree and pull it
low whenever writing to the memory.

This patchset:

- adds support for the write-protect pin split into two parts.
The first patch modifies modifies the relevant binding document,
while the second modifies the nvmem code to pull the write-protect
GPIO low (if present) during write operations.

- removes support for the write-protect pin split into two parts.
The first patch modifies the relevant binding document to remove
the wp-gpio, while the second removes the relevant code in the
at24 driver.


Khouloud Touil (4):
  dt-bindings: nvmem: new optional property write-protect-gpios
  nvmem: add support for the write-protect pin
  dt-bindings: at24: remove the optional property write-protect-gpios
  eeprom: at24: remove the write-protect pin support

 .../devicetree/bindings/eeprom/at24.yaml      |  6 ------
 .../devicetree/bindings/nvmem/nvmem.yaml      |  6 ++++++
 drivers/misc/eeprom/at24.c                    |  9 ---------
 drivers/nvmem/core.c                          | 20 +++++++++++++++++--
 drivers/nvmem/nvmem.h                         |  2 ++
 include/linux/nvmem-provider.h                |  3 +++
 6 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.17.1
