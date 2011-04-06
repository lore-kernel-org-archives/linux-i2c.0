From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Wed, 6 Apr 2011 01:16:07 -0700
Message-ID: <BANLkTimaRdRNOYM43AhjrU70o=GL0Q-D-A@mail.gmail.com>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
 <20110406052335.GA25578@sirena.org.uk> <20110406095240.410b4e7e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110406095240.410b4e7e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 6, 2011 at 12:52 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Wed, 6 Apr 2011 06:23:35 +0100, Mark Brown wrote:
>> On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
>> > This improves our resume time when we have devices on an i2c bus
>> > that are slow to resume. =A0In particular we have a light sensor t=
hat
>> > adds about 50ms of resume time on one device. We have to enable it
>> > both on the i2c master and i2c client side and then we get fully a=
sync
>> > suspend/resume. =A0I suspect we'll see nice gains on systems with =
more
>> > i2c devices and will test that out soon.
>> >
>> > Signed-off-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>
>> It'd probably help if the patch explained why this is safe - my
>> immediate question is why if it's safe to just unconditionally enabl=
e
>> async suspend for all I2C clients and adaptors it's not safe to do s=
o
>> for all devices of all types?
>
> I have exactly the same concern. From
> Documentation/ABI/testing/sysfs-devices-power:
>
> =A0 =A0 =A0 =A0It generally is unsafe to permit the asynchronous susp=
end/resume
> =A0 =A0 =A0 =A0of a device unless it is certain that all of the PM de=
pendencies
> =A0 =A0 =A0 =A0of the device are known to the PM core. =A0However, fo=
r some
> =A0 =A0 =A0 =A0devices this attribute is set to "enabled" by bus type=
 code or
> =A0 =A0 =A0 =A0device drivers and in that cases it should be safe to =
leave the
> =A0 =A0 =A0 =A0default value.
>
> As I don't see any code being added to guarantee that "all of the PM
> dependencies of the device are known to the PM core", I am skeptical
> about the general correctness of the proposed change.
>
> On the other hand, a quick grep on the kernel tree shows that the scs=
i,
> usb and pci subsystem enable async suspend unconditionally for all
> devices. This seems quite contradictory with the quoted statement
> above. Rafael, can you please clarify? Is the attribute description t=
oo
> alarmist, or are the subsystems too optimistic? ;)

Yeah, this is sort of why I made the change at this level.
I originally wrote a patch which just enabled it for the particular
sensor, but it didn't match with the other uses of that function
in the kernel which did things to entire subsystems like you
point out.  So, I re-wrote it in the optimistic hope that this was safe
just like USB/PCI/SCSI seem to be.

> Original post for reference:
> http://marc.info/?l=3Dlinux-i2c&m=3D130206741920878&w=3D2
>
> Sonny, on how many systems did you test it? In particular, did you te=
st
> it on several TV cards (which use I2C a lot and sometimes in complex
> setups)?

It has only been tested on my x86 system with the light sensor and
lightly tested on an ARM system with about 6-7 i2c devices.  I was hopi=
ng
the change would help the ARM systems because they make much
heavier use of i2c than the x86 system.  I haven't tested on anything
like multiple TV cards because I don't have such a setup -- the ARM
boxes with several i2c devices is the most complex user of i2c I have
at the moment.

Sonny
