From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: i2c-i801 partially broken on Lynx Point PCH?
Date: Thu, 19 May 2016 14:02:57 +0300
Message-ID: <573D9D61.5070500@linux.intel.com>
References: <20160511093452.5bc2614c@endymion>
 <20160511104322.60521365@endymion> <20160518140508.7dfe192e@endymion>
 <20160518152001.3ddb8d11@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24082 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908AbcESLDL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 May 2016 07:03:11 -0400
In-Reply-To: <20160518152001.3ddb8d11@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Seth Heasley <seth.heasley@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi

On 18.05.2016 16:20, Jean Delvare wrote:

>> If anyone can think of any better solution, please let me know.
>
I had an offline chat with Mika and although we didn't figure out any 
additional solution we were thinking what would be the practical penalty 
if we drop the block read when write protection is enabled? I mean if 
SMBUS connected EEPROMs are small like 256 bytes or so does the effect 
doing smaller reads get noticeable?

> 4* It could be that the sentence in the datasheet that claims the slave
>     address register bit 0 must be set to 0 (write) for I2C Block Reads
>     is a left-over from previous incarnations of the chipset, and this no
>     longer holds true today. Out of curiosity I tried setting bit 0 to 1
>     (as it should normally be for a read) and it seems to work just
>     fine. And then it is no longer affected by the SPD write protection
>     mechanism. However I don't know if there is any problem or negative
>     side effect I may have missed.
>
> Mika/Jarkko, can you check with your hardware guys if that statement on
> page 215 still holds for 8-Series/C220 and later?
>
We'll ping around.

-- 
Jarkko
