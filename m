From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Active low GPIOs (was [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator
 'mux' driver)
Date: Fri, 15 Feb 2013 21:34:14 +0100
Message-ID: <CACRpkdZETV1DRkGryOMJo=g=eCzO9sd7VovN5V5yGib+QVwYVQ@mail.gmail.com>
References: <CAD=FV=W7tBOHzwayT5kgtCGmvvGs8RoX7J3rTf2vHT69b4aj6g@mail.gmail.com>
 <CACRpkdY5dK==DEZjWvxVFLrP0Q8iOk-8RqozD3BA9cybxr2YLA@mail.gmail.com>
 <511D7EF7.9000803@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <511D7EF7.9000803-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29Tb/PtFMR13I2A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 15, 2013 at 1:19 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 02/14/2013 05:02 PM, Linus Walleij wrote:
>> On Thu, Feb 14, 2013 at 6:05 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> ...
>>>  One argument for keeping "cd-inverted" too is
>>> for controllers that don't use a GPIO for card detect.
>>>  In this case
>>> you could imagine a MMC controller that has a "card detect" on
>>> special-purpose pin and accessible via a status register.
>>
>> This is actually the case with Integrator/CP and Versatile/AB.
>
> In this case, I assume that the driver for the HW has custom code to
> read the MMC controller's CD register bit, and hence it knows whether
> the HW inverts it, and hence we don't need a property in DT to say so;
> the driver will simply read the bit, invert it, and return it all
> transparently? After all, the inversion isn't board-specific but IP
> block specific.

No that's not how it works ... heh.

It calls back to the platform:

include/linux/amba/mmci.h
 * @status: if no GPIO read function was given to the block in
 * gpio_wp (below) this function will be called to determine
 * whether a card is present in the MMC slot or not
(...)
struct mmci_platform_data {
(...)
        unsigned int (*status)(struct device *);
(...)
        bool    cd_invert;

So the flag tells whether that signal should be interpreted
as inverted or not. The same flag is used for GPIO
insertion detection.

The code reading the status will read a certain register
like this (arch/arm/mach-integrator_cp.c):

static unsigned int mmc_status(struct device *dev)
{
        unsigned int status = readl(__io_address(0xca000000 + 4));
        writel(8, intcp_con_base + 8);

        return status & 8;
}

0xca000000 + 4 is just the second 32bit word in the system
controller. This address range and that very word is used
for various stuff, so it's not like a general-purpose GPIO
or anything, it's just that one pin being readable throgh that
very bit.

Typical prototype-glue-ASIC-to-this-very-board design
pattern. Generic GPIO was not thought of at the time,
it was introduced in later ARM reference designs.

Yours,
Linus Walleij
