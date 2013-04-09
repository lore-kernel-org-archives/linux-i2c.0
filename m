From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Tue, 9 Apr 2013 13:26:52 -0700
Message-ID: <CAD=FV=UBUdyoQAXkDdRh5KjdrCOF2r-ayJCx63xfAivy9So7Kg@mail.gmail.com>
References: <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <20130408102617.GC3496@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130408102617.GC3496-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
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
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Prashanth G <prashanth.g@sam>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

Thanks for your review!

On Mon, Apr 8, 2013 at 3:26 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

> I'd like to have the bindings more generic. They should allow for n
> possible masters IMO. It doesn't need to be implemented right now, but
> it should be possible to add that later.

Done.  Left code as only handling one other master (as you suggested)
since it has been tested that way and there are no known users with
more than one other master.  Code will give an error if it encounters
a device tree with more than one master.


> I wonder about a more generic name. i2c-arb-gpio-challenge.* maybe?

Done.


> I'd like to drop the specific terms of AP and EC and just talk about
> multiple masters.

Done.


> An array based approach like in the i2c-mux-gpio driver would be more
> generic. Just mention that the driver only supports 2 entries at the
> moment.

Done.  Mentioned that some drivers may only support one other master
(rather than describing the current state of the kernel code) since
bindings should make sense even outside of a single driver, I think.


> Grant, I assume it is okay to introduce these generic bindings?

You are thinking that Grant wouldn't like the names I chose, or that
bindings of this type might not be OK?  The scheme as it stands is
pretty close to what Grant suggested himself here
<https://patchwork.kernel.org/patch/1877311/>.

I did drop the "bus-arbitration-" prefix from the ones he wrote up
since it seemed redundant to have that prefix on all properties of a
node that's only for bus arbitration anyway.  I can add them back in
if you think it's better.  I think Grant only had that prefix in his
proposed bindings because that was the name of the properties in
Naveen's patch (where the bus arbitration was bolted on to the i2c bus
and thus needed differentiation).


>> +config I2C_ARBITRATOR_CROS_EC
>> +     tristate "GPIO-based I2C arbitrator used on exynos5250-snow"
>> +     depends on GENERIC_GPIO && OF
>> +     help
>> +       If you say yes to this option, support will be included for an
>> +       I2C multimaster arbitration scheme using GPIOs that is used in
>> +       the Samsung ARM Chromebook (exynos5250-snow).
>> +
>> +       This driver can also be built as a module.  If so, the module
>> +       will be called i2c-arbitrator-cros-ec.
>> +
>
> This text could be more generic then, too.

Done.


>> +     /* We only support probing from device tree; no platform_data */
>> +     if (WARN_ON(!np))
>> +             return -ENODEV;
>
> Too much WARN_ON for my taste.

Sure.  I've removed them all and put dev_err() messages everywhere as
other mux drivers seem to.  I'd been of the mindset that there was no
need for verbose error messages and extra complexity for uncommon
cases like this, but I can see the benefit of describing exactly what
went wrong in the kernel log.


Please let me know if there's any other fixes needed.

-Doug
