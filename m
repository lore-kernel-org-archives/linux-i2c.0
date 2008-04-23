From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support.
Date: Wed, 23 Apr 2008 20:11:01 +0200
Message-ID: <20080423181101.GA2931@roarinelk.homelinux.net>
References: <20080325063236.GA29012@linux-sh.org> <20080423134156.1b368163@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080423134156.1b368163@hyperion.delvare>
Sender: linux-sh-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Paul Mundt <lethal@linux-sh.org>, i2c@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Magnus Damm <damm@igel.co.jp>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Wed, Apr 23, 2008 at 01:41:56PM +0200, Jean Delvare wrote:
> On Tue, 25 Mar 2008 15:32:36 +0900, Paul Mundt wrote:
> > This adds support for the SMBus adapter found in the various FPGAs on
> > the Renesas Highlander platforms. Particularly the R0P7780LC0011RL and
> > R0P7785LC0011RL FPGAs.
> > 
> > Functionality is fairly restricted, in that only byte and block data
> > transfers are supported. Normal/fast mode and IRQ/polling are also
> > supported. Primarily used for various RTCs and thermal sensors.
> > 
> > Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> No volunteer to review this driver? Manuel or Magnus maybe?

I don't think I'm qualified to review other peoples' code (it looks
fine to me).  The other thing is Renesas demoboards are impossible to
get outside of Japan so I think Paul is the only user of this hardware
who is also interested in linux support. And I'm convinced he knows
what he's doing ;-)

Thanks,
	Manuel Lauss
