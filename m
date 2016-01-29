From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 0/3] Improvements to the i2c-piix4 driver
Date: Fri, 29 Jan 2016 10:41:46 +0100
Message-ID: <20160129104146.50f06562@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59131 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475AbcA2Jlu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 04:41:50 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

Hi all,

Here are 3 proposed improvements to the i2c-piix4 driver, on top of the
3 patches I sent recently. Christian, I would appreciate if you can
test them and confirm that they do not cause any regression for you.

[PATCH 1/3] i2c-piix4: Support alternative port selection register
[PATCH 2/3] i2c-piix4: Always use the same type for port
[PATCH 3/3] i2c-piix4: Pre-shift the port number

-- 
Jean Delvare
SUSE L3 Support
