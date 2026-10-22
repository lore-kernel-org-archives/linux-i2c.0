Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678018;
	b=tgQ3dV9YTqsqov/6X9c1Y3JMp2VK3TQTVZnQt5+KujEJSKGPA/uh5urGbwVTXPZ03Tfb
	 EabvC1L9yaON8Sbol0mdx2uFsqsKy4LmYvpg2i9NKc3LREII3l5gfcBtcVhZ/es0lANJu
	 IxWWIWXEB5cjJMNGrfoRVG7qCtGXcy84zw6szYZvtPjGp01P2h4m7l4hKdOAwJ9zlH0N8
	 ey2DwuQt9J41rP/x1mJSOFjaPH2lSr24OBTWfyYdkdBkFLM9Zanx1zNz0AiR+MDDjniQR
	 FBiSnRkB/ZXjEp+Biq8UakgrPOUcZEcZXEEryyhljcmPsypRVeZheMHoHMiIVPKu+BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678018;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=bSoNGmXPBRRo+noUCmFIwPwAoqGkwANsbZ73sxEJJ8M=;
	b=xh/aIOul1SGe3ZwjzgvI5yQ12RlsBVu9rKtdw+hn2C0c6gh01FtYFjWV/yrAmJEAHiy+
	 V+4FPSwjt1jgEIidQe0QfG03MmIMQfRJ+5ohSNJhIx5vS/oUX98a6nXujvEGc5s7/Sk8T
	 ePj63hd0zZqdRNEfahhwF6ZPfD7GCLFEplBtOrNl0ZECdV2TWyY9GkRkyTAnM1aUIYOGp
	 8sa5yDFupEcyylVVjaCsKspsvFwU7pwSOt00C9nUSU2c9npQ0D9DNb68IjAAOidQdQDgi
	 8cHgyTl2VytbKTVI7rFbLhMdfF0w1PVkzqguhvkNYOrIShNeXEnYRNZin3tFaEJUW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=N6GO6fC5;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC010606A31A;
	Thu, 22 Oct 2026 14:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC010606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=N6GO6fC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792678015; x=1792937215;
	bh=bSoNGmXPBRRo+noUCmFIwPwAoqGkwANsbZ73sxEJJ8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N6GO6fC5YJyu9hXqSYZAUjUND7FvAoLmBHPd+E4PocKvT1wl6owBueJgMt93BLPqW
	 Pn5iqpA4Sp7/qhlP0mPcgEoHMhCbZ2b4c+kRuOGSF5L40APaq7RIsXP7wIaIuZPDc/
	 qcpdVRuXPwdoKKF8qo3GeFvKfYS5hU4zc1BzyK7tep2k/YOlA+u5RjTfDvtCKusAGR
	 l5Cv5UYjiZ9zB7hUca4zb3SWrnkx/ERIEg+l34wlu66nGJntDa0p3haaHHLTTZ2XT5
	 I4cN9RJ2I1Ku/PwU4xtzdBsf7kHgLWTRflu62fdNBcQsBRCa5FuMYdzG30iGA6kp6d
	 jBJylDj+1nC2g==
Date: Thu, 22 Oct 2026 14:06:48 +0000
To: Saikiran <bjsaikiran@gmail.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: loic.poulain@oss.qualcomm.com, rfoss@kernel.org, andi.shyti@kernel.org, sakari.ailus@linux.intel.com, hansg@kernel.org, bod@kernel.org, mchehab@kernel.org, vladimir.zapolskiy@linaro.org, jishnu.prakash@oss.qualcomm.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 0/2] i2c: qcom-cci, media: ov02c10: Fix camera power cycling
Message-ID: <179267799926.41892.11536083985254052619@pm.me>
In-Reply-To: <20261022071418.26895-1-bjsaikiran@gmail.com>
References: <20261022071418.26895-1-bjsaikiran@gmail.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 62f161cdaa6666d8a4f2478d20e4dbdeeb7c22db
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2026 12:44:16 +0530, Saikiran <bjsaikiran@gmail.com> wrote:
> Tested on Lenovo Yoga Slim 7x (Snapdragon X Elite): 20 consecutive Kamoso
> camera open/close cycles. The sensor entered runtime-active on each open =
and
> returned to runtime-suspended on each close.

I ran this series through the restart test from my CCI series [1] on a
Yoga Slim 7x with 7.3. 1/2 applies as posted. 2/2 is against a tree
with an extra delay at the top of ov02c10_power_on(), so I made its
three changes on 7.3 by hand. Each cycle streams five frames with
v4l2-ctl, waits, and starts again, 20 cycles per pause:

  pause        0.05 s  0.1 s  0.2 s  0.5 s  1 s    2 s
  7.3          19/20   19/20  19/20  19/20  15/20  0/20
  + 1/2        19/20   19/20  19/20  19/20  12/20  0/20
  + 1/2, 2/2   18/20   19/20  18/20  19/20  17/20  0/20

Every failure is the first CCI write timing out ("master 1 queue 0
timeout"). 1/2 does select the sleep state while the controller is
runtime suspended (pinctrl-handles shows "sleep", and "default" once it
resumes), but with the 1 s autosuspend the controller never suspends
when the camera is closed and opened again within a second. After a
longer pause the restart works without the series as well, which is
the case 20 Kamoso cycles cover.

On this machine both bus lines read low while the sensor is off, with
the pull-ups on, so the unpowered sensor clamps them, and both read
high once it is powered again. The CCI queue still stays on its first
command until cci_reset(). The pin levels and queue registers are in
my reply to Loic [2], where a reset on resume plus one retry of a
message after a timeout made 120 of 120 restarts work.

[1] https://lore.kernel.org/r/20261020193946.51478-1-birk.skyum@pm.me
[2] https://lore.kernel.org/r/179261145907.36927.5158021314822941179@pm.me

