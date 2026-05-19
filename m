Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6572622
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149651; cv=pass; b=pOP5ARE7glDgpG5HFolDEjNcsiorLZCznpk5z0EWA65sKQM/MrZD3i+M44MZPYI6Cuko6pxkpKB6likghHiiqqUBAReG2Lxjm7kR0xMmb3OY0F7Lesbpkrluy9EmLtkXvwjt3lGrLSQL/HPeyQ8AzBlPbcGtJU4uhcfGaFuwTns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149651; c=relaxed/simple;
	bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO4rv0ZmDgwtf/X3u+bgNYl8NnGyi2bM9eJNazdUgYTQrcnEFKOd+KIAWYUwEYjO6/FdSd9IuVTOvjLDJEq1GWKM/xXRXrozF8oYTAl/DZ3knFp4X/C1XvCpT3UIrFLyhvmdplXqc22W7Di5rLQVReHwaHZ/ejSnvYhg6W8wGhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d59lwcl8; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d59lwcl8"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-50fb4a7d704so27523041cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 17:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779149649; cv=none;
        d=google.com; s=arc-20240605;
        b=bsgpakT1SPsMk0i/6dzvwjpu6PHSoJDEU07ta9tDdIyso8FnpnAfFJeIGSr/hIHC6x
         S51La1imBTS7ERuMOA7WAZaumx1LttczzvVlDYGpFV7LtGnXY9CbLq3miz12gmXSgd7E
         lWraA+KoLxsw+BfthSMABFT78Xgwvtzqfr1G7uuXFEWSmc3RMQmJWFwWdLMED5FtglRQ
         +K/u1ImkR3E14KdR7LgDvHVj9CHbNb+jOL/Xf4fMq8qb9xaYcvMd99lNdZ3tiCCr4Y/x
         sCt6YE0bTl/HgtedoV5Gk3BCT66V6Nee/Bd2G35bcqgRQorb8jQTmgwIEPgpLfZl/OBv
         Bqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        fh=Qp2W26M7rLIuyoj0pSNftQwQfMwhwyOg5pdgecxJUpM=;
        b=jl4arR3EY/ASAbxpNeXJUGZRWkMQWC6jJz3WZ+VWGn/xPWFLWftDS/vNHp9TrTJr6t
         b5P+16+5G4iS3B5yX+SMzvf7M9j5WQog+5g8N+7CrRstRIb3apQRKQGvB4ApgcJK+qIU
         pmKbNE5aQ+X5KeeW489ZyPZI8KEatj5EaF0u1tQUG+DS1lleDgBfd7M+dDTTMIaA4c3L
         jCG5PApUZl+Jo/9IsG2TVlQnQMq1Hb/AptWb0HSkIDEilLfR/kvul0ildZCPg74PQenL
         NTiNaZbWJeneLPd9wI6NfnIEZzhGeL9uY2aFqC44XgHzrBLT5xdcx6J7VOYwgE1iYfe3
         t1qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149649; x=1779754449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        b=d59lwcl8NvuOHlMwJ/jtLfvIVKwSl887jI0zUq+n+MokZhIz5kSNG+Q7m83cRRj++o
         7S3rzqts7N4yutIkInkFXV9kygWG7yxiMPc0JWryBnFhkU7pGX5375FZhqllLsu46QxD
         yqRXefPbKqpNqDqlvNkmKy9NH53MH/MzNhs5i0t6EGN/qbHwnG3z9w6y+vTpWbbm4ui8
         +Y/emkK8/ZzUeQNXSb3F20EcO2qGGKw0KLfo5yfAg9tQxjLb8ir1PQn5DJpL6n74Uv7I
         Kzy/KgWqFZU9F5z3/y0h3xh8lwac6mtJi6nFuR/ealUBmYZWKM9xgcZKuPtDs3lS0PL6
         E+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149649; x=1779754449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        b=Yv8MM60Av4LLJquXp+OSke5wKbe27Bo1G43Of3yomkXr/Yax3wKVzYp75cF2F2Qlin
         itBSy0jmLpVh5b0QbN2qSgGZr7rzrREg9FKiuD8phqtTL+hOj4K02uA2FYU9ugH3Sr1/
         u+vwwn5as/ORn9lsDdWm5WnI5sk0vncP8DOuER0jWBiOsMg4B1FIjfmrlTiJoGC68tlj
         CdE14dV8oCTBY2QFXgGGa7mGL0a4S19ce4v3DDnZDEewUrhKmqVW+3w3o4bwR5njdPCb
         Efk/jBu0BxcX118ZTmcAYjjDStzkgSdLigwfzpcAsNLT2Yf/7mZH3eo2vLaS0FX75SIX
         3FhA==
