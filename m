From: Meelis Roos <mroos@linux.ee>
Subject: Re: i2c-i801 hangs indefinitely on IBM x3550
Date: Fri, 1 Jul 2016 16:24:50 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607011623040.12974@math.ut.ee>
References: <alpine.SOC.1.00.1309241438110.29702@math.ut.ee>  <20160701115330.1ff19621@endymion>  <alpine.LRH.2.20.1607011455120.12974@math.ut.ee> <1467378349.11332.5.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:56038 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbcGANXX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 09:23:23 -0400
In-Reply-To: <1467378349.11332.5.camel@chaos.suse>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

> > The machine is still alive and kicking with latest 4.7-rc4+. However, I 
> > do not remember the exact scenario  for testing.
> 
> Well originally you reported that the machine would hang when the
> i2c-i801 driver is loaded. I guess this is no longer the case?

Yes, that is no longer the case.

> > SO how do I see if os working? Nothing in dmesg, reboot works so seems 
> > OK?
> 
> Well, upon loading the i2c-i801 driver should say something about
> interrupt use. Either:
>   "SMBus using PCI interrupt"
> or:
>   "SMBus using polling"
> and possibly other relevant messages. Can you check your dmesg for these
> messages?

Yes, it is in dmesg:

i801_smbus 0000:00:1f.3: SMBus using PCI interrupt

And no errors.

So it seems to be working.

-- 
Meelis Roos (mroos@linux.ee)
