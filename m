Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794205378;
	b=ioYlCMczv1EVgjYkv64muDh4byHHRH+fZWA2fmsjzwPA66g3Sm647bEJPukQ87m5zArp
	 yiW0ydMWKMEL8RS4+UWtlbYMHmD8CClUTZ7db5XdTtdZvP0RUt/qO7FyJv1ORVGMu5Iiy
	 zf24l6Ke7Gmatz3TMP4m18t20L17rk/iFBdbLLpbbuNnVLf5q7Qu5z1jD3/PBa5O0l/tE
	 k1kSmeQIubkCVuQm0rTPGkyOlvJGOoGdXmG8c+L+1O/4gUqMEoI8go2Puh52kT+RhxhTM
	 wU3MqN6brg3bJP2U98trmWckYpt9CGDgysHfRbRJAhN4tuzVJyDWNdQK/bn4L7h8N0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=URMNcpQ5qqNQl+Xi1BHmKsQnDnwFJRQJWZlQPG3sB+E=;
	b=L6FZmFIr4vXtyDfKYIWunvab10sHedfIKKHU2+lykCI+JcxljIa3VqBLFH42QUxRU8V9
	 jazR55l7aZvGwgt/oF1N3vl1yGrxMnNYPxdXCI5DNdN7dWHwV4y1Q8vMjuAAnmoHaLmJF
	 mxPvubYZB7Gw8GJJA1TP1qQdAQ7ASRFnxMfzfSBXgBdYgEI0rWt4jp4TTk4x2btMIsIx7
	 ILHRbeTv0wuHZycF02m6kTUtl3pow07zTyQZjYcWfpPhwCmQCurU0MKA3CcKUQh7lKU34
	 VW9c4NoMNiELUYMN2ea1w6LJnaEsulmPZ5gX7br4sjgHeMeOvor2djkms278uzr6oLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxmlE8U3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB43606A31C
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 06:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB43606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxmlE8U3
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679965fb848so555661d50.1
        for <linux-i2c@vger.kernel.org>; Sun, 08 Nov 2026 22:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794205377; cv=none;
        d=google.com; s=arc-20260327;
        b=D2VV3mk4AuLrAHXtvKOIf5ju8VNM62gkrg2CeQnZbuFLLzRwAVv6CLX6boeXgtHLdD
         3NXDOCLezeMneAevRRj7GvNB5jiXgScmtHAOveQ5kjQ6uyGfKskC6Mdh/V8Kf2Ge7lLJ
         leyE+8GMjS35NOpTyEL/CqJ9SiLWwlaCB9u6c7rVfM8hXko+gmXYO9DJBLyf2z4ICw5v
         3oO3PTKh5tQH44u3cBr5L57DPkfKeQCVDmME7Br4qZZLDhOXlm7U8/aXLs4SCkYbcDW1
         Rsh3v8X8ftoz1zTlCKPqTB6X6k6fzflywTk+iZcqPdUzfZjOqDILe/AsDMS4gSPaAwnv
         x3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=URMNcpQ5qqNQl+Xi1BHmKsQnDnwFJRQJWZlQPG3sB+E=;
        fh=TbZ7mui+6I2MfsjVbYC9OuXUcqh7CzhxVxpPOrIP3TE=;
        b=FyTrwG2toCaD7mobw/NSQZBVTamHSK+ZprPr6ZDYun6C7HzomG63jFNNxGUnb2EKdR
         b/68a8VvZcJONQsmIxmFucPvFctXgeVOnLx5MMCGwqhBFRNZ31bto5+9k4/3XDwyELfj
         2WuP/0dQvd1zsqa03ZhD5Jou7ttm1Gf68YppAyAvq1ThhX+HMktskM7tq4bi/e9bljy5
         yhMuM1ylOH1RFfux8GZw2JYq3dIeeOaz02hl7jEIKpOvJmxRe6A8vnRLPrXbjsjA7pyZ
         NEMSzJ9nwF4ahxfo3GrLu4j7gnNiGspAkbbUx9UCf6GumpOHxuvDfi8BNmKafq+DAVS/
         ndbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794205377; x=1794810177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=URMNcpQ5qqNQl+Xi1BHmKsQnDnwFJRQJWZlQPG3sB+E=;
        b=oxmlE8U3d5SFm+VZiQuPeXsEoGdZIYMlTYvkA/I5/luvTx76xQU26zDe122m0NAZAv
         nb6mWBpfzgo6GYKcS0xe+1quZEEJLleeX3jknhyPVA2f4040l9LAoNAjEo/cVojhXhSV
         kVsFJPZUlT458kmAqyvL7quZmBfpHJBm8Zc2/WNIv71VrFvrgESiSMD9rDKyA4N7MIxl
         PBNxc4FOQrIwa3y+YP/dYuPzKNz8ycAX+EFQujD52srcMBrlR6WenLRwaJqQmkrd4wzD
         JJRKCAtFz/tU1ZypxJy5XRMTNqpFQhivgUhNYpNvedOqWk+HhgjpqWd5d9bmCf1qg2yQ
         jMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794205377; x=1794810177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=URMNcpQ5qqNQl+Xi1BHmKsQnDnwFJRQJWZlQPG3sB+E=;
        b=dMgWAhI6r5Wy226x72tWzv6j2NrartWQHUTBdqe8S7jJPLc9kQktzO0dznYFGD0IsX
         c1FOjpYZTYPOtzzCeHGThGy3GH5upTpZSj6CcTWXjvyERBLGMtWGA58p0U8YH2jcwFoX
         C+TXY/WQn8V+RtZt2+X6xCLy2Nz2vKvJ1w9V9z7CGUBwXKxEsxBuf4FfnYxje4KgAq/7
         HAvDxin5uTkEpoTnvPyJKTqu0b/NOEOsttBi5zGq2g+ArJY5Ub4EglDk3i/tMh/Q4mHr
         4oKu206t6ZkyB9bhb8B29yUEfUr454Tv5ydUYBrTx/RjO8WENC/4cXRn79J4mH1aDPnH
         xyQQ==
