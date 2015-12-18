From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v6] at24: Support SMBus read/write of 16-bit devices
Date: Fri, 18 Dec 2015 21:53:53 +0100
Message-ID: <20151218215353.4c342398@endymion.delvare>
References: <1914980865.104978.1447718293775.JavaMail.zimbra@xes-inc.com>
	<1637462042.105214.1447718539047.JavaMail.zimbra@xes-inc.com>
	<20151211131939.GC2742@katana>
	<1758302572.65470.1450468070959.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54280 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964980AbbLRUyE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 18 Dec 2015 15:54:04 -0500
In-Reply-To: <1758302572.65470.1450468070959.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>

On Fri, 18 Dec 2015 13:47:50 -0600 (CST), Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Wolfram Sang" <wsa@the-dreams.de>
> > Sent: Friday, December 11, 2015 7:19:40 AM
> >
> > I remember I had a lengthy discussion with Guenter Roeck about 16 bit
> > support via smbus. I don't have the bandwidth right now to recap the
> > discussion and check if the concerns apply to your implementation as
> > well. Could you check this thread
> > 
> > https://lkml.org/lkml/2015/2/4/436
> > 
> > and report back if it applies to your patch as well? This would speed up
> > the review significantly.
> 
> The real bus-level multi-master issue is still present. However, it is
> documented via comments in the driver and warnings in the Kconfig.
> 
> The other (and apparently bigger) issue of a single master experiencing
> corruption due to simultaneous access through i2c-dev and this driver
> appears to have been resolved. The i2cdump, i2cget, and i2cset utilities
> refuse to access any device that has a driver bound to it. My attempts
> to cause corruption using i2cdump were met with the following message
> until I unregistered the at24 driver from the device:
> 
>    # i2cdump 8 0x54
>    No size specified (using byte-data access)
>    Error: Could not set address to 0x54: Device or resource busy

You could always bypass the security check and force the access with
option -f. But then there are plenty of ways to corrupt any device that
way, regardless of the driver (or even without any driver bound to the
device, if you run multiple i2c-dev-based user-space tools in
parallel.) So I'd say this is not relevant.

-- 
Jean Delvare
SUSE L3 Support
