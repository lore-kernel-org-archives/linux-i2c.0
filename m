From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: Active low GPIOs (was [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator
 'mux' driver)
Date: Thu, 14 Feb 2013 09:05:24 -0800
Message-ID: <CAD=FV=W7tBOHzwayT5kgtCGmvvGs8RoX7J3rTf2vHT69b4aj6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang@pengutr>
List-Id: linux-i2c@vger.kernel.org

Linus,

On Thu, Feb 14, 2013 at 2:01 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Feb 14, 2013 at 1:41 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 02/13/2013 05:34 PM, Doug Anderson wrote:
>
>>> A little torn here.  It adds a bunch of complexity to the code to
>>> handle this case and there are no known or anticipated users.  I only
>>> wish that the GPIO polarity could be more hidden from drivers (add
>>> functions like gpio_assert, gpio_deassert, etc)...
>>
>> Yes, that would be nice. Alex, LinusW?
>
> OK so good point since Alex is rewriting the way the external
> API to GPIOs is done.
>
> So this is one of the evolutionary artifacts of the GPIO subsystem:
> that it has this concept of clients having to know if they want to
> drive the line low or high.
>
> Either way somewhere in the system the knowledge of whether
> the low or high state counts as asserted must be stored.
>
> The same goes for inputs really: for example we have a
> platform data flag for drivers/mmc/host/mmci.c that tells
> whether a card is inserted when the line goes low or high. And
> this varies between platforms.
>
> So that would lead to gpio_get_value() being rewritten
> as gpio_is_asserted() as well.

I had a very brief hallway conversation with Olof yesterday and he
proposed that introducing a parallel API might make sense.  AKA:
support both gpio_get_value() and gpio_is_asserted().  One would get
the raw value and one would handle the invert (as needed).  Old code
would keep working and new code could be written better.  There are
also times where you care about the actual logic level of a signal.


> We all agree that the meaning of a certain GPIO pins
> high vs low state as asserter or deasserted is a machine-
> specific thing, so it need to come from device tree or platform
> data.

Yes.  The device tree does have this knowledge today, at least on
Samsung SOCs.  See:
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=f447ed8b31da7b24c7c75c2d4624598135b41217

...and there's a generic way to access this with of_get_named_gpio_flags().


> So what this is really all about is whether that knowledge
> should be part of the consumer DT node/platform data
> or the producer DT node/platform data.
>
> I.e. in the MMCI case whether we encode that into the
> DT node/pdata for the GPIO controller or the MMCI
> controller.

This is actually kind of a screwed up case today.  See below.


> A bit like whether to eat eggs from the big or little end
> you could say :-)

The big end.  Definitely the big end.  ;)  ...and I think the bike
shed should be blue.


> But changing it would have very drastic effects.
> Consider this snippet from
> arch/arm/boot/dts/snowball.dts:
>
> // External Micro SD slot
> sdi0_per1@80126000 {
>       arm,primecell-periphid = <0x10480180>;
>       max-frequency = <50000000>;
>       bus-width = <4>;
>       mmc-cap-mmc-highspeed;
>       vmmc-supply = <&ab8500_ldo_aux3_reg>;
>
>       cd-gpios  = <&gpio6 26 0x4>; // 218
>       cd-inverted;

We're actually kinda screwed today.  What happens if you're on a
Samsung SoC and you have:
  cd-gpios = <&gpc3 2 2 0x10003 3>;
  cd-inverted;

What _should_ we do?  I'd argue that we ought to be using
"gpio_is_asserted" and then keeping the existing invert logic.  This
is much better than today where you need to do one of:
* ignore the active low on this GPIO
* ignore the cd-inverted property
* manually apply _both_ of these properties.

We could deprecate cd-inverted and at probably should at least
strongly discourage it.  One argument for keeping "cd-inverted" too is
for controllers that don't use a GPIO for card detect.  In this case
you could imagine a MMC controller that has a "card detect" on
special-purpose pin and accessible via a status register.  You might
have a board that needs to invert the card detect signal for whatever
reason.  Assuming that the controller itself didn't care, it might be
nice to be able to handle the invert in software.  That's a stretch,
but might happen...


> Another issue would be with things like bit-banged buses,
> I don't thing an I2C bus with inverted semantics is that
> very useful, and it makes things hard to debug for the
> user, it's much more clear if the bitbang is driving the
> line high or low than if it's asserting or deasserting it.

Yes, bit-banged i2c is a great example where active low doesn't make
sense.  Assuming we're not going to remove the OF_GPIO_ACTIVE_LOW
flag, though, we'd at least need an assertion fail if someone did set
it.  ...otherwise we end up with flags in the device tree that are
silently ignored (which is the case much of the time today).

In all honesty, though, I've seen some hardware engineers come up with
some pretty darn wacky things to save a few cents.  Would it be
completely absurd for someone to run i2c "backward" if they were
running it through a level translator that had the side effect of
inverting the signal?  That would certainly be a reason to use the
bit-bang mode instead of a normal i2c controller...


-Doug
