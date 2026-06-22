Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A93655DD
	for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124740; cv=none; b=WadFBNQUOCqQ6DcIcsTdzw7BHw3iM8FWKee8bvFKQTNuPZWKv8+x2Pefm1BJVzN9IzbJkcg1t6GnGNW77XZzCW/mu5mBAbArAVQ0Z1rTSL/FbpalKIMrPHx2W7MNMohUII6NXyWAm/jsqLOnPWApKFV/nkNMEFCkH5aS+xGr5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124740; c=relaxed/simple;
	bh=CTQXMUV+/UBVnNjzgtkJO88wjy6FOPIwK3y5DrpmBBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSil0GtI1sTqqmVloE4lRzWI8vEewvCHzbHY5rQCe4Bx9gLYe5Kop+XcxYHT349LA5z2dA5XMy+GA/9lJxesCdEdwjh5frxi67uAJSOL/adLbv2euTXIhYxFyj5AteFP+A2AlMJ9u2pmGvCh03QagI29mAOnhxDDj/sSQGCJ9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c69921bd15so17405425ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 03:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124738; x=1782729538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sEwup8vrGtzg0eQ+zIA6Kd2oTy+XBY9jxS2BNcFzC0=;
        b=mL8su4j/uos25mXVIOogPhiSf4kuDYYqordVPLIQkA1NsndeE041j+hpJRS6gAuRhE
         2GZJQ2dzl3zFCNdblbJjNGS6vb7xugWUiYHJK0okfKS5siybugm2TLAOtglisY3fWrPu
         mTeXnd1rKMSnzH4sqRzRz5sg78tlxg6Ugt1+/YydYxHaCwHbkj78BItFIPOynLuV84yL
         ij//os9TF4pdS3tLH6byvJ+DseuHfcO893b+1SzjZjddpU/4vVpiOuu0NCwdApKVNRO+
         /XNRu7YE64q3Td3uNILTckw/cG+Iqgl3YPcKY3bTDb5aR+ESr6u+PUNiqi/kAwNiQ5Yd
         Xz6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpse/0T8ChtgoiqPdLx8BfXrrY4nk3JEjOVhKmaYhiZERSZbQ9Pm02tJ18/9qdPVL2ANHr+niEorvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPepi3wgHWSNGpVl+vuELl1IbwNQTWcjpyWz+MP1otKXOvs8Am
	pAwRz0r6YZLi27w7p82B6vsL95CLtDAhD/G+zP7P0wKeCuNizCH08LE39dEO+ly1
X-Gm-Gg: AfdE7cmhs0x9uGNIZp8yJTsoC4QEU0OywcX5Tk21JxrhbFec+yRZOztkqg5IGOskW7e
	4x0o4UgBkgIf19FxhL8zn8B0ihR5pFWNbIjhkIhdyPQH8UNRoYX99tZRTPXdJX2+eSUVDRiuDkR
	EcEObfuehf7oK/DqH7ESfg0KrkSyzRUlAH6VfxZnpgL3vanKij870ttACQ51eRph0tJf4gR+85Q
	fSS5ZkMnBkNMZeRzwlJho4vVeComubO401a0QKTjZ6qYgBTe6CsYuDNZ/Q8/wwR0HDvmPoNE3DY
	dP0HssKGLCsr8osUVjC9zJl3M0r/ygpvzDq4mgTEmz24JKNQFQkN/t+oriibMTUwv5WUmWqyfwI
	Jc5qp+fanF9fgZy4wy/bDd3L2TKzoCaT7LD0zLOLRDtyIvQ68bWavPJXWuGoWkuTlm9/5IqL+po
	tPffQMTprwM4iMvMnGFNLOn73MZzqW9Buu9Urr4tJz3Jc754qD
X-Received: by 2002:a17:903:388e:b0:2c1:d49c:8397 with SMTP id d9443c01a7336-2c718f5fa3amr150642685ad.12.1782124737984;
        Mon, 22 Jun 2026 03:38:57 -0700 (PDT)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com. [74.125.82.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e42sm72280465ad.48.2026.06.22.03.38.57
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 03:38:57 -0700 (PDT)
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13988680a69so9780161c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 03:38:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9lLzRGWHpqLTaiz/xJ0vJslnP5lAk7aI3a77g7VmWZQkH1Ase33lMiQqHI1hMzKqeV7akD8ZzM4F4=@vger.kernel.org
X-Received: by 2002:a05:6102:3314:b0:6ef:f6cf:1b32 with SMTP id
 ada2fe7eead31-72a043c9af3mr8022945137.27.1782124344043; Mon, 22 Jun 2026
 03:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com> <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2026 12:32:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWw4+-YZRx2icp_t3OQt3cb9osjac7gziiyRZcHa3zMbQ@mail.gmail.com>
X-Gm-Features: AVVi8CeRh5uGKoGdWXUVe0e4sYYTgs7H91cw7cP665l5Rz_E8v79r8eSiiAY4SE
Message-ID: <CAMuHMdWw4+-YZRx2icp_t3OQt3cb9osjac7gziiyRZcHa3zMbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Georgi Djakov <djakov@kernel.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Linus Walleij <linusw@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Javier Martinez Canillas <javier@dowhile0.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Jonathan Marek <jonathan@marek.ca>, 
	Taniya Das <quic_tdas@quicinc.com>, Robert Marko <robimarko@gmail.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Stephan Gerhold <stephan@gerhold.net>, 
	Adam Skladowski <a_skl39@protonmail.com>, Sireesh Kodali <sireeshkodali@protonmail.com>, 
	Barnabas Czeman <barnabas.czeman@mainlining.org>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, Anusha Rao <quic_anusha@quicinc.com>, 
	Luo Jie <quic_luoj@quicinc.com>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Chanho Park <chanho61.park@samsung.com>, Sunyeal Hong <sunyeal.hong@samsung.com>, 
	Shin Son <shin.son@samsung.com>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alina Yu <alina_yu@richtek.com>, 
	Andy Gross <agross@kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-i2c@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jun 2026 at 12:16, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
>
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
>
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> Intention for this patch is to go via Rob's tree.

>  .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
>  .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
