From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 0/4 v2] Instantiate SPD EEPROMs at boot on x86
Date: Mon, 18 Nov 2019 10:24:10 +0100
Message-ID: <20191118102410.78cd8e6e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

This is my work to let decode-dimms work out of the box on most x86
desktop and laptop systems.

[PATCH 1/4] firmware: dmi: Remember the memory type
[PATCH 2/4] firmware: dmi: Add dmi_memdev_handle
[PATCH 3/4] i2c: smbus: Add a way to instantiate SPD EEPROMs automatically
[PATCH 4/4] i2c: i801: Instantiate SPD EEPROMs automatically

Changes since v1:
 * Fix build warning and error reported by kbuild test bot for specific
   kernel configurations

-- 
Jean Delvare
SUSE L3 Support
