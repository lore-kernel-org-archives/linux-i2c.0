From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Thu, 14 Feb 2013 11:01:48 +0100
Message-ID: <CACRpkdaUtOe9g7+T=cWPepeGae6RcJ1nTeGc9opTijcYzfMedQ@mail.gmail.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
 <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
 <511C32B5.20600@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <511C32B5.20600-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 14, 2013 at 1:41 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 02/13/2013 05:34 PM, Doug Anderson wrote:

>> A little torn here.  It adds a bunch of complexity to the code to
>> handle this case and there are no known or anticipated users.  I only
>> wish that the GPIO polarity could be more hidden from drivers (add
>> functions like gpio_assert, gpio_deassert, etc)...
>
> Yes, that would be nice. Alex, LinusW?

OK so good point since Alex is rewriting the way the external
API to GPIOs is done.

So this is one of the evolutionary artifacts of the GPIO subsystem:
that it has this concept of clients having to know if they want to
drive the line low or high.

Either way somewhere in the system the knowledge of whether
the low or high state counts as asserted must be stored.

The same goes for inputs really: for example we have a
platform data flag for drivers/mmc/host/mmci.c that tells
whether a card is inserted when the line goes low or high. And
this varies between platforms.

So that would lead to gpio_get_value() being rewritten
as gpio_is_asserted() as well.

We all agree that the meaning of a certain GPIO pins
high vs low state as asserter or deasserted is a machine-
specific thing, so it need to come from device tree or platform
data.

So what this is really all about is whether that knowledge
should be part of the consumer DT node/platform data
or the producer DT node/platform data.

I.e. in the MMCI case whether we encode that into the
DT node/pdata for the GPIO controller or the MMCI
controller.

A bit like whether to eat eggs from the big or little end
you could say :-)

But changing it would have very drastic effects.
Consider this snippet from
arch/arm/boot/dts/snowball.dts:

// External Micro SD slot
sdi0_per1@80126000 {
      arm,primecell-periphid = <0x10480180>;
      max-frequency = <50000000>;
      bus-width = <4>;
      mmc-cap-mmc-highspeed;
      vmmc-supply = <&ab8500_ldo_aux3_reg>;

      cd-gpios  = <&gpio6 26 0x4>; // 218
      cd-inverted;

      status = "okay";
};

Note property "cd-inverted".

It states whether the GPIO value is active high (default) or
active low (this flag set). Ironically the binding document is
incomplete but we have to support device trees like this
going forward.

How do I make sure that this device tree continue to work
as expected if we change the semantic of the GPIO subsystem
to only provide gpio_is_asserted()?

You would have to include a function call to the GPIO core
and tell it what is asserted and what is not, like
gpiod_set_assertion_polarity() so the driver can also
tell the GPIO subsystem what is asserted and what is not,
rather than encoding that at the GPIO end of things.

So all of a sudden *both* the consumers and the providers
can define assertion sematics for the pins. What happens
if they are in disagreement?

So I don't know if that is such a good idea, it just makes
everything much more complex to handle for questionable
gain.

Another issue would be with things like bit-banged buses,
I don't thing an I2C bus with inverted semantics is that
very useful, and it makes things hard to debug for the
user, it's much more clear if the bitbang is driving the
line high or low than if it's asserting or deasserting it.

Yours,
Linus Walleij
