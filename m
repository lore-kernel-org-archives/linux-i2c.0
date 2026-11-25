Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795573504;
	b=ooJUHTY5wwxvWW4RqLCcsD1//4EdzouSdGwV+7+maVu5S+TxX5AbRxkBNBdd/4W0gpme
	 7r3gUfIp51Iz3ui/r5fItiBguRdBYn3QxqhVBz292KC6csFCBLILByUV/qEsvSFOT1dgT
	 SdKFjoc5263Lgnrr7DRXStzirwo6ZkxQJ6r4aUvcuzJrhnoZ6Qm3d7nJ73laT9xYgYLbv
	 G3eIfd7oe9+r48OFpL4CP/iNHmrMfJw1roQzEWmJN6RZC2u5/J52XHVO6S2sJ9ET0pJ33
	 cXYLSZdRUBF7d8cQgCA2Fiv+d3cIgxWqVLrWzlFIXVdY9RVpQ6VKI8PRPGLEQGQqeuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
	b=vLp13puU4yuB9zupFTfL3AGj3mLUvbYSLdjRUn9y7wmd+6Dy58n0u2bPKqORoV2AbMin
	 G+8HtNVORza12BO5ZvVJKBpuHjfbsfHhWTIVmf82R/adixbbhN+Knt4bn/QHPbObLM5/y
	 vojQ1clluQd79hxY8EVdtnZmRgt6AN4QDL+X3ybhLzyOlqx2jBap7Yl/ejzzpXZPqhT1N
	 I8HrDcKXQtO+0ulSlV+833zUFei7DfQg6slDONl9g8HpWpUFhz5jef3aAHV8ApeLZmYZ3
	 lYL8JOhwPwcbus7ebX/wRLkOp1IPzP4kHn8QR1Yy87wVifot9nx0dd4I9u2ZpOgtudQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDPnUdSz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E271606A327
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 02:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E271606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDPnUdSz
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso54483791fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 18:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795573502; cv=none;
        d=google.com; s=arc-20260327;
        b=fCIFZH85QuG0iwxXijlc8f08yzpdRrZug6YWyjWVuPIQhQDScErCniWbQ4KsF7DZa6
         9IALNK8xdg5MVFbJJRdUaNcX3rAU5rp+YEjkmvm1RA3rNkfXYTc43+tS3tPUHQCX2Raa
         IerAbZRGpTJSAjL+f2dKSIZpIZklwsJgmms2I1imrhxs80ThFN6JrtG+z2rb1sQ1bfeI
         GDCp46Lh8SMf8f23D06O+9MTRQctjZ0knXNAPN5FjoUlptnfCn2gjVLSC5vwYK/4X4Cd
         yfT+FqgojhVJjSyCHRvBSSndqlfTupVznZIBGrYux0Tz1a3nvu86HzWtWpoXu8QoUMwB
         KXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
        fh=S3x5/quLPmD0ghY3mBirmz6ZIMKE0OKgtbPe3M4PEcc=;
        b=d43EkTub42Oyi9CWwG2gmXN3WiBok53IJBl8k385kfeql6SioE38V0HrVezmvKos/5
         pI/e5bsxZ+inHb+17zqm50Gbpgg/kTeoAv7YjkQbQpG9sPk6Y+EskEqCaEp4XarXE5mX
         T14qPbjKQgHBNOxiVUHBGqXjuXblTSVyYuXQYDfIztH73kPvXSLLSHja4IWMCXuOphK/
         WpTa08yuz1pP0oNxbMz9JRXIRoauHpVpkXyIVkDfjNX0vKCx3VORnS7Ifg5Al5erBKup
         KjfnJ6/Eo1ImGlRkJm8VcS1LR3P1z6VinI9c7Ivsbp5N16Zpm8nglZowa8gdQYEXDPVk
         HS/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795573502; x=1796178302; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
        b=RDPnUdSzB/AhnrN//N+BqPMk9ZTTXTKqFwy8gyHKdHefO1PpfVCMR6aUyienTzJI8P
         JQGcRjKX+MmaAJZP+B6NKdLw4K1FiiVv/6KY1f/KYSLS45C4rvQa4hna4gHfroEycXg9
         5lJVhz6BETGdhwdNnDbEdLmmRORAdtJpV5iWI7e9M8rr6iI8DHjdVvwL2S2z1QPfiOUa
         Pojb1nWft/8I7O5ZqDj5nnkxRhCwPDxrbDwItFQbwdO2Zaqcq0UY7r1w+tqo2Kg6hLcq
         nCJypzIw9gh4ToZYIVblfw33S8GICrIljQcEyhLP8cllbNWTJ1sIVcj6ZIeQ6W73XNxJ
         fwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795573502; x=1796178302;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RoVdVJuanm6IY9SbdoTW0HDKXtpUnzxojZdIdcKrd9Y=;
        b=v9tKP7wYCOpdk1vDSpk9paHBje4kgVwdcN/RFK9wBqRqi+KcmZsiK0HuQOI43D0OEz
         1BD5xleXECc/Lttta3xXMQLL8oexteP6MVAj7pHs1G9tW5eBH0vrudig1HMRgofbPl9V
         /whKv0TYv4KaMBTcqFcPw6D0Z7gGOsPtJF/pqVzQBNuCBPJ5Hbcg+O5Chs8CfKMUu4Fr
         2xEz/a9KFXM0cKE5jn1WO00S4R33yVF5g5pDdn4tuFU1ktoOva02vBsOfQaX7enN/iV+
         ZfhgplVocvVrI9XsiLezh5dGoiQzVd4TRpTIGz6f++AgIwcI+7Vo6AUoISyx0Lc2Yfi8
         CFtg==
