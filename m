From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 22:16:29 +0200
Message-ID: <CAK8P3a12kUxi1dFPeoMEkDvaoEaV28WiBTvWU+O+m2_CU3W=EQ@mail.gmail.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon> <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
 <20170801142936.5df48702@bbrezillon> <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
 <20170801153414.6ce34ee8@bbrezillon> <20170801155813.4b811a4d@bbrezillon>
 <CAK8P3a10oJwsE8vQmPoX4Xf2zg17ZFqypMHMiPR_xOWUAMSB-w@mail.gmail.com> <20170801171434.2bc2aa84@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170801171434.2bc2aa84@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ku
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 1, 2017 at 5:14 PM, Boris Brezillon
<boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Tue, 1 Aug 2017 16:22:21 +0200 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> On Tue, Aug 1, 2017 at 3:58 PM, Boris Brezillon
>> <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> > On Tue, 1 Aug 2017 15:34:14 +0200
>> > Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> >> On Tue, 1 Aug 2017 15:11:44 +0200
>> >> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> >> > On Tue, Aug 1, 2017 at 2:29 PM, Boris Brezillon
>> >> > <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> > I just realized I forgot to add a "depends on I2C" in the I3C Kconfig
>> > entry. Indeed, I'm unconditionally calling functions provided by the
>> > I2C framework which have no dummy wrapper when I2C support is disabled.
>> > I could of course conditionally compile some portion of the I3C
>> > framework so that it still builds when I2C is disabled but I'm not sure
>> > it's worth the trouble.
>> >
>> > This "depends on I2C" should also solve the I2C+I3C driver issue, since
>> > I2C is necessarily enabled when I3C is.
>> >
>> > Am I missing something?
>>
>> That should solve another part of the problem, as a combined driver then
>> just needs 'depends on I3C'.
>>
>> On top of that, the i3c_driver structure could also contain callback
>> pointers for the i2c subsystem, e.g. i2c_probe(), i2c_remove() etc.
>> When the i2c_probe() callback exists, the i3c layer could construct
>> a 'struct i2c_driver' with those callbacks and register that under the
>> cover. This would mean that combined drivers no longer need to
>> register two driver objects.
>
> That should work. Actually, i2c_driver contains a few more hooks, like
> ->alert(), ->command() and ->detect(). Of course we could assume that
> I3C/I2C drivers do not need them,

I was thinking we can add them as they are needed.

> but I'm wondering if it's not easier
> to just add an i2c_driver pointer inside the i3c_driver struct and let
> the driver populate it if it needs to supports both protocols.
>
> Something like:
>
>         struct i3c_driver {
>                 ...
>                 struct i2c_driver *i2c_compat;
>                 ...
>         };
>
>
> and then in I3C/I2C drivers:
>
>         static struct i2c_driver my_i2c_driver = {
>                 ...
>         };
>
>         static struct i3c_driver my_i3c_driver = {
>                 ...
>                 .i2c_compat = &my_i2c_driver,
>                 ...
>         };
>         module_i3c_driver(my_i3c_driver);
>
>
>
> Of course, you'll have a few fields of ->i2c_compat that would be
> filled by the core (like the driver name which can be extracted from
> my_i3c_driver->driver.name).

Right, that would work too, but it's almost the same as the version
you proposed earlier that would use

module_i2c_i3c_driver(my_i2c_driver, my_i3c_driver);

It's probably a little cleaner this way in the subsystem implementation
compared to my suggestion of adding the i2c callback pointers in
struct i3c_driver, while that would make the drivers look a little nicer
(and save a few lines per driver).

         Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
