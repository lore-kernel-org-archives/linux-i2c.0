From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 4 Oct 2012 09:59:33 +0530
Message-ID: <CAKohponLRTksWZ=Nq5yZsy8VgZews7NtzjXqL=bAdfDg+0O_LA@mail.gmail.com>
References: <viresh.kumar@linaro.org>
	<d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 28 September 2012 16:58, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in the i2c
> protocol Rev. 03 section 3.1.16 titled "Bus clear".
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
> This doesn't support multi-master recovery for now.

Hi Uwe,

If you have gone through V5 and have no noticeable issues with it, can it have a
reviewed-by: from you?

--
viresh
