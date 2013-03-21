From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V10 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 21 Mar 2013 10:36:48 +0100
Message-ID: <20130321093648.GA19297@the-dreams.de>
References: <59a73d182bf1ce330becf32ad780f3501a57aed0.1359106966.git.viresh.kumar@linaro.org>
 <20130125111322.GA2649@pengutronix.de>
 <CAKohpok2arxhsAt3xOxRCZZjvLMTed1EYX3ZRUSQ3733wx2mMw@mail.gmail.com>
 <CAKohpokNVPOvAc=Gbxn4ZquPnG4huukDmwhOsqaV51p0aRo8xw@mail.gmail.com>
 <CAKohpokCqe7LHFMn0t7EivTQ7US9Fp=07nowGP2H2ujeDKbHXg@mail.gmail.com>
 <CAKohpondDBBjTQYgV9XOFMYp_aKO+SdeRR1gjxe1ovTLuOm2Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpondDBBjTQYgV9XOFMYp_aKO+SdeRR1gjxe1ovTLuOm2Wg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Viresh,

I applied V11 of the core changes with minor modifications. I do wonder
about the hook in the designware driver. You apply the recovery on
transfer timeout. I think this should go into the timeout of
i2c_dw_wait_bus_not_busy()?

Thanks,

   Wolfram
