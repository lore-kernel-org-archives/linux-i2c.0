From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Tue, 24 Apr 2012 14:28:44 +0200
Message-ID: <20120424142844.752b1dac@endymion.delvare>
References: <cover.1330669025.git.viresh.kumar@st.com>
	<3d25a5406975dbab9d21bfe406e5f779480da17f.1330669025.git.viresh.kumar@st.com>
	<20120423125630.GG19192@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120423125630.GG19192-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 23 Apr 2012 14:56:31 +0200, Wolfram Sang wrote:
> On Fri, Mar 02, 2012 at 11:53:42AM +0530, Viresh Kumar wrote:
> > Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
> > protocol Rev. 03 section 3.16 titled "Bus clear".
> > 
> > http://www.nxp.com/documents/user_manual/UM10204.pdf
> > 
> > Sometimes during operation i2c bus hangs and we need to give dummy clocks to
> > slave device to start the transfer again. Now we may have capability in the bus
> > controller to generate these clocks or platform may have gpio pins which can be
> > toggled to generate dummy clocks. This patch supports both.
> > 
> > This patch also adds in generic bus recovery routines gpio or scl line based
> > which can be used by bus controller. In addition controller driver may provide
> > its own version of the bus recovery routine.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> 
> Finally, a review \o/
> 
> There are some comments regarding the code, but the most important thing
> is to get the interface right.
> 
> Jean, I don't think this is embedded only, so an additional view might
> be helpful here.

I'm afraid I won't have any time for this in a near future. If/when you
are happy with the code, feel free to merge it.

Thanks,
-- 
Jean Delvare
