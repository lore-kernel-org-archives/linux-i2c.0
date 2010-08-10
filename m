From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Tue, 10 Aug 2010 08:56:27 -0700
Message-ID: <AANLkTinNXxzCoH+b3=xA92sW8GCqqO4iY+_yVwBFLMqG@mail.gmail.com>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
	<20100420000621.GK32401@fluff.org.uk>
	<AANLkTikJ6XDywcBA5O0mC85jQEIWxZ9NOALIQOjcGCDJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikJ6XDywcBA5O0mC85jQEIWxZ9NOALIQOjcGCDJ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben,

On Mon, Jun 21, 2010 at 1:16 PM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> On Mon, Apr 19, 2010 at 5:06 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrot=
e:
>> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
>>> This series of davinci I2C driver updates and fixes is targetted fo=
r
>>> 2.6.35. =A0It has been tested in davinci git on multiple davinci So=
Cs.
>>>
>>> Ben, since these changes are isolated to the davinci driver only, i=
f
>>> you prefer I can merge them upstream along with my davinci changes =
for
>>> 2.6.35.
>>
>> I'll get them into -next when I rebase it.
>
> Ben, this series never made it in for 2.6.35.
>
> I've now rebased this against v2.6.35-rc3 and it's available here:
>
> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davin=
ci.git
> davinci-i2c
>
> Please pull for 2.6.36. =A0Thanks.

OK, it's now been two merge windows that these have been
ignored/forgotten.  Can you let me know what is the plan for these?

If you're too busy, I'd be happy to merge them via davinci git with
your ack if that helps take some load off you.  Either way, it would
be nice to know what to do.

If you want to pull, the branch has been rebased against v2.6.35 and
is available here:

 git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.gi=
t
davinci-i2c

Thanks,

Kevin
