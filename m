From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 partially broken on Lynx Point PCH?
Date: Wed, 18 May 2016 15:20:01 +0200
Message-ID: <20160518152001.3ddb8d11@endymion>
References: <20160511093452.5bc2614c@endymion>
	<20160511104322.60521365@endymion>
	<20160518140508.7dfe192e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36168 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbcERNUK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 18 May 2016 09:20:10 -0400
In-Reply-To: <20160518140508.7dfe192e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Seth Heasley <seth.heasley@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Me again...

On Wed, 18 May 2016 14:05:08 +0200, Jean Delvare wrote:
> * The I2C Block Read transaction must set this bit to 0 (write) even if
>   it is a read transaction. This is explicitly mentioned in the
>   datasheet (page 215, "For I2C Read command, the value written into
>   bit 0 of the Transmit Slave Address Register (SMB I/O register,
>   offset 04h) needs to be 0.")
> (...)
> Mika/Jarkko, is there any chance to get your hardware people involved?
> I wonder if there is any workaround to this issue? Any chance to get
> this fixed in future chipsets? Not sure about Send Byte but the write
> protection should definitely not block I2C Block Read transactions.
> 
> For now we need to come up with a software workaround. I can think of 3
> approaches:
> (...)
> If anyone can think of any better solution, please let me know.

4* It could be that the sentence in the datasheet that claims the slave
   address register bit 0 must be set to 0 (write) for I2C Block Reads
   is a left-over from previous incarnations of the chipset, and this no
   longer holds true today. Out of curiosity I tried setting bit 0 to 1
   (as it should normally be for a read) and it seems to work just
   fine. And then it is no longer affected by the SPD write protection
   mechanism. However I don't know if there is any problem or negative
   side effect I may have missed.

Mika/Jarkko, can you check with your hardware guys if that statement on
page 215 still holds for 8-Series/C220 and later?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
