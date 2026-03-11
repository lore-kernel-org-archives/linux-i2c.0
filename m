Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9248248873
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210039; cv=pass; b=a8OOTesDxJKfB44pToM7zLz48pZKBfvmqFJfVMJxBecm/VZkf6I82BVDrijx+TBVUZ9TnmUjLzCYqV32S11afU89O2+L/xtU9CkcQvUKD9oVOcuZY3GU90THi2vSIuJBbc9d2QBfogmZ2jakJs3PWXksf3w1qLMeuHEvUbvVQw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210039; c=relaxed/simple;
	bh=CvVHmCmeDC3VrhwUTCu1YjrYw3Bopq9SAawenX/tfKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkBWVKbVPO2rnQMg9JgboAF5dpnnFsuaMpLLw3E5XHkZbbC8oeL2XAiN6HaVqWW3IDtfGkl9aIiLdn4Ptv90mQANsANyLzemBJD6mHn/dB4UtA8/nE6EWaprg2bZAqD8+Fm7TPchqa0ngkrt/iwPV28W3RprQgc2Ym3PWWpVNhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY0//y+N; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY0//y+N"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-662ac74fd85so3431430a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 23:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773210036; cv=none;
        d=google.com; s=arc-20240605;
        b=bwk4PFVRvDVhRySzA0zCH2UeWfh4oFsqpQm8j2/WGKF7tU0bDyJgCXUBK2x3Sy/6zH
         UH/61KXU1mWhavqN8sigs74nuZe+VAuA5CfaItQB02dgbSDIs8xO4xiNVpyZwQCXt4M7
         JYwI+8uz34q7zDHq9iJk7qfr8QUAG08Wq1Q3AkSQQ5HxVIqe1ss/PFfBUtZQdcdvkh6r
         +jFPzifKBsj+A2h2C7Uk+iIYZoBVaapl9ZqeHyyS5x/uvE8LA7Ju7KP8819ldWGABkD+
         iIduc9ATF35s+XqC+raCamwz6TDvX/gvlFCSmin8GFfYQEATVA5fdvpW3UqUEXdsaHKe
         grNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CvVHmCmeDC3VrhwUTCu1YjrYw3Bopq9SAawenX/tfKo=;
        fh=Gs6ZNmdfswQs8xKuKCYiEqJZfwygbWL/ZSp7nLXWcaA=;
        b=W4o1oGytWGkydG13DIO4RmX0sQplA+viVHkoMFgo1zzA6CWDcvl+OFS3KAsR+0auS+
         +Ew6g5Bchx/AZ4O4ABzuEDEGA9EixpZeI7itTiVXf1VWABpYgxw81WcpHxwqHsCOTmL3
         sZu/3fubiH+ajylZ82+tJxwUZBaZqzxvq07IwWhfLG3fQEfltzuRnvT2vLOy1VEVdb1e
         sb/4vvSB5mium0u3/0KQC2fdrs/0kQEmMELj2mAih3BCVzSm99FVlvXTvofN4f2wSm7X
         Mhux+yQSKb1/aK4uB0K2K44jNDYi9eru73hiAkGo3fH4B1SOU1Qnx9+c0sW8MfEmaS3c
         mnzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773210036; x=1773814836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvVHmCmeDC3VrhwUTCu1YjrYw3Bopq9SAawenX/tfKo=;
        b=OY0//y+NE5vaAw6J3Av8SovWQi3DtfLR8XSzVDa+TQRZyYxFlWD3kFSWuwX1B/80Lj
         aOgsCP/3OPVbrgXaEBSU8aOEFmR66vmHYe/uMk+sB47+qUeRmuqfIMYx/e4S8vuLx7Xu
         fkQNnDz9kwzHbjTow115xl6juxpm0kTet3RqolcMQ22FdtFrk6EN17eJWJyr+k0anWrB
         ra1Cz+Ww8aUtA32pVcHYRR8W81Aw8sS6dyp0NuLuX87EYiL0QuDU9CY6DYehbkuwOVCP
         gZDiJjI6G+k5C/MN14GmhdVLXxkaCvpQ8LsMGxCa06ZyqCtWgODOVVXGp4nv+H3rzmwC
         l3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773210036; x=1773814836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CvVHmCmeDC3VrhwUTCu1YjrYw3Bopq9SAawenX/tfKo=;
        b=ZYObEcJcQsjIrjaP2L2rfR1HQu2FYXNLWXpXKN2qcZkMsnwEGiSJVRkleZ8Ni8hzK/
         mswswKMY7rPMintcduyG/l1c236ciSH2o/eSCxlTdTQnsl83qQDUewvwGSwUTLCqpry7
         qTGnCr4hTXaumk1Zt4ONJndZDgWsJnKZ19mEvifV1MXGZIWQAh3Ab3tjLwqjOezJWx8R
         MDLrK+p4iBxbuhly5vB1dfc7G1NYe3gNh0oJ3Y9KxsnEiU1PgU+LeJwNx4VHv2BPmmVt
         tPMhDEJXiMQBuECDyLhC2Lnba/AsndD6AQdnarYLIUtZpeaxd5VuQiemZbY0IsAPbW8v
         GAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmGD8wP7G5rYNcPGicAkg9e4HOv6A2hLnIZX8KKSVMXwUO929I2bQxwXR2SmqWBYP5snOm3QfmBCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sHl2kIOOnIBdw0NcUJurZc2VsxGhDQe8mtTDAAARRyeg02bV
	0Pa8ifwMOjulLnPL2nNFsY3u3m+RhHYxJ2tsXW/uJdF/l7mNNs4k/zCdMRYmYOm5BtpBfow7WUn
	ws2yZQlBHDtWOn7ZY3EfWug3hoiMAGDI=
