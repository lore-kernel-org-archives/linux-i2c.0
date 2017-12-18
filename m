From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v3 0/1] eeprom: at24: convert magic numbers to structs.
Date: Mon, 18 Dec 2017 13:30:27 -0500
Message-ID: <1513621828-6641-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

v3:
	rebase against maintainer's latest devel branch
	removed macros from struct {i2c,of,acpi}_device_id for easy grepping
	applied newline, formatting, tab suggestions

v2:
	use struct at24_chip_data instead of struct at24_platform_data
		(which decreases code size)
	explicitly write out of compatible nodes, e.g. "atmel,24c04"
		(which allows grepping for of compatible nodes)

v1:
	first shot

Sven Van Asbroeck (1):
  eeprom: at24: convert magic numbers to structs.

 drivers/misc/eeprom/at24.c | 219 ++++++++++++++++++++-------------------------
 1 file changed, 99 insertions(+), 120 deletions(-)

-- 
1.9.1
