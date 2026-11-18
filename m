Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794984877;
	b=Ib4LmEadUknkoKJGXMKVzsCIa95856NY7u11YkkskAfa4sr/iJIxraJOAzRwEZNpETkO
	 GwGYBq0NV5isapuYCvHsB/2g27mY346qqVf3gc8SGTkIn+ZoVNuN180m3k3XzekGvrtX8
	 +hwaCzxVV/Q9XtonIe4DnI1Os1EkvAnZFSZRvwpJZLjgQXOHIZb3Z0hu7+VPXp3parZUs
	 ttkcGcHwCcdp44fB4Trh5i8MjyQebIO9FcMv2CyGhsB0FsiX6tXB1CB7Uo7Bu10nQAs3s
	 ljmpYB2DHGEuu0Wk1L8ldfJ2Any22LVadsv4WMQcXzqUkgPIdEfYgNc/oiRaNZwubrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=0v55DjIlhgGgzFGL2Aj+I5ed/9R8VGys7w/8Zak98m0=;
	b=mwEBmnej3OVG1seRcDNUOazCLy3EaDVIuwm6l7sETWI3WGPOQQq0mNtAPlHlSVXK2PIb
	 NyIQajBtGbyb75dsbTXfOQTS5yIWXGcnDPzd1UrrN6aecclJrdhlgAJVKWEGfAVH9z8co
	 MYJuGIHsYqOnw4IqoqoXtArUWu52cxfzlCWZDDlue2ch3QFAHvLh05KjNRW05OHPsVJhv
	 83FmKg8vHJBrEq2O17dDafMxQEgR6aHv4MxcE5/TPkijYfbZ5l5M5bmTrI0xS4Pp0ad2m
	 tcsQK9IpK1vX+vWlgS3bNG0g/331l9g0yxsVoYw4uWiijpQFRJ7PW3OWUSYnObSaZgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X70F+gsx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7D606A32A
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 06:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB7D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X70F+gsx
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b87a92c17eso1084451a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 22:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794984875; cv=none;
        d=google.com; s=arc-20260327;
        b=DvUio5iLscspxvtcfNZCgiZ+rF7CTb1p5Y20e79XdjXKUyF/wzW4BwdchmSWFt9A8y
         VX1D6gOmuEtsfl1fquM1prZJ79Dc37POe6hKiMpy70GiHBP6t4Qj495F2inbhM/5zZwM
         B51vReeBduTOfi0DkHQ20OqOPKJ0eVC8JbC9kLd94LtGo1WFXhrBaiqk1Saf8f9fUY62
         OSy94To3UnDKZ60Ab1df3bHYFp5icF3mpByBnWRbXBznHt79HyRJFW2Mm4BedRW+GT03
         QboUGdNp+bazkIpCmjzLaaNWDJslOatls26aQej1elYHTSyYv9aKUHsvXPz/29zYHJov
         gjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=0v55DjIlhgGgzFGL2Aj+I5ed/9R8VGys7w/8Zak98m0=;
        fh=+5eqG6p84qLWB6DNASbq6rrJZwyv2cGbUvl2c1Qk7pg=;
        b=Fjl3oFo651NFePyQ5AxbcS3JAirqItxtieEA3p+wweapVOFEdI85Qi3gv6mb9B8qI8
         o0idoNrDiob268zpnqi0S9oExrraei0cJZ2o/hC3ZFq0mLVvDWRUaqd+gUaab7ltkga1
         hXH70oxY60Ea/Ndh/3gVz9qtFyME7QUSYLN96a0aDPrFO1moPBhguvJkpc32+BDGHxhD
         0IYvo9JmkbC+inJE6n4+PUUVqBDynDlTnMt6PcOtFZb54rwd1JxmTjSr2Ix7CGBjSRFU
         Fq/zkcrEOvTe+7CUGdLfp/hHwAdFeZntddYwWsK4znHuXzTCaqSv6bZnOHyDQaKmz7rB
         uwUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794984875; x=1795589675; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0v55DjIlhgGgzFGL2Aj+I5ed/9R8VGys7w/8Zak98m0=;
        b=X70F+gsxS6/RJth6H/Phnbs0QWcvpbFseI7hV0EltfxN2qWJksYKW9pZJJVQ9u8/38
         vGd+fEf50/58DC5Uwy2l+raoZZOEjS9ZH6/LZMZ+9c1mRLF2wq0Xp5JNx4UCa3mSq8EN
         gPbnqd7IlXoblejv4l/X2tUUY9vOfFUFNswwCcBMYw1/uT3Bn0awEKZJhkIJaWyDYss7
         2WokLBRwkYBnLYEW1QzbRr92uj8ATSu5fvpaz2CLP22l2Xru8l55OoP4Kr/yLRcMf2N8
         69v34dQqMmSozxdiptuMey2RdNsP7HJool00F2Ql5WHhkAB5RKsrqc229CgrWYZEDUYd
         w9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984875; x=1795589675;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0v55DjIlhgGgzFGL2Aj+I5ed/9R8VGys7w/8Zak98m0=;
        b=UDVr9VbNnyOlznHBxuuQFsl3D5mDbZCF6vdbQYREZHb9Ztqp3poFQ5lxvTX/KAZUuM
         R5fnjTGte7Xd+ASugMt6ORMCnJ5EzkzsgEDMyGjF9p2d+Z3IzzwaSycdonrrNWgts+nj
         uWkexlaG8kRe8+WQR7pvcWGDm3VLHY9rf7g0CSgscLzSrHG1um+hJSvPvjVcrN6WpeCW
         +Q7s3Mwg7bjgfIypSExl6CCcFg3QY2a7HSWnnx4a7mP7T4QI7nHOLs0Tbg25nZOpc8og
         3lhZIdjU8vpgu5Aiss+doNHp+biOA1R7lJZ8B11/MgMO+gfZMm8Dyu3FKo7utwSUEa+u
         oueQ==
