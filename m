From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: davinci updates for 2.6.35
Date: Mon, 21 Jun 2010 13:16:08 -0700
Message-ID: <AANLkTikJ6XDywcBA5O0mC85jQEIWxZ9NOALIQOjcGCDJ@mail.gmail.com>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
	<20100420000621.GK32401@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100420000621.GK32401-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 19, 2010 at 5:06 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
>> This series of davinci I2C driver updates and fixes is targetted for
>> 2.6.35. =A0It has been tested in davinci git on multiple davinci SoC=
s.
>>
>> Ben, since these changes are isolated to the davinci driver only, if
>> you prefer I can merge them upstream along with my davinci changes f=
or
>> 2.6.35.
>
> I'll get them into -next when I rebase it.

Ben, this series never made it in for 2.6.35.

I've now rebased this against v2.6.35-rc3 and it's available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.=
git
davinci-i2c

Please pull for 2.6.36.  Thanks.

Kevin

>> This series is based on v2.6.34-rc3
>>
>> Chaithrika U S (4):
>> =A0 i2c: davinci: misc. cleanups: remove MOD_REG_BIT and IO_ADDRESS =
usage
>> =A0 i2c: davinci: Add helper functions for power management
>> =A0 i2c: davinci: Add suspend/resume support
>> =A0 i2c: davinci: Add cpufreq support
>>
>> Dirk Behme (1):
>> =A0 i2c: davinci: Fix smbus Oops with AIC33 usage
>>
>> Philby John (1):
>> =A0 i2c: davinci: bus recovery procedure to clear the bus
>>
>> =A0drivers/i2c/busses/i2c-davinci.c | =A0314 +++++++++++++++++++++++=
+++++++--------
>> =A01 files changed, 251 insertions(+), 63 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>
> =A0'a smiley only costs 4 bytes'
>
