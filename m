From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v2 0/1] at24: support eeproms that do not roll over page reads.
Date: Wed, 1 Nov 2017 09:44:02 -0400
Message-ID: <1509543843-27697-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, nsekhar@ti.com, david@lechnology.com, javier@dowhile0.org, brgl@bgdev.pl
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

v2:
	kbuild test robot feedback: correct
		"warning: comparison of distinct pointer types lacks a cast"
	build warning on some compilers / architectures.

v1:
	original patch

Sven Van Asbroeck (1):
  at24: support eeproms that do not roll over page reads.

 .../devicetree/bindings/eeprom/eeprom.txt          |  5 +++
 drivers/misc/eeprom/at24.c                         | 47 +++++++++++-----------
 include/linux/platform_data/at24.h                 |  1 +
 3 files changed, 29 insertions(+), 24 deletions(-)

-- 
1.9.1
