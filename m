Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FD3B71BB
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732092; cv=pass; b=axRvV9EoCHeanrJWyr99NOUGZsQaDWDbnvWobB+uc7lerYEGRuit2ihTBGtwKRE/qD0EjJHz+RQRh75GTkQNq8gUIAuWFIiK6UC9iNzL7YosvdKeZq6lfKjIhEDuewdxf0x+HTCqJLX8ps5C/7eDWf/hr/o7rpy51SW6Mch8NMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732092; c=relaxed/simple;
	bh=xIxBYCYXrUwbfUVAMqtAFWJ5BtNBzO9WfalZVCTYmfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV27SuLw6j6bdsFxel8eXbnYHzrmOSJ28Irk69k5uwjW7DQeMiod7j/PcGBcejH8zWroURD8pZ4olAMzVCSRdoPYcBehNK7Gzx66F+oD2Lk9h/Xda7TN2pTiy0qLlpEMKRX0NBj03qkuiDhm1Ebamd9h1nj39GVHOy49VC+b5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjyRTVKp; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjyRTVKp"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66d06b5f023so1001075d50.2
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 01:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732090; cv=none;
        d=google.com; s=arc-20260327;
        b=JdHLA0zbvogHYKs+vfqOYTPXYWNGFZ2ZUrMmGnlesJtDx9EZdCGCVheaoLBBbQDimh
         eLPQBRin4wlC67BNO4dWIdwwlrTyZbw8CoahajcMLjCuBtMR+QuL4MMrhbBYsi9kVRk9
         PDcWS/xzrEo2PwvGoozVcFx/kC6mbBzDqOyfXTlleU/1kPfiKg+D3QaYZadNz37vXDVk
         qa5qLNHeDYZHSlLMYLzs/q8tDKufaSQji1oQARP4EyrdVXUcYXACBWY/UXhUnK6qim9x
         UyCQM9P9c+c2zijX+ko1eJ1mjwoslls/Nhf1N0TsdFdXxzGU77/r2V830iASuIvuQM9K
         Sz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7HLmr/bZmXhN1LnAoM7xxjQ55vZGNiBeJumbqyRK5ko=;
        fh=uwHkJygj2guxyuKmyx5/tqR3uk8PNZ3aImq8OQa4sAA=;
        b=QlxQLjYgyJEKByGI7GXm3xtbVSVBAX2sMZ2M7nHpvtUBnF/dv9XYOiGTcQsHdJYP/J
         8zxGIOLrRXj91fGJbtOauvqQsJTkuTqP/c/2AKzMqrvhu1GUNv3nTgDRgWAQ/yigYgBC
         cX4lq1CmL2LO08sveZkIFo9IbyMKHdmBAoCzW/tUNpap9fflLi1ecFtIqGWD0HtPCIZU
         KF8uhJLLOntU8WpJXDm0Q+1D8eygjnGQ9xf/sRw4wMBI7zyctN03ETj3NzW1x1gUh/Zu
         c6PGmSR3QJrrntFqEhk0bpaK6b80ip+4TbACtDHNvN1ihBbg0E/5KC8JnNOEeykJcvg7
         8KTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787732090; x=1788336890; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HLmr/bZmXhN1LnAoM7xxjQ55vZGNiBeJumbqyRK5ko=;
        b=cjyRTVKpK74FOlWr3ezfpkkMqTuX2lOhlZS1S/o/wPy/kx6WNu4fGoIb+CJVeJbY8/
         nZ/l9274WnyHVakBQR93E/OAYhhs7ioeP3Hs57FFXUzCqnyCiVJ7M1RQhzs3CQoJ89oL
         yKRadYCzyOmpZZvcdIf50V9hOSV99g0vQNuy1VqMSpl/fpgFA0YiF+ZeHHI8Zuv6gXJ6
         9H3TU2RsCOPbmp5KVpgjM7V6IHhKrNNPWtBuoRidamV+yY4CB69xprnrYfLMcw282k+y
         FjbJjYGnLF+J95NLgFDO8vvRQLcM7KJcHUhbdA+kxm8YdeTicuy0XoPRVBkqO8BFXOJX
         ip3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732090; x=1788336890;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7HLmr/bZmXhN1LnAoM7xxjQ55vZGNiBeJumbqyRK5ko=;
        b=H/QwIipHXYfy8hvGs5rwnh+s00zAVu/9+DQ5ANJ3lFO53pFf2cVTIuoWH2dtS29HEg
         g4S0Rek+LC067Mgo8C6ClBpbbaV8Bn5e0m/YMubaytEvL892ZmDPcWWLjq4NjfLexpKq
         kMnnqTr1my9LtJzxCMf3x3eGw/FOxcJ15zzjbooiINUi7BjoX7PKBRj0nKRHxsmdYBxJ
         2Nw2ogQ0dA5Eizj0y5Itw1cYy51M5MHOXluJ8eCtR8A3ZA5L2DWY0Z4U3pj+YzuXAWzU
         QreHXr0RLAsR/tKwUCHOnm5wHdCexj6jFhKrWl8feS2XTXDurQEkaitAylpCsK183w0g
         WKDg==
