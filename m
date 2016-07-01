From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-i801 hangs indefinitely on IBM x3550
Date: Fri, 01 Jul 2016 15:30:06 +0200
Message-ID: <1467379806.11332.8.camel@chaos.suse>
References: <alpine.SOC.1.00.1309241438110.29702@math.ut.ee>
	  <20160701115330.1ff19621@endymion>
	  <alpine.LRH.2.20.1607011455120.12974@math.ut.ee>
	 <1467378349.11332.5.camel@chaos.suse>
	 <alpine.LRH.2.20.1607011623040.12974@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1607011623040.12974@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On ven., 2016-07-01 at 16:24 +0300, Meelis Roos wrote:
> > > The machine is still alive and kicking with latest 4.7-rc4+. However, I 
> > > do not remember the exact scenario  for testing.
> > 
> > Well originally you reported that the machine would hang when the
> > i2c-i801 driver is loaded. I guess this is no longer the case?
> 
> Yes, that is no longer the case.
> 
> > > SO how do I see if os working? Nothing in dmesg, reboot works so seems 
> > > OK?
> > 
> > Well, upon loading the i2c-i801 driver should say something about
> > interrupt use. Either:
> >   "SMBus using PCI interrupt"
> > or:
> >   "SMBus using polling"
> > and possibly other relevant messages. Can you check your dmesg for these
> > messages?
> 
> Yes, it is in dmesg:
> 
> i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> 
> And no errors.
> 
> So it seems to be working.

OK. So whatever the problem was, apparently it was fixed somehow.
Good :-)

-- 
Jean Delvare
SUSE L3 Support
