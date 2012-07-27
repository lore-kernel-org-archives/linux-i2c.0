From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 27 Jul 2012 20:09:02 +0530
Message-ID: <CAM=Q2cu-YWBQxjL9GBuwDWMuunZ1=bJTj-tyXOWPYPY_NQ1pqw@mail.gmail.com>
References: <cover.1336124143.git.viresh.kumar@st.com>
	<3484bf49a423bd55daa6a45e68c2c31dce46eb32.1336124143.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3484bf49a423bd55daa6a45e68c2c31dce46eb32.1336124143.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Viresh ,
On Fri, May 4, 2012 at 3:10 PM, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
> protocol Rev. 03 section 3.16 titled "Bus clear".
>
> http://www.nxp.com/documents/user_manual/UM10204.pdf
>
> Sometimes during operation i2c bus hangs and we need to give dummy clocks to
> slave device to start the transfer again. Now we may have capability in the bus
> controller to generate these clocks or platform may have gpio pins which can be
> toggled to generate dummy clocks. This patch supports both.
>
> This patch also adds in generic bus recovery routines gpio or scl line based
> which can be used by bus controller. In addition controller driver may provide
> its own version of the bus recovery routine.
>
A few suggestions.

1. Bus recovery should ideally handle both SCL and SDA stuck a 0
   conditions. This only appears to handle SDA. For SCL stuck at 0 we
   need to reset the slave if possible. So maybe there needs to be the
   ability to register a slave reset handler (if this does not exist).
2. Following on from #1, there should be the ability to query the state
   of SCL and SDA if the controller supports this. For example, on OMAP
   we can query whether SCL or SDA are stuck low when the timeout
   occurs. Then based upon whether SCL or SDA are stuck, we either try
   the appropriate bus recovery. If there is no mechanism to query SCL
   or SDA, then we need to decide on the appropriate behaviour. For
   example, should we try the workaround for SDA stuck first as it is
   less severe and if that fails try the SCL workaround if a reset
   handler is registered to reset the device.

. What do we do if the recovery does not work after N attempts? Is
   this handled? If not after a certain number of failures it may be
   necessary to unregister the slave.Or if the slave supports reset
can we contemplate or if it is powered by gpio can we reset it.

What do you think
