From: Jean Delvare <jdelvare@suse.de>
Subject: State of the i2c-piix4 driver
Date: Tue, 8 Mar 2016 15:13:41 +0100
Message-ID: <20160308151341.48eb3f41@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50955 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbcCHONq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Mar 2016 09:13:46 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Rudolf Marek <r.marek@assembler.cz>

Hi all,

I am still working on the i2c-piix4 driver. The current state doesn't
look good, I see many problems.

1* We do not check which SMBus ports are enabled before accessing them.
So we create I2C buses which do not exist. I have a patch adding
support for this for the SB800.

2* Even if we only instantiate I2C buses for ports which do exist, that
doesn't mean they are used. Unused ports may have their pins left
floating by the hardware manufacturer, resulting in random behavior and
boot delays. I suspect this is what was reported at:
  https://bugzilla.kernel.org/show_bug.cgi?id=112811
I don't really have a solution for this. One possibility would be to
add a module parameter to specify which ports are present in case the
default leads to problems. Another possibility is to enable all ports
but disable device auto-detection on the extra ports, at least by
default. Yet another possibility is a DMI-based list of boards with
known mappings. Not sure what is best, maybe we need a mix of all that,
opinions welcome.

Christian, please provide the DMI data for your board, in case we need
it later.

3* For the Hudson-2/Bolton, according to the datasheet there is no
separate GPIO pin configuration registers for the SMBus ports. Pins are
GPIO when the corresponding SMBus port is not enabled, and SMBus when
the SMBus port is enabled. This means that it is impossible to detect
which SMBus ports exist, except for the one being currently selected.
Even worse, it means that activating any other SMBus port could send I/O
signals over GPIO pins which were meant for something completely
different. This has a potential for BREAKING THINGS BADLY, including
HARDWARE DAMAGE. Therefore I believe that multiplexing support should
be DISABLED by default on this hardware, as soon as possible.

4* Didn't check Mullins and Carrizo yet, but odds are they behave the
same as Hudson-2/Bolton, so I think we should disable them for the time
being too.

5* The I/O ports used for SMBus configuration and port switching are
also needed by a watchdog driver, sp5100_tco. Both drivers request the
region, so the first one wins, and the other driver can't be loaded.
sp5100_tco was there first, so the changes done to the i2c-piix4 driver
recently will cause a regression for some users by preventing them
from using the sp5100_tco and i2c-piix4 drivers at the same time. In
the long run I guess we will need a helper module to handle this shared
resource. Unless IORESOURCE_MUXED can be used for that. Either way,
that's more work than I can put into this before kernel v4.5 is
released. For the time being, I think we should simply make it
non-fatal if the I/O ports can't be requested, and continue without
multiplexing (as before.)

-- 
Jean Delvare
SUSE L3 Support
