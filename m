From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Wed, 26 Oct 2016 14:15:32 +0200
Message-ID: <20161026141532.5bd82382@endymion>
References: <20161011131327.0eabd227@endymion>
        <20161025100241.GH1597@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbcJZMQE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Oct 2016 08:16:04 -0400
In-Reply-To: <20161025100241.GH1597@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Wolfram,

On Tue, 25 Oct 2016 12:02:42 +0200, Wolfram Sang wrote:
> On Tue, Oct 11, 2016 at 01:13:27PM +0200, Jean Delvare wrote:
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
> 
> Fixed the BIT() issue mentioned by Jarkko and applied to for-current,
> thanks! But please double check my commit once I pushed out.

The BIT() cleanup is a patch by Benjamin Tissoires ("i2c: i801: use
BIT() macro for bits definition"), I thought you had applied it already
so I rebased my patch on it, but it turns out I was wrong. You could
just have used v1 of the patch ;-)

Your changes are obviously correct, but you'll have to solve the merge
conflict again when applying Benjamin's patch, sorry.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
