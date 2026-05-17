Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F81FECCD
	for <linux-i2c@vger.kernel.org>; Sun, 17 May 2026 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981322; cv=none; b=hMbtUpi3L0yUoa3GiVca6TgAkXxVjohoWq2fWlJbgjN8PvF2MenGlvWC8OjvE5gUH7vbNRIs4hftBQbKI7SS3owZeFV9wedUzTkUqhsyHQLYPyYYQSoWSv6PpC0EOdm7rAEcPPUYODXMNjrua3rBqqDXCd5MLLlx0/6djjihuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981322; c=relaxed/simple;
	bh=cu9Zky6li4tk2Xlj3OFkZViXL7TFqJC66jyQATVm4PM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=kJQVBbVJAGADwES33QBhZTUObIk7/fLWeZ+ahnxw0/U0LkAjENFUPiKAL9nmYi8wPIStjYFaoDzoBnD+NFbB66uzMtEoU1k6I6dQL/vI6plM3w/cqezrkJrhDQu6XJ1BLOREFf/wcobl7tyshJEILrvN2gnd8oftFo/P0MHTRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=B5Lp9e+0; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="B5Lp9e+0"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-133466cf955so5042049c88.0
        for <linux-i2c@vger.kernel.org>; Sat, 16 May 2026 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778981320; x=1779586120; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ijbrgH3b8D533VQ6EqJABWk50CO0cbZFk7FFN+l0dY=;
        b=B5Lp9e+0XjvfYpbXDpgq2mGkkpRG11gRuKdI1nfw8/V1UGLjmMJi8e7GyovpLHlj75
         5FNuVv9VjnQ9R+0cqEgNA4IpwbYyXpLpEYW2y4FriPdhWa/OaBjLWsmuhlDfEaDLtyo0
         DKLTXbqzvO4nxsc+r8xvop1sIOjkuout+TKb6aDzfufnJYvJtN9qWppT0BgCvBEic7Es
         bE/iFUgKsEDdCfUzuJVq6FHtf5i3TWUge8xQj2F+6/1iSV/25HT9OGEsTVH+vS3UOcNS
         hF2y3KLrbelHFzaaSdAGt+Tl032sxzHY7irNx318wqO251MMDVNtygW4nJUjHzhbygss
         WDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778981320; x=1779586120;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ijbrgH3b8D533VQ6EqJABWk50CO0cbZFk7FFN+l0dY=;
        b=rEw0rTIlVfqibuQTzq9i6K+hNlpJ/Uhh/Qs8qv05z02ZZ0x83Cwd6UkNzDFrWz1U3B
         Rkhwp7Ge/uFzqtVVHOXRPLZ0Yhd/dI6CMHiWTH4c1kMDKoI44ZC4q/pkxJZ3r8wq0t6E
         EsiRUIqYtv1aSpknBNOtYnWe03jDKBrdx9GAU8EKaRdAHR7RlYVPbjJgEHftENNEsY66
         Q1EtdvOb1p1BT3XWw8zfzpYs9eWKM7O++O7r5iJsiP3n5tRT/rohgQAnvZRwnYnobyG0
         Q9KuUzhY6JvmqGJ1oVNTY84FvT9IR9D+T/e3SHe6rjXVMVI0r71HCKDkAbrNUON+MQ6N
         n63Q==
X-Forwarded-Encrypted: i=1; AFNElJ/t08pcU3pl4kiB2CUZR7jYLEV3WexhL/YJFdPsZb4L+aHtQMc4p6x9RJo0ERMjeVFefgjtaaiL6lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmWls4Y1X4v2lmBeRC2H1sGMubrQGnkBnBrso6T8QezRdNNf9
	OwoDhr/XwGDX3DUuy9v95xX6HW6vW/aXT0Yxq6cTaDhAKC7bUoeQybpRPq8Qe+41L/zzjZi0wzP
	3BwROg7Y=
