Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69F3749E8
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900523; cv=pass; b=HwB7kCVX8vsbyvZxmMOiX5bYfyOutVZdSXCPkuFW2JUAWqnEWDh6CvnGolaPkuf8gGHsFou6P36yoB9W5GDC6ftnb/v0kcOH/R69jP0m5ticn5U0Qls7ADJCSXYxvAvOLmYRH10Oh8WnFCLeVNDDqtMULacxkhXK+oKunxFCf+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900523; c=relaxed/simple;
	bh=WUMZC5zmbWFHHM9fj/b0WVfBxUhBF81uS3y69nJEc54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDjWt16l1NDdYXa+2ykCY4prWykep1N8z0RGVxIIdlhvlwEYvwpy62g77GL4DWSoRqfNXMQHi5Y93zVwOs3WMvC0BVbHpnWMXPIRkjZSJ1Fw+maOSoFuu3Z1KbsfqKvt7IEY8BSEbm9VhwM8Wyh7+ZCXIxyQggZ/l3lQrEe89Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn9xNuvR; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn9xNuvR"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a20d12211bso7193271fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 00:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787900519; cv=none;
        d=google.com; s=arc-20260327;
        b=bdUvHaXXoy1RPqrfu3g0Zxhdl1lEfVUm/ECVjpHFFeqzzszCeAqfwWAjFxEusw0oB1
         MVzvcz6wk9j6DeV0y3/cHxqkIgyYfb9U7j/YRRxoInbFhAQ+pkV/VM+e1kGs+BvEHns0
         S0Lkij5mjZNNA6TCBJWFrEgqTPqT84aCiQ2R+cSNTRmez2T98Ta2B3lMOz60JsCaQr2g
         RBFhFqPIeZPEubEH76niPdX1gCJ09YHgFeVToUpgkYGjAbNXpk4+JEw3s4XIvkANjpCS
         2AQNS0y8hP3BkcAyj2SvVGI//5v4UB8UyFPUVwz/WTKZ+QN78JzZ0Ln+aiWWC7Qibtmd
         kjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H4YdnU69bw2loweZcyhECkKVgGdkyMQpoAxdxOphCTE=;
        fh=BtYfdsyNbel46m8yYVVV+4Gbagx6xZ5xXHTE147zCsw=;
        b=omui5M1hO3Jzzp7ILXkIN5JMKHbKqIex9slY39+vUKcUo3IbDEEhdCOnQ7px2pkMh3
         hzGrOHgFfR+on1G+tqinWFdB+XnML33WKcMQK6x2g2x3U+hWa96gOmP/dB3rhm4fbhhT
         AJdNIwuMNbgLwmTegG3r3WRJbwNE6er0/eSQja3UE5Qc0ITPkvA1TbjJ2IX6yebfmuZq
         QuveXlL/exW3vltEydgRzy8yL5SDDIwB/+Bb0CcGarhE2Bc2iZyyM8pdFYcM1wNGxOv4
         PZFQwrISiiyutATVm7pe6hEp/sZff8HJFEtPKo37uRRe/ttAx0yHX3Fi7LVLtqlrxaz1
         1VIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787900519; x=1788505319; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4YdnU69bw2loweZcyhECkKVgGdkyMQpoAxdxOphCTE=;
        b=Gn9xNuvRxtRTpKHKpxXJTDHjvMhBlWvtemhqnqf+pNCkWzHReockOnLz89X/aMZMNB
         b0T9mcl8KTBDtX3wRQo9V7jauZUj9eJnei+uTby40CK61tqSqlMLLXpA8sTwgHmsUkL4
         wd64VqvNKeKvexLyvHDVj32uNkcH+Z3zW1WDrbk2qNGuUcYEKs1EZKvq8eyQmRRo01Dm
         eHOtYQQnfZomgt73Rrs0yl9Imhz95QRU/6jXqMmJG39yf8XOdoKO5OcVznsKjaYB08mP
         iJDNSQHwTEImS+wUQAmh+6NeL5Gs0h6/buMLxjkmr4XPfcLZjvlg9c7MqSUh4SFNR2PU
         WzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900519; x=1788505319;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H4YdnU69bw2loweZcyhECkKVgGdkyMQpoAxdxOphCTE=;
        b=bdXAMGO2t0kLrvpZbbiZp87s383uuq7a2izhuFIYPyKNioG/YSV6JLuBW0b01io++w
         WWMUhpr57DjNanhUNJnzCiuS3I0pBYfBzV2UJSa8Xlc6uqVBdhHzMcgA25my89C7spQw
         WnYAHEtyWxmwIrCI5Eq+cxz8C2x13AiT2S4ysnD3lmxkuojr2IRWCali2pCIpIeGX+9E
         CbtF5Fx0c9gq+2BipR1PYKpXSKxpPTS3LSMCZHdyCvdXlJF1LzMrX4x8qSDJ1/SUQZ5p
         gIFUNAhsJ7xFTEKtEaXELxLZDwow22tnyym+serfrtOJLoJYG8CzHmHbAaUI0SWh4+r7
         xCNw==
