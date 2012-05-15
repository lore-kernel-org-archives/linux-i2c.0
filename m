From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH V4 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Tue, 15 May 2012 12:28:39 +0530
Message-ID: <4FB1FE9F.7030700@st.com>
References: <cover.1336124143.git.viresh.kumar@st.com> <3484bf49a423bd55daa6a45e68c2c31dce46eb32.1336124143.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3484bf49a423bd55daa6a45e68c2c31dce46eb32.1336124143.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org" <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ml.lawnick-Mmb7MZpHnFY@public.gmane.org" <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, "viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5/4/2012 3:10 PM, Viresh KUMAR wrote:
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
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
>  Documentation/i2c/bus-recovery |   87 ++++++++++++++++++++++
>  drivers/i2c/i2c-core.c         |  160 ++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/i2c-mux.c          |    9 ++-
>  include/linux/i2c.h            |   58 ++++++++++++++
>  4 files changed, 313 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/i2c/bus-recovery

Hi Wolfram,

Any inputs on this patch.

--
viresh
