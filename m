From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Thu, 14 Feb 2013 17:14:35 -0800
Message-ID: <CAD=FV=USf_YSzW1ZN2NWZKnLk_LPpnFpxRy=AGVyn_YHjRpKyw@mail.gmail.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
 <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
 <511C32B5.20600@wwwdotorg.org>
 <CAD=FV=X=BPQo245kAtPvNUgKjypOYnheYJWcBkq6AA19z99V0w@mail.gmail.com>
 <CAD=FV=UYEqreNbUAxHydmWH+66pOORMB_uFokivLitsavzTcsQ@mail.gmail.com>
 <511D74DD.9070600@wwwdotorg.org>
 <CAD=FV=Uri9O=iuuUKB9nPKW+6C+A_WsqW0sXB2nS5i7+=NtFKA@mail.gmail.com>
 <511D7E5D.1030003@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <511D7E5D.1030003-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard>
List-Id: linux-i2c@vger.kernel.org

Stephen,

On Thu, Feb 14, 2013 at 4:16 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> We can avoid that logic with has_full_constraints.  That will be some
>> work to get done but also should be done at some point in time.  Once
>> we use has_full_constraints we'll get ERR_PTR(-EPROBE_DEFER);
>
> That flag is normally set automatically:
>
> static int __init regulator_init_complete(void)
> ...
>         /*
>          * Since DT doesn't provide an idiomatic mechanism for
>          * enabling full constraints and since it's much more natural
>          * with DT to provide them just assume that a DT enabled
>          * system has full constraints.
>          */
>         if (of_have_populated_dt())
>                 has_full_constraints = true;
>
> Is of_have_populated_dt() not returning true for you? Perhaps when using
> the initcall, your regulator_get()s are happening before
> regulator_init_complete() gets called, which is the source of the problem?

The regulator_get() calls are before regulator_init_complete() by
quite a margin.  The regulator_init_complete() is a late_initcall, so
that's not too surprising.  Are we not supposed to access regulators
until after late_init()?  That seems like quite a limitation...


Note: I did send up a v2 of the patch series that you probably saw.
It still uses subsys_initcall().  I can easily send up a v3 if you
would like.  Worst case I can carry a local patch to hack the
arbitrator driver to use subsys_initcall() until we fix everything
else.


One other argument for using subsys_initcall(), though.  Using
module_platform_driver() means that we end up going through
device_initcall().  I would argue that since we're providing a bus
we're much more of a "subsystem" than a "device".  ...or is that a BS
argument?

Certainly if you end up building this code as a module then it'll get
called late anyway, but hopefully you wouldn't do that on a system
that had really critical components on the provided bus?


Let me know if you're happy with v2 or if you'd like me to make a rev.
 Thanks!  :)

-Doug
