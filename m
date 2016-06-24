From: Stefan Roese <sr@denx.de>
Subject: Re: i2c-i801 / SMBus timeouts on BayTrail board (U-Boot)
Date: Fri, 24 Jun 2016 16:33:42 +0200
Message-ID: <576D44C6.4030702@denx.de>
References: <576D2021.4030808@denx.de> <1466775522.8139.3.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:54808 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbcFXOdx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 24 Jun 2016 10:33:53 -0400
In-Reply-To: <1466775522.8139.3.camel@chaos.suse>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Chew, Kean ho" <kean.ho.chew@intel.com>

Hi Jean,

On 24.06.2016 15:38, Jean Delvare wrote:
> On ven., 2016-06-24 at 13:57 +0200, Stefan Roese wrote:
>> Hi,
>>
>> I'm currently trying to use the SMBus on a congatec BayTrail board.
>> This works just fine when booting via the original BIOS. But when I
>> boot into Linux using U-Boot as bootloader, I get the following
>> errors:
>>
>> [   81.877121] i801_smbus 0000:00:1f.3: Transaction timeout
>> [   81.879228] i801_smbus 0000:00:1f.3: Failed terminating the transaction
>> [   81.879320] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
>> [   81.879373] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
>> [   81.879421] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
>> [   81.879496] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
>> ...
>>
>> I checked with an oscilloscope and the SMBus clock is not toggling
>> at all in this case. My feeling is, that some basic setup is missing
>> in this non-BIOS case. Like some clock enabling. Does anyone of you
>> have some idea here?
>
> No immediate idea, sorry. Two ideas:
>
> * Is this problem specific to Baytrail systems, or does i2c-i801 fail on
> all U-Boot systems?

I only have BayTrail systems right now.

> * Did you try comparing the PCI configuration space of the SMBus device
> between original BIOS boot (working) and U-Boot boot (not working)?

The issue seems to be solved just a few minutes ago. As it seems
a pin-mux configuration was missing for the SMBus pins. Now the bus
can be scanned in Linux without any issues.

Thanks,
Stefan