X-Forwarded-Encrypted: i=1; AL+hErHUUjRuZ8V0sRXPGcIOqLywLIPF66qspUkSnTaxMBSWHKAk0ItcaMWam/r7gj7cQVVfzxZ6k51zuSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H5KNJxkCFoy4T19HpyjWMHgIXF/9knB9iiEVMmEiIpt4qtdhD
	w0bypHS/fWeviQ0oXb9T/H8TV27bn0bkO/W49z6oJI2FYahNojeRDkgLVii6x7ULTYXFQ7ziUxx
	I4o0OYKKUqeqWYHf4FLqSMSSZD31wT+I=
X-Gm-Gg: AZFdTZe+adjjlRqece8yN2OABBYTv5X3mJdsScIpmSrckcihPrjPsgkEdbfu2eh0jZD
	C6SNoRkQdTyeYjxRlDmi5//X7hpbFOD551Clbxhx+QMT6Yog68JS8k3vRhH0mDOhv/UGuRqFiWI
	dWmUJEXjeV4sBs3i83MJSWpmK6USn2yeDTlE2weYt0epI0TgSXW0XOBfvsqpKfEA0phJ1VOHyP8
	vnV7ufAZejQPTfppPMegQ4gCyUJi/LmxUxTQG7zN3m7lWjOmz7vL6AcHsDd/7B+VnfQqvMR31TE
	ufCF1EJ3fgnOq7h3aHdT5SKhQD2C5NvWcP5AYJ0bdB31gjhL/JyqwA1jRBvWz0BmqFiLPiR/z2D
	Ui5jLTtEHWEHQ6hHk2IAU3sOvYDOQvnw25c/w
X-Received: by 2002:a05:651c:160c:b0:3ad:ff5d:19b1 with SMTP id
 38308e7fff4ca-3ae7b7fbe41mr38238951fa.20.1795573502123; Tue, 24 Nov 2026
 18:25:02 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
 <20261109155743.83740-4-muchamadcoirulanwar@gmail.com> <179538281024.9825.4132712997497273037@linux.dev>
In-Reply-To: <179538281024.9825.4132712997497273037@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 25 Nov 2026 09:24:50 +0700
X-Gm-Features: Aa3M54rxCZafdUbvRb9-vw6Ll7Se68ZBnBVHsI0xIW9ramLI50wU4YKTZItQkks
Message-ID: <CAO26r3Tn95hm8SCEcP13wXE7p+iQpJ0O2n_tyhQvYUTkG813cA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 3/4] rust: add minimal IIO subsystem abstractions
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Shuai Liu <847807867@qq.com>, 
	linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 04:26, Igor Korotin <igor.korotin@linux.dev> wrote:
>
> Clippy shows two issues in iio.rs:
>
> 1. Line 332 -- ..unsafe { zeroed() } in VTABLE. The SAFETY reasoning is
>    already written above the const, but clippy's undocumented_unsafe_blocks
>    wants its own comment immediately above that specific line.
>
> 2. Line 408 -- unsafe { (&*priv_ptr).channels() }, drop the &:
>    unsafe { (*priv_ptr).channels() }. needless_borrow, no semantic change.

Hi Igor,

Thanks for the review.

I plan to use `pin_init::zeroed()` instead, since `iio_info` implements
`Zeroable`. That removes the need for the unsafe block.
I also removed the explicit borrow, as you suggested.

Cheers,
Coirul

> Cheers
> Igor
