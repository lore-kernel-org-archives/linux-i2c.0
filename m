From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
Date: Tue, 20 Apr 2010 17:21:05 +0800
Message-ID: <p2kf17812d71004200221gf81c664dradf3baf1137a6b1a@mail.gmail.com>
References: <20100412213235.1688dda8@hyperion.delvare> <1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
	<8d2bff4f5c4178f89e410edc702cd18f@localhost> <201004201040.00739.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201004201040.00739.marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 20, 2010 at 4:40 PM, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Dne =C3=9At 20. dubna 2010 10:27:00 Marc Zyngier napsal(a):
>> On Sun, 18 Apr 2010 13:48:29 +0200, Wolfram Sang <w.sang@pengutronix=
=2Ede>
>>
>> wrote:
>> > The timeout value is in jiffies, so it should be using HZ, not a p=
lain
>> > number. Assume with HZ=3D100 '100' means 1s here and adapt accordi=
ngly.
>> >
>> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> > Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>> > Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
>> > Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> > Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>>
>> Acked-by: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
>>
>> Eric, can you merge this directly via your -devel branch?
>>
>> Thanks,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 M.
>
> And possibly updating your git tree? There are a few patches in -next=
 that will
> need it's arm counterpart.
>

Merged and updated.
