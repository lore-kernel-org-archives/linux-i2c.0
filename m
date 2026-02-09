Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AA37883C
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644430; cv=pass; b=B893HeGqLvSWHq9qzmHOewF75hpmBdQ/+gJTwPHskEL7hU+XpoIe0nlu33nSXRLRr8nQtlxPyMXTz9lyALmRITfZwrmaP6mtXu/09kYIkCYCe/5xUMDxooP57oBfdrZAv9wy+kwLtIohglf2ahWcUH1hEcTxDm4Z9mgEne5cerc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644430; c=relaxed/simple;
	bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msTbUuvUsRFPJfm51erWSKb2lbq23kBMU1ymQF0jobfNFMqOjegbo4d/w+0Jf0kwWw99FNY+CWHUObeO3IzjIEcRymlZIbA1E4syuAm0xNySDKo9wQwiIqxEx0N0HZnCt0p/ipU93J7TAENKByEZQi/dd2Tev2W1mFQntKAzV3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVmlO7/c; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVmlO7/c"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso6603601e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 05:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770644428; cv=none;
        d=google.com; s=arc-20240605;
        b=AJ59SP9BtosYRDv0XQW1VniKy5mO8K5MrNLXjhLfbeGjRPvuWiy+k3uNieysy4YPga
         ea6ONjMXwgKCF96apyhZob0dvO8GH+bD2GZigaew40wLxci58jkyuNZ5e8rA34x+g28+
         1SpdmESofwgZ1r2Jr1iaqbpL3gReDdRoyYzI0ODXND3KJvRyntBDrG43dAe7zSYo+V03
         DzayU7SLTaHyEqabo/Y+YMFgvDqOT/pTrHuedyDSAuJxn/HtuMaEZxBPhlQXdrxxW9bt
         9JfLoFOHB9AbNrTHNxI9OAMN8DlrtqP3NQihi/40SeHQaAt8d4VsbKNPAw3ephVEzEQZ
         ePcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        fh=3cLlehMMscL6/EA+hkZxsr/z8aVEgEBp6dNEWHNBrn8=;
        b=dl1J6jk815QY0L46MQDZHvZa88KufDE8hkh9pM9xOId6o5KxAdnPFl1tW+4XnIT3//
         0d9P/bJry3QsK+04HzA8A9krfyfFxcAUeyMtQWSDSWlj0f6CotIPCYNmywEzOowDfsH0
         KDTYSynnuNwHB9UxyR+TstwK7/1hco70hwTgguoSaSMKJ0ueFJnNPI9/U95ZHELcVLfL
         sEMlNDMEVtxC0v65VPkzmuxHa1kXZJdVUfjBR4Ks3hqxQHjtWKsEjSOlnseTIm4IhGLc
         VI2o71sCMjtO50vdxppRa6n16Go4eCJQSXoPQyzhDcIqCp0B1DzXrwYgc3cLpr4WiPQG
         YPlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770644428; x=1771249228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        b=wVmlO7/c/GSzfyMCmKmhME4wSvfRsH4WQN0e1cbLojozqWPrMW+1uGV7KqY6fW0eFo
         IrVeuXkuC+b/MBsmxDugJsEJNB8vc/nz+dXEeO/aslFTKRxL0o7kj3hTeF56hBYBmTjL
         M85uVHuczS4dmxXE1BHXmNOZUcuTdpbRffmxYfrR6DfwqPcMK0N94JJRIIVSvxhDsaxm
         GbmvS/L692MsMmf3YcRDrWXovROPzHM3eUb0shWa/mTU5qdU5SO2uiNXNavlawKxeZxH
         Nlieu3NSNcIqYYsHMPeA+/LeYbNG1cWq35JoNU6ElSn5tdpxaOimZy/3dRu1pRxeQU+N
         jWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770644428; x=1771249228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        b=sXQD8WD7YghlNPCujORKe6agUdIgStzhhoYcqtX6VfprzKSZMjtjTesFlCp/9JxcDq
         w+5mrpFAIXX72+G7hgz1dQTX6DMv6Kk8CwLuqNvDPslhI0OULjlayfOS7qP9VPZPIA36
         uWaubeOdcwGBbB+HCmNBQbNqYx35bmAkZJ2sxUZ4mIrS9ieRjXp9EAM/LLzVvW3NVgpb
         uJtfUNW2O/cw6ErZ5ElNsI+QxJcjQxEXt2uex7BQDYyKiIhQ5WnYZzESmpCDzfyyUGG3
         eVn9Y87+MhXrKgVeqZFiE3Mt36Udhl2AhCZWzbV2wSR7m2NMfwa7ufCLd65W3rQAKxVw
         XFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXoOZY868KYEGnjJwJqzyB/y6x7exkiGfNiWQFITQ7G3hxryQfgfdbmqn12yuhYaCssqEK49acfds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3E8uooTFbLHGkVE2l8LcewUq6oUH/ByytLOcTqpDjg3uTw3yp
	Gdy++Fr77jGs+w5apPaKuXY9dadiBvMoejLOIIBuZiOsVct3lSdGyO8n3Tn7ejKnA090eix71Mm
	NNKbV6jZwBTwSjh7SOwLu1WfVstoPKy/Brg/R+4FSiw==
X-Gm-Gg: AZuq6aLlJgi9wjDBk4IESLjf/l/cC7BUElD/bHSJeWPcscxQliKbhPZVEwJATJjeSLt
	v10zUUjS4lDppY1jHF7ulawdviipkr63MVA4FjBGNk3q/iUltA5dEVo2Xxb4dCg/FuNhF4uJmUs
	VeUeSJYqYtt6GmegY6yixxeYIlDefmdbcKX8a9dQw0IGvw2uEXOhi4lPojivLbfDBg2uQsWekM9
	HO8IiJSMsL/QOWQWrEz4c/mjcsP6Zih6qIIYZuCUvcar5GLSa2pmqgDD0lP0oUIdHXp82w+SXSc
	nmCX/gPYzbsFd0sEpUAGpQT/OlQ=
X-Received: by 2002:a05:6512:23aa:b0:59e:3fca:fd68 with SMTP id
 2adb3069b0e04-59e45049262mr3618201e87.15.1770644428108; Mon, 09 Feb 2026
 05:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com> <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
In-Reply-To: <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 14:39:52 +0100
X-Gm-Features: AZwV_QiBKZ8ysCcM3dIWhiLTRzG7BAEGejTSAtpE8_Z2Od0YK-CzC2pfzVA8zOY
Message-ID: <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
>
> 2026-02-09 at 10:57, Ulf Hansson wrote:
> > I have already applied for v8 and it's going to be in my pull-request
> > for v7.0 in a few hours.
> >
> > Please send incremental fixes on top instead of a new version of the
> > series, then I can pick them as fixes for v7.0.
>
> Hi!
>
> Sorry for being late with this, but as the mux maintainer I'm not
> fond of
>
> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
>
> and would not like to see it in rc1. Can you prevent that some way?

Sorry, but my pull-request and branch was already prepared.

Please send an incremental patch on top then I can pick it up as a fix
for 7.0-rc1. Unless you want to manage this yourself via your tree.

Kind regards
Uffe