X-Forwarded-Encrypted: i=1; AL+hErHTT8p7RxqCavhJxVkpxH3nlrFkF5M6FdWAhp79fjyk//Itj+Pp8pKfV/iW8DC2tAtUrLok6Q4CRyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Qn1ltA6KafYFMSQUVqnb2HZ+P2vDEQBwkrwxNdDY3SfkT7y5I
	oQeBKR+dvoBvp1D2TLrP/eabYoM6jQprMp5sf60NGhdAT3/k3JSG+a7tLKrCMvzCLY27meus3fT
	0ClO89a8IQkqLglXhzI+EvHxl2Nx8fu0=
X-Gm-Gg: AYBFou37mFZfSad/luC/QRdLsy6yYHa/M8qMdG3AiDPXjoGFCWex33w6Y3tdeOcDDai
	OvT7GqIE8D5ZwS4qqhwwGwGiwpW4rtWE72DfywcHcsV6n1UR9SNRm5GDcFX7C7Z32b2xPlv5pdv
	PTTIHnYx2yvG5fD2z+MUeSg+xf2DmzHYa0V4dqJMC0rsaoBcApG3Jv9h8maf5FC9vQca5tGS11I
	uCNdCgAt50sUpR+SYyIacyds6dR1/gZrQr1R/72eYKrv8vNq0GfCNAxGaFzkDwp44Kcu36/56ww
	BT59zkQnAqafQyHboJsaA3vBEYQAucG7TPdAzo6BNQn+QFx1wuvChD4nAGR060M0nAgXziqScxH
	A95ESoZJPxU/y5RC6Fw/EjDysghvQnVfejivl
X-Received: by 2002:a05:690e:43c3:b0:67c:1fba:b465 with SMTP id
 956f58d0204a3-67c3d9fbc68mr1052892d50.48.1794205377206; Sun, 08 Nov 2026
 22:22:57 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
In-Reply-To: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 9 Nov 2026 11:52:44 +0530
X-Gm-Features: AclHuK_068F5Wc70oWZbpd7SA1pDUlq5xu7WG9r41_d4oinb86Mlf6cH4ArzQug
Message-ID: <CAKfKVtH_SRTSyZnouwz3MEbGrtinbJLN=y7NzuX_mV4+MgKoRQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] i2c: i2c-xiic: fix clearing of bnb irq and
 waiting/ clearing while atomic
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: michal.simek@amd.com, andi.shyti@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:08=E2=80=AFPM Thilo Zirnstein <thi.zirnstein@gmail=
.com> wrote:
>
> Dear all,
>
> This patch-series fixes the clearing routine for the bus not busy (bnb) i=
rq
> plus the waiting and clearing routines while in atomic context.
>
> The bnb is used to indicate that the current transfer is done.
> A high level view of the software flow for tx:
>
> * init i2c controller
> * prepare all registers ( fill fifo, enable irqs, ... )
> * start i2c txfer
> * clear and enable bnb
> * wait for completion
> * ( serve interrupts )
> * ( bnb interrupt ): complete completion
>
> The datasheet ( pg090-axi-iic, Interrupt-Status-Register ISR)
> states that the bnb bit can only be cleared if
> the bus busy bit in the status register is set.
> So the iic controller must have recognized that their is some activity
> on the bus. ( Start condition )
>
> Currently the bnb bit is cleared without checking or waiting for this
> condition. This can lead to spurious bnb interrupts.
>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

>
