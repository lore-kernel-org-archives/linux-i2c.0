Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794814595;
	b=aWGO/kQgrtw2IzSVFSsYNojc4IzRBZiK7nowRaMdXGiC7nSnuTt6QeWbiP/12Yeha2na
	 YuOiWaWjY6yNvmLK77IuYfq6AbXh+SZoyl6GcdKYhQaOaC6Bm9YP/wGzihwoDt43+R01G
	 M/rIupTOYNwW4YfRXLB966sQsCetRtFb6Lp42QgqFooeQF+EfF3KBijdjqdOug1ie24hj
	 L4ZULrYlmefqalvO1b3QrMaUJHATAhCU5pQSwHt0DTwLUtmAQCgxIPVan5A2UWM6qlM3F
	 WX4FwnSIoSDDllsV5LfalJ1+xXfQbMHshm+gGLjpM5Fz1UlVbj5JhjCz2ElNIg2+ktA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
	b=AWNA4KYt07Rs0dD9DwRHu8Yx1mF363RSN66VzldfHhwdFHMEY3LIHVj216AND9Xl38FW
	 8ZP4OUJeeJzkwNkQPAfmHnS3EyzK81lYINj3pp8z+DO5pMRdMMwnl9Iwq2asdVr/+CSOl
	 SdKBRD9EZOZoPkmGUE4aLJfpQMslROK3eCjkUaIWNR0X61TSZyq+c3zJrufnm/Dl3iUps
	 Oc46RHIL2upVo7PWGY+mPVrITaBITY01EuhSHnXg/ay0TbgeU1UwfEJmPlxO9cXQdLXgn
	 mQSTieS9luaSGXsuYbkpv7O14A92gjktMMb9mhdInPbfr/APTrGzYwKmAUcE3JwG6aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnQnW5MM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7988606A8A5
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 07:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7988606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnQnW5MM
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so3785535a12.0
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 23:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794814583; cv=none;
        d=google.com; s=arc-20260327;
        b=UriMn5wiAsgMV6ZYyl5PTobI8GkJ2dmKFflLJgZxqe82XLhN6OVaTwOHAa2/uaUTNB
         b3cpkMUc5y4kgpBMdeXeAvp1iM05G1PrcEe7yr4o8bN0W9ul0jbrCYskIKibyYiV3ryb
         3I5u+CML3oGiJVDpKt7EZoeT/aXQCRt/ZHgR7/Apx5FoNzlmo0wwCDPIoyMxzE9Dlh4D
         6MKokyuzksFeMH0+aD8Q3gEyl0NK1f6vvI5oZKPGnJvhhLWkF+OBYarOqcD+w2L58/+n
         w2xasruk5AW93iqBEJi2dWwjO3VZDmtGwmGpEFoWD0z0pZRPdFXXQU6fwUO4jh3wy2Q3
         95bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
        fh=vJZZq8cBlm8MilNMD3tgqwP6uY7vUXm/AzJKZfWT7lc=;
        b=QRFRCJET14mTvqlYN/3kidd4jh3kVvFpA+jrV5jpash9QSf0MejqVaUnmH/aDbb0Ja
         qg+lkLtAgan3o2hQN0Fp97kSyVYZYK3Fjfs0zjDvQtGG9vcDMXDVNAyONoRMuQ8I1TkY
         XWCPwG9bAMgU6zfpcliKIRQCjccb6yJhfaEb+7GI02gRpgbLrQNRVEGz17CHK//0fZji
         CnYdVTe430KeNy5v8mR1fwqWw3AJlrTiLksRKroDksnp7eMNolEbjblmB/kboi9roGvP
         F383BkD3C0lucNCyOiJdtt/YzNfEWcqsx03b0fa6eddB6opHloUtYFjeKpjG5OLzKAsc
         FGjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814583; x=1795419383; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
        b=ZnQnW5MMlw8g4UDJend73b2EqQM0QB6Z8uyJYgtQ4aWw+rMVJoWthx1owv+BmRqFOb
         BaV9WEsevPIZPRXbf67ehZ2/dHGqWOZumsHCVrHC+7bSpy1pqBprWCWjAd/qANlycO9k
         mkdoQkVuTYaLPCk8+WXG7XLf0drxrF4UZLTQaG3NK1fY/WNM4/vsqkg32Ngp9X8HHziM
         6hmqdHWBTZh85dtGyW43TYABPZ+oayr3KHt4yRA/5c3HIdT1CHuTrvD6uEWQshbPdDGX
         S65NCW40Wgb6igu9RrFlVaKXoNFE+80lUaqUlStIfZQTiODQiRQkUhOPtunUJCYWnmJ/
         HZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814583; x=1795419383;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NuMRN9mlOmZCEKh1xHdz4U4CqJ8o4hxQExiC+l3Niro=;
        b=NKPtCHALE8Csw14uULrl0jspm6qUtmLBHIA5UemtemlOUQtYXGDst+dc/INunXhO0g
         tBgt/fQEiF+q6v/FkBJeybg82Xwcv31+0WQ01mQJIQkHri4wKnG2IN2ZD14rdj19N4np
         WyHdTWiWZuwjXpvo/qKjClODTNLH8Wf/mbhA1QP0a2vAWQ5hhzzRZm84t88luPARKTBe
         eB+/HCptvawDMrbmQNR1+eC6D5/NwkH9SWw0R8laB3iK1o+4K8IMN278n/8G3udB0evO
         0R5IZjiyP7QBSW47kcmER511GaBQgibFMZGC/vbN9C3evtcHpIPNWRh0zFtygI8z2+1E
         IUXg==