X-Gm-Gg: ATEYQzwwQdKlQyaawJlq6nKL377assCmErK6EQ939nSXrw0WGCYaikPrA46lTZ9Id3/
	68eqjfOCspXe/apE618wUI/oYuA3P8beeLy0AuH3DkeocVJ0ahc1GKKg2E3hvAFws3csafwM5II
	2UJqVFUOaz1t9iRTumFuahH7KAgRUH7ynePOzFOM5qyqEHai5rXEUmpc+M/MSRggq084jc/D58C
	vUxSBrYEMKKxEovO6++F1ovysv3mybXVS/m1EHxtZXaKTq3M/i9OfGdhstZ6Uplkh2ygf+nrE1S
	rtZgGQs3Jg==
X-Received: by 2002:a05:6402:2686:b0:65f:9ce4:e046 with SMTP id
 4fb4d7f45d1cf-663192c4ed7mr673159a12.3.1773210036207; Tue, 10 Mar 2026
 23:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310184046.2010403-1-a.shimko.dev@gmail.com> <abBvf9HgLeCpjevu@ashevche-desk.local>
In-Reply-To: <abBvf9HgLeCpjevu@ashevche-desk.local>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Wed, 11 Mar 2026 09:20:25 +0300
X-Gm-Features: AaiRm50MwE3Tzzzojq64-DgKniLNcaDnuteSpiZiAEL_NMrCxkTnLbTxsiZG-wY
Message-ID: <CAOPX746OoVrQYgJiBMgDA+VOkUj5mtUmxFEXubwHsXTnPsCsrA@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: add reset control support in suspend/resume
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for your review!

On Tue, Mar 10, 2026 at 10:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Usually we try to avoid _adding_ ugly ifdeffery. Can you elaborate why th=
e
> change is needed in the first place and why there is no better way to han=
dle
> it?

The conditional compilation is needed because ACPI and DT platforms have
different requirements for system suspend/resume ordering: ACPI
platforms require LATE_SUSPEND/EARLY_RESUME
to support I2C operation regions, which may be accessed during
suspend/resume of other devices. DT platforms don't have
this requirement, but using LATE/EARLY callbacks causes problems
because the I2C controller's dependencies (reset controller,
clock controller) are not yet available at that stage, leading to hangs.

However, I agree that adding ifdefs is not ideal.

I have a couple ideas for v2, could you please advise which one is
better from your point of view?
1. Splitting PM ops into separate structures for ACPI and DT
2. Using has_acpi_companion() checks in the resume callbacks

--
Regards,
Artem
