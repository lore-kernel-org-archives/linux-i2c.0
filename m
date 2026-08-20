Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A994370AE2
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216286; cv=none; b=pX9gJA4mIm1kMcXLNcRyWNEh1bM3z/M4a4zIv8uqh0vEYzc6P0tEQEM4HdyAMxlAzeUgZ93F5bfXsnlmvPo09JixM2Jw45Ip0EquH0v11fNXuXEz/ozLYAvPZmJ7nfJNghwGkAoLBms8wbnogBg+iTXx/ipABKbhpltmGj4/uqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216286; c=relaxed/simple;
	bh=+pwWH0Ylj+bA4kVRpKE+GiAnMFCJcAphE6wSuMx+Mx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzZRmWT8kBkdMvhMMcJlfR4NRNwBeiQtL9IsKOYxObNVn4EI5oPPSIR2HyCvQ49gQJEYSm2P77w7hNuAvmCXUUcru+nBLsNpv3FczcnDUlW/1J02Q9DpilD3XeAwCO7GS/5CmXx/oPpVdYlh/gyKeZiyvGc2m0BY7VpDmZi4PDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfa4c51c2aso788206e0c.0
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 01:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216283; x=1787821083;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lIyX8eZ4F6Ye0rQT1cY+3tveCKsiBumqw03xeQl53DY=;
        b=MicMgfgDA1s8kto4C54x3lN1uDVKieWu1HFBbQ2MWcCN5rQX2T21xgqjI5vkJ0tDiX
         4B1JiXFAc8SO2lN4ZKl6ripk2e8b4xfHe63qjLwAZv0ofDZa1wb/Tnb2hV92jNGaKj23
         pZnBFYgo8yk3li+NXxdbdBj697TXW8F7x0uKkjj1hhSmbTxByhTN122D5FnWLMG2Ewoy
         LTGgTVZNV+MnqC5Y90GMMt2+YXKJdWQgZ8yvZp+UY3RZQ6mmAi3E9PX1ycKOK8O+zDG3
         yDm9ZNPtzs9cV/YboS1iP4dlRkXsMC8/W3JYIGyBCBvTAVhu3PGZ8ZCPsnBVoxVhY7hJ
         OM5g==
X-Forwarded-Encrypted: i=1; AHgh+RreqIpdZCSzDtMCwhLfQDfcAcNeGw+UP7J/uCgNr5QYb/et10q0xabVSYk3mPxkgDtkqkMaup0v71w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRH6qqSguME3SC6tzIxHGlg9vUjuyOpPmAMOvADhgZk57CBk1c
	YHat9S3LTWnoWCJdTpzL9jy1Ah3einf/TjQga2/ju4UnssrvZeVJSySAzsxkCYsW
X-Gm-Gg: AR+sD101JrFp4IcGvc4sWUv57C1qNXN7y6dpqsN9/qdILh+FtXtszdanelcdEUYYl1f
	tSUT59modO4/3Jw15KMPAKaAI1W7eyMsCHpLFh8quWB/0t93ZpJZrHN6fPAfWoaLBBbm8d5ssGD
	0cJLv8raWGCBsEsZqJ65fclQH5Ajl16iJRkoWj0aSXhvgo5+Oid/KOfRi6INEea0z1ywaDL5GG2
	x9h0DSmuPASV0eTEs1K7dfn36gkRAk4VdmPfuSrRT9RAWXiBEPPCZgjEoZGeKhlQkaopkVJCzEw
	3TCx/vMhiPbGRIANhCTRgXPQRv1vLI+EKrPn6w7k+kT1cbE4cqVzZ8o1Z70zTKP5xqsy+fgehe3
	ZgnGwuo1FvpCbD2vD2GgHrOns3OG8Koaym8Kx1tx3WWiI+qJgdbmlOfG4xhDd7TnP+/ZHtkBAuo
	itKrDIaGHtAu3w1vzNCEZwaIQpsexfyT/LUphmPdOCrmmH8vlEc6EryODVEfnOjZad0GHMOAFkI
	h12Lu3U+VlgIMqwyemsVmed3A==
X-Received: by 2002:a05:6122:3129:b0:5c3:61c2:9ec6 with SMTP id 71dfb90a1353d-5c5e3e3b693mr4465112e0c.7.1787216282813;
        Thu, 20 Aug 2026 01:58:02 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2857954sm5267558e0c.18.2026.08.20.01.58.02
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 01:58:02 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9773c6ea885so671891241.3
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 01:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr7lO5pO57WjAkAZAt1HDpb6h8eyCRwkOwhceh+XWs3xoUjw6cuV6TNKmSxwci1wFSAoK9tLzDptjE=@vger.kernel.org
X-Received: by 2002:a05:6102:8555:20b0:778:459:f0cc with SMTP id
 ada2fe7eead31-7780459f1f7mr1814844137.4.1787216282002; Thu, 20 Aug 2026
 01:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817083046.11935-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260817083046.11935-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Aug 2026 10:57:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJq382F+aRrJLBHx9hBJ1cpzJkuwry=s8aBr+a_v_e3Q@mail.gmail.com>
X-Gm-Features: AcwNN1UvQlkgAamNiFVHBaoN5yJQh83L7Pc2pSVec7awxDWPpdL2YKJFb3rej_s
Message-ID: <CAMuHMdXJq382F+aRrJLBHx9hBJ1cpzJkuwry=s8aBr+a_v_e3Q@mail.gmail.com>
Subject: Re: [PATCH] i2c: rcar: fix reset handling for Gen5
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Mon, 17 Aug 2026 at 10:31, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Missing reset_control_status() support is not Gen5 specific. It depends
> on the firmware used, if any. Refactor the code to handle missing
> reset_control_status() more generically.
>
> Fixes: 87e713f20048 ("i2c: rcar: add R-Car Gen5 support")
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

I reviewed this a few days ago, but wanted to postpone my
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
until I could add a
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
too.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
