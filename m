From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH v2] i2c: change the id to let the i2c-gpio work
Date: Mon, 15 Oct 2012 09:29:25 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EE8007F@wm021.weinmann.com>
References: <1350034971-1050-1-git-send-email-voice.shen@atmel.com>
 <CAGhQ9VxRGQ8JAygxJreNDJY=tJ67yt2CM9NHvW3VyhjxooXuig@mail.gmail.com>
 <507B7066.4060802@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <507B7066.4060802-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Bo Shen' <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, 'Joachim Eastwood' <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "'hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org'" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "'plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org'" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bo,

Bo Shen wrote on Monday, October 15, 2012 4:10 AM:
> Hi Joachim Eastwood,
> 
> On 10/13/2012 1:42, Joachim Eastwood wrote:
> > Hi Bo Shen,
> >
> > On Fri, Oct 12, 2012 at 11:42 AM, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> >> The i2c-gpio driver will turn the platform device ID to busnum.
> >> When using platfrom device ID as -1, it means dynamically assigned
> >> the busnum. When writing code, we need to make sure the busnum,
> >> and call i2c_register_board_info(int busnum, ...) to register device
> >> if using -1, we do not know the value of busnum.
> >>
> >> In order to solve this issue, set the platform device ID as a fix number
> >> Here using 0 to match the busnum used in i2c_regsiter_board_info().
> >
> > I have been bitten by this myself on RM9200.
> >
> >> Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >> ---
> >> Change since v1
> >>    Make the commit message more clear
> >> ---
> >>   arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
> >
> > This pattern exist in at91rm9200_devices.c, at91sam9261_devices.c,
> > at91sam9263_devices.c and at91sam9rl_devices.c you might want to fix
> > them as well.
> 
> Thanks for your information.
> After I test these boards, I will send patches to fix them, while not in
> this patch.
> 
> >
> > I assume we have the same problem if CONFIG_I2C_AT91 is set?
> > See further down in at91sam9260_devices.c we have another:  ".id = -1,"
> 
> Maybe Nikolaus Voss will deal with this case.

I merely tested with G45 SoC where .id is set to constants != -1. Could you
extent your patch to cover the at91_i2c case, too? I think it would be good
to have all these in one commit.

Niko