X-Forwarded-Encrypted: i=1; AL+hErFz+qbt2hWLbjQHHybuhyphp/fRCrpYIICmG7h5f987hzxExuxUiabH2Mng9Oahzyk/MWEah5akTHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z90g3TrN95z3PqnbdwMCoz8fmibUTTb7cfZ+XAKrxGyKF8qiRZ6
	u4PkONI3HG0gnaaBh1UjSH3HUrp6B8zplEsQO3Tze4VUtsPD/huKHx1a7lLwR/ZsphHoWDfVMfE
	E2y7Vq8hEyWBtnKh9OSm9kNzyCrpy+53wSi4T
X-Gm-Gg: AYBFou1ly6pUH7X7HmPrtgv+2lQ+PX5O5f3Ahr9sSWhy/A8vGH//7Q1oh29NFLgHKgH
	EKB3aRrFNVwQtmfOwMrTVc523Ao/1X221GbLpSzOeti1Am3oMS1KoDXAMRoLkihTY0JOmXYT65H
	DEykYWZ8PAiZE2RFGYGTFoO3K54Khlqi2Vq1SYIzFb2mtbfJLvAc/xJmdhmGAwX2BdewdzuFITl
	P0ldsnDMWEuWMnn5coCVxcJ9zKs4ZimcixeqfT0QCDKXvNNS8Hg5EVd1y1yFZZtv3pqtFNKwXOj
	WZfBQwtctZFdgJbhYvZ8fCo0HQ1ejK7tfFguhXpa8gVRuwJ1187KYU18fDffgZEqmBTtyYwXdLF
	SEZ7HGUVFcP3g2hdmlep4K+E8riKrlre/HtQVub1LHcGhgFAi3H57dl7v
