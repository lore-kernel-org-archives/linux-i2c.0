From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Tue, 11 Oct 2016 20:20:45 +0200
Message-ID: <20161011202045.43787f2e@endymion>
References: <20161011131327.0eabd227@endymion>
        <eb3c0e91-5744-3b49-515e-dd68ed5d88aa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753582AbcJKSUw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Oct 2016 14:20:52 -0400
In-Reply-To: <eb3c0e91-5744-3b49-515e-dd68ed5d88aa@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi Jarkko,

On Tue, 11 Oct 2016 14:32:55 +0300, Jarkko Nikula wrote:
> On 10/11/2016 02:13 PM, Jean Delvare wrote:
> > Starting with the 8-Series/C220 PCH (Lynx Point), the SMBus
> > controller includes a SPD EEPROM protection mechanism. Once the SPD
> > Write Disable bit is set, only reads are allowed to slave addresses
> > 0x50-0x57.
> >
> > However the legacy implementation of I2C Block Read since the ICH5
> > looks like a write, and is therefore blocked by the SPD protection
> > mechanism. This causes the eeprom and at24 drivers to fail.
> >
> > So assume that I2C Block Read is implemented as an actual read on
> > these chipsets. I tested it on my Q87 chipset and it seems to work
> > just fine.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > ---
> > Changes since v1:
> >  * Rebased on Linus' latest tree.
> >
> > Jarkko, still no information about this from your Windows or hardware
> > folks?
>
> No update, in fact some of the contacts have left the company :-(

What do we do then? Without this patch, I2C Block Read doesn't work at
all on recent chipsets. I don't think it can be worse with the patch.
And it works fine on the few machines I tested on. So I would like this
patch to go upstream.

My coverage is limited though. Did anyone at Intel test this patch on
other (recent) systems?

-- 
Jean Delvare
SUSE L3 Support
