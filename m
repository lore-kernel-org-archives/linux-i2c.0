From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: State of the i2c-piix4 driver
Date: Tue, 8 Mar 2016 16:05:32 +0100
Message-ID: <56DEEA3C.1010202@assembler.cz>
References: <20160308151341.48eb3f41@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ms.trustica.cz ([82.208.32.68]:54809 "EHLO ms.trustica.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbcCHPNo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Mar 2016 10:13:44 -0500
In-Reply-To: <20160308151341.48eb3f41@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi all,


> 3* For the Hudson-2/Bolton, according to the datasheet there is no
> separate GPIO pin configuration registers for the SMBus ports. Pins are
> GPIO when the corresponding SMBus port is not enabled, and SMBus when
> the SMBus port is enabled. This means that it is impossible to detect
> which SMBus ports exist, except for the one being currently selected.
> Even worse, it means that activating any other SMBus port could send I/O
> signals over GPIO pins which were meant for something completely
> different. This has a potential for BREAKING THINGS BADLY, including
> HARDWARE DAMAGE. Therefore I believe that multiplexing support should
> be DISABLED by default on this hardware, as soon as possible.

Was it ever enabled?

> 4* Didn't check Mullins and Carrizo yet, but odds are they behave the
> same as Hudson-2/Bolton, so I think we should disable them for the time
> being too.

Carrizo:
http://support.amd.com/TechDocs/50742_15h_Models_60h-6Fh_BKDG.pdf

Looks they restored the behaviour to the way it was for sb800 - but other than
pair scl/sda 0 is reserved (pair 1 is used for TSI).

> 
> 5* The I/O ports used for SMBus configuration and port switching are
> also needed by a watchdog driver, sp5100_tco. Both drivers request the
> region, so the first one wins, and the other driver can't be loaded.
> sp5100_tco was there first, so the changes done to the i2c-piix4 driver
> recently will cause a regression for some users by preventing them
> from using the sp5100_tco and i2c-piix4 drivers at the same time. In
> the long run I guess we will need a helper module to handle this shared
> resource. Unless IORESOURCE_MUXED can be used for that. Either way,
> that's more work than I can put into this before kernel v4.5 is
> released. For the time being, I think we should simply make it
> non-fatal if the I/O ports can't be requested, and continue without
> multiplexing (as before.)

Yes 0 thank you for looking into that.

Thanks
Rudolf
