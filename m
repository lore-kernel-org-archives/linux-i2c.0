Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D289198A17
	for <linux-i2c@vger.kernel.org>; Thu,  5 Feb 2026 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278188; cv=pass; b=mWL4P1R9ibrK3DYU0K1Vu+8XAnKRHVM02pfPB9BBEEgLlOv6ydU2lVVOP/asPJEOZWB4zDNoYksScfAW3ztv0dhUq5syaNS9/8cI9ayzXsgYQmQqxVxXu4SqSzcKcWOaYb3+4JX1IYLTW9df4Sins6pypRDUytfafc/cc8XCahQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278188; c=relaxed/simple;
	bh=FiPWzge7PqsuR/pZcXsdUy7/neeh9u5uNlwCRWv/7Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIlK8zkK0rZ8B4Og1UnNkqNJGIRSzbEYKaqcxmF6clDprh9+0c+Jx8Qlt5mx242CwTcFK3Sm6RDnj/7BHZV5HJzw4SYf3QpHJNdp4yZGdwf5VnrZE3pWx1jpl5qkNJl7K6qIerqSc1SLOFEBHdWcdsJWoL5ZD733xh+jHOmtOLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5xxQBFw; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5xxQBFw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b884a84e622so106891466b.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 23:56:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770278186; cv=none;
        d=google.com; s=arc-20240605;
        b=Np06OvxzJLsjF//hPs1rvSWDOvHqP8Y9za7iuCPjkwDfpjqUeutycK18jaeYf7IGNk
         Of10VbBkHyzKWMB6uMLtmIt150xNQfTHpz8SEnME9kU0rFovMv6aFUbxvp3toxlYP2tl
         aD8Z54bjreBhOITjIM8CBRDmLEd1S1stfy1tyO20AviIWGs0N9ElkYAGqhuBsN5Bgxx3
         kkezylg/3AzspD4ig7RCWUkhD3RWHwPCOgt9kdjMQPJNVYxHYmuGVPLEwuNnszLMQdj2
         VQvVE5rlogUAMr3mm8nMM5KK0i4WhQMlHhwD7m6cuLTXuf/4bkkHLpZNd77t0rjVya+q
         wYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=35ftEK9hqtuZe83o91BgSC1s5AaJRzWksvm21eIX2rE=;
        fh=szEtJ0OMJXTbwsXXmpdqiueu2nLZ/YBY6O2/4OkDJb4=;
        b=HpwphI4ELK7e8VHQ7rDGmg5EYHDBpuj5YvDAypSmFw7IqS2HFx1zbD7eNkeD+PXO4C
         HoUDm/gX9RtjkqsufWjkfz16cI6n/kSZ7U0D8sG20mNVVI19QGum9k/Qji831JBGa4nH
         KeKNNPDJs6rAcG/qptqjpIvUFg/1LSTUlsqs2gJaAyfdEZE8o983ImCY74XF8rB7HYFN
         YrHaa987LRTke1P2PTrufdR90QjLzPE/TTP8zEbWcnsqPua5J2s8dD+fBNse+PVH+GYN
         APpILdrZGhJmZ9rejcMOz46hBNrpErcmOT2i7qIjJy9mvjkmrwn5jKk26Yh5WUV/isw9
         yTJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278186; x=1770882986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35ftEK9hqtuZe83o91BgSC1s5AaJRzWksvm21eIX2rE=;
        b=m5xxQBFwzQwfYC6+SGxYNRPYSv3oKFWTqSic3qiFLL1gdJTTQsvQISGH/VmExTJ3L/
         c8YNtkqO196As7/IGq4IvfwSQlRSE6Xfb99kjDOpSHYVsUbEyI47DtWP4UB1OMKaHL0D
         ycCuWheInwVkRp4X507bnqF7aD0tHzOxABCu5ZxCDk8vtKiebVux8tz6C2aCxT8BltGS
         3jSBJRyvBcJn45ciMlC5wxeAthR4cE9ysF5JiVHTH+5ZXf/0CI6wBL66VHGbadpecH04
         Ga+0cz071JL+rO2ZWTi1//NJw0Qo8Ekl7kjVg6D0p7XZFthj5Jj/k9K8ndfUY03bmW4U
         xThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278186; x=1770882986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=35ftEK9hqtuZe83o91BgSC1s5AaJRzWksvm21eIX2rE=;
        b=eSoi6Gg/kkNIRrm2+YjEDIPIdCzqaY0zNMZYbip/UuikWHskRcYieUwIlNAWwIeWkh
         FB0eyqgGZ0vhSNgrP5WJR7rTURXPN4mk0cf+IbolmMVyTX/7AlAPQdh0SGpuemk7oJxz
         Apc0RNssixg1EoIqXvnlp95gp13PnQMieeFZw5T3YSzI7iBmpnjVANaAQFU2LyNDMZ1i
         gnSKz7QWaxl8wGaTKCCegi268B/kcsAIv2OaDK2aQl1SRwMcVU37C+fPBc+jMiaJHk5X
         N23igKWlyjJoTL5Tows+rLosnFN5mPiIBTMlxJOzIoNdBLpVxU0/AprnllMsQYuUyqPa
         W75w==
