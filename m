Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EAE3B27F9
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341743; cv=none; b=ET7SEmsNgzvxOtdxV0ymYvGveLBTDfCOJ47o9VY1oQOz01KeHz4dsf7pMKBgThGM1gIRH2DeCweMqZN2qThsoGXVPBcjwHdCMpsqjI+SDgQVtKbUhchCAr8FxGnnID90dlAZ60o6oeiOkVfUp5RYoBflSXrGCZsmssnfXbsgj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341743; c=relaxed/simple;
	bh=rZiQSaURDYO17/6WGoNt/MVWZsEN5ahkC1vFIHK/U1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJbYQErgJ9D3n8wl7qBD3NMgA2AMm7txEkqSuraF45f8HfjWcvQtPT5TCH0bxF9XBKwaj4+1XFY9Tc4D49FXjJsaJNzESsVtWE/7rVsBeshE+sK03DM6wK2AqiueL3mbnpb/LXs5FzzDCSQkLh4GLY3uSZ612Bqeo8QD/AHefZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmkaP2JP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmkaP2JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4891F00A3D
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 22:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782341741;
	bh=rZiQSaURDYO17/6WGoNt/MVWZsEN5ahkC1vFIHK/U1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TmkaP2JPQfksOxtmYTQbeS/nAngITe1/7m/+4k5iMJPGYM3eCSKbX2EoX8xm8hTHZ
	 vmMIPFr/mYv7e7Kh2B4lkJIMh8OGaCn28DKah5fnaM26hkZ0CfyLmqsq+uzRrrk1ir
	 0Aztjei+ZaT5X5YzpOiHI7aNcdGd2uExUVi2Ml8IXw6wlIW7MLx1St+m6BiMweNN4J
	 9tixfv9DW9lK5Kmpbs4LaXzIGotI13N5HXHjXHSVbThbmh8+1EmMhdmcMJcBTbyMPn
	 1f5g9f4/NObzpE/YAJ0Z2dsoVxTMwGVR25DeFZUHwsm3sfI4DVpfe/Li/DKWkN1nPa
	 b8JT9Hgtp1nLw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so1837812e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 15:55:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoABjOcAwMhAimZeeewv/9c180z4dJp7rwqJSMv6MBxP3R/xQBWh0ZMr/pao9LOqsg4vwMZUiVsBS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NUh0OYzdihl75OhLOHuk8w74oAC5M96T3qtFhgDxZPylblX/
	xkFgof3oYCH1HcTW9x0UcjSMwSBvYZtJJSSi1vZjOGz2NgRfYLCFl3LaLEJJwQ9w5vQ74gptCJC
	tuqJIno6wNE/EOIkyq0pUmfiNXTIpj7Y=
X-Received: by 2002:a05:6512:8041:b0:5ad:5a14:4c1b with SMTP id
 2adb3069b0e04-5aea1f645b0mr6767e87.36.1782341740475; Wed, 24 Jun 2026
 15:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com> <20260623-i2c-fault-reporting-v1-6-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-6-6db1a8aabf18@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 25 Jun 2026 00:55:28 +0200
X-Gmail-Original-Message-ID: <CAD++jLm+dHRNqS3HNL3+p7NGB2_bxncFPMEQVAOG-ZRZqQH7hQ@mail.gmail.com>
X-Gm-Features: AVVi8Cerkddbq6mFwZBM5M7tjoj4rE4OxpQJFijXkFL3Z8iwOxVsKKaRtrxxd9E
Message-ID: <CAD++jLm+dHRNqS3HNL3+p7NGB2_bxncFPMEQVAOG-ZRZqQH7hQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:32=E2=80=AFPM Dmitry Guzman
<Dmitry.Guzman@mobileye.com> wrote:

> In Nomadik I2c controller, register I2C_MCR has 11-bit wide LENGTH
> field. Its maximum value is 2047, so this is the maximum length of a
> single message. It is less than the common maximum I2C message length in
> I2C subsystem (8192), so define a quirk in order to report the
> unsupported message without any attempt to transfer it.
>
> Zero length reading doesn't work properly on this controller, so add
> `I2C_AQ_NO_ZERO_LEN_READ` quirk flag.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Excellent improvements, almost a Fixes: patch.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
