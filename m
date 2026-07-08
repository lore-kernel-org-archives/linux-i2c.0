Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107183B6BEE
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506992; cv=pass; b=JSbjxIuT/0a0ihYiXLx5s2lHpMCu1/kdrRQ9M1yVp+H+tStiuRUkJpTt5yHVdv1ZrJUB506KQ52SQJRQl0+0Dz1Mdqe8uB3UC6NNA2iiOTL5qxV0qbIvzPHx9lTC88HKrcJMrLT2L27FwYBaRJYAllIa2N6wqsLdyF8hjjIHUGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506992; c=relaxed/simple;
	bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kD6T7c06hTgDHOPy9ZHvGbsqwKhMJ0ZYP9OnoS1/hH0tMN2ONvPv58jxv+1DROOb9v3xzhM/RAKeZfKAD9KVtM7QBC2+7/flezo0l/G8tV5KHgKxiQP5cmJA3qY7OTWz7wo/mxsD7bABkddkEDEbPaL5YnBqMV7sOGivam8xrh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0TRToUq; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0TRToUq"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca6a6181273so13778a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 03:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506985; cv=none;
        d=google.com; s=arc-20260327;
        b=AMy/XGZmvM5FRzIaOf7VKH7CFC2sP79Q3Z7JDjD9juCRXG0En4330uDagEDmUWIvjI
         fiJ7UIGG5A2ZNM1uwXh4I3MoEkoziBkubkbTXxbhz9Sn8R/Oc6j9J5pVSdyB1ST6DecB
         VxsTcilV5OluewqCtswbin2phloPhQd37A64KTNV0yp2Udl4yShgX1J7+ftUTwetiKgt
         +nUMcy1mYIQMPRd2rCKmjAGRh5CdU3hoPhEg0FqFhX1nqOp1SQEkqYUVIizehoQfE8ie
         7YHjTitQalir3LND9Q00vfgF9Dm7cybJrUHFbe1EWfkvtq1hi2aaqEX7EUGlhrmamaWq
         LmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
        fh=+uNvPvhS3mKtJH7Ph8rSGJsSSMiokx+AHP5dMCaWCcI=;
        b=VJgFT1WzDuMRO+zgx3WURaSSjcDpgBy1Tqa0ZiHVkZNuOlFZqG0yK23nN77ENRqf0D
         kbuJGnpvzc3OfEsGeHvAQBK28+iijZWjdyPnELZygZa9WXnp3V8bWVxLqNFcJUtPwIsG
         +Ftstn8VckLcKgvoDyYztxTeUxpAGGgPTFQJqBNcrq2Ca2OTqRSRDRQJpQ9B1RlGKJWt
         9QucBzh03GWpX3rpFM5qFZJSybzf7qxhcymgWXLBDi5LeAlCFD72Y4j7mFsN3KypAnSF
         QBDFq53BHVtzlncqRuKzWvrLP5ZZJCDGmWcLc/BiaYPhMvPA5dzgfYa+2P4QD4iwriJ8
         G+fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783506985; x=1784111785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
        b=D0TRToUqYN3Rdph001VmDw3gvRgj4X6J3yFtQ2Oldbtl3B7Y/MtUitwTij3J3KAEzu
         Pu5nb4rvkARj9WfzxX38LoWFQd/1rhiXARKq9+hIQw8kraeuSljD2QLKJ7sfzFDrOQbv
         bH1ZVkZRIqj1Ql7A7wGyUFVVXCDZ4dLAr8RLW2T1UCirRY/G3zY5KqM3d9xhYJXmoeon
         Nd44xV55fO7l/kdu7Edq3EGoaq/lcH6VOe4IRyF0y7ujHpWErTwTB+oejnQZiAmiMjn7
         Cg8G/luw0IaJg1EFDC2EYuFTo/NNd2CT7nbVkiCncvBPB/j+VhJUz5V7OBouMjLaaJ1O
         TuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506985; x=1784111785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzqSzBmO2/LNWpe9fGm4KLVQueTZtd5Ku7sSD56PRhc=;
        b=W4iQ4D4wPL5fIoMYdyOBfsASfJXPrnH6xtxhkogZJZBUqTkL8m01CRkghDXWDzvZqY
         PVJ2cECtzDOx4n2lmE4/kJfu54gOvigkgpyx/0RwsW5pzhi5Fg7NSpYBlSzEmThStAaO
         ygBE7+XiIHIw7Cq3TLPZPVXlSf+9JFkFajLAW1us30Rro2bBDp+sjx3cyZRDlAv38Zhf
         s+chzFIWdUvM7IZKlDmvevbLxcdVXdc/f/6pROcUzThbSLIQxJKVHieR+3uVUP1C8+G2
         IVD0SuOaIWIrkQXnzd9ySRTTIzheSQa0p+6EAtOmDtoSCIaVdD05ubM3pagW4B11UqCM
         nTLg==