X-Forwarded-Encrypted: i=1; AJvYcCUXuJJUXP5vP4WcS8N+Hv3dqesX8s0iTB3dOWSL5bDBVx/HaBcaqe+QeWHqNtF1y3oKA5vCjRMf0+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Ce/JrfUW0qwJesX4a1QPOaZSb2Sn+YAKUgCw49D1SrS0w62P
	zopppbnlA58t/ZR/2S4pl08TdmGQqXJh0d+GnX/8oLo47rqEQu/RxibKQPX7WQ/8201LeHHtkG7
	SiG/xE7/6mw5pgOz3NC3PZJ6cJ8OpHuQ=
X-Gm-Gg: AZuq6aJVA4DwK4M12jbUEp2RhFoB0iq6LhJ84mD/7h5K18DiZIrTb6NHqt2dQRbWWGC
	aJIoSCIhheJLBsIDnPb48mnvnmbQy1nI0Op+fiTKq6NXGiV75VTrO8GttayrWaq3tztf8T2mWWQ
	3W16gssaSc3SoPhZlPRs/dpFp//1swKsLuMRtYKFjrh57a4hu8zFCDA5gAXzUcyYucnLaSaQ6d1
	xZU3ePPAxluUiV8POLPkoV/iB74aUhg4ny7XfOelWTu9ullIvQJrzAAFGVgM3eDu/vrTQaraA==
X-Received: by 2002:a17:907:3fa4:b0:b83:1326:a504 with SMTP id
 a640c23a62f3a-b8e9f545928mr360588266b.60.1770278186008; Wed, 04 Feb 2026
 23:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com> <aYKj31hi1bF4wmsi@zenone.zhora.eu>
In-Reply-To: <aYKj31hi1bF4wmsi@zenone.zhora.eu>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 5 Feb 2026 10:56:13 +0300
X-Gm-Features: AZwV_QjcPIUfyn5brYRimQMMOsneFKGT4yvAXTddliwOl4qcdG5SMBtrfKKFayc
Message-ID: <CAOPX744QCxpXZuVDfSHkw44SGe+Pr=gXt=MetcK22C7aVrv5hQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
To: Andi Shyti <andi.shyti@kernel.org>
Cc: p.zabel@pengutronix.de, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

Thank you for your review!

On Wed, Feb 4, 2026 at 4:43=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> w=
rote:
> the dev_err_probe() changes are not mentioned in the commit log.
> Can you please split this patch in two, one for the
> devm_reset_control and one for the dev_err_probe?

May I suggest to keep the commit as it is? From my point of view this
dev_err_probe() relates to changes of the reset. Otherwise, I'll have
to return the reset_control_assert() to the first commit, that's
unnecessary when we use the
devm_reset_control_get_optional_exclusive_deasserted().

It'll look like:
1. devm_reset_control_get_optional_exclusive()  +
reset_control_deassert() to
devm_reset_control_get_optional_exclusive_deasserted() keeping at the
same time unnecessary reset_control_assert()
2. removing reset_control_assert()
3. cleanup of exit_probe

My suggestion:
1. change devm_reset_control_get_optional_exclusive()  +
reset_control_deassert() to
devm_reset_control_get_optional_exclusive_deasserted() as well as
remove unneeded reset_control_assert()
2. cleanup of exit_probe

Regards,
Artem
