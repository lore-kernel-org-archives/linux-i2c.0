Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F594B8DE3
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045420; cv=pass; b=kwf2YcMld9WuLJuySD9i3pl7LHFPA1wzQDSdQFmGQlw85933Ym2vLVO2qOecA64twYYIITPLeAphssdjH+Y0+Q5qGdw+RTAgtHkYA7HEkLGA/+ntNVmwZYOjeLZ/07MaDLSuWAocsRdrGG63bw4yz7pgzZoji+iyJo7kxvnc/EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045420; c=relaxed/simple;
	bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6fAnMq8pgp27TLImMv8HO2OF4s8GCHH/NptObC0tiGwABitofXkzQNh3NUuym08X3E01T1EW6nap+xhmbDzWM432FSahikfYnUV//Cs7lzCR+aYUtdZQdwYinfOoWXRAdQExLAGGr7LZydDiM3fn4CJrhHbUlQCZjlF6SpJBOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck0d+Nf3; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck0d+Nf3"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1117378e87.0
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 09:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045417; cv=none;
        d=google.com; s=arc-20260327;
        b=OBu9+p6s9C+XLa+wpXcuFyfzy7AwUO3xTMha//w+4QZU0Bj00MxGiX6r5leY5HPDif
         vkwHh4waeSKWVdaCE68b+3y4/J/oaDsC6gaMEKeWf1ASqcz3vqYR1F97JAlS4UkAjNuU
         3bNypKZWaL7fBE8NZQESd7qi49HUBYy+O4zdUQ70wot+A/0naA3GlYdlqlNNV+ezJ164
         gB1P7c3gkQpJj9u/DZBB6LJnNJIvWFiaQoC1oKbF3S8ok+OPrHSVXXKcrmqTzqja3kUQ
         KbSKOFuyItPWBex9XKcn3sjFRRdP/9NwCBM5gIIqbvrhe5+qedKtR7j1d/DWMcBcBpEu
         EvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
        fh=YoKGH7xN3U5jzA5TBTMdXklxUU2T4vc0pq04kNm7wz8=;
        b=KcqopNGMvtJ4WhRsNIu+buV8gvsZQJ6pH+9mEgD4p9aCsbFpqjn62+OK8qzcq5g+bg
         ROyav4ucwynC3OKCQi4E1bnzKpMEmfD1enun8ZZxzKJzR7Kr6Z/33ChqsIVXBBdjvdz3
         Ve/nb8EXY4OJ2a1se0UJTFUu5ln6j7Iv+Woa5VSCYVK5t5oxr6PtNhBcDtPE0elb8NQR
         8QnQKlM6D7+L4Rcr9KwKSlkk9J5ZXiRIeI78bEaFBDHRmnlfS9H70c6fedYd85jBah8f
         NCmqTmHvMeNP+dAWEOjuw+FJeDOzamlYC29L31+aeea56wDSGrHgBjGGOESt6ETnFoYU
         F3xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784045417; x=1784650217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
        b=ck0d+Nf3NUDdCNwVj+cmbx8ZMWebrGRg0wU9Ev0rW/LdyouvXxinzXoqdLPt/YOFzY
         ToDs5EKOyW7RJ9m4eKKQVow3pNXnQXglXYkhkSceYMPn1tw0PqsAWzevfmA9YLTj4Q0w
         MlwegQJDH5hosvrZoeyErqwMATX6uo6hvIaUWMn83nDJi/9hgABcSRWqBMbTivJoZHci
         lVJqKPzs6+G9Zw34I1d6i8QAaBtcqQZEdELu5x2KDBVLKIpmTVLg8syLjx5TbPUlyO3y
         oTJCOWGdwHubUcNwryawW+y+W7lPAWIqmG6S2cJGVIoFTaLbBgtzGPuYIuq4cWNr2Lww
         CGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784045417; x=1784650217;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
        b=K2vR8l0kYHmE/8/U5gaFp/Tf/IHA2xvygZcF+EAvdh273802XFwEksQ0pvu5EkNF7N
         jSexLedB/+UAX9IYeFUpWiIeeiDOPBzxLybnIieCKKOg9b9iV7WsxtpeRvsWk8S+aSdg
         9A2oIKZ9DAX7YxZdTyXjARZXAdaP3e1l25snokRtvQor9svYRmZUptJVkZCL17EeWgzw
         haRyCloNvj7fya3oOVjpyI3qzMzbHc1elgcGDDEqysMee1OsonT6eJp271S1nZMCNFlK
         6Pvt2GTh/pLXYNp27wWL4Z2NLs6ijdISZZCvreIEUy64r/IPQJ4xtwreHlaeT5hhRB3e
         sBzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYEptEKWWcon0w3PpbGcwaspy0qkc3zW0PMUFI2QeCTUFy5Wcw8+0IeCYKB1S8ow7zqn5AV3fdFpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtL/SScKjDt8bICRRjJuUGWfDny3+irISoa2lYNoDdOoyiMFJu
	J++wWHIjVTuehPV3DSK1QxYmndWlvQTN++V0d7R1izaBbmwK9CE5K7PZW8eUjCBFM1fY/0seS4P
	mhBB/ti9MH25Y4njNPLaCxrispTh4WbU=
X-Gm-Gg: AfdE7clkP4SyYsDboKDJex0uMPfGiI0xXuG+yMJZhgCyed09OAzLVAIvzcMoQ/4wCfR
	xT84JoIfgKIRmvcrUQUSI50St2uvUmnkT6RJwg5WFyZA8L/LtgUiWYJzd2xvApEhmRwE0Y20lgp
	J/HW6e/vD8WyCbxzLHx7AcAMTkEuBLbo2blNaDujD99+2C3wiDImI/HiBAFBfLXuuH+5hAJZNh7
	NHB97fziXTSQ0IJuKYnGSIlY8jnjvwlTXRrt24JnM61wAFtJjkrtpci4EZAhJMn28xilgsArjmP
	i7eWMyhhQ3nSGXQ96KappHaCn5wGGc4=
X-Received: by 2002:a05:6512:250f:b0:5ae:ba27:ee5b with SMTP id
 2adb3069b0e04-5b023698580mr2990182e87.40.1784045416281; Tue, 14 Jul 2026
 09:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <DJVQAMP6ZPH2.1X68IDVBOMXGQ@kernel.org>
In-Reply-To: <DJVQAMP6ZPH2.1X68IDVBOMXGQ@kernel.org>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 14 Jul 2026 23:10:04 +0700
X-Gm-Features: AUfX_mymuGx4LGuheBapAT0SbQMDCl6HhaNslE_Je5xKU5wY_Z1_u4BqSMiQNB8
Message-ID: <CAO26r3TkGm0Puq0yJc7HyxMAujioLAs==RjGTiGUANzkHGb+Vw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Danilo Krummrich <dakr@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 19:08, Danilo Krummrich <dakr@kernel.org> wrote:
> On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:
> > +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {
>
> Independent from [1], this must not be implemented for any DeviceContext. I/O
> operations require at least the Bound the device context.
>
> [1 https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/]

Understood. I will restrict to I2cClient<Bound> in v5.

Thanks
Coirul
