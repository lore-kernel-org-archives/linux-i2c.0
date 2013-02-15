From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Active low GPIOs (was [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator
 'mux' driver)
Date: Fri, 15 Feb 2013 01:02:22 +0100
Message-ID: <CACRpkdY5dK==DEZjWvxVFLrP0Q8iOk-8RqozD3BA9cybxr2YLA@mail.gmail.com>
References: <CAD=FV=W7tBOHzwayT5kgtCGmvvGs8RoX7J3rTf2vHT69b4aj6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=FV=W7tBOHzwayT5kgtCGmvvGs8RoX7J3rTf2vHT69b4aj6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang@pengutr>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 14, 2013 at 6:05 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Linus,

>> But changing it would have very drastic effects.
>> Consider this snippet from
>> arch/arm/boot/dts/snowball.dts:
>>
>> // External Micro SD slot
>> sdi0_per1@80126000 {
>>       arm,primecell-periphid = <0x10480180>;
>>       max-frequency = <50000000>;
>>       bus-width = <4>;
>>       mmc-cap-mmc-highspeed;
>>       vmmc-supply = <&ab8500_ldo_aux3_reg>;
>>
>>       cd-gpios  = <&gpio6 26 0x4>; // 218
>>       cd-inverted;
>
> We're actually kinda screwed today.  What happens if you're on a
> Samsung SoC and you have:
>   cd-gpios = <&gpc3 2 2 0x10003 3>;
>   cd-inverted;

Hm I thought this was a local binding for the MMCI controller,
but no. Ohwell, it's to be kept around forever then.

> What _should_ we do?  I'd argue that we ought to be using
> "gpio_is_asserted" and then keeping the existing invert logic.  This
> is much better than today where you need to do one of:
> * ignore the active low on this GPIO
> * ignore the cd-inverted property
> * manually apply _both_ of these properties.

So if the GPIO is active low and cd-inverted is specified, we
will take the signal and double-negate it so we end up with
an uninverted signal.

So there is suddenly two ways to express "passthru".
well, we usally type !! double-invert in code so why not.
I'm more worrying about the maintainability of this
going forward.

> We could deprecate cd-inverted and at probably should at least
> strongly discourage it.

We also have wp-inverted.

These were added a while back, I guess Arnd and Chris will just
love to discuss this :-)

>  One argument for keeping "cd-inverted" too is
> for controllers that don't use a GPIO for card detect.
>  In this case
> you could imagine a MMC controller that has a "card detect" on
> special-purpose pin and accessible via a status register.

This is actually the case with Integrator/CP and Versatile/AB.

>> Another issue would be with things like bit-banged buses,
>> I don't thing an I2C bus with inverted semantics is that
>> very useful, and it makes things hard to debug for the
>> user, it's much more clear if the bitbang is driving the
>> line high or low than if it's asserting or deasserting it.
>
> Yes, bit-banged i2c is a great example where active low doesn't make
> sense.  Assuming we're not going to remove the OF_GPIO_ACTIVE_LOW
> flag, though, we'd at least need an assertion fail if someone did set
> it.  ...otherwise we end up with flags in the device tree that are
> silently ignored (which is the case much of the time today).
>
> In all honesty, though, I've seen some hardware engineers come up with
> some pretty darn wacky things to save a few cents.  Would it be
> completely absurd for someone to run i2c "backward" if they were
> running it through a level translator that had the side effect of
> inverting the signal?  That would certainly be a reason to use the
> bit-bang mode instead of a normal i2c controller...

We'll handle that as it comes around I guess, we cannot
upfront-design our way throughout the entire thinkable
universe :-)

Yours,
Linus Walleij