X-Forwarded-Encrypted: i=1; AHgh+RptMQXnP06JZ4n3wMqRW2QPZt+jPqTlDxXSGkuiZE3Jun4hsgOdGaSHDKS4ZSMuCY6yyUnVbqRk8hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA2zecpRHeZ0+AvUnTeG6sRB1N1qlNyVFch9J5dzg03eY2xuTt
	PBqv/RUW1+QhZuOB14mV0OsrB6A8fSJZGcke4b5OuQEUFljuuUu0qWva+pHRhLtJ1Qt2ENHYI2V
	xg1w9Zdud1NSjlAnX6+bKERqmlEOuuY0=
X-Gm-Gg: AfdE7cl/wSPtHLlG5SBQLHR5FKlPOMG16JyEjfD+ZKt0e+rHMTxVAYgNm0h0XalQ7pL
	mc+TWiXtEVI0LH/hJnTW2OsoUbk32CnFx07Zw3dlJ1fKOXuhOtIaa7cU36plwZ/1vLGEdJBJLo6
	tIjAPixosM/lMIsyBGBESBJf9XBEKOR/v8DqpwnTG0/9gHtKSVel3cVddfS1zYbbYkZnpRY05yb
	DM6DiHRxVoafu2h0+TKgC24vBFyRP/mZ51C7/KAB9+kGP5yx7E7Jl70lNFF1NMLYLx0A1j/Lhas
	qVhHZYo8uVY7i//aFq8NzXCBopsLMFsc1YjdenrJMv6QZb3zl+GWEXud52S+il+DkFurjOLZCIW
	e/KxbkA10M6KG
X-Received: by 2002:a17:90b:3fcb:b0:37f:fc3a:382d with SMTP id
 98e67ed59e1d1-38941fb2d0amr1770186a91.6.1783506985239; Wed, 08 Jul 2026
 03:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
In-Reply-To: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 12:36:12 +0200
X-Gm-Features: AVVi8CejjCB0cQnGD60nSceTy3aexNzKn6liFV-neeZ4M32IR5vUutS1Lqo1P0k
Message-ID: <CANiq72kQ0=MqAhrSSk3m5RNVrO+4Cv18xv1noTE1Y8TsPeRhDA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/3] iio: position: add Rust driver for ams AS5600
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 5:17=E2=80=AFPM Muchamad Coirul Anwar
<muchamadcoirulanwar@gmail.com> wrote:
>
> This is v4 of the Rust driver for the ams AS5600 12-bit magnetic rotary
> position sensor. v3 hardened the IIO abstraction layer and introduced
> kernel synchronisation primitives. This revision simplifies the driver
> substantially based on review feedback, removes components that were
> over-engineered for a single-bus 12-bit sensor, and validates the result
> with comprehensive hardware testing.

Please Cc rust-for-linux as well for patch series that contain Rust -- than=
ks!

Cheers,
Miguel
