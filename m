From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Fri, 15 Feb 2013 09:25:54 -0800
Message-ID: <CAD=FV=W9WwSsid_KqtDRmAkFXnneRXu5zcakDB3t4hLhOpuCtw@mail.gmail.com>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
 <511E64C0.9090500@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <511E64C0.9090500-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <peter.ko>
List-Id: linux-i2c@vger.kernel.org

Stephen,

New version will come shortly with fixes below...


On Fri, Feb 15, 2013 at 8:39 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 02/14/2013 05:21 PM, Doug Anderson wrote:
>> The i2c-arbitrator-cros-ec driver implements the arbitration scheme
>> that the Embedded Controller (EC) on the ARM Chromebook expects to use
>> for bus multimastering.  This i2c-arbitrator-cros-ec driver could also
>> be used in other places where standard I2C bus arbitration can't be
>> used and two extra GPIOs are available for arbitration.
>>
>> This driver is based on code that Simon Glass added to the i2c-s3c2410
>> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
>> mux driver is as suggested by Grant Likely.  See
>> <https://patchwork.kernel.org/patch/1877311/> for some history.
>
>> diff --git a/drivers/i2c/muxes/i2c-arbitrator-cros-ec.c b/drivers/i2c/muxes/i2c-arbitrator-cros-ec.c
>
>> +static int i2c_arbitrator_probe(struct platform_device *pdev)
>
>> +     arb->parent = of_find_i2c_adapter_by_node(parent_np);
>> +     if (WARN_ON(!arb->parent))
>> +             return -EINVAL;
>
> I think for all error paths after this point, a call to
> i2c_put_adapter() is needed.

Right.  I messed that up when I reworked.  I'll reorder this one to
last since it's the only one that needs cleanup.  Thanks for catching!


>> +     /* Request GPIOs */
>> +     ret = of_get_named_gpio_flags(np, "ap-claim-gpio", 0, &gpio_flags);
>> +     if (WARN_ON(!gpio_is_valid(ret)))
>> +             return ret;
>
> You shouldn't warn in all cases; -EPROBE_DEFER can quite legitimately
> happen and only temporarily prevents probe() - it's retried later.

Done.


>> +     arb->ap_gpio = ret;
>
> Nit: Perhaps simply assign arb->ap_gpio directly from the
> of_get_named_gpio_flags call? It would make that call slightly clearer.

With the addition of checks for -EPROBE_DEFER this causes several line
wraps including the "if" test so not doing.


>> +     arb->ap_gpio_release = !!(gpio_flags & OF_GPIO_ACTIVE_LOW);
>> +     out_init = (gpio_flags & OF_GPIO_ACTIVE_LOW) ?
>> +             GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
>
> Nit: I'd be tempted to test arb->ap_gpio_release here, rather than
> extracting the value from the flags again. Semantically equivalent, but
> it seems to slightly more directly show why it's being tested.

I wrote it both ways and decided I liked this way better.  IMHO the
symmetry between the ec_gpio_release code and the ap_gpio_release code
is worth the extra test.  ...but I can see both sides of the argument
so will change it if you wish.


>> +subsys_initcall(i2c_arbitrator_init);
>
> You mentioned that you only saw problems using
> module_init/module_platform_driver in your downstream tree, so the
> problem doesn't affect upstream. Presumably those problems would be
> fixed when upstreaming any other drivers into the mainline kernel. I'd
> still be tempted to just use module_platform_driver here. But, I guess
> I'm fine with the patch either way; I'll leave the call to Wolfram.

I take it you thought my "since this provides a bus it should be a
subsystem" argument was BS?  It seems like the "it needs to be this
way for correctness" is a pretty weak argument, but even if we fix the
other problems it still seems like it is more ideal for bus providers
to be registered as subsystems just to avoid defers (so you get a
faster boot).

If it will make the patch more palatable I'll move it to
module_platform_driver() and we'll figure out how to make it work.


-Doug
