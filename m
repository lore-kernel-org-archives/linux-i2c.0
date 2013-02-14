From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: Active low GPIOs (was [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator
 'mux' driver)
Date: Thu, 14 Feb 2013 10:48:45 -0700
Message-ID: <511D237D.9000306@wwwdotorg.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang@pengutr>
List-Id: linux-i2c@vger.kernel.org

On 02/14/2013 10:05 AM, Doug Anderson wrote:
> Linus,
> 
> On Thu, Feb 14, 2013 at 2:01 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Thu, Feb 14, 2013 at 1:41 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>> On 02/13/2013 05:34 PM, Doug Anderson wrote:
>>
>>>> A little torn here.  It adds a bunch of complexity to the code to
>>>> handle this case and there are no known or anticipated users.  I only
>>>> wish that the GPIO polarity could be more hidden from drivers (add
>>>> functions like gpio_assert, gpio_deassert, etc)...
>>>
>>> Yes, that would be nice. Alex, LinusW?
>>
>> OK so good point since Alex is rewriting the way the external
>> API to GPIOs is done.
>>
>> So this is one of the evolutionary artifacts of the GPIO subsystem:
>> that it has this concept of clients having to know if they want to
>> drive the line low or high.
...
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
> 
> What _should_ we do?  I'd argue that we ought to be using
> "gpio_is_asserted" and then keeping the existing invert logic.  This
> is much better than today where you need to do one of:
> * ignore the active low on this GPIO
> * ignore the cd-inverted property
> * manually apply _both_ of these properties.

This is actually why I rather dislike the idea that device tree has an
immutable bindings. To some exten, I imagine that much of
Documentation/stable_api_nonsense.txt could apply against device tree!
We can't fix problems like this by changing the definition of that
binding to remove the cd-inverted property and rely solely on the GPIO
specifier flags.

And I think it's ironic that you linked to the commit that adds the
inverted flag to the Samsung GPIO specifier; IIRC, Samsung's previous
lack of support for that flags was one of the reasons that a bunch of
bindings added their own foo-inverted or foo-active-high flags, since
not all GPIO specifiers could be relied upon to provide that information:-(
