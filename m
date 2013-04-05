From: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Fri, 5 Apr 2013 12:37:19 -0700
Message-ID: <CAPnjgZ0bt+ppAMAB1RtoeUKrzUjxxZ3+=GQwHqxByce7fmOLDg@mail.gmail.com>
References: <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <CAD=FV=UW4wGFqsg2B3MmC24jhnba5PSvCh8Wck-V6iuYk+Xifw@mail.gmail.com>
 <20130329115821.GC6359@the-dreams.de>
 <CAD=FV=XyBZXD1dsOy4kY3CjkFiJXCO+taAJ-zZ8op6V-z9J8jQ@mail.gmail.com>
 <20130403191938.GA7875@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130403191938.GA7875-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
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
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj
List-Id: linux-i2c@vger.kernel.org

HI Wolfram,

On Wed, Apr 3, 2013 at 12:19 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Doug,
>
>> Separately from a discussion of the technical merits, I'd say that
>> this patch is needed because the Embedded Controller (EC) on the ARM
>> Chromebook shipped expecting to communicate with this scheme.  While
>
> Uhrm, with all respect, "we already shipped it" is not a convincing
> argument regarding inclusion. Benefit for the kernel is.
>
>> ...but we can also talk technical merits.  One person on our team
>> spent a bit of time thinking about this and decided that traditional
>> i2c arbitration can't actually be used in this case (aside from the
>
> The details would be extremly interesting here. I am very interested in
> this and will ask a few questions further on. This is to get a better
> undestanding for the situation regarding multi-master and what is
> needed, because I expect some demand for it in the near future.
>
>> general experience about multimaster being buggy).  Specifically, our
>
> I'm also interested in these experiences.

Thanks for coming back on this. Please see my comments below.

>
>> The problem here is that the EC is both a master and a slave.  It's my
>> understanding that if the AP tries to talk EC on the bus at the same
>> time that the EC is trying to talk to the battery of PMU that we can
>> get into trouble.
>
> If I understand correctly, the I2C Specs mention this case explicitly:
>
> "If a master also incorporates a slave function and it loses arbitration
> during the addressing stage, it is possible that the winning master is
> trying to address it. The losing master must therefore switch over
> immediately to its slave mode."

This seems pretty complicated - does the EC then need to compare the
address it was sending with the remaining bits that are to be received
in that address?

Anyway yes we did consider this case at the time, and the STM32
datasheet had mention of it. But it adds quite a bit of complexity. I
think the start sequence is intended to make this all work, at least
in theory, but it seemed risky to rely on it.

The practical problem here is that in my experience the I2C
multi-master feature is lightly used in practice, and is quite tricky
to get right. That experience was shared with other engineers in the
team, and no one was willing to take the risk on getting everything
running perfectly with i2c multi-master, or doing it on a tight
timeline. I suspect this same problem has arisen many times before,
and will arise again, so from that point of view this feature is a
useful addition to the kernel.

If you are interested in specific experiences then I might be able to
collect some comments from people here. For myself I have found that
getting a reliable I2C driver at all is a sufficient challenge and
time sink with many embedded chips. My memory is a little vague now,
but I know that in 2-3 projects we had to use bit-bash due to bugs or
insufficient documentation in the chip's dedicated I2C peripheral. One
project which had multi-master used a retry scheme with sequenced
packets which seemed to work well enough (i.e. adding a layer above
the I2C layer to sort out problems). The snow project was more
challenging on the I2C  ront, due to the critical nature of I2C buses
in the device.

For snow we found that the Exynos driver did not support arbitration
loss, the STM32 driver we had did not support it, the STM32F I2C
errata indicated problems with I2C in general which reduced our
confidence, and we were unable to determine whether the slave devices
on the bus (smart battery and pmic) would definitely do the right
thing (both chips had I2C issues which we were tracking). I am not
trying to point fingers here, and certainly anything can be solved
given sufficient persistence...but keeping to common features that are
well-tested and available is prudent. As it was we spent more time on
I2C drivers than I would like, and you can get a feel for that in the
Chromium bug tracker if you wish.

Again, I don't believe this would be an unusual situation in a product
development. We need to consider the risk and cost of an approach,
rather than just whether it is technically possible.

>From the point of view of arbitration, the two critical points in the
I2C transfer are claiming the bus (detecting that the start condition
failed) and detecting loss of arbitration during a transfer. These
points need to be tested and validated on all master devices, which
can add a considerable burden. Silicon and driver bugs may make this
even more onerous and in fact for some non-compliant implementations
it simply might not work, or might not work reliably.

Please don't take this as a negative view of I2C in general, which is
an excellent bus, unmatched for what it was designed in my view.

>
>> Specifically the EC needs to be switched to "master
>> mode" to talk to the battery/PMU and thus has a period of time where
>> it won't be listening for the AP's messages.
>
> When it talks to the battery, the bus is busy and the EC will not be
> addressed by the AP?

That's right - there is only one bus and we want to avoid contention for it.

>
>> The arbitration lines make it very clear that the EC has gained
>> mastery of the bus and is free to switch into "master mode" without
>> worrying that the AP may talk to it.
>
> There is another thing I wonder: The arbitration is not I2C specific.
> You could use this scheme for various busses. So, besides the question
> if this is really needed on top of I2C arbitration, the other question
> is if this should reside inside the I2C kernel realm or should/could be
> generic.

Yes this is an interesting point! So far this feature has been added:

- in a separate 'arbitrator' driver (my original implementation, and
now suggested by you)
- in the Samsung I2C driver (suggested by Olof Johansson, my second
implementation)
- in the I2C core (suggested in code review I think and implemented by
Naveen Chatradhi)
- as an I2C mux (suggested by Grant Likely, implemented by Doug Anderson)

So yes there are clearly a number of places where it could go and we
might be going around in circles. But we should be careful to address
this question based on present need rather than theoretical value. I
believe there is clear value in having an I2C mux which can arbitrate
between masters using an out-of-band method for the reasons explained
above. Other needs and wishes should be justified on their merits when
they arise.

Having a mux, which can be is set up using the device tree, is quite
an attractive option. It allows the feature to be used by any I2C
driver, and does not touch the core I2C code.

The present patch is a nice clean implementation IMO, and I believe it
has value for the kernel.

Regards,
Simon
