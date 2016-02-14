From: fetzerch <fetzer.ch@gmail.com>
Subject: Re: [PATCH 1/3] i2c-piix4: Support alternative port selection
 register
Date: Sun, 14 Feb 2016 09:39:39 +0100
Message-ID: <56C03D4B.6020107@googlemail.com>
References: <20160129104146.50f06562@endymion.delvare>
 <20160129104452.05e94c08@endymion.delvare> <20160212192720.GQ1520@katana>
 <20160213225147.26c64bbf@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36680 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbcBNIjt (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 14 Feb 2016 03:39:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id a4so5381184wme.3
        for <linux-i2c@vger.kernel.org>; Sun, 14 Feb 2016 00:39:49 -0800 (PST)
In-Reply-To: <20160213225147.26c64bbf@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>

Hi Jean,

On 13.02.2016 22:51, Jean Delvare wrote:
> Hi Wolfram,
> 
> On Fri, 12 Feb 2016 20:27:20 +0100, Wolfram Sang wrote:
>> On Fri, Jan 29, 2016 at 10:44:52AM +0100, Jean Delvare wrote:
>>> The SB800 register reference guide says that the SMBus port selection
>>> bits may not always be in register Smbus0En (0x2c) but could
>>> alternatively be found in register Smbus0Sel (0x2e) depending on the
>>> settings in register Smbus0SelEn (0x2f.) Add support for this
>>> configuration.
>>
>> Were you able to test both cases?
> 
> I don't have the hardware myself so I was not able to test any case.
> I was hoping Christian would test. This is the reason why I am logging
> which register is used, so that we know if the alternative setting is
> ever used. I found the potential problem by looking at the datasheet,
> it's not something that has been reported (yet.)
> 
> Meanwhile I have found a datasheet for device 780Bh (named Bolton FCH
> on AMD's web site, but Hudson2 in our driver) which suggest that the
> "alternative" setting is the only possible one on this chipset. The
> register used to figure out the setting is marked as reserved. If the
> register exists still and the relevant bit is set, then my patch should
> work. If not then a better patch will be needed.
> 
> I'll try to gain access to a system with a Bolton FCH and experiment
> with it.
> 
> Then there's the most recent device, codenamed "CZ", for which I have
> no information at all.
> 

sorry for the late response. This time it slipped through on my side.

The sensors command still works fine without any noticable change.
Here is the output:

[1894808.057493] piix4_smbus 0000:00:14.0: SMBus Host Controller at
0xb00, revision 0
[1894808.057504] piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus
port selection
[1894808.394960] i2c i2c-1: Found w83795adg rev. B at 0x2f
[1894808.666968] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host
Controller at 0xb20

Thanks,
Christian
