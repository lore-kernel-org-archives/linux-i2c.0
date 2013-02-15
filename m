From: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Active low GPIOs (was [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator
 'mux' driver)
Date: Fri, 15 Feb 2013 16:21:42 +0900
Message-ID: <511DE206.5000506@nvidia.com>
References: <CAD=FV=W7tBOHzwayT5kgtCGmvvGs8RoX7J3rTf2vHT69b4aj6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVjdc2367bhdW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

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
>>
>> Either way somewhere in the system the knowledge of whether
>> the low or high state counts as asserted must be stored.

Interestingly this knowledge is already more or less stored in GPIOlib - 
all GPIOs descriptors have a FLAG_ACTIVE_LOW, but it can only be set 
through the sysfs interface does not affect the in-kernel APIs. It does 
affect what is returned by the "value" sysfs node, though.

If we are to introduce something similar for the in-kernel interface, it 
would be nice to keep it consistent with the sysfs behavior, otherwise 
it will become a nightmare to maintain two different polarity settings 
for in-kernel and sysfs interfaces. The introduction of the gpiod 
interface could be helpful here. Since it would work with descriptors 
obtained through gpiod_get(device, consumer), the polarity could be set 
transparently from either the DT or platform data (which would then have 
a "flags" member). Then gpiod_set_value/get_value would take it into 
account, and behave just like the sysfs interface.

So, in short:
- old gpio_* interface would *not* be polarity-aware
- new gpiod_* interface *would* be polarity-aware (and get the settings 
from DT/platform data)

This looks simple but I don't have enough altitude to be sure we won't 
hit some walls by doing so.

This would make the new gpiod and legacy gpio interfaces behave 
differently, but at the same time is a good opportunity to have the 
behavior as sysfs.

An undesirable side-effect would be that the legacy gpio interface could 
not be built as a simple wrapper around gpiod anymore. That's sad, but 
presenting interfaces that make sense is more important.

As a side-note, there is also this gpio_sysfs_set_active_low() public 
interface that only mach-at91 seems to use (once!). Maybe we could try 
to get rid of it?

Alex.
