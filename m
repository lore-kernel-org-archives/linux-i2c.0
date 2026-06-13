Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A528469B
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363920; cv=none; b=b/zHj1mAWtinal35rU5FXTFbycgeAhZL6rHnGJBsBKIFomUPvSQUntnoKqHC/WzmMZMyAdp0GYGH2RgwMEkwM34nGqe7ZWO44NOyHLmg4YBLL3ggAFnoIeFJsIBsD0JjDIIRQl27irFZzYSyBxbFUcQlR13pZZ6hthDs2H8UZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363920; c=relaxed/simple;
	bh=vBkxLH0mF3zNcxPkS0VH9B+adGOiiuM/jOKLBovIudw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMrvzA9MEnkesKpaG2EhT139RsH3O42Eo3UzW90GlI+5/44RP+pEpTSg8JF/rytCF3OuLAzEW4R1k0nuVeQOEAmiD0lfBFSTykTea7nBN6Hc3JhZFinoxu1HG0jMPugb4c4SV5ueo3WG2qnqafO9/XOKVuxZN/e+sjxbLTJaWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YXHlec00; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YXHlec00"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6914a658115so2429312a12.0
        for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781363917; x=1781968717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8Tv83fZywQzG5lndi3x7cLXcleIo9ocJ2EoiyIwtA0=;
        b=YXHlec00cTma8RtdaBXwADH9r1l9o7MEOsIyBe7TnBqmN7BGMDYdZo3TY19Uxt6EN4
         +/6yVRCY1+9oYzruuetfdrQkF8cWQL2P1y8e27EHY5IoW5IXfBxaWnWf3vWfq+Tj8GDk
         pdvg1XpBdUxuI38PKdm90ZiHZgmkTBgNGCvN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781363917; x=1781968717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Tv83fZywQzG5lndi3x7cLXcleIo9ocJ2EoiyIwtA0=;
        b=Sa28JCk1AWad+WxmpQgdrELTbqS0qaKMue7J7NNcwxC/PV1IlnZT7tzzBUBJKzNMOU
         aQDz7NFtN4McHTPzWg2wNAdWOEN+qDKxX5IRrRH1v3w8qTEjY0tzI4baame29/SkmJ09
         CzZDi7PWotQWO01xl6m+dN/SKymV6MLxNlhWcqWnL7lWheHI3gh4++aL1y07G6n0Mxnd
         utdUxL8nYq9DdB6M3jZDhs/p4EG7dfCTTgCZy05egg8H+oRLpOsbFANYChIyPJpTRUJp
         Vlcss1wej1X+ftR4QLLASqt5r/koIOLLKu9+AxsgxMNiLk3Zs9kdOT52aH/2FfXt4OKf
         2TWw==
X-Gm-Message-State: AOJu0YzMFglH/ljRlQ30TFTPXEuMYQAv1hGTBXMT9Hy7gNjWygnoxkjU
	P3e7feLCVh7sOejIEZxfDZtXsWZMKLiaUXZjmtGITmdx3Gh11ochMe8mNiDUOsb8kRQxjemeeDG
	yfE8+8N8=
X-Gm-Gg: Acq92OE4jkGFSYFftnF2ad/NqnEdzJIaiSlVX/Azse6NP0ADUK4PMmQkqAM9ZTsB3gW
	0tOQRC+v/cwYieN+tkM4Ig7maGN/LLHRzpUa117jTlBVjwooci7Yvgk5QEQfriRC0YgNBaPl4KP
	Izqpvy/HrQnDJeyiXR1O++ItGArfHnnPYSpiImxRxZ6elMtDW9Lad9Zlem6qjZ4xTcdy0eTGX8f
	FfWjYiYv0Pj6SHfXdQfkbyxc+yZz/zCk9WzBxJFdsZvlBn8+QQQPhmRdSMYMmZv/l8poZy/fAxn
	khR5WYc8PzSKAn9EeZhNcKGeAyNrx6boxHRs/hOwbLxwpxfqjYhJyztcylpiGockjcFwx6NAmAt
	E6FoeaWQwvDS5kIBMGB6r7lUN+hi16Ae52oKFiC7PfkrLLKR6Be3zqo/TPoCLrZ34kTvz2yBd13
	mG3kLeM12DyTcaL774HKd3Nnz2z4+FnoN2YPmQ5AxfKnac6oinX+LxIhJHKVe/baoA7Pa6uZJEo
	u+d3iV6U9U=
X-Received: by 2002:a05:6402:3608:b0:691:af8c:7ab5 with SMTP id 4fb4d7f45d1cf-69378a3933emr3113577a12.22.1781363917443;
        Sat, 13 Jun 2026 08:18:37 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919b54asm1592189a12.3.2026.06.13.08.18.36
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 08:18:36 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bebc80100efso198438166b.1
        for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 08:18:36 -0700 (PDT)
X-Received: by 2002:a17:907:961f:b0:bec:e6ae:2f6a with SMTP id
 a640c23a62f3a-bfe2a80fc30mr304227966b.36.1781363916154; Sat, 13 Jun 2026
 08:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ai0phU8FZ9uDcm7M@shikoro>
In-Reply-To: <ai0phU8FZ9uDcm7M@shikoro>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Jun 2026 08:18:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9HZnTngc=Orznied1q1XauR+=1WNoeO7Hdxc9GnKUYw@mail.gmail.com>
X-Gm-Features: AVVi8CdQ8REUJvdNJSEsWsieeNQCPGNz3anMH-zhkXY07kMPxpWlGIYfYegX7Pw
Message-ID: <CAHk-=wj9HZnTngc=Orznied1q1XauR+=1WNoeO7Hdxc9GnKUYw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-7.1-rc8
To: Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jun 2026 at 02:57, Wolfram Sang <wsa@kernel.org> wrote:
>
> biggest news here is that this is my last pull request as I2C maintainer
> after 13.5 years. Starting with the 7.2 cycle, Andi Shyti is taking over
> who helped me greatly maintaining the host drivers for a while now.
> Thank you, Andi, and good luck with the subsystem. I'll be around for
> help, of course.

Pulled. And thanks for all the years of i2c maintenance,

             Linus
