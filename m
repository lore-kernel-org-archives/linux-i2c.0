Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034973;
	b=GWz1vkt6L7VQLNvRIzmnI4XCvioD8PUEgXgSAgBSEr2WaaUvkQlWJnbjZxqq6288c26X
	 hVcmm/RcsfcHtD2T/NWylLz2yX3GLFme6RjDp5FHFux1T6qqpueay2p4ZZrqaXdhAjmAb
	 9wVx6DLcb3H7ngNyFMFniU5u0ppkh67hMgTgg0qCp2WEtmjT7X7tIjMbIH8G41O4b3YFc
	 xAzl3963ssIiiT8FUbSj4WQL8ZnooArxmML+8ll++LDHr1eh0B+X1KVfxItozDobSsyys
	 xNGs75E6+khcgQd4gE4PQbDJY4vYYI25Uef8d7rOENVcLiO7DkaAvujydB2dTfcuyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=y/T7eHMAoSP0rr4UWWXbf1cJ8XwTfHjYASx0lqrxNZw=;
	b=P0qGbbnU1BHlhrlvm7z7JvRc5uQyJfBp9sYh5CaxiEyTYhboZotRWt55qiDL1j6nJWfx
	 Vw8OHV+h4gJxCvuz2+8mhBCK1tH7wmg11HvXPZ4ImwS31d0ACa22Qk8aBDsSnmfrVUe+f
	 3OyG0M703TLmLVyINcQ2vL4gt6RowBVhIWAJD0X0tAXt2eaZE+M51BqHoTrj7GN+HhLDH
	 4/0K/erYMEALwihS1C7i6k+JKeZsmiF9hA2nuKn4Z29tp608Ut8Se/BsPUwXwUoxVUU7n
	 seX5Khxi0IUmPYTEj0qNmfP0eY8FkFyVBtYFGyrcUDm4a7JzZasuunYr5sZ8e9quw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RAajzsxU;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420B606A31A
	for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 17:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5420B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RAajzsxU
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so4753387a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793034970; x=1793639770; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/T7eHMAoSP0rr4UWWXbf1cJ8XwTfHjYASx0lqrxNZw=;
        b=RAajzsxUJ2sFczKNO+26d4DYz10EjLEvi+AmU8k4uMu3opkOZ7SEWtttcqiWzvM8fl
         ToCVE+dOd36KM4WKHUwLVJONsIgV6QWRfsgJKpo4QLmgatyap4aJRT9bIoK5TdGRmQ25
         LDLojEWqCFVLE7WflkmlEinSH4pL9YUVgyAoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793034970; x=1793639770;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y/T7eHMAoSP0rr4UWWXbf1cJ8XwTfHjYASx0lqrxNZw=;
        b=Xh6zSjs33Zb7406Qy5l4/c6/kfT7iCwdK+UF8J4IVkk5r9M3T1Gg7H/vit7+iLpkbn
         4Nw3gtBVfAYe9Z+VieXKcupt4qc1+d8KP6oHKg5/TKcTYSklIAS8y4DwFOoUY5Tf7qZb
         52sokAC6pOpnTuEv8GGxt/jjdCZUKR8xkS/NvKINY0en0HB6eAfE+1NEQu0ahUO0BnKa
         w1qgCbGOArP6OMWYS8g82OU2ftBdbXKKxntOOxFZpXA0bfDOO7Ug8zWFgYiFdSVbuzE1
         6Vl+sJPglnHKhNrIK/CEuKf4wFyLqr6+W9eby3g71xAisop5Py5OMcV5srdgvpzQUoO5
         BVHg==
X-Forwarded-Encrypted: i=1; AKwUvBytiPjPg7PivwAWrduRQf0NWNhI2UMwx0iKGf3kXgdk34rfLVsnB4umeqIoxj1mC8Xh13elluLu7Ao=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqaDmlXtQ2yL5zDieHEm5do3RDYjCElQeah0Sci131Y/e0epg7
	OLO0zigMs+TUdAtsvzrsyrSxt5YbP1TC23jTL7raCc54YvqDs4NEY0ILnscBFwEYTKTJAEmRm9l
	tYjIrbl0=
