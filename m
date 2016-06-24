From: Jean Delvare <jdelvare@suse.com>
Subject: Re: i2c-i801 / SMBus timeouts on BayTrail board (U-Boot)
Date: Fri, 24 Jun 2016 15:38:42 +0200
Message-ID: <1466775522.8139.3.camel@chaos.suse>
References: <576D2021.4030808@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44955 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbcFXNiz (ORCPT
	<rfc822;groupwise-linux-i2c@vger.kernel.org:0:0>);
	Fri, 24 Jun 2016 09:38:55 -0400
In-Reply-To: <576D2021.4030808@denx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Chew, Kean ho" <kean.ho.chew@intel.com>

Hi Stefan,

On ven., 2016-06-24 at 13:57 +0200, Stefan Roese wrote:
> Hi,
> 
> I'm currently trying to use the SMBus on a congatec BayTrail board.
> This works just fine when booting via the original BIOS. But when I
> boot into Linux using U-Boot as bootloader, I get the following
> errors:
> 
> [   81.877121] i801_smbus 0000:00:1f.3: Transaction timeout
> [   81.879228] i801_smbus 0000:00:1f.3: Failed terminating the transaction
> [   81.879320] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
> [   81.879373] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
> [   81.879421] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
> [   81.879496] i801_smbus 0000:00:1f.3: SMBus is busy, can't use it!
> ...
> 
> I checked with an oscilloscope and the SMBus clock is not toggling
> at all in this case. My feeling is, that some basic setup is missing
> in this non-BIOS case. Like some clock enabling. Does anyone of you
> have some idea here?

No immediate idea, sorry. Two ideas:

* Is this problem specific to Baytrail systems, or does i2c-i801 fail on
all U-Boot systems?

* Did you try comparing the PCI configuration space of the SMBus device
between original BIOS boot (working) and U-Boot boot (not working)?

-- 
Jean Delvare
SUSE L3 Support
