From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.38
Date: Thu, 13 Jan 2011 22:22:58 +0100
Message-ID: <20110113222258.128d6a13@endymion.delvare>
References: <20110110222145.31c40d8e@endymion.delvare>
	<20110111111758.GH6541@sirena.org.uk>
	<20110111122500.203c4ce4@endymion.delvare>
	<20110111112458.GA13429@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110111112458.GA13429-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 11 Jan 2011 11:24:59 +0000, Mark Brown wrote:
> On Tue, Jan 11, 2011 at 12:25:00PM +0100, Jean Delvare wrote:
> 
> > Thanks for the reminder, I'll look into that as soon as possible and
> > when the patches are ready, I'll send another pull request to Linus.
> 
> Excellent, thanks - I was worried it might've got lost since you were on
> vacation during pretty much all of the discussion.

Correct, but I trust that you and Rafael got things right. I don't know
much about power management anyway.

So I've applied two patches from you. Please check in:
  ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
that I picked the correct versions and confirm that nothing is missing.
If everything looks OK to you, I'll send a pull request to Linus
tomorrow.

-- 
Jean Delvare
