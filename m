Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965F3D649A
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789972; cv=pass; b=j883bU56vJjYViJU2rGuo7PfaJkZB7vV7k7JrKg4UhfxAOVqlYr0f0TVRg3ERkMi0fbXYLhQ7fw2fZ5MUzIEEwPEhRy+0qOirooIvXpe5hAQ2+3EFN88E8Vsfee0EpX2Xwc/txKcKzvft1mI8lZ45AGF+knV1gsY5aCIoKL+Nnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789972; c=relaxed/simple;
	bh=LzC78n/1cSkKY2MkbnFZtdzczAtKa4M13Zh07S4fs9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of7rszicSQJWZbdLBoVxOj9UO/34WnlkXj0/7Ngnvi7nVM4ZQ0C1ybDiuii5so9g/ULWO5z8eHZ2dzPqoXCEx4Pf55EK3ZmyGCr//1dHLta3izbuREc8uTvypbSNOrmQ20tckqtju3k7npt/lZ+HDqGP4ZwVq2VGAxLXW8u8HOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GviGtrXf; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GviGtrXf"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b41fdf9de2so76109417b3.0
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 03:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779789970; cv=none;
        d=google.com; s=arc-20240605;
        b=GYnbCM+k7pqi7PX+0pQfzj8GNUKg6iSeliq10sQ+Ssnjezh9W/ARaC6t99VWB3MnAX
         3mAjx06OosoXc+Tg7KeQUw/1I/L9Y1p21bcU9bpg9CU1jqj8uJNyaoBvlh2a6wf9fFut
         82MGsArhEUOnDL7qn/sRxed6xHK0UtnBL4mGE60ql4ydg2S8WrgtczHGNMK5GE856msT
         k7CXWCy5d6y4x9Th2X52xCZe9ApkgK5z7Ib+eERqPDkwNSuH5JYCgLdrJ/5JBdjyLJrI
         hJma3/S3upDDkMytU0I4S9+fvp1dibBfSkHfLiTVZPYheE9XBoMRFamLXh1JR58PshuU
         J9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LzC78n/1cSkKY2MkbnFZtdzczAtKa4M13Zh07S4fs9I=;
        fh=mDqnvL3tfDrNz/2ctQbCN4QYoXDSYRmFSDSacAEpp80=;
        b=Mq+9+4JLibthERkBIwDQqy32HxUZUW2E4aS1DhMMEIt3vhfZKzPEFgPDiPnKwZSSb5
         56gDhVnt9uLfVRiMTlyRNxRFkiwuheIeVXnrtLEqQWQkpHya2OMswkAIAGvmvV7QbYaq
         kJSFO/T3jvnM9heZmjg7F6nVWXW3YxdqFQhPCBe95DduwxNyPKyWwUOh/3PQWZ3W4ZOJ
         G2CtrLUcmN/DqquwFhl+G6tIfJJvcthaOlMwEMoyfucbvzPxLnEp8gvd+SQVEdy2SvJy
         3mLDyO5lSnqGsZsUtlOAfcpcUc6LxFz6IXZrUeMjr6OTpO76SwLD5hstP52Zp9K/yuPe
         bQ6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779789970; x=1780394770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LzC78n/1cSkKY2MkbnFZtdzczAtKa4M13Zh07S4fs9I=;
        b=GviGtrXfvT92u/zxcXo9AEpbMCghGOWpWelI8m1Q38JNgID7Xv74MdWp7ZycmrPvB2
         +2rZFQrMIKmb269qm7Nv+qn71OmYo41zBux8y+AAiRCTbfyxBM7EiBI1mC3SCJ51xvzZ
         hK6N6Qfbqxzgi7ciQwLT7S7Ux0rJ8HQZfiHUHdUhZ62zyBoJucS4sPnXYGyhCzoJG7O3
         SQCmlFmq2tgCCEhBQEPLEa6BgB9N8I8UibxDbxwtH3b0tn+bRDTA4sN8sfG+SncpSOQ2
         lOBrNhMXMpqLvpbNi2qEelxjXf3mc+1vpuC8INQq/CRKNcrpnHPuKpu84BCRRB3NtqdZ
         Tc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779789970; x=1780394770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzC78n/1cSkKY2MkbnFZtdzczAtKa4M13Zh07S4fs9I=;
        b=CZEAbXs0yigA1inKBCt8efmOd0lsoe8i8LOfOpzXp3C8vhNCbjjW3276RydHd/99Zb
         LgEwuli+3s5fe6W+Vr/4xrNrM36whHqnNHBAUr43ZLZ53Wc/VP2j6JzLlYup8kH6ofr5
         gfrRxCEJ9aTzaXQ8bt27x7xQedUqTRSafPZVJ7THzNlRK3xpOcioMG9wD1P5Dmy1BW/v
         eK4VYf64F7mQgIgDD2MhiHu3iojRhX+CAqQ0PdSBFlO3yLxRH4rL6PsPNIBC8v7NQZfS
         psxdOmWvLQBVdRiIxbdQ1SmX/FefroSGsCE/sLvQ6RBw9DJ/rOywrmm5yGrwGUxAUOGK
         vrCg==
