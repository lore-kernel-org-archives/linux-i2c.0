From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v5 0/1] eeprom: at24: convert magic numbers to structs.
Date: Wed, 20 Dec 2017 11:48:55 -0500
Message-ID: <1513788536-7672-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.arcx.com ([184.94.50.18]:57735 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753538AbdLTQtJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 20 Dec 2017 11:49:09 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: svendev@arcx.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

v5:
	applied formatting suggestions

v4:
	applied formatting suggestions

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

 drivers/misc/eeprom/at24.c | 221 ++++++++++++++++++++-------------------------
 1 file changed, 100 insertions(+), 121 deletions(-)

-- 
1.9.1