X-Forwarded-Encrypted: i=1; AL+hErF9UKHAMB6JKzULGJDH5w4HeKldmRfBHQTR0mwHuAYwzXNwX2OpN5BlO7ZpRsKA5UJ5TrcZtvM4yI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iE7Ht0MBiJz5yGAnP4yzmwdHBTNx/X4BTBL6t0B3M7+phvRVI
	GKrLPbEZY0wur7IAZsoFEpQpk+/Yh7zwpEP+dGL434pKB5Yaot818pUj39Lpqfiws44DtQhwRDC
	/wrsHKl9TWtSXLMAMCNVyl74UZI9jJpfEHDl5
X-Gm-Gg: AYBFou3yz8a9Yyb+knnbaP5A1CU542aU9xRvJqOFTvkEgF+vDwG25gE9K77VnNmKeGv
	fEOHv7nC7jzQzZqeU0mDzOEHC5h4p6kK1n8Ydgo+DyqErSFY9B9vs19YwIMgA174zJNGD4aS7/r
	PN+zWoYlj4PjCY5SWjND35tTkuynlYyOvI9UYjeMUZDt4pUYMVxgARXdOmPYvZeAedZLN/SxROT
	MpGwFDVk3aoJbIipK94wCSTOdTSA8Yxz+hkNWuLMga9ndGRT6KS99lTUtd2x+8WnVIR2dbV2YyV
	/Zc1I+vkEW7eF6cxialsRXRyHkLhmmPR4VWTjmQN1HqZp5/AuXs+L679+jjotmVZG1lrHcJ9k4l
	v483VfhfQc7+9sUgzkkpTtdn1/9uc/ujxTSkGIWESFG29dLNtzHM3gJeF
X-Received: by 2002:a05:6402:5d4:b0:6b5:5fc8:9ca2 with SMTP id
 4fb4d7f45d1cf-6b7c0c7dc86mr6801231a12.34.1794814582850; Sun, 15 Nov 2026
 23:36:22 -0800 (PST)
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
 <avpN-gFOvTBAMY6G@venus>
In-Reply-To: <avpN-gFOvTBAMY6G@venus>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 16 Nov 2026 13:06:08 +0530
X-Gm-Features: AclHuK_zi0cJ5esU4k_l4Yl1mv76j_qYKuptpaeB4AEIgcR7sleibDfPZTNW_HY
Message-ID: <CANAwSgT_k35_waHL-+iU93f=k3fjFAPXhk=exRz-XHMm2MqREA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Yixun Lan <dlan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, 16 Nov 2026 at 11:33, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> > The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> > to access the PMIC. However, these handlers run in an atomic notifier
> > context (specifically within an rcu_read_lock() critical section), while
> > the I2C-backed regmap uses a sleepable mutex.
> >
> > This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> > context switch in the RCU read-side critical section during shutdown on the
> > Banana Pi BPI-F3:
> >
> > [  563.803475] WARNING: suspicious RCU usage
> > [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> > [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> > ...
> > [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> > [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> > [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> >
> > Replace the regmap operations with atomic I2C transfers to avoid sleeping
> > in an atomic context. Preserve unrelated register bits through
> > read-modify-write operations and check for atomic I2C support before
> > registering the handlers.
> >
> > Obtain the I2C client from the parent device and verify that the adapter
> > supports atomic transfers before registering the handlers.
> >
> > Tested on the Banana Pi BPI-F3 (SpacemiT K1).
> >
> > Assisted-by: LLM
> > Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff/reboot")
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
>
> regmap runs i2c_transfer itself and thus also uses the atomic I2C
> transfers. The problem here is regmap itself. But instead of moving
> away from regmap, the atomic use case should be supported properly
> in regmap.
>

On  RISC-V platform, poweroff and reboot are already handled by OpenSBI
through the SBI System Reset (SRST) extension. Linux delegates these
operations to firmware using SBI_SRST_RESET_TYPE_SHUTDOWN for poweroff
and SBI_SRST_RESET_TYPE_COLD_REBOOT or SBI_SRST_RESET_TYPE_WARM_REBOOT
for reboot, depending on the supported reset type.

Therefore, there is no need for an additional Linux PMIC poweroff/reboot handler
on this platform, as it duplicates functionality already provided by firmware.

While supporting atomic operations in regmap may be useful more generally,
it is not necessary to address this platform's shutdown and reboot requirements.

I tested this on the SpacemiT K1 Banana Pi BPI-F3 after removing this PMIC
poweroff/reboot driver.

OpenSBI commit which handles this extension

d9637d00bf47 ("lib: utils/reset: add SpacemiT P1 PMIC support")
b10e18ec854a ("lib: utils/i2c: add minimal SpacemiT I2C driver")

Similarly, on the StarFive VisionFive 2, poweroff is handled by
OpenSBI through the
AXP15060 PMIC, so there is no need to register an additional poweroff
handler using
devm_register_power_off_handler().

OpenSBI commit which handles this extension

568ea49490d9 ("platform: starfive: add PMIC power ops in JH7110
visionfive2 board")

-----8<----------8<----------8<------
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 50df66de24e06..069259f7d7c15 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1458,8 +1458,14 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
                return ret;
        }

-       if (axp20x->variant != AXP288_ID)
-               devm_register_power_off_handler(axp20x->dev,
axp20x_power_off, axp20x);
+       /*
+        * The VisionFive 2 handles AXP15060 poweroff through OpenSBI.
+        * Avoid accessing the I2C PMIC from the atomic poweroff path.
+        */
+       if (axp20x->variant != AXP288_ID && !(axp20x->variant == AXP15060_ID &&
+                               of_machine_is_compatible("starfive,jh7110")))
+               devm_register_power_off_handler(axp20x->dev,
+                               axp20x_power_off, axp20x);

        dev_info(axp20x->dev, "AXP20X driver loaded\n");

Please let me know if this works on your board?
>
> -- Sebastian

Thanks
-Anand
