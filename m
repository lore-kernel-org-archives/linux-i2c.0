From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Tue, 26 Apr 2016 08:42:42 +0200
Message-ID: <20160426064242.GC5758@hardcore>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-4-git-send-email-jglauber@cavium.com>
 <20160425221621.GI1550@katana>
 <20160426055845.GB5758@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1on0059.outbound.protection.outlook.com ([157.56.110.59]:8547
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751221AbcDZGm7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 02:42:59 -0400
Content-Disposition: inline
In-Reply-To: <20160426055845.GB5758@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

On Tue, Apr 26, 2016 at 07:58:45AM +0200, Jan Glauber wrote:
> On Tue, Apr 26, 2016 at 12:16:22AM +0200, Wolfram Sang wrote:
> > On Mon, Apr 25, 2016 at 04:33:32PM +0200, Jan Glauber wrote:
> > > SMBUS QUICK never worked for the read case, because EINVAL was returned
> > > for a zero length message. The hardware does not support SMBUS QUICK
> > > messages so disable the support and remove the zero length check.
> > > 
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > 
> > I see better now and I think we need to drop this patch. It looks like
> > the driver supports only SMBUS_QUICK_WRITE which can be used for
> > scanning devices. The driver probably works with 'i2cdetect -q'. This
> > will regress if I apply the patch.
> > 
> > It seems it can't do SMBUS_QUICK_READ thus the extra check in the code.
> > 
> > I2C_FUNC_SMBUS_QUICK should have been split up in READ and WRITE to
> > support this scenario.
> > 
> > Are my assumptions correct?
> 
> Yes, I thought briefly about splitting SMBUS_QUICK into read-write
> variants too. To me the question is if this feature is still used on modern
> devices or if this is more a relict of the past. I don't know enough
> about SMBUS to answer that.
> 
> Also, the ThunderX documentation does not mention that it is supported.
> The read case would be forbidden by the documentation (that was probably
> the reason for adding the read EINVAL). The write case is kind of a grey
> area, it might or might not work.
> 
> I'll see what i2cdetect does.

Checking on ThunderX:

[root@localhost linux-aarch64]# i2cdetect -q 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0 using quick write commands.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f 
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f 
40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 
50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f 
60: 60 61 62 63 64 65 66 67 UU 69 6a 6b 6c 6d 6e 6f 
70: 70 71 72 73 74 75 76 77 

Address 68 is the only device (rtc clock, module loaded).

Do all these other numbers make sense (although there are no
devices)?

--Jan
