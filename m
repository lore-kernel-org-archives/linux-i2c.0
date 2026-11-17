Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794918872;
	b=Z0fVNjSz1PuiMZezFkIFkR90ZjJ+NFtfV4zpixgUuSxpgpykQGg/+uA2Sj0Zv2cJcDCb
	 8QAGf2l/jD9LVB0ItCkqcP0s56VTdd3sgax3ocVHAwpR1yEsM/vTBg8R8kNGngKj6DqYX
	 zzuLj8M6Zsi6lPfvz4xkRWy3/rA0VTCKJGY6Tz0gpwQ3XJ3uxZk8GtyaRg4MIMj7OgJnU
	 9N0IZRGJ/cvSPAGoh/F9gNNg68wiRTX0nUA7I2Jd7DI5dWLbuz1eM0a3qTPinBXRiH7G1
	 x/CfMjIjgfiryNctO+Tr40GSJ7b11oAI/e7DmiOHR0zRcMNDFUZKTXMq0cYeSChBIVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=R0C1suA4SxiusRHiawiUCOcPgTxU2RpEnv1XCXIekfM=;
	b=Vc3d7i1lH1U2jE8QRNt1HZCeFwIU/rdoyXHxeYDeYqa76P/mt6MTpucFSqWAqNIfLQPP
	 cE9UMKAMX4NsN6MDFARbhwLwuxtmqtMBx1tf9ttcsg7d3q/RioVT2ohnFa0WuN5Szu+yW
	 5+j1tG6Z/zXBM2IonNz8iv6jf7Aw4gPJC/E0Mft/qwR5nKbjrx+LRa/ybUlynjbHu68Yc
	 PQn1SfHHYT1dS2IVSJbmYf8tnbdmtQF69hh2Y6iW9ngCTv36ga7WyyoJZlP+kqNKeRC+N
	 BIyvIlxcYFNaXM5HF6j+hd3Jj7TF4NXQDm6T6IPLjU9Pl3LLEebm28QJLu+msOEbjig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1rjWLSk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11F606A8A1
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 12:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B11F606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1rjWLSk
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b757029223so5606908a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 04:34:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794918867; cv=none;
        d=google.com; s=arc-20260327;
        b=aYBZCyCwmGvQbLVYTZF1raRc9QA2itBBRlurjYclHoXf1K8q+hIANkKUzzXPd7hsiv
         NBP6MaiCVQNxx2X8x/ZoNtmaYra5oKCbnzJj2up2/l8N7L4egRuS9fd6tXzsuE8Li6ub
         m7gLen3uDo//NIywjw55GuRAuY3CJr47YN0PMvRSr6BWOMbaEl1EekX2YfiTpFLPjkLr
         sIgLEDFZNhBdybDQ6snV0x3VIZc1YZNHFr5a+o6vOBReZm3efy2LBw68JHyG4nPW/y+a
         YeoIFe7Tg2gKYy4Hd75dxhMnVEvq//ZFHerkhP0Y7pGfCJl0eGRG59VWrRAkYGhXFZGI
         ww7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=R0C1suA4SxiusRHiawiUCOcPgTxU2RpEnv1XCXIekfM=;
        fh=cvH5/f2D65vUFFDq/kE1EOztfm4cflVXjuVrL8lZs4Q=;
        b=k6sZ8Dc1Z6tl9xSacv/GPOS1EgceWr6tiC/2a56b+ExyCXnv3dLRgiWmiF4qIa1fmx
         9f1ObQEHT2y3QIXJJ+BFvFS4bmGluNpi2rM21HJFgr0aJ9pP91IoOodcjNLqtvMYXGx4
         x8xIBoqYaeFUMEcl5uHRifAiOf6lvDel9lukQpztmhtaNdCTMJSbUW24nzzNlAsqsvN9
         TMnXqe49Vt0IVT9GlPsTZFdzuaAp9wz8RvQTDqkieAXOKcTFgns9infoIAQ/pptQywL9
         CVL9JekISoqS8EwpFt86a5UueMtGU/tR6TxzFsOoZy7TLI15LjpScV1WibuDrNxfdrjI
         /jwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794918867; x=1795523667; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0C1suA4SxiusRHiawiUCOcPgTxU2RpEnv1XCXIekfM=;
        b=N1rjWLSkLdwh0E7jWov8qkbMBi8fHXFij6VQGin1fve9HGSVlL92toijae487NzqSo
         2Jhg7fsgyvwTLCMi+6kNvqyKMZV/izFeJSzay8sKEBz1xmQ66VEjcusd5mPlpWstyEZk
         EMs9vkPxN94nrL2On8FF8j9r/n32yxkwz7uGZyN6noLo6p+CQiL3/u1sQ0wYaKkgvgDI
         YKomDRWoIK1PssDkqvpNyuOWWDjUh7BrhBLivziEtKM+zBzV1EC5eWgrfRZ83GnDXbOn
         g4kOW2fhlAY/idqM0ueK905XFwWWs/OzrLc14WR3LOedUBJ949nfxKhT7nALtLQSg0cf
         S/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794918867; x=1795523667;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0C1suA4SxiusRHiawiUCOcPgTxU2RpEnv1XCXIekfM=;
        b=VG6PIvdFGYKqSckbR07KN4NckxeB5On3kc3KszG7jEa7sd2j9JNtHnyGZg2+orNclH
         fR5VoEurWBvaWmGJvX8po0njCxBf0ykDa7jh+Fdfyf8CQPyPFb4L5rgqAjWCaO/TkVE5
         Zz/XQRuSNx2hXmXitJPfesVceH2bv2PxAE2u5WsuhqTJ/t0ia+SZwbOA6fZEZieDhnJA
         CedqKJ948A4wZ12y7bEtMvgqkKGqYf2BUeg0YjkAUA+z07ym9g/QoLutTeL6CrJlQB0C
         526fsJzqmP/L0PjCHAqpmT6IKudIn/L7eYerm8hnM2qqnfbPkp33+ReBvRY5dhAHtpSC
         U1Jw==
