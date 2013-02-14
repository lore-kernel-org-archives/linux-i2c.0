From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Thu, 14 Feb 2013 13:40:49 -0800
Message-ID: <CAD=FV=UYEqreNbUAxHydmWH+66pOORMB_uFokivLitsavzTcsQ@mail.gmail.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
 <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
 <511C32B5.20600@wwwdotorg.org>
 <CAD=FV=X=BPQo245kAtPvNUgKjypOYnheYJWcBkq6AA19z99V0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=FV=X=BPQo245kAtPvNUgKjypOYnheYJWcBkq6AA19z99V0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, Feb 13, 2013 at 4:54 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>>> You should be able to replace all that with:
>>>>
>>>> module_platform_driver(&i2c_arbitrator_driver);
>>>
>>> Sigh.  Yeah, I had that.  ...but it ends up getting initted
>>> significantly later in the init process and that was uncovering bugs
>>> in other drivers where they weren't expressing their dependencies
>>> properly.  I was going to try to fix those bugs separately but it
>>> seemed to make some sense to prioritize this bus a little bit anyway
>>> by using subsys_initcall().  ...but maybe that's just wrong.
>>>
>>> Unless you think it's a bug or terrible form to use subsys_initcall()
>>> I'd rather leave that.  Is that OK?
>>
>> It's certainly a bug if it doesn't work correctly as
>> module_platform_driver(). It'll have to be fixed sometime.
>>
>> I don't think it's a big enough issue for me to object to the patch
>> providing it gets fixed sometime, but I've certainly seem other people
>> push back harder on using subsys_initcall for expressing dependencies;
>> it's not very extensible - what happens if there's another bug in some
>> other driver that requires an even earlier level of initcall?
>
> I don't like it either.  I'll give it a few hours tomorrow and
> hopefully I can track down the problem.  If I can't track it down or
> if I come up with a really good justification for why it's needed I'll
> leave it with subsys_initcall() unless someone gives me a big nak.

OK, so I dug into my problems here a little bit.  All of the problems
are with a private branch that includes stuff not fully upstream,
but...

The problem is that we've got a regulator (tps65090) on this bus.
Right now the first code that wants to use tps65090 runs from the
set_power() callback of "platform-lcd".  It looks like:
   lcd_fet = regulator_get(NULL, "lcd_vdd");

...and "platform-lcd" is instantiated really early via
platform_device_register() for some reason.

I tried to fix it by moving platform-lcd to actually be instantiated
via the device tree (with platform data populated through
of_platform_populate).  I then hooked up regulators through the device
tree:

    platform-lcd {
        compatible = "platform-lcd";
        vcd_led-supply = <&vcd_led>;
        lcd_vdd-supply = <&lcd_vdd>;
    };

...I verified that these worked (needed a small mod to tps65090) when
I used subsys_initcall().  AKA: I could rename lcd_vdd-supply to
doug-supply and then change the code to ask for doug-supply and it
worked so I know that the device tree regulator association worked.

...but when I moved to module_platform_driver() then things still broke.

[    1.510000] platform-lcd supply lcd_vdd not found, using dummy regulator

I was sorta hoping that there would be some magic where
regulator_get() would find the device tree node for the regulator and
then resolve the chain.  ...but maybe that's a pipe dream.


Is there some better way I should be expressing dependencies?  Do I
need to try to hack something together with -EAGAIN (ick!)?  I will
point out that the i2c bus that we're arbitrating on also registers
with subsys_initcall().


In any case, I've spent my few hours today.  It's not a waste of time
since the above learnings were good, but I haven't actually found a
way to avoid the subsys_initcall().  Unless someone can point to what
I'm missing, I'll send another patch up with subsys_initcall(),
hopefully by the end of the day...


Thanks for listening!

-Doug
