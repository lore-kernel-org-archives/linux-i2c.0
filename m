From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] eeprom: at24: new property
Date: Tue,  5 Feb 2019 14:59:32 +0100
Message-ID: <20190205135934.18841-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Microchip 24aa02t EEPROM is compatible with Atmel 24c02 except that
it's visible on 8 i2c slave addresses. We already support such a
use case with hard-coded config for 'atmel,24c00'. Let's add a more
flexible device tree property - 'num-addresses' - to the binding
document and support it in the driver.

Bartosz Golaszewski (2):
  dt-bindings: at24: add the 'num-addresses' property
  eeprom: at24: implement support for 'num-addresses' property

 Documentation/devicetree/bindings/eeprom/at24.txt |  3 +++
 drivers/misc/eeprom/at24.c                        | 13 ++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.20.1
