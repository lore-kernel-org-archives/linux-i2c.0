From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Tue, 26 Dec 2017 23:21:16 +0100
Message-ID: <CAMRc=MfcODVkY88nR7WPkg5G48R_FCz9v+9077cdKzdGCy0TqA@mail.gmail.com>
References: <20171221134842.31287-1-brgl@bgdev.pl> <20171221134842.31287-2-brgl@bgdev.pl>
 <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se> <CABxcv=kZk+Yrt9uj9uV7UVC+Tca7NCECfyZXmKkqHdopm5EZTg@mail.gmail.com>
 <a0cbee79-29dd-686c-5069-d95e1710bfc1@axentia.se> <CABxcv=kkp_Ck_JdDGomAGmSsTiCg82X67j5hEsvRnnY3RDMMfg@mail.gmail.com>
 <5adf70b0-51a2-f1b1-a5e9-2b9c4ef2ff1e@axentia.se> <20171226213226.iyw6tbdnhlrhxwdc@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171226213226.iyw6tbdnhlrhxwdc@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-26 22:32 GMT+01:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Fri, Dec 22, 2017 at 05:58:29PM +0100, Peter Rosin wrote:
>> On 2017-12-22 00:38, Javier Martinez Canillas wrote:
>> > Hello Peter,
>> >
>> > On Fri, Dec 22, 2017 at 12:07 AM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
>> >> On 2017-12-21 21:27, Javier Martinez Canillas wrote:
>> >>> Hello Peter,
>> >>>
>> >>> On Thu, Dec 21, 2017 at 5:20 PM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
>> >>>> On 2017-12-21 14:48, Bartosz Golaszewski wrote:
>> >>>>> Current description of the compatible property for at24 is quite vague.
>> >>>>>
>> >>>>> Specify an exact list of accepted compatibles and document the - now
>> >>>>> deprecated - strings which were previously used in device tree files.
>> >>>>
>> >>>> Why is it suddenly deprecated to correctly specify what hardware you
>> >>>> have, e.g. "nxp,24c32". In this case the manufacturer is nxp, damnit.
>> >>>
>> >>> Sorry but I disagree.
>> >>>
>> >>> When you specify a compatible string, you are not specifying a
>> >>> particular hardware but a device programming model.
>> >>
>> >> That's not what it says in https://elinux.org/Device_Tree_Usage
>> >
>> > I think the most up-to-date DT reference is at:
>> >
>> > https://www.devicetree.org/
>> >
>> >> in the "Understanding the compatible Property" section. I quote:
>> >>
>> >>         compatible is a list of strings. The first string in the
>> >>         list specifies the exact device that the node represents
>> >>         in the form "<manufacturer>,<model>". The following strings
>> >>         represent other devices that the device is compatible with.
>> >>
>> >> Pretty clearly talks about devices and not programming models. But
>> >> maybe I shouldn't trust that reference? What should I be reading
>> >> instead?
>> >>
>> >
>> > For example the latest spec draft
>> > (https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2-rc1/devicetree-specification-v0.2-rc1.pdf)
>> > says:
>> >
>> > "The compatible property value consists of one or more strings that
>> > define the specific programming model for the device. This list of
>> > strings should be used by a client program for device driver
>> > selection. The property value consists of a concatenated list of null
>> > terminated strings, from most specific to most general. They allow a
>> > device to express its compatibility with a family of similar devices,
>> > potentially allowing a single device driver to match against several
>> > devices."
>> >
>> > The recommended format is "manufacturer,model", where manufacturer is
>> > a string describing the name of the manufacturer (such as a stock
>> > ticker symbol), and model specifies the model number."
>> >
>> > Example:
>> >
>> > compatible = "fsl,mpc8641", "ns16550";
>> >
>> > In this example, an operating system would first try to locate a
>> > device driver that supported fsl,mpc8641. If a driver was not found,
>> > it would then try to locate a driver that supported the more general
>> > ns16550 device type."
>>
>> Yes, that's a bit different from the wording on the elinux site. Thanks
>> for the pointer! Google was not my friend on this occasion, since I
>> managed to miss that site in my searches. Maybe it has gotten a higher
>> rank now that 0.2 is out, because now I find it easily?
>
> The wording may be different, but both (and Peter) are correct.
>
> And ns16550 is a perfect example of why that string alone is not
> sufficient. Just go count the number of variants and quirks in the
> kernel 8250 driver.
>
>> >>> It's very common to use a compatible string that doesn't match exactly
>> >>> the specific hardware used. That's why it's called _compatible_ BTW.
>> >>
>> >> That's not how I read the above.
>> >>
>> >
>> > That's not how I read it nor my experience with DT, but of course I
>> > may be wrong on this.
>>
>> Either way, it should not be wrong to specify the more specific binding
>> before the generic fallback, as is done in the at91-tse850-3.dts
>> example I gave below.
>
> Indeed. I don't think I've ever said anyone is being too specific.
>
>> >>> For example when a DTS define a UART node with an ns16550 compatible,
>> >>> they don't really mean that have a UART IC manufactured by National
>> >>> Semiconductor.
>> >>
>> >> That just tells me that most people are a little bit lazy and ready
>> >> to cut a corner or two when they can get away with it. Or that there
>> >> is some form of misunderstanding at work...
>> >>
>> >
>> > For example, I usually see that different SoC families from the same
>> > vendor use the same compatible string for integrated peripherals just
>> > because are the same from a programming model point of view.
>> >
>> > TI am33xx SoCs use a lot of omap3 compatible strings on their nodes
>> > and its similar on Exynos SoCs which are the two ARM SoCs I'm most
>> > familiar with. Following your logic that's wrong and instead a new
>> > compatible string should be added for the GPIO or pinctrl drivers even
>> > when are the same because refer to different devices.
>>
>> Considering the above quote from the actual DT spec, I wouldn't say wrong.
>> But I'd still say that it should be preferred to list the actual device
>> before the fallback to some generic programming model compatible or some
>> previous version of the hardware/IP-block. Just in case an unintended
>> difference is discovered late in the game...
>
> Let me clear, "generic" compatibles alone are wrong.
>
>>
>> >>>> Sure, it happens to be compatible with "atmel,24c32", but that is
>> >>>> supposed to be written with a fallback as
>> >>>>
>> >>>>         "nxp,24c32", "atmel,24c32"
>> >>>
>> >>> This isn't a requirement really, systems integrators are free to use
>> >>> more than one <manufacturer,model> tuple in the compatible string if
>> >>> they want the DTB to be future proof, just in case there's a need for
>> >>> a more specific driver or if the programming model happened to not be
>> >>> the same at the end. This is usually done for the boards compatible
>> >>> string as an example, even when there isn't a struct machine_desc for
>> >>> the specific board compatible and only for the SoC family.
>> >>>
>> >>> So it's OK if you want to define the compatible as "nxp,24c32",
>> >>> "atmel,24c32", but that's a general OF concept and not something
>> >>> related to the at24 eeprom driver so I'm not sure if it should be
>> >>> mentioned in the at24 DT binding doc.
>> >>
>> >> One problem is that if "nxp,24c32" (or "nxp,24c02" as in the example
>> >> below) is not a valid compatible, the tooling will be correct to
>> >> complain about it. Currently, it is just a checkpatch deficiency that
>> >> it complains like this:
>> >>
>> >> $ scripts/checkpatch.pl -f arch/arm/boot/dts/at91-tse850-3.dts
>> >> WARNING: DT compatible string "nxp,24c02" appears un-documented -- check ./Documentation/devicetree/bindings/
>> >> #249: FILE: arch/arm/boot/dts/at91-tse850-3.dts:249:
>> >> +               compatible = "nxp,24c02", "atmel,24c02";
>> >>
>> >
>> > But isn't that a bug in checkpatch? as long as there's a valid
>> > <manufacturer,model> tuple in the compatible string, it shouldn't
>> > complain.
>>
>> Then there is a significant risk that speeling mistakes are not
>> caught. So, I don't think it will be considered a bug unless a DT
>> guru says so of course. I think the checkpatch intention is to catch
>> all undocumented compatibles. But I don't know of course...
>
> checkpatch.pl is just plain stupid. Who wrote that check anyway? Because
> bindings are not machine parseable, compatible string checks are pretty
> much just a grep for the string in all binding docs. So "The" or
> "compatible" would be valid compatible strings for checkpatch.pl.
>
> If you want to quiet checkpatch.pl, I'd suggest documenting compatible
> strings as "<vendor>,foo" and having checkpatch match any string for
> <vendor>. We already handle vendor,<soc>-block type compatible
> descriptions.
>
> Rob

Hi Rob,

more than shutting up checkpatch, I care about cleaning up the device
tree support in at24 and extending it with other variants that are
currently supported as i2c devices.

While just listing the supported models with any vendor allowed would
be fine in most cases, there are also examples like
"renesas,r1ex24002" which is really just "atmel,24c02" but with a
different model name. So should we say in the document that 'any
"<manufacturer>,<model>" pair is allowed as long as the fallback is
one of "atmel,<model>" strings'?

Best regards,
Bartosz Golaszewski
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
