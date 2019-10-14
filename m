From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 0/4] Instantiate SPD EEPROMs at boot on x86
Date: Mon, 14 Oct 2019 11:36:36 +0200
Message-ID: <20191014113636.57b5ce89@endymion>
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

-- 
Jean Delvare
SUSE L3 Support