X-Gm-Message-State: AOJu0Yy2CFsrmyjK8Yn+Wr4Y6e6Si7S6OScA54x1URIsJcbB0+Ib0SlI
	KnLapjEHhGI2dMIg516/WjUlCc4vXSZ9kaOFTxTtNk2BHtBOB/8hM9I7+xapKGjWou1aFX2CZkN
	jVmqRof+EO0WBsOev+HGm7gSiTzcyOPY=
X-Gm-Gg: Acq92OFWp5ZE3dpBoIhbZdvQkogoA1z2PaJc+pwzvg+jZ9M7E2bpv+Quki+9i94Nrqc
	OOJfVRhmjwS+QDDa+wQngPpSRUfcpWaC8pHHUkU+yT4x35YHOAuCrxaL8c9Rxu06Uu4xX7Bg9gF
	MFFvxQv5+r/QnhMumy7sgZqZvk1XjsyzFiaPKIWKUF6MHL11Ew3ty76qwJSfdfckfx7ArInP/3E
	TcZEV0q8jhGfML5F2TQcK40PPQQim0JZ2f+QFK3ZVMuzo0f5twtFXhnjQrrzJEqEwrB8PyCEXSb
	xg0UDBoGl41kpNNuUKyaY9XwbbrnaycSq2YhgmXhNLe3xHA64P4uTEqbhIZbQFFC7llpmmMWCW+
	njZY7MQsUl1YVIBOofl8SbrCuymoQsDBfRjlyN1W6Rj14V3TzRd4kGlMfyi4=
X-Received: by 2002:a05:690e:154c:10b0:656:7cd:98e4 with SMTP id
 956f58d0204a3-65ec96555b3mr13525257d50.16.1779789970393; Tue, 26 May 2026
 03:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523174440.9629-1-hardikprakash.official@gmail.com> <CAMRc=McOJ6FoLWYfFGeFgh20CNpFASj0gMtfn0+v25BqNUn5dQ@mail.gmail.com>
In-Reply-To: <CAMRc=McOJ6FoLWYfFGeFgh20CNpFASj0gMtfn0+v25BqNUn5dQ@mail.gmail.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Tue, 26 May 2026 15:35:58 +0530
X-Gm-Features: AVHnY4Ibft4-GqOxKTXkPI0fDR3Kssg7RiKV0mTuOEbmY3NWYUNxobWViGXQV7k
Message-ID: <CANTFpSXNLLYs526dGgXUGeOY2fuKcpsbGvqiuv0eE=W2305TKA@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, 
	basavaraj.natikar@amd.com, linus.walleij@linaro.org, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, May 26, 2026 at 15:12, Bartosz Golaszewski wrote:
> What happened to the idea of doing this in subsystem-level GPIO ACPI code?

I tested it and reported back on May 20th in this thread -- it didn't
work. The deferral in acpi_get_gpiod() never triggers for AMDI0010:02
because i2c-designware does not call acpi_get_gpiod() during its probe.
The GpioInt resource is on the WACF2200 touchscreen device (TPNL), not
on the I2C controller itself. So the gpiolib-acpi path is never
exercised when AMDI0010:02 probes.

The race is between amd_gpio_probe() completing and dw_i2c_plat_probe()
starting. Nothing in the gpiolib-acpi layer gets called in that window.

Thanks,
Hardik
