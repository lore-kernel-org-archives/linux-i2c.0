From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: do not disable adapter after transfer
Date: Fri, 8 Apr 2016 15:17:49 +0300
Message-ID: <5707A16D.2010800@linux.intel.com>
References: <1459478866-3896-1-git-send-email-lucas.de.marchi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58751 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757888AbcDHMSD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Apr 2016 08:18:03 -0400
In-Reply-To: <1459478866-3896-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, linux-i2c@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, christian.ruppert@alitech.com

Hi

On 04/01/2016 05:47 AM, Lucas De Marchi wrote:
> From: Lucas De Marchi <lucas.demarchi@intel.com>
>
> Disabling the adapter after each transfer is pretty bad for sensors and
> other devices doing small transfers at a high rate. It slows down the
> transfer rate a lot since each of them have to wait the adapter to be
> enabled again.
>
> It was done in order to avoid the adapter to generate interrupts when
> it's not being used. Instead of doing that here we just disable the
> interrupt generation in the controller. With a small program test to
> read/write registers in a sensor the speed doubled. Example below with
> write sequences of 16 bytes:
>
> Before:
> 	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
> 	num_transfers=20000
> 	transfer_time_avg=1032.728500us
>
> After:
> 	i2c-transfer-time -w -a 0x40 -x 6 -n 20000 -- 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07 0 0 0xd0 0x07
> 	num_transfers=20000
> 	transfer_time_avg=470.256050us
>
I gave a test to this patch and saw similar improvements when dumping 
large set of registers from I2C connected audio codec.

echo Y > /sys/kernel/debug/regmap/i2c-10EC5640\:00/cache_bypass
time cat /sys/kernel/debug/regmap/i2c-10EC5640\:00/registers >/dev/null

I checked the runtime PM status of adapter was suspended before running 
above cat command in order to get comparable results.

Before patch time was ~0.55 - ~0.76 s and with patch applied time was 
~0.16 - ~0.25 s.

Hopefully we'll find how to prevent regression on Christian's machines.

-- 
Jarkko
