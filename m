Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31D279329
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184574; cv=pass; b=GOuoQ/nGvypNIjvKRaWaLv4S4nJJUHp+lEk++/kfwTPOj+W4KuEwCjaEnU6kcwJcOUed6MaQq8ReEAtbb3PVbGv3njcNuVPhgGPFjZJtDgtxZOqaysK5zTC6wGnh0TtUvvq+GcCJmO36+D+czGkoBcpZKTTFYdAkQvSE88ZlP5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184574; c=relaxed/simple;
	bh=KCJAiZkPB1/csmAr41KG5K5+mgI57ElVdyP1BHcYJPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJXt5x9k1kW5dQ2HxoW6NjhwGq79YRpZrxvDSFdmnwx2Avs6N+IfTji9087AS3T14ubvXyFd7ie2FdTTLfbpwwtQaoRsLdB5z6/PHfzd4a9SVmGgro2auY0GOZL/FE5rYUHRlBrZMU6ZfwbWvA5DKwSQIISr3GvO3PtcMlEmXWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoIZDNO/; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoIZDNO/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso5134817a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 08:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769184571; cv=none;
        d=google.com; s=arc-20240605;
        b=Xot3OUWKBsr+mtRpZ7QcliWhTYWfHl75gQwSzn1Y6OpCSamEAsj9Q0EFXIQ0tpk51q
         fycY4TOTL57o0HSp8zuREcZbdbYfmTzqwX3SaHpOQbrVA8lBYcTpukHZ+0aCGxqpLwRu
         8B3sdxCYKG6Jxsb0bXlNkA7MICRD/7bsyGPj1osO6mlDuWO4+201YPQ2rxgbI9u5To7n
         AZyV5v9MYMeaxAnDC1OJY94gveFirzG37gl6l+pFuSgIB5SOl7ET+vPZRV93WjJGwJbQ
         WsvBept9gLEGR0TT1OnZot0o97pammmfNnQ/aU18Ak6YCpxAHDZYxNL0izDxPZ2Yxhom
         SpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XXh4ycEdrIOCavg2u1ruAX0i0otO0CkJZlVEZrN27c=;
        fh=rv98ZK64FFeq0aJW8ADxcK+C+ZeXNW2Ff4wFmWfD4Lc=;
        b=I3iS9wUsqL8JYeFDw5OqNacO4FKBzqwp0aReW//yKXPdMgHMiK3U94FyVupH2xpB0M
         ns4LmqAMN47l0J8pf/8P9jpkEmY/nmSBV6JMdfO68tKRD/cLrOF6o5yglQFG5+UUqjIi
         SlSnZgz3u4HzrQfmvier8nvmcAQTYAvgAbnUbq7CjJfPXREReduvrMNOOLc738D3JfDM
         a9tWS0Chi7qQXNuAgEtoBmDvEYcJvXdnUJrTo8HnUSMUvBzKkXhuEuseOuDI+P/WSM3Y
         8nNsYhnzxBJemlyvZe0bbK+0GXiTWmdqipvqZMTZ1QSMN/iAkVrwJ2r4e2VRcGxIFTmj
         vN4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769184571; x=1769789371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XXh4ycEdrIOCavg2u1ruAX0i0otO0CkJZlVEZrN27c=;
        b=DoIZDNO/s01RxPK3dejnWt2qCfLe5iMJotutwTqbuznhwkWiE5XmajDyPwmtNVUpjV
         4kPeqBc095n7cnziG3YzuwUyOoOP6AG3TLSwe2o/6/1OqT8cr1uD+fxUYKpZemdprWcH
         zrbn4T9B0TDqzXBXa3uWCXWngG49SGwqXNp275LeYs/7AZX+5KQcgpWy1D7dJRAzQmbp
         P9EczZSqlu6bpWEe2WaX8qHxB65fvcs7qlyCPYDE27KL5Dhcps9bpIF2a7KS8lc1JcpL
         p63l/UtV4w1vdCHlr3XUgSFUMi1d+dUMAUO4LbzC+nqgXc/fCevrSiZwbPztCW+CeZtZ
         JdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769184571; x=1769789371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XXh4ycEdrIOCavg2u1ruAX0i0otO0CkJZlVEZrN27c=;
        b=wMjT+aka70e3deMi55KTBFlPLNDEDLLFymmqaDC8Lo/Eqcb2N/kp4OP3Wuo7PxFlB8
         RHjK+6n/CradDq0Eixa/f4/6yb9P+00aKp9TRg1CDLmzcsert8VtgYXCnKN2IuBd4Gtz
         rt4FZsK5sQFnGsO2A6QHm7Z6gIaexJnp6tZYW86PU9BZyvPchTW+ZSJtERFJL+NAvwhN
         hLyD498LSnLQ4rr4wSNlk1z958hB4rOpWGKicYo//IXrmwtjoPI7KIPUyyhYcj7yV+6J
         e0ut/zt5s2HOhL0F4K+ICOfPYd7lHLvTAd6+URTazb/7OjmlTAZJ8NjQyCBZUC7f7hNo
         Yd8w==
