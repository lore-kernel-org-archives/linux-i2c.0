From: anish singh <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C: Fix i2c fail problem when a process is terminated by a
 signal on octeon in 3.8
Date: Thu, 28 Feb 2013 10:08:07 +0530
Message-ID: <CAK7N6vrSMBgO9=2vfB3PCG0e0WDhkTwQ0wLpJLhicu4U61ym5g@mail.gmail.com>
References: <88.A5.02716.F6CB6215@epcpsbge3.samsung.com>
	<alpine.LNX.2.00.1302261101250.2128@pobox.suse.cz>
	<20130226110740.GA3962@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130226110740.GA3962@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, =?UTF-8?B?7Iah7J2A67SJ?= <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2013 at 4:37 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote=
:
> On Tue, Feb 26, 2013 at 11:02:17AM +0100, Jiri Kosina wrote:
>> On Fri, 22 Feb 2013, =EC=86=A1=EC=9D=80=EB=B4=89 wrote:
>>
>> >
>> >
>> >
>> > I've been debugging the abnormal operation of i2c on octeon.
>> > If a process is terminated by signal in the middle of i2c operatio=
n,
>> > next i2c read operation which is done by another process was faile=
d.
>> > So i changed to ignore signal in the middle of i2c operation.
>> > After that the problem was not reproduced.
>>
>> This is not really material directly for trivial.git. Adding maintai=
ners
>> to CC.
>
> Yes, this should not go via trivial. Please resend to i2c list. Patch
> looks okay from a glimpse (and fixes an issue we have seen before and
> fixed the same way).
Just curios to know why reinitializing the i2c controller is a bad idea=
?
This fix looks perfect but if we know that there is only one i2c device
currently being controlled by controller.Can we(i know it is expensive
compare to the fix provided) not re-initialize the i2c-controller?

Thanks,
>
> Thanks,
>
>    Wolfram
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
