From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: HMC6343
Date: Tue, 7 Jul 2009 14:20:06 +0200
Message-ID: <20090707142006.2c998ba7@hyperion.delvare>
References: <23114.97301.qm@web28307.mail.ukl.yahoo.com>
	<20090707095934.7b86524f@hyperion.delvare>
	<4A5333C6.3080802@cam.ac.uk>
	<20090707134638.6ff1b324@hyperion.delvare>
	<4A53375B.9070304@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A53375B.9070304-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Hugo Meric <hugo.meric-Qt13gs6zZMY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 07 Jul 2009 11:54:03 +0000, Jonathan Cameron wrote:
> Jean Delvare wrote:
> > Note: this could be done from userspace too if needed. The i2c-dev
> > interface supports raw reads and writes.
> > 
> Good point, I'd missed that functionality (did seem a little odd
> that I couldn't find it!)
> 
> Method's much the same, but involves using the relevant ioctl
> (I2C_RDWR), in conjunction iwth an appropriately filled
> i2c_rdwr_ioctl_data structure.
> 
> The i2c_smbus_access function in i2c-dev.h (lm-sensors version)
> is similar enough to show how to do it.

Actually: i2c-tools version of i2c-dev.h

As some point in the future I'll try to get it generated from the
kernel's one so that it gets integrated into the standard
kernel-headers package. But this involves moving some of the helper
functions to a new library and I could never find the time to set this
up.

-- 
Jean Delvare
