From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] GPIO_SCH and I2C_SCH: select MFD_SUPPORT to eliminate
	kconfig warnings
Date: Wed, 15 Dec 2010 21:21:04 +0000
Message-ID: <20101215212104.GA20097@trinity.fluff.org>
References: <20101214162656.b8550c70.randy.dunlap@oracle.com> <20101215101541.5952780f@endymion.delvare> <4D0920DD.3080306@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D0920DD.3080306-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 15, 2010 at 12:11:09PM -0800, Randy Dunlap wrote:
> On 12/15/10 01:15, Jean Delvare wrote:
> > Hi Randy,
> > 
> > On Tue, 14 Dec 2010 16:26:56 -0800, Randy Dunlap wrote:
> >> From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> >>
> >> I2C_ISCH and GPIO_SCH need to select MFD_SUPPORT so that the
> >> dependency tree hierarchy is satisfied.  This eliminates the
> >> kconfig warning:
> >>
> >> warning: (I2C_ISCH && I2C && PCI || GPIO_SCH && GPIOLIB && PCI) selects LPC_SCH which has unmet direct dependencies (MFD_SUPPORT && PCI)
> >>

Hmm, it seems that MFD_SUPPORT enables MFD_CORE, and as such, I don't
think MFD_CORE can be selected without the MFD_SUPPORT.

My view would be to add MFD_NEEDED, or NEEDS_MFD which would force
the MFD_SUPPORT and MFD_CORE on in one go.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
