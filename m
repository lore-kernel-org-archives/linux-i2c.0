From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Wed, 13 Feb 2013 17:41:25 -0700
Message-ID: <511C32B5.20600@wwwdotorg.org>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
 <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <peter.>
List-Id: linux-i2c@vger.kernel.org

On 02/13/2013 05:34 PM, Doug Anderson wrote:
> On Wed, Feb 13, 2013 at 1:02 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 02/13/2013 11:02 AM, Doug Anderson wrote:
>>> The i2c-arbitrator driver implements the arbitration scheme that the
>>> Embedded Controller (EC) on the ARM Chromebook expects to use for bus
>>> multimastering.  This i2c-arbitrator driver could also be used in
>>> other places where standard i2c bus arbitration can't be used and two
>>> extra GPIOs are available for arbitration.
>>>
>>> This driver is based on code that Simon Glass added to the i2c-s3c2410
>>> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
>>> mux driver is as suggested by Grant Likely.  See
>>> <https://patchwork.kernel.org/patch/1877311/> for some history.
>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt b/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt
...
>>> +Required properties:
>>> +- compatible: i2c-arbitrator
>>
>> That seems pretty generic. What if there are other arbitration schemes?
> 
> OK, going to go with i2c-arbitrator-cros-ec.  Hopefully that sounds OK.

That seems fine. The mechanism seems potentially a little more generic
than just for cros-ec though, but I guess there's no harm naming it
after the first implementation. That why "compatible" allows multiple
entries anyway.

>>> +static int i2c_arbitrator_select(struct i2c_adapter *adap, void *data, u32 chan)
>>> +{
>>> +     const struct i2c_arbitrator_data *arb = data;
>>> +     unsigned long stop_retry, stop_time;
>>> +
>>> +     /* Start a round of trying to claim the bus */
>>> +     stop_time = jiffies + usecs_to_jiffies(arb->wait_free_us) + 1;
>>> +     do {
>>> +             /* Indicate that we want to claim the bus */
>>> +             gpio_set_value(arb->ap_gpio, 0);
>>
>> The GPIO signals appear to be active low in the code. Instead, I think
>> it'd make more sense to extract the polarity of the GPIO from DT, using
>> of_get_named_gpio_flags().
> 
> A little torn here.  It adds a bunch of complexity to the code to
> handle this case and there are no known or anticipated users.  I only
> wish that the GPIO polarity could be more hidden from drivers (add
> functions like gpio_assert, gpio_deassert, etc)...

Yes, that would be nice. Alex, LinusW?

> In any case, I've done it.  I used the "!!" trick a lot to convert
> "zero/non-zero" to "0/1" to at least reduce the lines of code a
> little.  I think this is common enough that it helps readability
> rather than hurting it.

>>> +static int __init i2c_arbitrator_init(void)
>>> +{
>>> +     return platform_driver_register(&i2c_arbitrator_driver);
>>> +}
>>> +subsys_initcall(i2c_arbitrator_init);
>>> +
>>> +static void __exit i2c_arbitrator_exit(void)
>>> +{
>>> +     platform_driver_unregister(&i2c_arbitrator_driver);
>>> +}
>>> +module_exit(i2c_arbitrator_exit);
>>
>> You should be able to replace all that with:
>>
>> module_platform_driver(&i2c_arbitrator_driver);
> 
> Sigh.  Yeah, I had that.  ...but it ends up getting initted
> significantly later in the init process and that was uncovering bugs
> in other drivers where they weren't expressing their dependencies
> properly.  I was going to try to fix those bugs separately but it
> seemed to make some sense to prioritize this bus a little bit anyway
> by using subsys_initcall().  ...but maybe that's just wrong.
> 
> Unless you think it's a bug or terrible form to use subsys_initcall()
> I'd rather leave that.  Is that OK?

It's certainly a bug if it doesn't work correctly as
module_platform_driver(). It'll have to be fixed sometime.

I don't think it's a big enough issue for me to object to the patch
providing it gets fixed sometime, but I've certainly seem other people
push back harder on using subsys_initcall for expressing dependencies;
it's not very extensible - what happens if there's another bug in some
other driver that requires an even earlier level of initcall?
