From: dong chen <china.gd.sz.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Date: Tue, 3 May 2011 17:59:38 -0700
Message-ID: <-7669036502097985728@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=E7=BC=96=E5=86=99=EF=BC=9A


On Thu, Apr 28, 2011 at 12:11 PM, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Thu, Apr 28, 2011 at 11:46:37AM +0900, Magnus Damm wrote:
>> On Thu, Apr 28, 2011 at 11:22 AM, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org> w=
rote:
>> > On Thu, Apr 28, 2011 at 10:18:01AM +0900, Simon Horman wrote:
>> >> On Thu, Apr 28, 2011 at 10:06:38AM +0900, Magnus Damm wrote:
>> >> > On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms-/R6kz+dDXgpECS10DBIrLA@public.gmane.org=
au> wrote:
>> >> > > I believe that on the sh73a0 and so far only the sh73a0
>> >> > > denom needs to be doubled.
>> >> >
>> >> > Uhm, I don't think this patch is specific to any SoC type. It m=
ay of
>> >> > course be used on sh73a0 to adjust the denom value, but setting=
 the
>> >> > I2C bus speed is something that can be used on any SoC. So I'd =
say
>> >> > that this is a fairly generic feature.
>> >>
>> >> I'm just saying that that I've observed the value being doubled f=
or sh73a0.
>> >>
>> > The general rule of thumb is that whatever unusual behaviour is ob=
served
>> > in the latest CPU we will see become the standard for future ones.
>>
>> This may also be an attempt to simply double the I2C bus speed on th=
at
>> particular platform for that particular application. So in the end i=
t
>> may have nothing to do with sh73a0. Actually, now when I think about
>> it, I recall hacking up a prototype to control the LCD backlight via
>> I2C on sh73a0 and AG5EVM, and I did not have to modify any part of t=
he
>> I2C bus driver to get that going as expected.
>>
> Ok, that bit of information was missing from your patch. That's obvio=
usly
> a bit more dodgy. We don't want to have the default behaviour out of =
spec
> for some specific application.

I suspect that I may have chosen my words poorly. By writing "This may
also be an attempt to simply double the I2C bus speed on that
particular platform for that particular application." I am not
referring to this patch. I am commenting on something Simon may see
when he is going though kernel source that has been mangled by people
doing integration.

As for configuring the i2c bus speed, I wouldn't call it dodgy. It is
something that is fairly common but of course needs to be handled with
care. Other drivers handle this through module parameters, but since
we want to configure this with per-device instance granularity
platform data is a better fit.

>> > Abstracting the denom value seems reasonable as a cautionary measu=
re, and
>> > it does do the NORMAL_SPEED as a default fallback so there is no a=
dverse
>> > impact for normalized platforms.
>> >
>> > This really should be going in to include/linux/i2c/ or so though,=
 no
>> > need to dump these tiny stubs in to include/linux/ directly.
>>
>> I guess I just followed what other i2c drivers do, but yes, putting
>> the header file in include/linux/i2c/ makes more sense.
>>
> Other i2c drivers put things in include/linux/i2c, too. There's also =
an
> include/linux/platform_data/ now as well for things that don't fit
> anywhere else. "This is the way we used to do it" tends to be a prett=
y
> pointless argument going forward.

I looks like I have been unclear in my writing once again. I'm not
arguing that the header should be kept in include/linux/.

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
