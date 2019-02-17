From: Adrian Bunk <bunk@kernel.org>
Subject: [4.9/4.14 patch v2 0/2] at24: add support for 24c2048
Date: Sun, 17 Feb 2019 13:14:50 +0200
Message-ID: <20190217111452.6152-1-bunk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

There are some changes in the driver that prevent a direct
cherry-pick to older kernels, including requiring only one
line addition in the backport while the upstream commit
requires three.

Backport applies and builds against 4.9/4.14 (but not 4.4).
Confirmed working with 4.14.
For 4.19/4.20 please cherry-pick the upstream commits instead.

Adrian Bunk (2):
  dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
  eeprom: at24: add support for 24c2048

 Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++--
 drivers/misc/eeprom/Kconfig                         | 2 +-
 drivers/misc/eeprom/at24.c                          | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.11.0