X-Forwarded-Encrypted: i=1; AJvYcCWozvTGAtqs/LB+yxT9IYOav6JDItAQmfUK61uoFCqbY8kn9NNxSXpAs0DfraC5K1QKkGKezsSHI5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMRtbHGOdz0Pg4r0yVG2F2hD/nX1iWQBWu0jJ/VnGQ8lbCcxa
	p6cs1Kj/raOURAnduTA3HP7hzDmnJ5jLb4uH5tf6djWWOI8KA8LImoKnqhPMcZogJ7ep0hi12Sw
	UrRskHXG+CKAJRUcKwh/AO7a/+S3nGWw=
X-Gm-Gg: AZuq6aK1IA3QUkpWSEX2UDjjHcdK2BEA76N+eVGtmK2J+lX4U5lMMWXxscjTIIuCPjU
	sJl1snJXsN/nlERKL0i/p29bO2pMMGgHG5Us4lZ8NT9sqgboDM+pOvXjIbjPofFkE/G6XJYje+O
	REY3wOy4Y82qdgH1aVEscbnPYOm5bRni1eyB68SuITUly/Us5NdAOjy7aBdFMZ4x+7woqt1i4PH
	xJ416pZJ1PejiW7iAoF9Nvy/ESdNwZ7tFMN0KoMQZJB1y2o70fxsqMdYc4sCoLAK4+a7rhFPw==
X-Received: by 2002:a05:6402:2709:b0:658:3c04:b110 with SMTP id
 4fb4d7f45d1cf-65853d9ffb1mr1330342a12.32.1769184570984; Fri, 23 Jan 2026
 08:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123100537.1429497-3-a.shimko.dev@gmail.com> <d802354283652410ebfbe7717716bb347d7dba25.camel@pengutronix.de>
In-Reply-To: <d802354283652410ebfbe7717716bb347d7dba25.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 23 Jan 2026 19:09:20 +0300
X-Gm-Features: AZwV_QisjPDIxU1l1p_uG7OLNaW5B_OCgb_kCbiZa9lF4-sohLvFfQ_Ow_0QVgY
Message-ID: <CAOPX747KPUFyXiCjAj-Nf4z-LWNiyiGoaamu=QEaUrfBh1Y3Ew@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] i2c: designware-platdrv: refactor error handling
 and simplify cleanup
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 3:48=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Fr, 2026-01-23 at 13:05 +0300, Artem Shimko wrote:
> > Streamline the probe error handling by replacing goto statements with
> > direct returns and using dev_err_probe() for consistent error reporting=
.
> > This results in more linear and readable control flow.
> >
> > Remove the explicit reset_control_assert() call from the driver's
> > remove function, as the reset controller is acquired with
> > devm_reset_control_get_optional_exclusive_deasserted() which manages
> > the reset state automatically through devm resource management.
>
> This change belongs in patch 1, same with the assert in the  probe
> error path.

Hi Philipp,

You're absolutely right. I misunderstood Andy's earlier feedback in [1].
He was specifically referring to separating the dw_i2c_plat_pm_cleanup
change into its own patch, not the reset_control_assert() changes.

I'll fix it.

Thank you.

[1] https://lore.kernel.org/all/20251111075400.2982270-1-a.shimko.dev@gmail=
.com/T/#u

Regards,
artem
