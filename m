From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: remove HAVE_CLK build dependecy
Date: Mon, 13 Jan 2014 14:18:06 +0200
Message-ID: <20140113121806.GO4944@tarshish>
References: <f3ebead75d45623e4b649c7a8d0112584ffd1788.1388392279.git.baruch@tkos.co.il>
 <20140104224846.GH3150@katana>
 <20140105050410.GA5316@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140105050410.GA5316@tarshish>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Ping?

On Sun, Jan 05, 2014 at 07:04:10AM +0200, Baruch Siach wrote:
> On Sat, Jan 04, 2014 at 11:48:46PM +0100, Wolfram Sang wrote:
> > On Mon, Dec 30, 2013 at 10:31:19AM +0200, Baruch Siach wrote:
> > > Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h need
> > > not depend on HAVE_CLK. Also, remove a redundant clk.h include from core driver
> > > file.
> > > 
> > > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > 
> > Is the patch description correct? The core driver simply does not need
> > clk.h and thus the dependency. No redundancy here, or?
> 
> The platform code (i2c-designware-platform.c) uses the clk API, but the 
> Kconfig dependency on HAVE_CLK is not needed anymore. The core code 
> (i2c-designware-core.c) doesn't use clk. Originally the driver was in a single 
> file, including the clk handling. This code has been moved to the platform 
> file, so the core file doesn't need the clk.h include.
> 
> Logically, these are two separate issues. But I'm not sure it is worth 
> splitting into two patches. What do you think?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