X-Forwarded-Encrypted: i=1; AL+hErHztPRR9tcM9lkaMojkB5C6ybl2E9+M2ZJUiiOKiB2J6z5KbjOSMkn9TbP28nn/MusiE6Mhb+RtIH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NJXR+YETFIB2OETW3vqJFI559nk3z4pk9lF/IAMvJIqKuTn/F
	F/SlffQcdRlRa544mn/t8rn0BW6DsVDsE93p3heaSZUod9QRvhqOdQeZORmyhtoOTDslbuwTeE7
	FXqHhh7LPBSpfJ5tngo40MtFF2OaD6EmB3DZm
X-Gm-Gg: AYBFou1OVQFo8GC7ET/NsLV+I8wg4vTxRT6J4ad5Gp6nPpOYJOFCOzw/KQxGTANJyUQ
	jhRoQGi90Y2Rq78aSkCWK+PEFw7479Z57CDB/S3aOVVo33Zz9qUU7rMEz/PkJSTQGhfX7ro9GRN
	C6maBADkLPrdfPnoMKezhM4+fPlyGa/JD9JklzSVhFoizEImLXNLvQD3EMYD346ImOXjfuPxZ0T
	wnuzAPsQ5aQmaAwo1Wk56/GgeDhMDOtHMQw6uderJ1CYgZoXr9sh2YOQG5T28ZOwU6P+iMv7oPS
	6ZfVPyzW5Us6MlXoAR7BooG0mGQni4qHHuiVu1Q/h0nKdZNuLOC2tHdvsEnKQe5uz1H4YTvipNJ
	g0huzrQgAFDtUnjAS93dmEIodyzcQswbKM0s=
X-Received: by 2002:aa7:d14a:0:b0:6b7:b872:2799 with SMTP id
 4fb4d7f45d1cf-6b7c0998ba4mr7830416a12.19.1794918867146; Tue, 17 Nov 2026
 04:34:27 -0800 (PST)
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
 <avvnRkK9agPSdzac@aurel32.net>