X-Forwarded-Encrypted: i=1; AHgh+RoCj1vW1ep8RTTGfbWIdXZCfWC1OXZpKiOHcYf+xkvFlWAOmtC0XHShQO/XJAAAqZIwq8RNTp/o2E4=@vger.kernel.org
X-Gm-Message-State: AFuF++lRsU1ug5Kte8g06E5+A8eih48hxE/RSYXNaeBGq8wIhonscjR0
	onBOdKFknVd2ATE3TLfArxW4oEoC7S/YBeHMpVd3ZXdF6EHI2r3B0cLRo6EeCrclRSMGBmwnNQq
	BX9hwN3t9bvkzN5QDSgLKKrkQi7hmz2M=
X-Gm-Gg: AR+sD12csCkrO/sKcU53qfLGH2ZrpB3r7SUp/M0p69WWRYX8GPHl/724pzOx6jDXsWD
	+6rfclKqqKAsjMBUH3iXs5sJ9EFjKEUnCoUsMHNk+VIN1tcsT7FA7HJjDimULAyNa8XYlJltk3C
	mJPbam5KxYEvBqndp8iXfvaojtmEkw6tWHlMDjwHp4vha1dPSJeiN4P7yPS3R5MZlolmKR9lyhD
	oeQvitTC1VMnePD+08QMUqMrluZFGS2S6aCj/Vf46vCTz0rKLWburd63W4d0gjIVIHgwPBZpa5v
	GGvAA+Qg8ZlbUP60L+Wy9U8YYfONMV0n5hIuKLXK/7r7JVo=
X-Received: by 2002:a05:690e:4550:10b0:66d:2b87:67d2 with SMTP id
 956f58d0204a3-66d2b8768c1mr231426d50.14.1787732090507; Wed, 26 Aug 2026
 01:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812085808.3313948-1-lgs201920130244@gmail.com> <0d9ba848-bef1-4171-ba1d-edc73e65ac51@kernel.org>
In-Reply-To: <0d9ba848-bef1-4171-ba1d-edc73e65ac51@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:14:38 +0800
X-Gm-Features: AcwNN1VMPCDnOAPyOQoQk5KlVx2oQz-exFCd0E6V9cddulgot8PqE_pvbCSMj3M
Message-ID: <CANUHTR9Sd6rQ-6GyWMu_q5ZzHW6uMYLrOFVRmZ2Qu7f4oXWwpw@mail.gmail.com>
Subject: Re: [PATCH] i2c: mv64xxx: fix autosuspend cleanup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/08/2026 10:58, Guangshuo Li wrote:
> > mv64xxx_i2c_probe() calls pm_runtime_use_autosuspend(), but the probe
> > failure and remove paths do not call the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without undoing the autosuspend setting during
> > teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Call pm_runtime_dont_use_autosuspend() in both the probe failure and
> > remove paths before disabling runtime PM to properly undo the
> > autosuspend setting.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: e5c02cf54154 ("i2c: mv64xxx: Add runtime PM support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-mv64xxx.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Srsly, one more separate I2C posting, just like you did for dma, crypto,
> drm and everywhere else. You seriously waste our time.
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
