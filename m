From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 hangs indefinitely on IBM x3550
Date: Fri, 1 Jul 2016 11:53:30 +0200
Message-ID: <20160701115330.1ff19621@endymion>
References: <alpine.SOC.1.00.1309241438110.29702@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56029 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbcGAJxd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 05:53:33 -0400
In-Reply-To: <alpine.SOC.1.00.1309241438110.29702@math.ut.ee>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Meelis,

Cleaning up my mailbox, I found that I never replied to this message.
First of all I would like to apologize for this.

On Tue, 24 Sep 2013 14:46:30 +0300 (EEST), Meelis Roos wrote:
> Tried latest Debian kernel (3.10-3-amd64) and latest upstream kernel 
> (3.12-rc2) on a decommisioned IBM x3550 server. i2c-i801 is autoloaded 
> but all access to it seems to wait forever, including stopping reboot 
> from happening because modprobe is still running and blocked on this.
> 
> 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus Controller (rev 09)
>         Subsystem: IBM Device 02dd
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
>         Interrupt: pin B routed to IRQ 20
>         Region 4: I/O ports at 0440 [size=32]
>         Kernel driver in use: i801_smbus
> 
> 
> [    3.028771] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
> [...]
> [  240.172009] INFO: task modprobe:267 blocked for more than 120 seconds.

Most likely SMBus interrupts do not work properly on this machine.
Since then a number of improvements have been committed to the i2c-i801
driver to detect and workaround corner cases in this area. If you still
have this machine, you may want to try to upgrade to kernel v3.19 or
later and see if it helps.

Alternatively the stand-alone driver at
  http://jdelvare.nerim.net/devel/lm-sensors/drivers/i2c-i801/
can be built for your current kernel.

-- 
Jean Delvare
SUSE L3 Support