X-Gm-Gg: Acq92OH/rj1EWg1BJ6d1h3i4xbpGP5Wb78aLYO8M7Uq+8rG7C1RWWF2JRM+I7pkHxX5
	GuAUe5xHB7Ck/V8ffZy3CVvSCnDJcSblWgYhod3e/LmaQ2xJ0BtZRSHCwh1hDBAXuK6TnF3SmON
	46lepKz9XgIvcgGxainWn/oe6mEaqvkm4QQ7fw4QisH539aqBiQ7GzJ3Q0pFyZGU0NVUFq8g02L
	r9Nby6hjgx/H+R8bwftL2q5JgNSOjQ+7MomJlCZWgOYYacXFROcQG3Cy3WyHw2YMU47cuVhkxuf
	UHu7iUEiNwQKjU/mS2kc3EQu61bldmHao3iyQI+1ToAgeual++0l7nyny0WYGCDmW9C8OH2dInT
	thI2tygKkuh2YBDx16+PcSkLpRbF4q6ioWU5WvLRT8iNOl9obkMIpoJdhYDQ6PORsOiNcYkXh0j
	QnZvstZ1yFPGLXh4lRFSktAiM=
X-Received: by 2002:a05:7022:3d14:b0:12c:6a24:a24f with SMTP id a92af1059eb24-13504952278mr4237401c88.33.1778981319661;
        Sat, 16 May 2026 18:28:39 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm15503968c88.10.2026.05.16.18.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 18:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 18:28:38 -0700
Message-Id: <DIKK8VG304IK.3UYPZDTKL2S04@nexthop.ai>
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Peter Rosin" <peda@axentia.se>, <abdurrahman@nexthop.ai>
Cc: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: reg: use device property accessors
X-Mailer: aerc 0.21.0
References: <DIFQPMZMN7AN.YTWGF8U973JL@nexthop.ai>
 <20260512075059.258309-1-peda@axentia.se>
In-Reply-To: <20260512075059.258309-1-peda@axentia.se>

On Tue May 12, 2026 at 12:50 AM PDT, Peter Rosin wrote:
> [note change of email adress, I'm now using peda@lysator.liu.se]
>
> On Thu Feb 26, 2026 at 10:28 PM PST, Abdurrahman Hussain wrote:
>> Hi Andy, Peter,
>>=20
>> It looks like the patch is marked as "Changes Requested". I haven't
>> heard any feedback lately. Did I miss something?
>
> Hi!
>
> First of all, as usual I'm sorry for being slow to respond.
>
> One specific thing I noticed with your patch that is a potential
> problem is that it replaces the open coded little-ending/big-endian
> logic with a call to device_is_big_endian() which is not an exact
> replacement. The logic provided by device_is_big_endian() is simply
> not equivalent. Further, the new behavior does not match the device
> tree bindings.
>
> At a minimum, you need a matching patch for the binding before doing
> something like this. But that would of course only expose the risk
> for regressions.
>
> Since there are apparently few who can test this driver, and even
> fewer with endian issues, I'm reluctant to make these changes. I
> would prefer to keep the endian logic exactly as it is.
>
> I have not looked all that closely, but you also make the call to
> devm_platform_get_and_ioremap_resource() unconditional. Why will
> that change not cause regressions?
>
> Your commit message is lacking, you make these changes but only
> talk about extending support to non-OF platforms as if that is
> the only thing that is going on.
>
> And, the initail problem still stands. I would like to see some
> tags that indicate that the driver still works for existing users.
> Especially so since there are changes that look problematic.
>
> Cheers,
> Peter

Hi Peter,

A gentle ping on v3 [1] -- just checking whether you've had a
chance to take another look.

The conversion was reworked deliberately across v2 and v3 to keep
existing OF users behaviour-identical:

  - The three-way endian fallback ("little-endian" wins, then
    "big-endian", else the compile-time byte order via the original
    __BYTE_ORDER preprocessor block) is preserved verbatim.
    device_is_big_endian() is deliberately *not* used here because
    it ignores "little-endian" and introduces "native-endian"
    semantics that would diverge from the binding.

  - The "if (!mux->data.reg)" guard around
    devm_platform_get_and_ioremap_resource() is preserved so a
    platdata caller's pre-ioremapped reg from
    struct i2c_mux_reg_platform_data is not clobbered.

  - The dev_err_probe() wrapper at the probe_fw() call site is
    kept so the helper's silent error paths still produce a dmesg
    line on failure.

Tested on ACPI hardware (two of our switches).  The OF-only
in-tree users are on PowerPC/SH so I couldn't bench them, but I'd
appreciate a maintainer read to confirm I haven't missed anything
binding-visible.  Happy to respin if you'd like anything tweaked.

[1] https://lore.kernel.org/r/20260513-i2c-mux-reg-v3-1-0fa7242605bc@nextho=
p.ai

Thanks,
Abdurrahman

