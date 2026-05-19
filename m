Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478540757A
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184184; cv=none; b=aVQRVE0XHXXPiIBc1XqUGfdSscwOksFMW2u1pWdTn0emRdofBtzmWiB+LJO29H1o/z2BAlv/YKhSJDXhjAPOinAcWW0BVBiY66r1D+l6ALZxRlNmzXU0V9EkmKfjhb3yN9LZlc3XDXE6DlcpWcOqgpwUXIiKHDRQpWDCYyZlej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184184; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfC44cB8rlc1ev02/qJba3UlMTOtTUqj2hwimtxo7qIE70jqQyRk1aoO6La0n+lC2O6agtH7l/M8sm7XlrgWUzQnnOnztxEkKnw8fwwOaHM1BwwUQH9u3jIGFwsD4EEffnmbOovM2VNSk/hsIB3u59tsQBq/R6o8Be0yH+4+cQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042905015cso2865446fac.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 02:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184181; x=1779788981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=HXxMJSMJ5F90Q1cLu5UUNV8tm5v6DblRaKRcbknzSihXOhegLIeN9YLflGh4cpdqgV
         YA3/zA315OJitYZpeuxFNoT8WlXa+f6eohOtvxa2rqVQNqyTF0l+4C/G3puR0iSCLolC
         9Y4CFgvAgaVsFNDoIZcENYrceBpmqGr8Vo6khNYSI7J/3Kk9y2oMGrycptEOS+h394YN
         KOm9qSPl6RSny7AGdDnIwSgIm6SiJOj3oRg0VL5H8BLHpMftLNGPENIpg/UXHKICDLRt
         54DQRSiwLFDfs8Fa/S1Zd1n+c/o3UYF3zvRv1J5hXanL3/6+S1bh4lpfn7iS85DAHEqO
         crHg==
X-Forwarded-Encrypted: i=1; AFNElJ+y7KIave4Dj5Sr/Kemj8BozoNfY5EBhBdHwuRrGbj9Xqj19ROSpwBRRCSPAVLQgktWfsoRjngIXfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0rnyhtCMIw2G4S1vyV0+VczGrG0nzk9Gw33uDCZkhUDnVHwT
	ZVz/DoE/OJ79Ri7gO3zMQV5Ozf7onX5N9sYMJgxNH7W8y7t3mMNUqIdD4rpqpgbR
X-Gm-Gg: Acq92OFC4rOQqfbhbt9/vn3yHc4MXLpEFRDy9r0YLhXP/epoBOAk+oT+v0yqCZEbrdp
	SSasAFdj/x3rGt/88PUrijs9hyGNngHloZojQR/8JZs7rBtJ26LXGFLinBPnPKxdRftQhC/ug8o
	7fO6gGs9ZI07DwyNYdiMJDziadWW3PtUweSC4cyIttlG1qaNZKvY/BU9fMjuTaDcMJmkXuMKZoS
	oCc6Eee6UWuz2lKKZ9rvKB8Mfdg6kN3r/wq67N0hWKCiMerqY2uhSY5m8bbvM/wmXsJBQHK3guO
	8xkjrBpAIrTO8rMuoLpcGAJrcjkRs7CIUJ29GUkzLRf33We9BUnCzXVJk8eSxNgsm00NNgHLJ1U
	hfwbjVNjqxl5oD9i5gm8XrkmjWQadqkIdZTMsp/OM7rhLjLSBckY4RlhQzf2Ks/mTmecpYKid16
	giW/RUkax5f2ouyRiW2CFC01N2Ktqsm9wUFQ6oDONRzu9SCnbDNQwXrDQdvvxXVDrXSq14Dpw=
X-Received: by 2002:a05:6871:2ee0:b0:417:3421:13ff with SMTP id 586e51a60fabf-43a2dd89218mr12493478fac.29.1779184181306;
        Tue, 19 May 2026 02:49:41 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a956f4957sm6950624fac.12.2026.05.19.02.49.40
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:49:40 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6841e6a5e51so1567871eaf.3
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 02:49:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8TX0FgbG4x7SM40jk9pmgHlljkxnj9kKc19xAu8iArmlbkb+HsUpvIiVFbhuTuswIo2SrDtb+65WQ=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
