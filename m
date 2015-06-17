From: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Py-smbus and python3 support: it's time for a new release?
Date: Wed, 17 Jun 2015 11:23:38 +0200
Message-ID: <CA+TH9VnFW=3Q5w9=PhC_djftbAHgJ0krYF5u1ggxXB7QYx+U-A@mail.gmail.com>
References: <CA+TH9V=OwuaezZ7UKT-9Vg4cs8h4+mmhSZiGBDNq_Pp7V+G7Og@mail.gmail.com>
 <20150617111855.787ddc6e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617111855.787ddc6e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

2015-06-17 11:18 GMT+02:00 Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>:
> Hi Angelo,
>
> On Tue, 26 May 2015 09:56:47 +0200, Angelo Compagnucci wrote:
>> Dear Jean Delvare,
>>
>> Now that python3 support was added to python-smbus, could you release
>> a new stable version with it?
>>
>> This way, py-smbus with python3 support could be included in
>> distributions that usually don't pick unstable packages.
>
> I understand that distributions don't want to ship unstable packages,
> however they can (and do) cherry-pick individual commits to fix bugs or
> add features they want. If you have a specific need, you can always ask
> your distribution to consider backporting a few commits. In this
> specific case, there's a dedicated stable branch for i2c-tools 3.1 so
> it's even easier.
>
>> Is there any planned roadmap or showstopper that makes this thing difficult?
>
> The main blocker is that I'm always so busy and can never find the time
> for the release.
>
> Another problem is that it's the first release which will include
> libi2c, and with that the first API will be set. After that, it's
> harder to change it I got it wrong for any reason. I had plans to
> extend the API a bit too (basically merging i2cbusses into the
> library.) I guess that's the reason why I'm always delaying the
> release. But to be honest, I suppose that no problem will be reported
> until the library is widely used, and that just can't happen until it's
> part of a stable release. So it's a kind of chicken-and-egg problem.
>
> For the legacy branch (3.1), there's no libi2c excuse, and I did
> consider a release after adding support for python3, but canceled the
> idea after seeing only 2 lines in the CHANGES file. That being said,
> there's so little happening on that branch that maybe it's expected
> that only a couple fixes will make it into every release.

Yes, exactly. I think having a legacy release with python3 support
would benefit community at a whole, meanwhile waiting for the new one.

> I'm adding "release i2c-tools" to my formal to-do list [1], but I can't
> promise anything regarding the schedule.

Please, please, find that time! I really would like to package
i2c-tools 3.1 with python3 support in buildroot!

> [1] A sheet of paper on my desk, nothing fancy, really.
>
> --
> Jean Delvare
> SUSE L3 Support



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
