From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.38
Date: Thu, 13 Jan 2011 23:24:29 +0000
Message-ID: <20110113232428.GB13717@opensource.wolfsonmicro.com>
References: <20110110222145.31c40d8e@endymion.delvare>
 <20110111111758.GH6541@sirena.org.uk>
 <20110111122500.203c4ce4@endymion.delvare>
 <20110111112458.GA13429@opensource.wolfsonmicro.com>
 <20110113222258.128d6a13@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110113222258.128d6a13-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 13, 2011 at 10:22:58PM +0100, Jean Delvare wrote:

> So I've applied two patches from you. Please check in:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/

> that I picked the correct versions and confirm that nothing is missing.
> If everything looks OK to you, I'll send a pull request to Linus
> tomorrow.

Looks like that's everything, yes - the PM bits that the factoring out
patch depended on are already in Linus' tree.
