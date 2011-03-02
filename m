From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] ARM: pxa2xx: reorganize I2C files
Date: Wed, 2 Mar 2011 11:08:30 +0800
Message-ID: <AANLkTikPDAtH10gPauq9F54MFSg=XBKt-p-PVXp8J7AW@mail.gmail.com>
References: <1298461100-14869-1-git-send-email-bigeasy@linutronix.de>
 <1298461100-14869-3-git-send-email-bigeasy@linutronix.de> <4D6D9426.8030905@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D6D9426.8030905-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 2, 2011 at 8:49 AM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On 23/02/11 11:38, Sebastian Andrzej Siewior wrote:
>>
>> This patch moves the platform data definition from
>> arch/arm/plat-pxa/include/plat/i2c.h to include/linux/i2c/pxa-i2c.h =
so
>> it can be accessed from x86 the same way as on ARM.
>>
>> This change should make no functional change to the PXA code. The mo=
ve
>> is verified by building the following defconfigs:
>> =C2=A0 cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defco=
nfig
>> =C2=A0 imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defcon=
fig
>> =C2=A0 raumfeld_defconfig magician_defconfig mmp2_defconfig pxa168_d=
efconfig
>> =C2=A0 pxa910_defconfig
>>
>
> Russell/others, you OK with this going through my tree?
>

Ben, I'm fine that you take this change. Trivial changes to me, so
I expect no significant merge conflicts.