X-Gm-Gg: AYBFou0Ho+2xIaIE9oQvXAc0xQi3AtTNUyvqxJNZac2sN/de1wf/Xwd+b+r1ongbKFs
	LHVW75xLwuuUMFxAEZxeXvglSwCTvMyhCtea/wBuhhG+x7JA//vssMCZxNexj5a+797E7glTjo8
	oS9Kvh7eEbPD7lGYu2zIvJYUVuLKdQay2zAF7nJdWaFb8g2QEUQE3THdffUEc+DMr1FvQAGEvBz
	C4WxGMBynQzqmJiNQa8y02MjPJukQco0WN9E8PpI76ohazD+zK2cNvefwQJmCTopd+W6LnU1ZSQ
	HaAC1LmZTUjK+QBYZlzPK+t3p8PObwZP/koKWrgYCznniY4Mj/qKVcGyOZeKzqxeb870WxBG+G6
	zedrQW3BXYRbbDl6sH6t2i7dJv4rtfKP5r9rwe05gxbEZMywAPjXN2SYCA0JqB1/8+GgKQ+2q7x
	wVCX1A8XR/5lltNEJuRu80MOdQ2tYKW/iFL+uFMDhnc3j+U4pKBgrTnqt92qzpWtinvNuYPrhWl
	ocFU4b8Z+/ZBgWmPmHPMwoJtdXeiPLU0csGfeIhbvrVedlm7+srtBshR7N0wWCgA6yLZf7oqaE/
	zBp6bHzJwgDeBJBApmbt2YN3ydxfzw==
X-Received: by 2002:aa7:db4d:0:b0:6b3:c382:364a with SMTP id 4fb4d7f45d1cf-6b442ff307cmr5783518a12.35.1793034970439;
        Mon, 26 Oct 2026 10:16:10 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595d7c8sm3899645a12.8.2026.10.26.10.16.09
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:16:09 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso4849466a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 10:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzvmz8vICcmdNuaQWFL6u+e23VIwltSKtgzUg2s0/DUKrUBXzKRT6deKEazwpF51gufui/+phgwq4c=@vger.kernel.org
X-Received: by 2002:a17:907:96a1:b0:c46:75e7:25af with SMTP id
 a640c23a62f3a-c46bdd6feb2mr883057666b.11.1793034969326; Mon, 26 Oct 2026
 10:16:09 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <at5i65e5wjMz2TCA@zenone.zhora.eu>
In-Reply-To: <at5i65e5wjMz2TCA@zenone.zhora.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Oct 2026 07:15:52 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiMOMfksBhvDa+huuNCAu_EfpxzLiSawNxdady0r=zFEg@mail.gmail.com>
X-Gm-Features: AclHuK9Y_0fn4SgEGbZUWloU7JZaAjwIq8dkffK0lllMB-Mf8oR2BLWFRRI-aLg
Message-ID: <CAHk-=wiMOMfksBhvDa+huuNCAu_EfpxzLiSawNxdady0r=zFEg@mail.gmail.com>
Subject: Re: [GIT PULL] i2c for v7.4, part 2
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Oct 2026 at 10:20, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> I'll now start queuing patches for a possible third week of the
> merge window. Otherwise, they will go into v7.5.

NO!

I've taken this.

But the whole "merge window is for new development" needs to stop. I
will *NOT* be taking any more patches from you that aren't fixes.

The merge window is for merging stuff that is ready BEFORE THE MERGE
WINDOW STARTED.

It's absolutely not for "let's add more to the pile". Never has been,
and never will be.

The merge window is two weeks NOT as a way to give maintainers two
weeks (and no, it won't be three weeks this time, I've been keeping
up) to create new stuff. It's so that the stuff that *was* ready
before the merge window can be merged in a sane and controlled manner.

So no. No more of this "I'll have a second - or third - pile of
stuff". If it wasn't ready before, then it wasn't ready, and it goes
into the *next* merge window.

                  Linus