X-Received: by 2002:a05:6402:501c:b0:6b7:d1a4:fe1b with SMTP id
 4fb4d7f45d1cf-6b88810c5f5mr1112459a12.43.1794984874478; Tue, 17 Nov 2026
 22:54:34 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110061429.2036-1-linux.amoon@gmail.com> <20261110061429.2036-2-linux.amoon@gmail.com>
 <avpN-gFOvTBAMY6G@venus> <CANAwSgT_k35_waHL-+iU93f=k3fjFAPXhk=exRz-XHMm2MqREA@mail.gmail.com>
 <avvnRkK9agPSdzac@aurel32.net> <CANAwSgSXP1bZVVrX71jfgi1iR9AY4TpM0pk07ke+oeLvcX1fEQ@mail.gmail.com>
 <avzUjsZzhky4krEV@aurel32.net>
In-Reply-To: <avzUjsZzhky4krEV@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 18 Nov 2026 12:24:21 +0530
X-Gm-Features: AclHuK9HKxBMC369hvmbX2XcXZTYgL0-Osg6H7GZAWz1CrH05BbQd5v0LX84zZk
Message-ID: <CANAwSgRm9dbAtr4J4Gry_kR6xWQTQ+T+EaJ0vGDMpKGUPZxojw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
To: Anand Moon <linux.amoon@gmail.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Yixun Lan <dlan@kernel.org>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Aurelien,

Thanks for testing. Your feedback helped me a lot.

