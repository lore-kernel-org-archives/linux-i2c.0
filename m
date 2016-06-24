From: Stefan Roese <sr@denx.de>
Subject: i2c-i801 / SMBus timeouts on BayTrail board (U-Boot)
Date: Fri, 24 Jun 2016 13:57:21 +0200
Message-ID: <576D2021.4030808@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58948 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbcFXL5f (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 24 Jun 2016 07:57:35 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Chew, Kean ho" <kean.ho.chew@intel.com>

Hi,

I'm currently trying to use the SMBus on a congatec BayTrail board.
This works just fine when booting via the original BIOS. But when I
boot into Linux using U-Boot as bootloader, I get the following
errors:

[   81.877121] i801_smbus 0000:00:1f.3: Transaction timeout
[   81.879228] i801_smbus 0000:00:1f.3: Failed terminating the transaction
[   81.879320] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[   81.879373] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[   81.879421] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
[   81.879496] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
...

I checked with an oscilloscope and the SMBus clock is not toggling
at all in this case. My feeling is, that some basic setup is missing
in this non-BIOS case. Like some clock enabling. Does anyone of you
have some idea here?

Thanks,
Stefan
