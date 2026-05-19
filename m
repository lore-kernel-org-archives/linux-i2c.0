Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70393480DE6
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188883; cv=pass; b=VfZwAZea6M4N8lEm+OB5seqspq63I1gmdKh/oliE9+gKRnFCQ1RiLsiDsr8MZ+Ti542NBQ8dRluc505p+7dtfcuO2EADrW22unltowg+j5SSVU82xB82D0aJK2+RwtN6kK8X7RAD34G2vHR3sslFZjq8Otjd1qa8eZt+Gv27SiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188883; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n++nOzoGyz+X77yBHlW8Ed338LnseXCMAaKHIDD3Ar2Rf/kDWCxGP15hVx78K/3ILEGm13LNC8nGXJGyOyoDcvLwC50rZf7KR8v+UitmbJxadxArYcuNtspn5KSc0QE3Q99H7I2mhiMtvwWHEvr/CBjIY9N+0SVhsKLor/U2qm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f24905306dso284652eec.2
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=FESUdPvSDSyeNosnFUPZKXAgKkw4gIdF6JwM7SWP0xQnkLRrc1n/1Guje4CqyJ4y3f
         Ac6EN1ZVDTcvQ5tKHAD566YJPMl+Ftf+WlgKNrDPvtngnKgpIXuq88EBYn2LJYEm2v+N
         TUfnHc5AGi8VzmZTWbqCJRPyd2hHb8OoHLFN7yI2IXtyJq4cQxCpI20UyeF/3exZ72If
         A2qLajanXwMijLmBwREchxucUQrm0KL/r74F7CjULW2VJYnncAP2vXOOwgdcSXzzPDKo
         i1IoMkdBWZ0LUcfMtHT5S7aXgNWh0xM11LD7O7DTHDNYBQEb4c3iJT44nkjgSceAQNm8
         sVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=o5OJkic6Dal8yrdliWXyiQBnIDysZiAvZHKnnVfl9tg=;
        b=X1GPtfp9ASxGheUDrqe7ybPaO0NWeR6m1Hd25J3C7+rfLEuDnquqSVxaGSre/9Vu4Y
         bupVYcijXqmy+WqYJsuu7ns2+wlIR0WpUMZ27cFN7FXBQbxXaGJORVBsHvbpuf/4uTOO
         meJGda1hX6XZ6vzo7oM99XAfKzL1JvPoonTyxLCCRycVnvSyKywvIarpujATsd6uip8O
         YR7bCVlZS3tq05HtDBEfTPLVFFgT73veOpajshV9a4zgvz6zCdlCt731HydxOB0FmFnJ
         wZBXAGbJ/bZEvXxzqWM5JL2gUIK9kpYXx7XP5jWIbf5WwpfR9PQ293Jpas6gIMUCKe16
         tRPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=nED3LvDHTyDK1EMm2tQHBbEeZAZ3eL1LYGk0PpsR+TTHLLP9L9HpRZuABpMEPA6DgI
         0c6fy7GFka9teZ4a4HU/tCrFTmW9zOssvBpw+xoZW5GLzFq+FaCqdRIWnVdLf9Qqb1VV
         QyXZfj6FziL+O1jCWRDu0thseyBDASGyh9q+UfGSz4kk5umKQff5gILIcUbQP44XqQta
         10bJvx/3efk8oUpleHSCXBa2pleZ5flq6a3DiI5u/90//YEu5emgzydoYEM9RQ740pg9
         l0Hw4pNsH9YPKzRQzNK9iLqCmEPRDwjhZA8USRC6MBkFg7IsltFWZIqMFCRx/n0MZGPb
         wRyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HjRweQXQ9Z3uXrnZNCd5AhvImukbV45VcqmBLeHix6/t+m3fy/0hJ/ORlQ1YqpO7NT+swgSd5KR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeayuW3o0rNZZ7eAhRfB603/jWatDKFBi0Eppj7O/at/DPmOfx
	ZRR7zjoGgUVbqfA7XiZLhCOOYcrukk8AmhezhOnENligr5KlahmBrt84xhsIm0ypHw8FlLWcbTc
	oxaB7FPirAZx539Tzkwzp3bbasL9ZNHE=
X-Gm-Gg: Acq92OECRtZ7l6ZXpE2QA6RVkXFVVhlpAGQLOLpQiyWD5Zh6Qi2HWqaV5fDH46CYkEW
	uLQbfXOrkMnidnHUAAndVmsL67ootx+3VSJW09XmNvXMdJGT7JkYa6K38K5swZDIxEHHgyXOdT9
	zjSUAi9uPt1jTy3q/xkI6pNHzryecEpXrhsT4SzenuNn+kwQnUEGOqqH4KA19lMuhW8yF+RUmuu
	avYAWhd0r9Kfux1lYn8RkXMoQrOX0XiWczUtNETmtzANDgfH/b+E+zV/uACRCBtKYfxAOLjI/3k
	FMOdQeBgk5vHuzEMSEKfwJJnj4bNY2yrWpCuhWZXUSJWKoTaXZ795O9j73TRSkLWYmKJpgQQxAy
	Lq7jzDW1rnFcWM6CJ+8R4oio=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
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

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel
