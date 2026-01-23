Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E721CA02
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184237; cv=pass; b=CaJh+Mn9mM/uDyo8jWQJs8Od8IpqID1yktpq9CSWYeLwM9EIYwm1Mhx5DXutqh7ES144kANSSE+i7UVnPcihW4TUhbUQMtBFLchcNs+mgC1YAbxmrsD9t2PVY1ukCJ53RnKueF1fc5rTWMHJ3sz2hin7y7IfgMwsM/U5MHDjxag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184237; c=relaxed/simple;
	bh=TSdd2b2+wNRFWHSMzl7jYT/BVToLvIGBcqV0TesOD5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4281at5eC+xMprg+tNHEsDQz2NOZy8NqhFa3pU5v+6EOy8iVUQ6NZfXsBIbCIqsqhbG9hCcNaRDWI6ASLkbdcbZbeUgn62sT63SAgLztVs3tJEkof7u9sDAznTaWhnTt46RnvRW61coePtsn96ePvb6laijmDJE/eRoXBe5tgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECokD85I; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECokD85I"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so3806820a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 08:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769184234; cv=none;
        d=google.com; s=arc-20240605;
        b=Dv6DbJEMoCV6mmO8WB1jZuJq7hmPo9O+IrutfLgp5lU2PgTpWZAIrJzuhY0vwAkG+F
         aBggopwzyp1x/e1vckfyXUAbpFFxcHAhNzI9mfSC/49OQBtj4O9jpAXLlotaW5fZ85zx
         48KsE/mkaIh2jqA2Wpnc+MAc+cgXq1IidW49cbJBB2CGH/XokgGwhbhUAejG5IiWM2Hm
         ZzXU68/yzZhvf7ugIOjNlKVikocfGVGYbpFt2g5vRfXYISCWFql3vP+Dt6UleD+aNrPq
         jVkzRWsMSfdRoNJva5Av3Iua8WsNAQY6Z7hGtLfvzHYMFgrEjdgwWLiL+uudIbaMCGlX
         cdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TSdd2b2+wNRFWHSMzl7jYT/BVToLvIGBcqV0TesOD5A=;
        fh=axQUDaj91nT+6pa0/M60ED5ZMNwRjaJMywGmRYtSnZk=;
        b=Kt/hVOc+MBuNyCbti4tb0oOo6luj5oomV6spoGm7CJ8Cjo5oc5P0GYwJb+GHcsxlz5
         KhvvsQVKOypJEGhxkYmuZf4Bc5iDkcnQ4mvNtRqM6+vT2YFo5SZjEf44k4t29rhG8DOW
         OPh69i6O7oBadVYsLir3VFFqRP/ZCPp0ZAItd3cj3P70Tw5p/b5HKaxIR/CcctC59Hjn
         ScaFp1fzuxLoYT6gkD7GrEkH+8+MAcoZQwRJt8G+0RjaBX4IRm1IFSA/biW9WCynDcvC
         Or9+fvmf772GgE3pmh1V0+lF7Xt+Wi4cOXLtzFgxvf+o3yKxZCZacUNrVBWVhhwcConK
         0eIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769184234; x=1769789034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSdd2b2+wNRFWHSMzl7jYT/BVToLvIGBcqV0TesOD5A=;
        b=ECokD85IP4lUmK3gRCdMuh0abP98+Lm5yrAauvd+oEgpyGy3PRHl8/UDNeZDzOeWDF
         ZiyYUior8II33exwW2BZ1MXtd0L5/OUvhmA4M0rhsX/NfqWi/J7FNLBY4IRBzQIFEbuj
         jb4hm5ipakqq6xulyGhaQppv2ZyIhcSua1IaO1XlROOrVMm0qscNxA0DKAXzlVV4Cbd3
         Gzly3KTZddj+vKwrQhXwBurJT7VrjTGZjJp78bWPYgOGLAdz/fJVJIA+RAuCQcZGQHE2
         dtZItYT6Sy2fOPs9jouZrR3cQM4DLmDsbwmNmeuXWmMSqgbUVVroW9/TOl3zu8hUJwKn
         /gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769184234; x=1769789034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSdd2b2+wNRFWHSMzl7jYT/BVToLvIGBcqV0TesOD5A=;
        b=R69oiRGGvwN8sizrzwIhWHutDbpV/cRg4wPrAFQObXEDX3BnHvpSRu2KJweDI1t02G
         QPFpbdZIi3M2FM4kGja7qB7OABYB8d6otjI9AubrJeTB7kUURSuLfllf8WrfVAMenvZ6
         6iF/c0GKCgSJjH0w00qaXZM5GmyVsbrI+uzERyuUaXhL2oB8KRjwbXRkM2PZ7dkBmS9r
         FXFmD+ntGjgYcFRlxhMWIlOy+81ify/fCw3q7FQTk/SUFVo4Xem6KNSK1iurhZhANSKC
         MB6AeJQTQ5iWrEL+ydGG5l67dIx3bQKfT6d37W6CSPIe8l8ec5ki5aNgcQhCfDwAKgxa
         zkZg==
X-Forwarded-Encrypted: i=1; AJvYcCWvFf334DWUdYZ8e/a7Fnf3YlqgxXOiLW2fr0AC+coucF/HpEElcZpWvHpu1s473UISSwCd5RbbpCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmdiXKIFQyhA/o9uMK5rYfCYIGAOD78bPDzqXd5xNM/MLu8+I
	UIYN430aKXY9vUQfnGrPF3jz8m3fep+mIWtttqO9ItOR6oz6KTHoyx9YcqunlcvZxaLPGcOxXmn
	6OJT2fkYK06k6ly5SC95SjJmTOfrdEAs=
X-Gm-Gg: AZuq6aJh133Nzgu4JiSZVpnD0cgDfMJpo61FCcS54AbP7Jrs2iIP7gOyur+rmOP/udG
	FsjKP6Y/tlcDNBbKjNVh33DTosh21PGM04vUPOHWO2krWp7Mz2nw6W1TcHD2+iOmRC+yrZs0pBf
	VKhLjVhm2qbqiYGIigkDNfXrzBrJn/625q5JqZddRAe+w7NZOR1iN17kVLcgq6K/MHsa27xch/D
	mkyjNLH4bOiU4ONbHkdJ3CVPvmEHHbVW4ZJGGGWUJAO19VtMLakwc950XxpUmt/xpV4sOpZ/g==
X-Received: by 2002:a05:6402:3641:b0:64b:7e89:811 with SMTP id
 4fb4d7f45d1cf-65848763ad2mr1915308a12.13.1769184233983; Fri, 23 Jan 2026
 08:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
 <aXNXx4elBVRpWCWf@smile.fi.intel.com> <aXNYBahiKTnVkRfg@smile.fi.intel.com>
 <CAOPX746Fo4VP9tCTz+T42Uhy_LnbmNNSx8MtMJbRh41YtfHhpw@mail.gmail.com> <aXOBTME6GOiiSowD@smile.fi.intel.com>
In-Reply-To: <aXOBTME6GOiiSowD@smile.fi.intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 23 Jan 2026 19:03:42 +0300
X-Gm-Features: AZwV_QgXjsyGryHcHxjODBXnUUPi7TVw-baqaPtxtx0zsOWb9b2NVoBejYCX6Ec
Message-ID: <CAOPX745tqA=XpYA437PN=N+gC+=y_XvJ-aabXnrHZrkP1LGHqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] i2c: designware-platdrv: simplify reset control
 and error handling
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de, 
	mika.westerberg@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:10=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Wait a bit (24h + ) for others to have a chance to comment.

Got it, thanks. =3D)
