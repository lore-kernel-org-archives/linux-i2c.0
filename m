Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794294273;
	b=5m57RZ0M80Js27k1AStbLwQbNM6HKt9A8W9IShcS/5dCX6agtycjDj6F3ld1CpE3ym6i
	 K/NUvvaX5cX3SV+x4hsKXCD1N1xcfx3hbGxEmmH7N9EZLrQscjI4bN1i0pK/HA3Var9op
	 /fR3qhTlWvtXH6QQ7A/rt7uOaYoqnzekD50FCiVB7yRYhG0rlDRV4BC5xLRBy/6syT3i1
	 y3WOtqcyxCdMBIzuJ6qpflkPwyHq3/fcw2Zxxb9AmTRDzuCLc3yqf0TspbSxHCCKhPzFJ
	 koKXOBfNxi4gaRnYOWA5rEMuVJz4U4LWWfnkmG9DzmAyNfhsVVxEgV//RpEVXJ8rlIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
	b=qSO/0H9MKDMB4bvm4yLQw5zgc7eKzVDRqfFz77Mk0hdKGCwUwNXhfh8uOiQ5anS3x5S3
	 nawLzU+GXC/I6SpnEEUlgWawKcFXG+3PUKkabmscGF/+6p7iZPCJiog8LOG7glKAwMNIu
	 07Iqk68ObU8xFIg7rtHtnlrQGQRByTW5gSQruxpGkaMPmC+VYzIAVpjzfvLV/5Bf4Be7z
	 A/1hvdvWMuT1Tgkm84FGeTW/7Q7CCdKWX8Xgz6K/8N5V8BgRRL2y/Ll+sPJp5CaeDGrp/
	 nKIyhUQTSqN/DhwM/PRpxnL6Vfq3+rracgmzSsurNZMlfh7fDlc+Quc9KlhLVkPILlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8Fz+pUk;
	arc=fail smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55762606A321
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 07:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55762606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8Fz+pUk
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2752115a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 23:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794294272; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhGEd++Av3/bKAKywxTCnSB+F9TU92Gkz/nKF/d+8vxPAbpHpX2Vdq0tjNia1CnKYb
         1bD5m5d18QrjEYuAlLYEeHe2/0JUnhy+UzCKeQwhS+GKjnvCSD7YO+uMGH29UFiygt19
         kZ8m+kE8UWL6+2I6KMHSNTVQNb/GPn1FCMqgxMrhEjK4WBNtr5VHaeXtNda0HOYr6IVd
         gbMojUQuPg/CjcFRUuJ5euYWrDI8jLERfosLig5XUb6jgv1ZgHiR6R8gysyiBctrApmf
         PiYR/FYkjIoMpVgELDbE5d8ZBblXuZ3I64UX6Hj7T+axoZ7AzXMtzUGU0UZtFcArmphI
         bLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
        fh=lYR1Imw8oHdk6t1POCW3aIWkj4wlWppKyK48UEBYq3Q=;
        b=bbvSH8+/iPUbalpPfVM4qychrE0IwOv+Nw+37TTB55R3hhvuXUYpyjfubHsypriGoD
         fpNqZ8H33KGoKSZ/3iHLFOl2vh81vJ9P3/jjLgtkPVPbHkschIwD/aoZ9aUq1W0+eLX6
         p6OtYXazd9bcP5pZPrYRtUJp74hDJu0NQLpwjYLz0dBZ1flRbawXtaoGRg3nwS9IAVVl
         hJ8iwF6b87Ehw/0EmN+rr72VmOmxVLWDq+f7wMKwQ7NDy55GwjuwSCIhyY4rBWePT4EJ
         hDJg1BiAcObSI39VprUYQ8klYJ/YWK2kd1AybVeZq99UrSLjbmuQPTYAmeZm+Ly/wdQI
         FWtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794294272; x=1794899072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
        b=g8Fz+pUkZixQzSh9e2idFtncVxS6j+NGGEZZa2lSqnzxQkB1hqczJADO9xnq+rBc6Y
         1Kh3IUy5TF1yBwURnLO/LkQGNgLQJgtHbcgRbPbtcpYwn06Ows9DONJ46b+ISSdkPney
         G+qiWAcYINW4/XIkTB5elPNc/Vd8+so2LmpijE9N1ipFlXeFkQXxlUbTFYmRqZpIoOdE
         dq6BS12Yqug49VJA+WclM2apV/bGg4XpHVix+s+wVuoVKalXRpkONgM4MurBbay3iP4M
         p+10Ahl/+pyx/fXh2SXXp2jGK4gG/wve9G07LuErTdahE0Z+wB4LxBX2fhhXC+NaSUjH
         YMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794294272; x=1794899072;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
        b=0Mc2cwxfIVpS+76+BEwXIqeSuxYsp1tkSG4To0TvnJNytqv4AaWytkihRHfaRs8xd6
         bYl0ZbuVX4/RiZuYlwOht8KZhRuqInot4LBG+mjuMiLan2fVjSWiEbw6V47UUWTW8R72
         ZTRQ516xZDlYP/icva3tsQ+Ekjds0kg2n5GBHYhOzYpOifjnz91dZPNt2AZp/UXPYkNL
         Y+ZRNjrt116mce/QGzbMcdb98eoTpcCgHPUGltOIVOfMp4tyLFlwic0WDPfd6y7ni3+l
         zgbUWBEwIn59RCYoQJj18jUZ24vv2SPwClRf3lKQ06TJuj/96Zg6CVrI5MaOSo/kdAG/
         3hAQ==
