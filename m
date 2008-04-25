From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support.
Date: Thu, 24 Apr 2008 23:12:07 -0700
Message-ID: <20080424231207.11a03f3d.akpm@linux-foundation.org>
References: <20080325063236.GA29012@linux-sh.org>
	<20080423134156.1b368163@hyperion.delvare>
	<20080423181101.GA2931@roarinelk.homelinux.net>
	<20080423203104.0ca0f301@hyperion.delvare>
	<20080425013011.GA27359@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080425013011.GA27359@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: khali@linux-fr.org, mano@roarinelk.homelinux.net, i2c@lm-sensors.org, linux-sh@vger.kernel.org, damm@igel.co.jp
List-Id: linux-i2c@vger.kernel.org

> On Fri, 25 Apr 2008 10:30:11 +0900 Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Apr 23, 2008 at 08:31:04PM +0200, Jean Delvare wrote:
> > On Wed, 23 Apr 2008 20:11:01 +0200, Manuel Lauss wrote:
> > > On Wed, Apr 23, 2008 at 01:41:56PM +0200, Jean Delvare wrote:
> > > > On Tue, 25 Mar 2008 15:32:36 +0900, Paul Mundt wrote:
> > > > > This adds support for the SMBus adapter found in the various FPGAs on
> > > > > the Renesas Highlander platforms. Particularly the R0P7780LC0011RL and
> > > > > R0P7785LC0011RL FPGAs.
> > > > > 
> > > > > Functionality is fairly restricted, in that only byte and block data
> > > > > transfers are supported. Normal/fast mode and IRQ/polling are also
> > > > > supported. Primarily used for various RTCs and thermal sensors.
> > > > > 
> > > > > Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> > > > 
> > > > No volunteer to review this driver? Manuel or Magnus maybe?
> > > 
> > > I don't think I'm qualified to review other peoples' code (it looks
> > > fine to me).

I looked through it when I merged it - believe it or not, I always do
(well, except for some dopey mechanical code transformation patches where
I'll just believe the changelog).  I saw nothing worth commenting on.  As
is always the case when I don't comment ;)

So here's a
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

Although that is of course of limited use, coming from a person
who isn't terribly sure what an i2c is.