In-Reply-To: <avvnRkK9agPSdzac@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 17 Nov 2026 18:04:12 +0530
X-Gm-Features: AclHuK_kx8zawYGaheU3obBfG0RSjShsNOB5FZzf0Hf2ULzVFDROSleg0QHq__c
Message-ID: <CANAwSgSXP1bZVVrX71jfgi1iR9AY4TpM0pk07ke+oeLvcX1fEQ@mail.gmail.com>
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

On Tue, 17 Nov 2026 at 11:04, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi Anand,
>
> On 2026-11-16 13:06, Anand Moon wrote:
> > Hi All,
> >
> > On Mon, 16 Nov 2026 at 11:33, Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> > > > The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> > > > to access the PMIC. However, these handlers run in an atomic notifier
> > > > context (specifically within an rcu_read_lock() critical section), while
> > > > the I2C-backed regmap uses a sleepable mutex.
> > > >
> > > > This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> > > > context switch in the RCU read-side critical section during shutdown on the
> > > > Banana Pi BPI-F3:
> > > >
> > > > [  563.803475] WARNING: suspicious RCU usage
> > > > [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> > > > [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> > > > ...
> > > > [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> > > > [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> > > > [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> > > >
> > > > Replace the regmap operations with atomic I2C transfers to avoid sleeping
> > > > in an atomic context. Preserve unrelated register bits through
> > > > read-modify-write operations and check for atomic I2C support before
> > > > registering the handlers.
> > > >
> > > > Obtain the I2C client from the parent device and verify that the adapter
> > > > supports atomic transfers before registering the handlers.
> > > >
> > > > Tested on the Banana Pi BPI-F3 (SpacemiT K1).
> > > >
> > > > Assisted-by: LLM
> > > > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > > > Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff/reboot")
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > >
> > > regmap runs i2c_transfer itself and thus also uses the atomic I2C
> > > transfers. The problem here is regmap itself. But instead of moving
> > > away from regmap, the atomic use case should be supported properly
> > > in regmap.
> > >
> >
> > On  RISC-V platform, poweroff and reboot are already handled by OpenSBI
> > through the SBI System Reset (SRST) extension. Linux delegates these
> > operations to firmware using SBI_SRST_RESET_TYPE_SHUTDOWN for poweroff
> > and SBI_SRST_RESET_TYPE_COLD_REBOOT or SBI_SRST_RESET_TYPE_WARM_REBOOT
> > for reboot, depending on the supported reset type.
> >
> > Therefore, there is no need for an additional Linux PMIC poweroff/reboot handler
> > on this platform, as it duplicates functionality already provided by firmware.
> >
> > While supporting atomic operations in regmap may be useful more generally,
> > it is not necessary to address this platform's shutdown and reboot requirements.
> >
> > I tested this on the SpacemiT K1 Banana Pi BPI-F3 after removing this PMIC
> > poweroff/reboot driver.
> >
> > OpenSBI commit which handles this extension
> >
> > d9637d00bf47 ("lib: utils/reset: add SpacemiT P1 PMIC support")
> > b10e18ec854a ("lib: utils/i2c: add minimal SpacemiT I2C driver")
> >
> > Similarly, on the StarFive VisionFive 2, poweroff is handled by
> > OpenSBI through the
> > AXP15060 PMIC, so there is no need to register an additional poweroff
> > handler using
> > devm_register_power_off_handler().
> >
> > OpenSBI commit which handles this extension
> >
> > 568ea49490d9 ("platform: starfive: add PMIC power ops in JH7110
> > visionfive2 board")
> >
> > -----8<----------8<----------8<------
> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index 50df66de24e06..069259f7d7c15 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -1458,8 +1458,14 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
> >                 return ret;
> >         }
> >
> > -       if (axp20x->variant != AXP288_ID)
> > -               devm_register_power_off_handler(axp20x->dev,
> > axp20x_power_off, axp20x);
> > +       /*
> > +        * The VisionFive 2 handles AXP15060 poweroff through OpenSBI.
> > +        * Avoid accessing the I2C PMIC from the atomic poweroff path.
> > +        */
> > +       if (axp20x->variant != AXP288_ID && !(axp20x->variant == AXP15060_ID &&
> > +                               of_machine_is_compatible("starfive,jh7110")))
> > +               devm_register_power_off_handler(axp20x->dev,
> > +                               axp20x_power_off, axp20x);
> >
> >         dev_info(axp20x->dev, "AXP20X driver loaded\n");
> >
> > Please let me know if this works on your board?
>
> Yes, that works, but I don't think this is the correct solution to
> disable here. Also this won't scale for future boards which might use a
> different existing PMIC driver with poweroff support and that will also
> need to be patched.
>
No changes needed over here, reboot and power-off priority will
work fine.
> As pointed out by Troy in an earlier mail, the real problem is the
> priority at which the handler is registers, 192 for the reset and -256
> for the poweroff one. I wonder if the SBI SRST extension should also
> register the poweroff one at 192. It seems it's about replacing the call
> to register_platform_power_off() by register_sys_off_handler(), which
> supports using a priority value. And maybe SYS_OFF_PRIO_FIRMWARE = 224
> should be used there instead of 192.
>
Thanks for your input; with the changes below.
It works fine on Spacemit k1 and Starfive Vision 2 for reboot and power-off.

 arch/riscv/kernel/sbi.c | 51 +++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index af1ccea222f1..32a3d2df9032 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -512,23 +512,55 @@ static void sbi_srst_reset(unsigned long type,
unsigned long reason)
                __func__, type, reason);
 }

-static int sbi_srst_reboot(struct notifier_block *this,
-                          unsigned long mode, void *cmd)
+static int sbi_srst_reboot(struct sys_off_data *data)
 {
-       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
+       sbi_srst_reset((reboot_mode == REBOOT_WARM ||
+                       reboot_mode == REBOOT_SOFT) ?
                       SBI_SRST_RESET_TYPE_WARM_REBOOT :
                       SBI_SRST_RESET_TYPE_COLD_REBOOT,
                       SBI_SRST_RESET_REASON_NONE);
+
        return NOTIFY_DONE;
 }

-static struct notifier_block sbi_srst_reboot_nb;
-
-static void sbi_srst_power_off(void)
+static int sbi_srst_power_off(struct sys_off_data *data)
 {
        sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
                       SBI_SRST_RESET_REASON_NONE);
+
+       return NOTIFY_DONE;
+}
+
+static bool srst_power_off;
+static bool sbi_srst_available;
+
+static int __init sbi_srst_sys_off_init(void)
+{
+       struct sys_off_handler *handler;
+
+       if (!sbi_srst_available)
+               return 0;
+
+       handler = register_sys_off_handler(SYS_OFF_MODE_RESTART,
+                                          SYS_OFF_PRIO_HIGH,
+                                          sbi_srst_reboot, NULL);
+       if (IS_ERR(handler))
+               pr_warn("Failed to register SBI SRST restart handler: %ld\n",
+                       PTR_ERR(handler));
+
+       handler = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+                                          SYS_OFF_PRIO_FIRMWARE,
+                                          sbi_srst_power_off, NULL);
+       if (IS_ERR(handler)) {
+               pr_warn("Failed to register SBI SRST poweroff handler: %ld\n",
+                       PTR_ERR(handler));
+       } else {
+               srst_power_off = true;
+       }
+
+       return 0;
 }
+device_initcall(sbi_srst_sys_off_init);

 /**
  * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
@@ -643,7 +675,6 @@ int sbi_debug_console_read(char *bytes, unsigned
int num_bytes)

 void __init sbi_init(void)
 {
-       bool srst_power_off = false;
        int ret;

        ret = sbi_get_spec_version();
@@ -677,11 +708,7 @@ void __init sbi_init(void)
                if (sbi_spec_version >= sbi_mk_version(0, 3) &&
                    sbi_probe_extension(SBI_EXT_SRST)) {
                        pr_info("SBI SRST extension detected\n");
-                       register_platform_power_off(sbi_srst_power_off);
-                       srst_power_off = true;
-                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
-                       sbi_srst_reboot_nb.priority = 192;
-                       register_restart_handler(&sbi_srst_reboot_nb);
+                       sbi_srst_available = true;
                }
                if (sbi_spec_version >= sbi_mk_version(2, 0) &&
                    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
--
2.56.0

> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

Thanks
-Anand
