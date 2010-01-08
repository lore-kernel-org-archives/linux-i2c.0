From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] pca953x: Minor include cleanup
Date: Fri, 8 Jan 2010 15:34:15 -0600
Message-ID: <20100108213415.GA23113@lixom.net>
References: <20100105201042.GA28367@lixom.net> <20100105202158.GB4848@pengutronix.de> <20100106121722.6e2598ec@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100106121722.6e2598ec-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 06, 2010 at 12:17:22PM +0100, Jean Delvare wrote:
> On Tue, 5 Jan 2010 21:21:58 +0100, Wolfram Sang wrote:
> > On Tue, Jan 05, 2010 at 02:10:42PM -0600, Olof Johansson wrote:
> > > linux/i2c/pca953x.h is a very bare include file. Fix check for multiple
> > > includes of linux/i2c/pca953x.h, and add dependent includes into the
> > > header file.
> > > 
> > > Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > 
> > Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> And also
> 
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> Note though that this file is not part of the i2c subsystem. Your patch
> is something for the gpio people.

Boggle. No GPIO maintianer (nor list) mentioned in MAINTAINERS. I
don't see any common merge paths in the git log of drivers/gpio either,
besides akpm.

So I guess I'll ask him to pick it up.

Andrew: Want a fresh copy of the patch?


-Olof
