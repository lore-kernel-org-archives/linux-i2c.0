From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v4 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Tue, 29 Aug 2017 09:58:14 +0800
Message-ID: <CAMz4ku+CH5-9Omxr=srJrJM7+_xni1-ZeMTsTJnA+A+ycUarOQ@mail.gmail.com>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <acbfda522aa806284b86f8935278cc7f7133e876.1500021046.git.baolin.wang@spreadtrum.com>
 <20170827153054.ijqxbjk25zpskojl@ninjato> <CAMz4ku+MJ49-Orp4mGL=jW0bfnko5o9fZgAjpZKqAMVUiw-o4Q@mail.gmail.com>
 <20170828151306.GA10688@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828151306.GA10688@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 28 August 2017 at 23:13, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> >> +     /*
>> >> +      * If we did not get one ACK from slave when writing data, we should
>> >> +      * dump all registers to check I2C status.
>> >
>> > Why? I would say no. NACK from a slave can always happen, e.g. when an
>> > EEPROM is busy erasing a page.
>>
>> For our I2C controller databook, if the master did not get one ACK
>> from slave when writing data to salve, we should send one STOP signal
>> to abort this data transfer or generate one repeated START signal to
>> start one new data transfer cycle. Considering our I2C usage
>
> Yes, so far so good.
>
>> scenarios, we should dump registers to analyze I2C status and notify
>> to user to re-start new data transfer.
>
> I disagree here. You notify the users by returning -EIO. The upper layer
> (e.g. the i2c client driver) will handle it, like the EEPROM driver
> might retry after a while. This all is expected behaviour, so no need to
> print the registers to the logfile.
>
> If you really, really want to keep it, make it debug output. But I think
> the sentence "we should dump all registers" needs to be rephrased.

Make sense. I will remove the registers printing here.

>
>> As I explained before, in our Spreadtrum platform, our regulator
>> driver will depend on I2C driver and the regulator driver uses
>> subsys_initcall() level to initialize. Moreover some other drivers
>> like GPU, they will depend on regulator to set voltage and they also
>> need initialization much earlier.
>>
>> Since it is arch_initcall() level, Andy suggested I should get rid of
>> tristate (use bool) and drop module.h here and all leftovers like
>> MODULE_*() calls including module_exit().
>
> I see. So the driver is really so essential for proper bootup that it is
> not even allowed to be unloaded. I might make an exception here and

Yes.

> allow arch_initcall() then. But I do wonder: did you try deferred
> probing all over the place?

Many modules (like GPU) need set voltage earlier by regulator which
depends on I2C ( or we also need regulate voltage for big-cores ASAP),
if we defer to set voltage for GPU or other modules, maybe will cause
some system problems. Thanks for your comments.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
