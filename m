From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Tue, 24 May 2016 10:00:55 +0300
Message-ID: <5743FC27.2000307@linux.intel.com>
References: <20160523114740.1f8cf29e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32288 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754110AbcEXHA7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 24 May 2016 03:00:59 -0400
In-Reply-To: <20160523114740.1f8cf29e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi

On 05/23/2016 12:47 PM, Jean Delvare wrote:
> Starting with the 8-Series/C220 PCH (Lynx Point), the SMBus
> controller includes a SPD EEPROM protection mechanism. Once the SPD
> Write Disable bit is set, only reads are allowed to slave addresses
> 0x50-0x57.
>
> However the legacy implementation of I2C Block Read since the ICH5
> looks like a write, and is therefore blocked by the SPD protection
> mechanism. This causes the eeprom and at24 drivers to fail.
>
> So assume that I2C Block Read is implemented as an actual read on
> these chipsets. I tested it on my Q87 chipset and it seems to work
> just fine.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---
> Jarkko, Mika, that's what I'm using on my machine now. It works, but
> obviously I'd prefer to have confirmation from Intel hardware people
> that this is the right thing to do before it goes upstream.
>
I haven't yet found the contact but search is on going.

-- 
Jarkko
