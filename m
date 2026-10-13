Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006851991B
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897305; cv=none; b=eLM0U7XqMACVY4fHmNsYO0NYIuxbq2YsAwDoXkAkq5JChpnyIXnRFyi7eyEW8nvZNF2bhv0cZFT2Ut27hOYDGDHFVTWlABjKzaCI17Pb05o0D2YSBjDBs3sCgQ4Ect2epTUU5BpgKy9g59BfglBK1mgpLBWvhwcWPEqnPrEZIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897305; c=relaxed/simple;
	bh=ID7ITH/ey5fDaXQS2sirspBvibpDl8OQIA3uc+tsOM4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Sn1JujMzQlGQU1LJIL6ChHmVw0uRBRXRab+wAtboODVqAwDNb/tbyuy8b25Q/b6JYTA3BE7CL3WWvq+uFtBLlCm9JKvied7aalw0k4sAIbtD5TxNL3xEhtifj+3+rXg5aV6DWId5bB9juQYKjBXusDFOLHIbmHRiDhHfxvtC758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPLqu/+7; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPLqu/+7"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9901faa197eso339118241.2
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791897303; x=1792502103; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ID7ITH/ey5fDaXQS2sirspBvibpDl8OQIA3uc+tsOM4=;
        b=FPLqu/+7aQFRel3lANPVYVO8kML/ngLiwPn/7YgcNBBVGWfN298UHU1b/Oz1DWzT0/
         OssUVyJsBAgnl6xFP6SGQ31aazTAJiU4EuF8rjROKQh2NrwdeBty3W0XExr8oCNC07z+
         9Ez3XZo4XhUI1AQ74I8AR3miNGg1FpoIurXb+lnpZHZG3ruzdE7Rsb3G2yJXlHet3muG
         BPFDXozCFfhK7iYd9dKaUs+6SolmOcQZRBejUnPfa1S71wa5qv7NF0/Hm7gZgxDfwOKB
         7T/4/xNfGJtfLS7h4w67GG5FaOjBg5TveoN9BJI9w6BuDCD2LhGgo7kY+XENS1DS9sS/
         3Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791897303; x=1792502103;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ID7ITH/ey5fDaXQS2sirspBvibpDl8OQIA3uc+tsOM4=;
        b=jqpxqNt+JcmGheGhxGQAQpd5uFx7uraisuMLgauWucvpncfEhLW8TwLvlI/4qoWcC5
         dNDKv056T7+ndQSpMwyZiS6nRbFb6OiR12BJetwGq7F9slTh7KpVtpQCpGHDJrPS+T5J
         tErFG6oj9nXRdFF5zwaa3XR/CS+8cbtWmqk56IXXz3RY2109qJmmviyowHWFc/MR8y30
         h8SfeYiAFJ3bZZWcuSSO3AKre/5rWAmOmcx8IfMcJftz/xJTOU96307BDcych2oudH/w
         vBYmkI66LmpUHlTRkV0j1psBFXc/uU2bMMNjsjqvr82R7RL4jDdsTrQpidaUCV2SaINa
         kOKA==
X-Forwarded-Encrypted: i=1; AKwUvBzDpEKlj2uOJonvlavgfPaEvDYbcu3ATEAxDyR4qkDZ0heMITey3TXLJABh+1bTH7tsmLVWM2882Ls=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyy0ZbhmvAVlETacg/B6kTo/22QsAAjIcQj+T2ilHM7eJjeDVa
	0TcrEdJJM3Dp/r7fK3voWIe2lFu3HZ22n1E9Pfpt0SPXYG8pVfIVpFc=
X-Gm-Gg: AYBFou2WMOKVBJRy3QQz1/72KcQZ+kSV2YvjUPuhLtIexO9A47K+Ejz8iHkPaMaZbyq
	9sEhOxH0/Eq4Xzk0xgk1p25igrP41QBS1jZOpQP8ARCUZ0MDfgJt7b2kR0bDGBQxtrYu79uZPkc
	wWp7QHK4efq/0sX9ulahXDqZJ2T2Wb0VfvwrD1+3tcVwX71teyIwzuW5FGKQCEmtphcJcCTJLjg
	XOJVG1hzyC6v84giKuVM2EcRxLk0e5WRdlhnPeu9IB4N1r3Opwciq+8pNp4+jE7PEaXDocBQ2qN
	whkZDsh6ik5YUL5o9/cHBmx4h4RSA0iJlD1cPqbFE1KwyoOUSgoImoQ7iKbNQnDsE8fxxpvq+gW
	dAapkiNC7ljqFCAwBZ3uZtjHKQamkoWHwJT70QshUbFl9YxMqpeJRBY93LPR+pyQl+XMcHh0J6b
	oI3/a4o54Efet+axkVeDOEMCuecR+3LPDk05nDUVaBk9FiibUOE2S5AM0NNyjkbJZo0iIM9I8ou
	EE5lyypkPdyEL5msPP+khswEnbOkwl6aQ==
X-Received: by 2002:a05:6102:441f:b0:7a7:19aa:f0d4 with SMTP id ada2fe7eead31-7cb37a04f94mr2579211137.33.1791897302771;
        Tue, 13 Oct 2026 06:15:02 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb3539092esm8734108137.3.2026.10.13.06.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 10:14:55 -0300
Message-Id: <DM3QKTJYPA8I.13TW7H9HIV3YB@gmail.com>
Subject: Re: [PATCH v2] i2c: rust: avoid locking when performing
 I2cAdapter::inc_ref
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "Andi
 Shyti" <andi.shyti@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Boqun Feng" <boqun@kernel.org>, "Brigham
 Campbell" <me@brighamcampbell.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Danilo Krummrich" <dakr@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Jori Koolstra" <jkoolstra@xs4all.nl>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Shuah Khan" <skhan@linuxfoundation.org>, "Tamir
 Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 "Sashiko" <sashiko-bot@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260904134600.340991-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260904134600.340991-1-nico.antinori.7@gmail.com>

Hello,

On Fri Sep 4, 2026 at 10:44 AM -03, Nicol=C3=A1s Antinori wrote:
> The current implementation of `<I2cAdapter as
> AlwaysRefCounted>::inc_ref` relies on the C function `i2c_get_adapter`
> to increment module and device counters. This function acquires a lock,
> looks for the adapter in the IDR table, and, if found, increments the
> named counters before returning the adapter.
>
> In the Rust API, the `I2cAdapter::get` method returns an
> `ARef<I2cAdapter>` upon success. Incrementing this reference count in an
> atomic context (for example, via `ARef::clone`, which relies on
> `AlwaysRefCounted::inc_ref`) could trigger a sleep-in-atomic bug due to
> the mutex locking inside `i2c_get_adapter`.
>
> Since cloning an `ARef` implies we already hold a valid reference to the
> adapter, the IDR table lookup and its associated lock are unnecessary.
>
> The fix consists of bypassing `i2c_get_adapter` and instead calling
> `__i2c_adapter_get` directly to increment the counters.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260524181151.24988-1-nico.antino=
ri.7@gmail.com
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

Following up on this patch. Please let me know if you have any feedback
or if any changes are needed!

Regards,
Nicol=C3=A1s=20
