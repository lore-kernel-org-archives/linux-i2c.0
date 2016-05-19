From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 partially broken on Lynx Point PCH?
Date: Thu, 19 May 2016 13:29:33 +0200
Message-ID: <20160519132933.1202b6be@endymion>
References: <20160511093452.5bc2614c@endymion>
	<20160511104322.60521365@endymion>
	<20160518140508.7dfe192e@endymion>
	<20160518152001.3ddb8d11@endymion>
	<573D9D61.5070500@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44292 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754295AbcESL3i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 May 2016 07:29:38 -0400
In-Reply-To: <573D9D61.5070500@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Seth Heasley <seth.heasley@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Jarkko,

On Thu, 19 May 2016 14:02:57 +0300, Jarkko Nikula wrote:
> On 18.05.2016 16:20, Jean Delvare wrote:
> 
> > If anyone can think of any better solution, please let me know.
>
> I had an offline chat with Mika and although we didn't figure out any 
> additional solution we were thinking what would be the practical penalty 
> if we drop the block read when write protection is enabled? I mean if 
> SMBUS connected EEPROMs are small like 256 bytes or so does the effect 
> doing smaller reads get noticeable?

Reading one SPD EEPROM takes 33 ms using I2C Block reads and 81 ms
using Word reads (to which the eeprom and at24 drivers will fall back.)
Large machines can have 16 memory slots and as many SPD EEPROMs. On
such a machine, without I2C Block read support, decode-dimms would take
1.3 second instead of 0.5 second. So while this isn't the end of the
world, it will be noticeable, which is why I'd rather avoid it if
possible.

Also note that it could penalize other devices on the SMBus
("grep -r I2C_FUNC_SMBUS_READ_I2C_BLOCK drivers" will show you a list
of affected drivers) unless we implement a per-slave-address
functionality callback. That's possible and not difficult but would
make Wolfram sad ;-)

> > 4* It could be that the sentence in the datasheet that claims the slave
> >     address register bit 0 must be set to 0 (write) for I2C Block Reads
> >     is a left-over from previous incarnations of the chipset, and this no
> >     longer holds true today. Out of curiosity I tried setting bit 0 to 1
> >     (as it should normally be for a read) and it seems to work just
> >     fine. And then it is no longer affected by the SPD write protection
> >     mechanism. However I don't know if there is any problem or negative
> >     side effect I may have missed.
> >
> > Mika/Jarkko, can you check with your hardware guys if that statement on
> > page 215 still holds for 8-Series/C220 and later?
> >
> We'll ping around.

Great, thank you.

-- 
Jean Delvare
SUSE L3 Support
