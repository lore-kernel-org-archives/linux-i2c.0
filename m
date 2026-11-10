Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297823;
	b=Bil8s0/ypKwEWzVsz5JsVaaGNv3ev0XFhSS843+CSZPZ+KGDiYlPrpDndyZnyUm1ywmY
	 /6vPQVtRZfIKgtvgWqp4BIZPJ5ll6pPdqJ37xfIOryqnUAJO+XOeA1j78oL4bJAzcgznn
	 Oaed6yl2PczZz48jvKIvhSAmY9BiH0tLAEFdZ1IjHJieOvjDrHlPAtfwFHwhp2xa/WmkT
	 9hz9FysB8y1GB77oqTCBZsl8+w9eqTueuXtLj5bdNirb1UgdSBIsEjeVwWYNtzSKkK85b
	 NLgahlsF+crBfCSqBYFSYQMiGvbtjMhrJv7EgisIOQs66XqNFaKtohjwUYf0pLVMK6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297823;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Bh9PLp3fsMYJMJTRrDf+gKXw1r5bvWitb4XoPWpFjfU=;
	b=WD0Yb/rC40znwmwz1XVoD542x47S8CjiTyLmNYX/grvDdeuQpHzPheeptxNlZFvPOASX
	 7IgVw7EXWJ67uE79n6tU+7Jc72mAG/uGgkPZhiZDh1Ct4I4vvq7EAZlW3sB0SE59+OpsT
	 s8SKb2p/P7YipFpPt/Dl0DoDFdFCMwC4w6TZk0+qCIwW4tbUXEYRUHDJLJxvSTl0cThLx
	 5Yw34Eee3igUTlpcK8Lu8Sz/kLT79FEv/3HEB/6hi8Ns3fIAGqWamjt3/bv12hnz5hDlC
	 wTXljFFnFmj7VGg5ZVWAL80bIGygHU/XpZKcUrDBvnsMShpVNgiicklUfecVMvFq3Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED60606A724
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 08:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED60606A724
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b2f59de176so1275797b3a.2
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 00:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297823; x=1794902623;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bh9PLp3fsMYJMJTRrDf+gKXw1r5bvWitb4XoPWpFjfU=;
        b=v3wSfddbvAWHBGbiiz4SxI2NaILW8AX/wImVjfXH8KCyu5TVn6i8Saap1Bp+ow60yG
         M0lrwSUP1f0q9B2txtX2KMRUkmWI9Se8IFT4fEhm2ufD+I17Ak+ezHK5io5rla5kMw+U
         CNJlj42Bcxb9c8D817tNpLVwVq1emgq2bCHbq844n2kLrCvXe74Fy7BDfD7vNVJ3NE+y
         SCMNA6tukqOC1jULFeTh25Y/JE9BVZdCOwet7oNZqsHRe2MUEZJadys2eEvCKGRxdoeV
         /sGLSAnYT+2CioX0Ci75uEm1Wj0DjWlkR4h67REaQQyjn2S5NUBO0KrCiDYrqgUNcqZn
         d41g==
X-Forwarded-Encrypted: i=1; AL+hErGE/6UWjSbBbcQR42muueFNBTpEWwBDHdfAFgGoUzntvSnu88sFlLpAumO2xv0DWfmWIWzKRldqGf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NrVicJAQbPwiHwCNx6noKcpwQbNSYDMAHt4+CTwkvRT/V4sdq
	Y2+U6UaTU9yU4Jt9gE4Iv5uUbEtwo7Onqja7YSTljfvZTXlyt9bd+A0FryQZahRol08=
X-Gm-Gg: AYBFou2YypEqYLMErJbd1kP4b8oyt9R4cM/e0F2i0IZ3ALhHhcLEdpALeDgIJf3Cu6D
	biKJSxFv6nj/igDha7tdP0BbN/65anKKvllxWo1yoz2QsKG8jCk18sSHioHImVKzKnvvc2ep1/l
	KXgJCeF0zY9qxX1UH1d7xOinewRJtcFcfSOYyVClyJdHoWUOHayqG0foCF/U9332q3kyPib2+Gf
	/xDEeaA32LhOEhcJkXlK+A81+hTF3hJmF3fAHwZhDUfHIVfapIiTd90SQGq1DYCHWf1RL0fvIvd
	zjh5CKKzIUKYaFIMSB5oual9aiQlvevlEnDr/HLw4XS/1kvTta+3iTCFCQkTX+49OhwNEbUSbnI
	oW/QYbRj2w1nmC3ut7XdzWLeq7xdo4Vmwoa91Cv/zdvjpSl67f0jBnsrEbNjjW0PwjayPEPzaG+
	c5R4fKHDIZdOxX7MJ8AaEVNvkoYNrM0rLLQ7w6ert+AIYGPptd5khgxcKmkbtZ7UoAejN+rcN1L
	Pp4efyrAj7GYTAq2xkXmyKfvw3HBmcLv38ghZWQPfM0E9iZJYzLCOm2qvz9/jJyUtOcIVJnNZ5q
	b2bBrUlFVJfyVxcEMvYSjiRbep8fpI2QiSaNp6RbnH4f1AH1Wj+trfvRFDk95gPNVg==
X-Received: by 2002:a05:6a21:3b46:b0:3e2:a849:64bc with SMTP id adf61e73a8af0-3f18c1166aemr1436718637.9.1794297822604;
        Tue, 10 Nov 2026 00:03:42 -0800 (PST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e582sm573283b3a.39.2026.11.10.00.03.42
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 00:03:42 -0800 (PST)
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1931ff67a29so840788c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 00:03:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEnDd7TwMXMnIJ1l8ytpufdmzyLr5gxi0snuHRBNraGBZfMdoTBOtkdZIDQBdaVp8zNMYiFYbxqSMs=@vger.kernel.org
X-Received: by 2002:a05:6102:4190:b0:7c3:2b19:6266 with SMTP id
 ada2fe7eead31-7d301bfd9b1mr443049137.22.1794297471476; Mon, 09 Nov 2026
 23:57:51 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
 <20261109-i2c-remove-dont-use-autosuspend-v1-4-49a08b8daf36@kernel.org>
In-Reply-To: <20261109-i2c-remove-dont-use-autosuspend-v1-4-49a08b8daf36@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Nov 2026 08:57:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-2XT7Npksv2om+ZRxOAQJfc92VpLD4sPeoj8AgKUU=w@mail.gmail.com>
X-Gm-Features: AclHuK9JsEgh5r73zJDHAyGi1UgY8FApv7iweIjEvmBZD0LvfpJpCmquM1eWYd8
Message-ID: <CAMuHMdV-2XT7Npksv2om+ZRxOAQJfc92VpLD4sPeoj8AgKUU=w@mail.gmail.com>
Subject: Re: [PATCH 4/6] i2c: riic: remove redundant pm_runtime_dont_use_autosuspend()
 calls
To: Joshua Crofts <crofts@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Chris Brandt <chris.brandt@renesas.com>, 
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 21:51, Joshua Crofts <crofts@kernel.org> wrote:
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
>
> Remove the redundant function calls.
>
> Signed-off-by: Joshua Crofts <crofts@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