X-Forwarded-Encrypted: i=1; AL+hErHPrI62/xhLuGLI5mWC3tOAlkMJQURR6atkC/o84prwIED1exeLR9NOH3wdgEJon/+Ypzov1cwZWNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z96hEzr//OSCyZcrKcrzqDpzkBaAf046sCr/pYg7ngDN4PGlwM4
	MvFoOVAVBmc5kkmBglf7VfSriEzwh1Yq6xDbiRWeIeOfsHwbzSGeqIntYCoZyHsNAg6MnRhOEGW
	F5Y57fasEL4Bh96bFGcDm4Dbud58WPec=
X-Gm-Gg: AYBFou1Lgx4REECkXYDDFDuhw9FEK6qaFPUEkgmJai9Rh2/SWKPXez4DJ7/3LfsoXUE
	zfJ5ZoJPKYOIfooF7ssSKdGHtsbPWJsEjjophkq7sNj7WrrKpKFAdXkYpzcRyAqM4PnyFaC3juI
	uIgmNmRcITZpY3McOibmLz2qA05QymOvCLO1ys9AyofXvapH37GeB3GGlPJOIaXaewA//AsifLs
	JqR2sPyn8wPR9qwngLZl0AiI5hDw+3JjRU3ejl9fsUu1X97cZSs+pRGdR9yUCpwihsyeryKLXdx
	cfdoW3jJ4OEuXDN0hD09UL1TTZ5+PY9RwyZe6DRbbcM4KDlw3EsF9BxE3nSaSEMSNMgpT7u0+bp
	5a+49dyNJ1ow4nHp5+OjzEndfHhyVAbPUlv4=
X-Received: by 2002:a05:6402:239b:b0:6b7:1b62:48f5 with SMTP id
 4fb4d7f45d1cf-6b756afdd1emr945605a12.34.1794294271512; Mon, 09 Nov 2026
 23:04:31 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110061429.2036-1-linux.amoon@gmail.com> <DMRBWY2S42EN.1CNW1DNHJOKKD@linux.spacemit.com>
In-Reply-To: <DMRBWY2S42EN.1CNW1DNHJOKKD@linux.spacemit.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 10 Nov 2026 12:34:13 +0530
X-Gm-Features: AclHuK_QdgUZlVEI88uRaFYkO0SFBxHrM1OaI5F967fviYpCpm4NPd-mBXdjZBY
Message-ID: <CANAwSgRRYCjYfuW+RqpRzbWx+_Fee2xmqr-GdtWAHCsEFZF76A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in
 atomic context
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Aurelien Jarno <aurelien@aurel32.net>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, Alex Elder <elder@riscstar.com>
Content-Type: text/plain; charset="UTF-8"

Hi Troy,

On Tue, 10 Nov 2026 at 12:19, Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> On Tue Nov 10, 2026 at 6:14 AM GMT, Anand Moon wrote:
> > The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> > to wait after triggering a bus reset request. However, this function can
> > be invoked during atomic I2C transfers (such as power-off or restart
> > handlers running in atomic notifier chains), where sleeping is illegal.
> >
> > Replace the sleep operation with the driver's internal helper,
> > spacemit_i2c_delay(), which conditionally uses udelay() when running in
> > an atomic context, avoiding "scheduling while atomic" bugs.
> >
> > Assisted-by: LLM
> Also, please drop this tag. The same applies to patch 2.
> See commit 1e035297ffda.
>
Ok once I get positive feedback on both patches, I will drop this tag
and resubmit.
> --
> Troy Mitchell
>
Thanks
-Anand