X-Forwarded-Encrypted: i=1; AHgh+RppLMPH7+TrqhsNoe0sdsubCzlfeJyST/7KxWklvenj7gKEwTKSAc2kcM4pGhtSd8RxYQ2ai8ZnEhk=@vger.kernel.org
X-Gm-Message-State: AFuF++kyH2oOf1lzk2x5wC4jIAEiwav/CK5or8s7jLMaVzYe92LLbFWg
	EmuJHWgMK2NUWpeIeJTOjEOofrNTBdWCLEkIi3z79GJZUitSqVzRlLf3hwmj2jThN9ATz3iVVkV
	5LoAaVXG1Arj9Mkycw6dRtpU9M/Ij14M=
X-Gm-Gg: AR+sD12FfI8SqQoE4pZxvDPUNKyYQYP2BPlg0z97ZgmSmIlVfORFKuAPPWpQ3cYZ43d
	rCwjlaqnRLQIa4aVJcMORokb3dzBmJEm3AX05xz+cviR2j7p+9//TVla2rAfQTUFad2wRXqf5Mi
	Wb+dGYadYa0ldxjlJ9R75Al7XPv5SdEaQNaTXisedkFzqyiGhCqTaZzriRRW7Gwm9wbpd4iEUYk
	eFmPGagt1ZVsmRTlPdUmk2hKpGI/ov8sRVKWkya715lUo7AZy+dg/8ZqL1vfYngnFQ9y30vXy1q
	cW51eFZIuiOilS5EHzFetxJBxF0KEjO3AaxyBBUTbeOesn4NkZKPV4UORQ==
X-Received: by 2002:a2e:a909:0:b0:3a3:364:f783 with SMTP id
 38308e7fff4ca-3a303650017mr4458281fa.11.1787900519048; Fri, 28 Aug 2026
 00:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-4-muchamadcoirulanwar@gmail.com> <20260824011749.62322d99@jic23-huawei>
In-Reply-To: <20260824011749.62322d99@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 28 Aug 2026 14:01:47 +0700
X-Gm-Features: AcwNN1WZvS_vxAPD9ztThL80CtQKEFkx81WWXxaTUCllRl2U0Sxi7MBLeV2GPXs
Message-ID: <CAO26r3QMzTuGnHN3if8N82DEHdWo4TS5upEWgUz88gy54rXj8g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/3] iio: position: add Rust driver for ams AS5600
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Thanks.

On Mon, 24 Aug 2026 at 07:17, Jonathan Cameron <jic23@kernel.org> wrote:

> > The AS5600 stores the 12-bit raw angle big-endian across registers
> > 0x0C-0x0D. smbus_read_word_swapped() handles the byte swap: SMBus
> > always transmits the low byte first (little-endian wire), so an
> > unconditional byte swap recovers the correct value regardless of CPU
> > endianness. The long-term solution is regmap-rs where endianness is
> > configured once at the transport level.
> >
> > This driver uses INDIO_DIRECT_MODE without buffer or trigger support.
>
> I'd only talk about what you do support.  There are always many things
> that aren't in an initial driver so listing that bit doesn't provide much
> value.

Yes, I'll remove that sentence.

> >
> > Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).
>
> Generally put things like testing info in the cover letter or below
> the ---

I'll move it below the --- separator.

> The code itself looks fine to me - but as with earlier I'm looking
> for rust expert review.


I'll add an explicit review request to Danilo, Igor, and Brandon in
the v6 cover letter.

Thanks again for making time to review.

Coirul