X-Forwarded-Encrypted: i=1; AFNElJ9yZSgpz93xeRBS0kh01gIFxGnGcanNv95gugQP0u+f0bMrJF0kb+lq+sQsfYGj2GGt0IZI8lrO1Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nhyFfFEY2CC+K2ZYplZqlycogrYvlgsnG8HvUDgCdq5DSVVB
	uc+VJcG8bU3oQh5vUXZhEjqN//4JxlgzTkboG/rx+WcU0omMoIaKr4b0+0g5VMDKQMuNHAmYEo4
	AhyUK2fwlJdN/54yqf3o0LEu4B5U7aeo=
X-Gm-Gg: Acq92OGtdjydF4RnDiSeYqjUuF7lLNJbFnlOffhnN5Ma1auNSKYe5/Gg39LXrKyWe+E
	CIVIhQ8PXVQ62ofNfmfyWh5hfOzB0seCB6sj4YKS5PFSkjCOp+dJ11Qy64B/nMBFIISHnbHomjG
	JQkwvZUed1knpsyf5e/l+bkhEcyuwW2CXpBKYN05xUlc8TnCCvW4bWB/HnaPCRVB5It1s31QWb6
	sZlDhGm2zpPqpCgTBTk0yubXf9p03oahz+hfomVTtwHqzLy5EdY/gt0LKYAm8gmmC3fsDn2VEJC
	K0iw9yK7v9vuKta3v3+IQguox/4BHZE5W15XoaB8h1ovWSe2TJAHqbfPjc87f9Zuw/XjhOOqtGX
	XKqY=
X-Received: by 2002:a05:622a:d0e:b0:516:707a:cf8 with SMTP id
 d75a77b69052e-516707a0e9amr149948671cf.44.1779149648695; Mon, 18 May 2026
 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
In-Reply-To: <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 18 May 2026 17:13:58 -0700
X-Gm-Features: AVHnY4ICd7H9-70Xucdx9uJAfA9u6BhUaXyRyteuNE6Jo8mNtePRuTvmeSFjqyQ
Message-ID: <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Simon,

Thank you for notifying us of your continued use of the Nios II architectur=
e.

On Mon, May 18, 2026 at 10:24=E2=80=AFAM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
> Unfortunately, as we are an infrastructure provider for civil energy
> infrastructure, the refurbishment cycle is a bit slower than for
> traditional consumer systems. This implies that the traditional LTS
> support duration (max. Dec 2028 as of writing [1]) is rather short, and
> we would be glad if we could keep the architecture in mainline for at
> least 5 years and only then "decay" to LTS.

Your reasoning makes complete sense. However, there is an alternative
to maintaining the architecture in mainline.

The Civil Infrastructure Platform project maintains super-LTS kernels
(and a set of base Debian packages) for 10 years. They are intended to
be used for exactly these kinds of devices.
See here: https://wiki.linuxfoundation.org/civilinfrastructureplatform/star=
t#kernel_maintainership
and here: https://cip-project.org/about/linux-kernel-core-packages

CIP will maintain kernel 6.12 until 2035. Is this long enough for your
lifecycle? What kernel are you currently using? If it's newer than
6.12, we can easily wait until the next CIP SLTS release to remove
Nios II support to avoid a downgrade.

One important thing to note is that the default CIP kernel branches
are not equivalent to standard LTS branches and include new hardware
support, which has a higher likelihood of introducing regressions.
However, the -st branches do not include these changes and follow the
same patch acceptance rules as standard LTS, so they are likely a
better fit for your use case.

Also, CIP focuses on architectures used by CIP members - currently I
think they are x86 (32 and 64-bit), ARM (32 and 64-bit) and RISC-V.
Since Siemens is already a CIP member, you can simply ask them to add
Nios II to the list, and you can assist them with testing and directly
submit patches to them once the standard 6.12 LTS period ends.

I hope this information helps you decide on the best course of action.

Ethan
