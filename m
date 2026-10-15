Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629C51CF62
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070719; cv=none; b=d+1c+gQUtCX6wV+WektlyInIhdGvIG6OffX/9bRbr3n+m0XiRRNlgPwId5wI7u69sZQVWZsQ4uyqXSOrfmW9yWiEJqljPu622Ach047v1EhdsnKMYaoaiX1Vn5G/jr+f0+4avTThx9H2qfEUP5LGYdhh6/vAwNNW80p7sUqI6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070719; c=relaxed/simple;
	bh=H3zCP5H13vvVFVkfSQiIjCtmW1MwjHaJtfgXUw5dX60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i8CmENohVB67GC0q3KALvmlpQo/ib1cQ2lBIPWOlFloMTLHy18JrNc8qG7JT/3vl8LQnR+th11KCYN47DFWnIPP1jDc8+eWDrZstv8GrwlZC0shm0yz99iuRGcqmFzT7WfSvOOqoL+xdHBMmxixN4SeKK3Lwt7vfwXupCI7P0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBae+0GZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBae+0GZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c4649b35bso424408f8f.3
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070716; x=1792675516; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fatwg6Ql10eF4yUkxnXRufoS1VKiolsiumheXDiVcQ=;
        b=CBae+0GZcOGJDgIX1tHi1ZOI04z/UBOJD39qMdwmRbrcq971OYnfa8TT8VgnRoH1ag
         OJqediBSk9PNcNxf82i4Uk7Zra5yHVcpOMB9B2+FzQ0UgYNkiRTKX+9nNikkJPS0/UAk
         JpBHp1SArlEB3B/2jjkhESnhoeXzz/Gu5MIplCvBguZV0WTQbb7OTA55xNB2ax8oQQaU
         mYOm1payuMenxSFnlQNKDiSfKGsV0u0lKAO1Kklmro69gOhrjc+8LNS+0z+ox/TwvVJr
         p2uvpktUHsQ+QpxC+NCvrNykld46qcz/pOkoi7G9l9iZo+xbvmnbmYWO1BJnuV9Bb6Uo
         FlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070716; x=1792675516;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fatwg6Ql10eF4yUkxnXRufoS1VKiolsiumheXDiVcQ=;
        b=H7cft4V9ZaWmVH7YahuVvCjIvU2aMj3bM58JvDFALUSmdLuEDDaiCwvvEJVhfBCuBY
         b2zA6AcXLlwFvdXsxP/5K8Qm4hM6wxB7lc64OBa00aEstXAAqupeHHdb7WaIBLpec0RV
         2c/6o2JcvdAIyZghE9HaXHbzYCELZp94iDD7MF8WSRy12O11VVvdcFkqLXHjbEIabwIf
         vzopGbYfMuDV1+q/aJ2zA8GimB+IlW60oyxqpT/m4BjJoy/gsKbIIjgs/nYZdX0rAG3a
         +HGtwwFltVVSQyQqwY7QroPtutcebQLiS7WXBdhSS046ZvAAvLMeFGInT+934yfOK1t6
         F+Ow==
X-Forwarded-Encrypted: i=1; AKwUvBw9BolCEpOR7JOlSuH2FVvdcID1rNcfRUqEgVkLumQXibemIODgvMW6+wyHIS+8RnesdJRxPL4u9CU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+TFQeXux+Oao/fgVRZElY5FkZVQkvezzMbZGYAz2prHg9GgYy
	+B2xHupj+JIGLe7+I6lFXtFVq3Ea7/FcLXmadKyY4ZKEYg+iV7zTHSrd
X-Gm-Gg: AYBFou0YrvumUTxvyTak/JNSC2WZHgD1T8daYgdGPdFoTQv6Rxwm6B3ucqX8p1Unqb9
	XA2TdtGqG+CsWdIhMQ5vGXEtV8UHN5UNosrb7HX+gb45/XFfiPZ4lvF8hSenEZv0OGzaf4WABm3
	M7b1ztINOOoT+4d6GgCUlczN7UBAhjqHmUm7SsZN1naWi5FUDu87fP+1cu2xOagMAVB60dHGPOe
	liO0mNdR5ETCiQ14/YUQAmLbrL2BzyKAVW5Lk441NrcgWcjDTO39GEhp6WAwHlL4mChYEuQ1KoO
	qtYhOx9j8UhTLhIJ+PLniQWjXlwUpyMmiSHnndi0oHdz/8xnhyPkW1kUnhhtl+3rxGWvWnS9rNt
	ZD3NBXhCveQrPMEL/PjGZ05L9WJY7A8WBB/DHybIAd4LsXhfjOe7UZXtFfYPyZ71cJ9YoyWU8Kt
	BbF8lba76YcS6oXDEsmnt2hGh18Lg2yBEw1KvmVbB0Q/JgdFC1irRYi6NPosF2aiP0Vz/uPLXVb
	QXXhHGHzfwnqOLqLg2v7sADkxh6OD4ONqj3lWklHiAxZd5hUCsn8LyNcw==
X-Received: by 2002:a05:6000:4549:b0:48d:facb:5939 with SMTP id ffacd0b85a97d-48dfacb5b8fmr147377f8f.8.1792070715607;
        Thu, 15 Oct 2026 06:25:15 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de09693c7sm23470807f8f.4.2026.10.15.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:25:15 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>,
 Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 02/11] irqchip: Add Cortina Systems CS75xx peripheral
 interrupt controller
In-Reply-To: <87tsmndu0p.ffs@fw13>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-2-181bb0d23f4c@gmail.com> <87tsmndu0p.ffs@fw13>
Date: Thu, 15 Oct 2026 16:25:06 +0300
Message-ID: <179207070645.418589.10399440167204506807@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On Thu, Oct 15 2026 at 14:32, Thomas Gleixner wrote:
> On Tue, Oct 13 2026 at 09:07, Fil Dunsky via B4 Relay wrote:
>> +static int __init cs75xx_intc_init(struct device_node *np,
>> +				   struct device_node *parent)
>
> No line break required. You have 100 characters. Please fix that all
> over the place.

Done for the next version, the declaration and the calls in the init
function are on one or two lines now.

> Other than that this looks good.

Thanks for the review. The next version will come after v7.4-rc1, with
the interrupt controller as a series of its own (binding and driver),
split from the GPIO, I2C and watchdog patches.

Fil

