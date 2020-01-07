From: Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v4 0/5] at24: move write-protect pin handling to nvmem core
Date: Tue,  7 Jan 2020 10:29:17 +0100
Message-ID: <20200107092922.18408-1-ktouil@baylibre.com>
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
The first patch modifies the relevant binding document to make the
wp-gpio a reference to the property defined by nvmem , while the
second removes the relevant code in the at24 driver.

- adds reference in the at25 binding document for the wp-gpios property
as it uses nvmem subsystem.

Changes since v1:
-Add an explenation on how the wp-gpios works
-Keep reference to the wp-gpios in the at24 binding

Changes since v2:
-Use the flag GPIO_ACTIVE_HIGH instead of 0

Changes since v3:
-Keep the example of the wp-gpios in the at25 bindings
-Add reference for the wp-gpios property in the at25 binding


Khouloud Touil (5):
  dt-bindings: nvmem: new optional property wp-gpios
  nvmem: add support for the write-protect pin
  dt-bindings: at24: make wp-gpios a reference to the property defined
    by nvmem
  dt-bindings: at25: add reference for the wp-gpios property
  eeprom: at24: remove the write-protect pin support

 .../devicetree/bindings/eeprom/at24.yaml      |  5 +----
 .../devicetree/bindings/eeprom/at25.txt       |  2 ++
 .../devicetree/bindings/nvmem/nvmem.yaml      | 11 +++++++++++
 drivers/misc/eeprom/at24.c                    |  9 ---------
 drivers/nvmem/core.c                          | 19 +++++++++++++++++--
 drivers/nvmem/nvmem.h                         |  2 ++
 include/linux/nvmem-provider.h                |  3 +++
 7 files changed, 36 insertions(+), 15 deletions(-)

-- 
2.17.1
