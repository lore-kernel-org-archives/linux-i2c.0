From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Wed, 13 Feb 2013 16:34:55 -0800
Message-ID: <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <511BFF77.2090202-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj Kumar <yuv>
List-Id: linux-i2c@vger.kernel.org

Stephen,

Thank you for the review.  Comments below (including changes I have
done locally).  I probably won't have time to test / repost until
tomorrow.


On Wed, Feb 13, 2013 at 1:02 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 02/13/2013 11:02 AM, Doug Anderson wrote:
>> The i2c-arbitrator driver implements the arbitration scheme that the
>> Embedded Controller (EC) on the ARM Chromebook expects to use for bus
>> multimastering.  This i2c-arbitrator driver could also be used in
>> other places where standard i2c bus arbitration can't be used and two
>> extra GPIOs are available for arbitration.
>>
>> This driver is based on code that Simon Glass added to the i2c-s3c2410
>> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
>> mux driver is as suggested by Grant Likely.  See
>> <https://patchwork.kernel.org/patch/1877311/> for some history.
>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt b/Documentation/devicetree/bindings/i2c/i2c-arbitrator.txt
>
>> +This mechanism is used instead of standard i2c multimaster to avoid some of the
>> +subtle driver and silicon bugs that are often present with i2c multimaster.
>
> Being really pick here, but I2C should be capitalized in free-form text.
> There are a few other places where the comment applies.

Done.


>> +Required properties:
>> +- compatible: i2c-arbitrator
>
> That seems pretty generic. What if there are other arbitration schemes?

OK, going to go with i2c-arbitrator-cros-ec.  Hopefully that sounds OK.


>> +- bus-arbitration-gpios: Two GPIOs to use with the GPIO-based bus
>> +    arbitration protocol.  The first should be an output, and is used to
>> +    claim the I2C bus for us (AP_CLAIM).  The second should be an input and
>> +    signals that the other side wants to claim the bus (EC_CLAIM).
>
> Is it worth using two separate properties here, so they each get a
> unique name. That way, nobody has the remember which order the two GPIOs
> come in.

Yes, I think it's better too.  Done.


>> diff --git a/drivers/i2c/muxes/i2c-arbitrator.c b/drivers/i2c/muxes/i2c-arbitrator.c
>
>> +enum {
>> +     I2C_ARB_GPIO_AP,                /* AP claims i2c bus */
>> +     I2C_ARB_GPIO_EC,                /* EC claims i2c bus */
>> +
>> +     I2C_ARB_GPIO_COUNT,
>> +};
>
> Oh, I see from later code that those are indices into the
> bus-arbitration-gpios DT property. I thought they were states in some
> state machine at first. A comment might help here, if you continue to
> use one property.

Removed this bit of code.


>> +static int i2c_arbitrator_select(struct i2c_adapter *adap, void *data, u32 chan)
>> +{
>> +     const struct i2c_arbitrator_data *arb = data;
>> +     unsigned long stop_retry, stop_time;
>> +
>> +     /* Start a round of trying to claim the bus */
>> +     stop_time = jiffies + usecs_to_jiffies(arb->wait_free_us) + 1;
>> +     do {
>> +             /* Indicate that we want to claim the bus */
>> +             gpio_set_value(arb->ap_gpio, 0);
>
> The GPIO signals appear to be active low in the code. Instead, I think
> it'd make more sense to extract the polarity of the GPIO from DT, using
> of_get_named_gpio_flags().

A little torn here.  It adds a bunch of complexity to the code to
handle this case and there are no known or anticipated users.  I only
wish that the GPIO polarity could be more hidden from drivers (add
functions like gpio_assert, gpio_deassert, etc)...

In any case, I've done it.  I used the "!!" trick a lot to convert
"zero/non-zero" to "0/1" to at least reduce the lines of code a
little.  I think this is common enough that it helps readability
rather than hurting it.


>> +static int i2c_arbitrator_probe(struct platform_device *pdev)
>
>> +     /* Request GPIOs */
>> +     ret = of_get_named_gpio(np, "bus-arbitration-gpios", I2C_ARB_GPIO_AP);
>> +     if (gpio_is_valid(ret)) {
>> +             arb->ap_gpio = ret;
>> +             ret = gpio_request_one(arb->ap_gpio, GPIOF_OUT_INIT_HIGH,
>> +                                    "bus-arbitration-ap");
>> +     }
>> +     if (WARN_ON(ret))
>> +             goto ap_request_failed;
>
> you could use devm_gpio_request_one() and save some cleanup logic.

Whoops, didn't realize that was there.  Done.


>> +     /* Arbitration parameters */
>> +     if (of_property_read_u32(np, "bus-arbitration-slew-delay-us",
>> +                              &arb->slew_delay_us))
>> +             arb->slew_delay_us = 10;
>
> The DT binding document says that property is required. Either the code
> should error out here, or the document updated to indicate that the
> properties are optional, and specify what the defaults are.

Done.  Now optional.


>> +static int i2c_arbitrator_remove(struct platform_device *pdev)
>
>> +     platform_set_drvdata(pdev, NULL);
>
> You shouldn't have to do that; nothing should care what the pdata value
> is while the device isn't probed anyway.

Done.  Code was stolen from i2c_mux_gpio_remove(), so perhaps we
should remove it there too.  I'll send up a quick cleanup patch
tomorrow.


>> +static int __init i2c_arbitrator_init(void)
>> +{
>> +     return platform_driver_register(&i2c_arbitrator_driver);
>> +}
>> +subsys_initcall(i2c_arbitrator_init);
>> +
>> +static void __exit i2c_arbitrator_exit(void)
>> +{
>> +     platform_driver_unregister(&i2c_arbitrator_driver);
>> +}
>> +module_exit(i2c_arbitrator_exit);
>
> You should be able to replace all that with:
>
> module_platform_driver(&i2c_arbitrator_driver);

Sigh.  Yeah, I had that.  ...but it ends up getting initted
significantly later in the init process and that was uncovering bugs
in other drivers where they weren't expressing their dependencies
properly.  I was going to try to fix those bugs separately but it
seemed to make some sense to prioritize this bus a little bit anyway
by using subsys_initcall().  ...but maybe that's just wrong.

Unless you think it's a bug or terrible form to use subsys_initcall()
I'd rather leave that.  Is that OK?


>> +MODULE_LICENSE("GPL");
>
> The header says GPL v2 only, so "GPL v2".

Done.