On Wed, 18 Nov 2026 at 03:56, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi Anand,
>
> On 2026-11-17 18:04, Anand Moon wrote:
> > Hi Aurelien,
> >
> > On Tue, 17 Nov 2026 at 11:04, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > >
> > > Hi Anand,
> > >
> > > On 2026-11-16 13:06, Anand Moon wrote:
> > > > Hi All,
> > > >
> > > > On Mon, 16 Nov 2026 at 11:33, Sebastian Reichel
> > > > <sebastian.reichel@collabora.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> > > > > > The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> > > > > > to access the PMIC. However, these handlers run in an atomic notifier
> > > > > > context (specifically within an rcu_read_lock() critical section), while
> > > > > > the I2C-backed regmap uses a sleepable mutex.
> > > > > >
> > > > > > This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> > > > > > context switch in the RCU read-side critical section during shutdown on the
> > > > > > Banana Pi BPI-F3:
> > > > > >
> > > > > > [  563.803475] WARNING: suspicious RCU usage
> > > > > > [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> > > > > > [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> > > > > > ...
> > > > > > [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> > > > > > [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> > > > > > [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> > > > > >
> > > > > > Replace the regmap operations with atomic I2C transfers to avoid sleeping
> > > > > > in an atomic context. Preserve unrelated register bits through
> > > > > > read-modify-write operations and check for atomic I2C support before
> > > > > > registering the handlers.
> > > > > >
> > > > > > Obtain the I2C client from the parent device and verify that the adapter
> > > > > > supports atomic transfers before registering the handlers.
> > > > > >
> > > > > > Tested on the Banana Pi BPI-F3 (SpacemiT K1).
> > > > > >
> > > > > > Assisted-by: LLM
> > > > > > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > > > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > > > > > Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff/reboot")
> > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > ---
> > > > >
> > > > > regmap runs i2c_transfer itself and thus also uses the atomic I2C
> > > > > transfers. The problem here is regmap itself. But instead of moving
> > > > > away from regmap, the atomic use case should be supported properly
> > > > > in regmap.
> > > > >
> > > >
> > > > On  RISC-V platform, poweroff and reboot are already handled by OpenSBI
> > > > through the SBI System Reset (SRST) extension. Linux delegates these
> > > > operations to firmware using SBI_SRST_RESET_TYPE_SHUTDOWN for poweroff
> > > > and SBI_SRST_RESET_TYPE_COLD_REBOOT or SBI_SRST_RESET_TYPE_WARM_REBOOT
> > > > for reboot, depending on the supported reset type.
> > > >
> > > > Therefore, there is no need for an additional Linux PMIC poweroff/reboot handler
> > > > on this platform, as it duplicates functionality already provided by firmware.
> > > >
> > > > While supporting atomic operations in regmap may be useful more generally,
> > > > it is not necessary to address this platform's shutdown and reboot requirements.
> > > >
> > > > I tested this on the SpacemiT K1 Banana Pi BPI-F3 after removing this PMIC
> > > > poweroff/reboot driver.
> > > >
> > > > OpenSBI commit which handles this extension
> > > >
> > > > d9637d00bf47 ("lib: utils/reset: add SpacemiT P1 PMIC support")
> > > > b10e18ec854a ("lib: utils/i2c: add minimal SpacemiT I2C driver")
> > > >
> > > > Similarly, on the StarFive VisionFive 2, poweroff is handled by
> > > > OpenSBI through the
> > > > AXP15060 PMIC, so there is no need to register an additional poweroff
> > > > handler using
> > > > devm_register_power_off_handler().
> > > >
> > > > OpenSBI commit which handles this extension
> > > >
> > > > 568ea49490d9 ("platform: starfive: add PMIC power ops in JH7110
> > > > visionfive2 board")
> > > >
> > > > -----8<----------8<----------8<------
> > > > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > > > index 50df66de24e06..069259f7d7c15 100644
> > > > --- a/drivers/mfd/axp20x.c
> > > > +++ b/drivers/mfd/axp20x.c
> > > > @@ -1458,8 +1458,14 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
> > > >                 return ret;
> > > >         }
> > > >
> > > > -       if (axp20x->variant != AXP288_ID)
> > > > -               devm_register_power_off_handler(axp20x->dev,
> > > > axp20x_power_off, axp20x);
> > > > +       /*
> > > > +        * The VisionFive 2 handles AXP15060 poweroff through OpenSBI.
> > > > +        * Avoid accessing the I2C PMIC from the atomic poweroff path.
> > > > +        */
> > > > +       if (axp20x->variant != AXP288_ID && !(axp20x->variant == AXP15060_ID &&
> > > > +                               of_machine_is_compatible("starfive,jh7110")))
> > > > +               devm_register_power_off_handler(axp20x->dev,
> > > > +                               axp20x_power_off, axp20x);
> > > >
> > > >         dev_info(axp20x->dev, "AXP20X driver loaded\n");
> > > >
> > > > Please let me know if this works on your board?
> > >
> > > Yes, that works, but I don't think this is the correct solution to
> > > disable here. Also this won't scale for future boards which might use a
> > > different existing PMIC driver with poweroff support and that will also
> > > need to be patched.
> > >
> > No changes needed over here, reboot and power-off priority will
> > work fine.
> > > As pointed out by Troy in an earlier mail, the real problem is the
> > > priority at which the handler is registers, 192 for the reset and -256
> > > for the poweroff one. I wonder if the SBI SRST extension should also
> > > register the poweroff one at 192. It seems it's about replacing the call
> > > to register_platform_power_off() by register_sys_off_handler(), which
> > > supports using a priority value. And maybe SYS_OFF_PRIO_FIRMWARE = 224
> > > should be used there instead of 192.
> > >
> > Thanks for your input; with the changes below.
> > It works fine on Spacemit k1 and Starfive Vision 2 for reboot and power-off.
> >
> >  arch/riscv/kernel/sbi.c | 51 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 39 insertions(+), 12 deletions(-)
>
> Thanks for this patch. It sounds good overall, and it's always good to
> switch to the newest API.
>
> I have been able to test it successfully on VisionFive 2 and Banana-Pi
> F3. Please find a few comments below.
>
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index af1ccea222f1..32a3d2df9032 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -512,23 +512,55 @@ static void sbi_srst_reset(unsigned long type,
> > unsigned long reason)
> >                 __func__, type, reason);
> >  }
> >
> > -static int sbi_srst_reboot(struct notifier_block *this,
> > -                          unsigned long mode, void *cmd)
> > +static int sbi_srst_reboot(struct sys_off_data *data)
> >  {
> > -       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> > +       sbi_srst_reset((reboot_mode == REBOOT_WARM ||
> > +                       reboot_mode == REBOOT_SOFT) ?
> >                        SBI_SRST_RESET_TYPE_WARM_REBOOT :
> >                        SBI_SRST_RESET_TYPE_COLD_REBOOT,
> >                        SBI_SRST_RESET_REASON_NONE);
> > +
> >         return NOTIFY_DONE;
> >  }
> >
> > -static struct notifier_block sbi_srst_reboot_nb;
> > -
> > -static void sbi_srst_power_off(void)
> > +static int sbi_srst_power_off(struct sys_off_data *data)
> >  {
> >         sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> >                        SBI_SRST_RESET_REASON_NONE);
> > +
> > +       return NOTIFY_DONE;
> > +}
> > +
> > +static bool srst_power_off;
> > +static bool sbi_srst_available;
>
> Not sure we want global variables for this, as they are not used anymore
> once the initialisation is done.
Correct, srst_power_off indicates whether SBI SRST poweroff is available,

The sbi_srst_available boolean flag indicates whether sbi_init () detected
the SBI System Reset (SRST) extension during early initialization.
It allows the deferred initcall to register the sys-off handlers only when SRST
is supported, avoiding a second extension probe.

Ok I will remove them.
> > +
> > +static int __init sbi_srst_sys_off_init(void)
> > +{
> > +       struct sys_off_handler *handler;
> > +
> > +       if (!sbi_srst_available)
> > +               return 0;
> > +
> > +       handler = register_sys_off_handler(SYS_OFF_MODE_RESTART,
> > +                                          SYS_OFF_PRIO_HIGH,
>
> I think you should use SYS_OFF_PRIO_FIRMWARE for both entry. It
> corresponds to the reboot provider.
Ok I will modify this.
>
> > +                                          sbi_srst_reboot, NULL);
> > +       if (IS_ERR(handler))
> > +               pr_warn("Failed to register SBI SRST restart handler: %ld\n",
> > +                       PTR_ERR(handler));
> > +
> > +       handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> > +                                          SYS_OFF_PRIO_FIRMWARE,
> > +                                          sbi_srst_power_off, NULL);
> > +       if (IS_ERR(handler)) {
> > +               pr_warn("Failed to register SBI SRST poweroff handler: %ld\n",
> > +                       PTR_ERR(handler));
> > +       } else {
> > +               srst_power_off = true;
> > +       }
> > +
> > +       return 0;
> >  }
> > +device_initcall(sbi_srst_sys_off_init);
>
> Any reason to use a device_initcall as opposed to just calling the
> fuunction from the sbi_init function below? If so, please provide the
> reason in the commit message when submitting the final patch.
>
Initially, I called  register_sys_off_handler() directly from
sbi_init(), replacing
the existing register_restart_handler() and register_platform_power_off() calls.
However, the kernel failed to boot with this change.

The sbi_init() function runs during early RISC-V initialization,
before the kernel
memory allocator is fully initialized. Since register_sys_off_handler()
requires dynamic memory allocation, calling it at this stage is unsafe.

Moving the registration to a device_initcall() defers it until the
required initialization
has completed. I will document this in the next revision's commit message.
> >  /**
> >   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> > @@ -643,7 +675,6 @@ int sbi_debug_console_read(char *bytes, unsigned
> > int num_bytes)
> >
> >  void __init sbi_init(void)
> >  {
> > -       bool srst_power_off = false;
> >         int ret;
> >
> >         ret = sbi_get_spec_version();
> > @@ -677,11 +708,7 @@ void __init sbi_init(void)
> >                 if (sbi_spec_version >= sbi_mk_version(0, 3) &&
> >                     sbi_probe_extension(SBI_EXT_SRST)) {
> >                         pr_info("SBI SRST extension detected\n");
> > -                       register_platform_power_off(sbi_srst_power_off);
> > -                       srst_power_off = true;
> > -                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> > -                       sbi_srst_reboot_nb.priority = 192;
> > -                       register_restart_handler(&sbi_srst_reboot_nb);
> > +                       sbi_srst_available = true;
> >                 }
> >                 if (sbi_spec_version >= sbi_mk_version(2, 0) &&
> >                     sbi_probe_extension(SBI_EXT_DBCN) > 0) {
>
> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

Thanks
-Anand
