From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v5 0/3] Support multiplexed main SMBus interface on
 SB800
Date: Fri, 22 Jan 2016 13:50:40 +0100
Message-ID: <20160122135040.6db7b66b@endymion.delvare>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45613 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbcAVMuo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jan 2016 07:50:44 -0500
In-Reply-To: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>
Cc: linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

Hi Christian,

On Thu, 19 Nov 2015 20:13:46 +0100, Christian Fetzer wrote:
> This is an attempt to upstream the patches created by Thomas Brandon and
> Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
> chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757.html)
> 
> I have mainly rebased the latest patch version and tested the driver on a
> HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor data
> from a w83795adg).
> 
> The patched driver is running stable on the machine, given that ic2_piix4 is
> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
> sensors triggers some errors:
>     ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
> 
> While the kernel log shows:
>     i2c i2c-1: Transaction (pre): CNT=0c, CMD=05, ADD=31, DAT0=03, DAT1=c0
>     i2c i2c-1: Error: no response!
>     i2c i2c-1: Transaction (post): CNT=0c, CMD=05, ADD=31, DAT0=ff, DAT1=ff
> Unfortunately I don't know how to tackle this specific issue.

I think I can explain it. In piix4_setup_sb800() you touch the
SB800_PIIX4_SMB_IDX port without first taking the mutex that protects
it. You only take the mutex on transactions (in piix4_access_sb800) not
during initialization. If self-probing I2C device drivers such as jc42
are already loaded before you load i2c-piix4, then as soon as the first
SMBus port is registered, i2c-core will try to attach I2C devices to
it, while at the same time i2c-piix4 is registering the second SMBus
port. So SB800_PIIX4_SMB_IDX is changed while piix4_access_sb800
accesses it and chaos happens.

I think if we had proper locking in piix4_setup_sb800() then you should
be able to load jc42 first and then i2c-piix4 and it should work fine.

-- 
Jean Delvare
SUSE L3 Support
