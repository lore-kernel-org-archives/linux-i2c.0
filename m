Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E33932C6
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904512; cv=none; b=cSH03MXzv1aKQ2JpL+SraMnwWNhoPlewWb+9n7XlISqTNtoHw8mV3Et6eFPe8tjHQU+oN4+5EKerZw0wE4piBtIFpk4L2ONgmNw+3kAlW6EJAhhc/uxjZAYmvgmQ9EtEO1Q6xjXDephzEaSvu14WI2LBTWK1u3HLBcxpVj394WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904512; c=relaxed/simple;
	bh=R7MwiCWB0jLjrbgihAJaI3C+U48f2yX/bqNuxPmV05g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9FpcgyZMsxmTCYxyDVqZAQnc7Njk7Ix90KvQuCLNC7t2wANdKjdXPaKFD1kX/ZXkv2OA7jolq/kkJkh2FzWmd3OEMnuvieT+GQBvvvRI1GxUIW/xHtLitttoOLkX+7JfVbovYSHb1NrVdNBrF3VlDJwjhjsHtMzoVMHi+eqAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59e2b96e3d3so2664897e0c.2
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 00:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780904509; x=1781509309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt9sAdVpyjABq8uk+bJPrbepMfmlnejqLbS+z27bzVk=;
        b=dmEgO6h4kjeDjYLqtu4pdRwwAW+guAgNPvGdxEB6Pr7n2pCM3NL+FEYG6XNyf8kKmP
         UjyLGSWZ7NwLgkWUbj8SKtLva2tUziW3K2BZWjHQy45Dhob5z9t+cRcjsWgynS2gCM3F
         3MSgGFnzrryN3QlEHrDLiTxCi+gihkbe+OXgyKdnlddze7sMnVhzknXeAs3uu2AlkMgw
         t3cFALl5eDF3Ht36ByVPCsmZ3kjzICqQ/pJdGy/LyV3yRuOKajDshYijJ7QkC6dphUIQ
         D6AYmMVilNv7ZYCAuJkuBczG8gfmmBBA9IX/Sogl69y76lgRzLVKf9N9OVBG9CU98LZY
         CgpA==
X-Forwarded-Encrypted: i=1; AFNElJ+r0Qtdz8azxYINkYlTCygcelMrKu6JdbO3ibLV3lymnS7l/d/Dgh3O0R3jRxvxabixkkqYJaumxrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZWcjhrakcAi1gwTGYvYBtuaI7tvgNNUkrxorf9detqFwIYsb
	O1+NpEwl6nQPSiKa3BlvWP4GfoP9ZoNIAvqa74zKUuCv/3Y67bb+zLZdsjwnYMt6
X-Gm-Gg: Acq92OE1kmcj3WaHIKtKkaZTm7BUFmTlZXCamVSdgB0pvbD0hzUxCfpHsPcy+LyOimR
	zMa9HeYCJYOPjua1scbLV23PlMaBfuS1oO7a5d7Yugql6ZC3uTKf3AjvOHBw5dQg+yWtehx0WBt
	CM1mGhlx2u9dAWuPVG+P6yYPCdv6wOAdx2SXDLo00kr8A+ugTIQYQLnFabBoNaDs5gaFfUn5DXZ
	uBDnxE7XXzRkSANTdCELliT8fA5zCTmchPUNzaAI3299jrTdh+lwzt7uJQftuRODaoHcmgNJw7Y
	GWPHJMMYmfYXIjVtenpsU/vJI7nk+8ENxW6/a8GOjvjbhGKofjDTxS5O+DgEYsZFFDPRiRsi/Oc
	/FF/KuvI+u/yCuLeVtIQ4ztKsulUbSMQIHlnv7mJO+iom7cFA9ea05vXA0ULl7V76AsFmepQf0o
	Zk5+yQQ+e2ww3kcHXi6mPvfLk7Dv5Aiq0GYDnvNeHaWPKXUXe0F69JzbRRNMTfr1MBIt27UL4=
X-Received: by 2002:a05:6122:45a8:b0:5a4:3c79:f5a8 with SMTP id 71dfb90a1353d-5ac477d7f60mr6607039e0c.0.1780904509087;
        Mon, 08 Jun 2026 00:41:49 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d6dc3d3fsm14082694e0c.5.2026.06.08.00.41.47
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 00:41:47 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96392241154so2928917241.1
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 00:41:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8IGdj6knVSDT5pHR6uI/1H2neo5QFEqDdZAGHP3cgMVN4xKLc2PqbThM2xe6RzeH0vbcvhW+4pRnc=@vger.kernel.org
X-Received: by 2002:a05:6102:6b0a:b0:631:7781:fe8a with SMTP id
 ada2fe7eead31-6ff084a55demr6790737137.19.1780904507130; Mon, 08 Jun 2026
 00:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608071123.128964-1-vulab@iscas.ac.cn>
In-Reply-To: <20260608071123.128964-1-vulab@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jun 2026 09:41:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWz1Z6Pp1hss2X8R2D_9-bLjUpYnpdGEsGtZMKbF9L7pw@mail.gmail.com>
X-Gm-Features: AVVi8Cdai5h3PhjO-8qphts-gv8u9z_8lWsZUpbrxaI2yb-8L5dWz5NU13b55BY
Message-ID: <CAMuHMdWz1Z6Pp1hss2X8R2D_9-bLjUpYnpdGEsGtZMKbF9L7pw@mail.gmail.com>
Subject: Re: [PATCH] i2c: riic: fix refcount leak in riic_i2c_resume_noirq()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 09:13, Wentao Liang <vulab@iscas.ac.cn> wrote:
> When riic_i2c_resume_noirq() is called, it deasserts the reset
> using reset_control_deassert(), which for shared resets increments
> a reference count. If pm_runtime_force_resume() then fails, the
> function returns without calling reset_control_assert() to
> decrement the count. This leaves the reset deasserted and the
> reference count unbalanced, which can prevent other users of the
> shared reset from properly asserting it later.
>
> Fix the leak by calling reset_control_assert() on the error
> handling path for a failed pm_runtime_force_resume().
>
> Cc: stable@vger.kernel.org
> Fixes: e383f0961422 ("i2c: riic: Move suspend handling to NOIRQ phase")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
