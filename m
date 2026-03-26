Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD133556B
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533943; cv=none; b=muXBVpaPvMU1duwVnyXSRwr3+M6WSmKUz7QtFJZinjSkg6lNRzKkLWPvHBn4Eym+LqgzjkZlL+YnNdH7hnJSHjaNVS5PTnNJ+aACY22dmTYY2zg1kraSh9Z2lCi2Mjs4a1QTs9Sfh+NKR7LD4vH+ZhG8oltxLMO5GveuZ5lSREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533943; c=relaxed/simple;
	bh=LrtNtHSmO4hzVyw5+PEvmHrePHuoHtR1t9d/gmGKyFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etb3Iq8oSBl1+AqjVbf+TDWZK67WIBnpKXf8zMy9ZAKcFJZR7jS/h4bhdwhxl4XaJ5p1oIbRAoW+GQWzCfhvS6Jw+W/SNZI64iC4TS/wb6miXpmyFC4F+lyxbGop0tA3PrBo2qbQoB93mcEdoXBvn1O33cMsyWrjr2J8LsuP+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56ceded5a11so381684e0c.2
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 07:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774533939; x=1775138739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GU4kGMAIQG/ljX6qMbUY/Mk2ED5n18dQJ01whvarEI=;
        b=lmuBWneEtjbdQIBFDXLLVsjGiYv+QHugKzE4M0S5GD9ziObz0dZZWnN1DKNttMD48t
         3I1wxRViKPlYO8ghzXAN+E32szMBBdS4qzXuYZvc0UXJrhI6FwiIRmniMsoHnt5keFyl
         d8RBb7CragsJCs9xmM8KqX3cbTm13pRUOFh0/613zf8IqQdqb8SvKgeCtc8p4F3Q3oOd
         n4aGGazLSFTH/gPdzFm5VDMJzWTshBy7Bfemixb52NRzG+y8ci82mtdi1Tpx2Jv1Z3uK
         jB129xxvyBiUkJ60E3U5B5SXO+XeY39sWpG5v2ByZ+JgPXe4pSmwhhCakhlJgojYjIer
         yU4A==
X-Forwarded-Encrypted: i=1; AJvYcCUtVV451jJhCPPAs/P9hxokVTyXmYYwk8dCWRnBR+b5uJNb5tM8F0F8TfmVaOmf965WJO9WqIplJfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIJJ4DtzHjnc5LcqZ+5/21JH4F/TQBRXb3XCZk16u2s10jdA1
	oQl24mVIIKWZXewURq39KO4UpEO9wBexMDQnUSS7aGbXG6PMXpqFb2/2Z0zCPDVwU1E=
X-Gm-Gg: ATEYQzxrriACr702dPgjruRDcChWrIzlz5MS8NpmIk2YTx2nAJeT12pRmu0zJl4rb4d
	guj2IpZmhjK27y5c/pVWR+T/56lQDJb/Eeh8wS7dzN26VoTC8P/cu0FUOWLY8jF3GDEHjgw/30t
	n+onHSOREJK8aVP4BHXVXTJtgAdaApmX0glorJ4of50UTDyGT0MyVBhAnARM2h6h/TzA8024qji
	2VpOO+P/BkXuoKMGorSjFR/bxpq6tgp7rcaBavUsTM9ol7ropN25hlPQJpPkGUdXpgyF7a76LTZ
	ZmAwU0luvFH0adI7o6Z3gEY+BWQlV1ylBvCOopnl+v/TC+G5YncnovzwDopvrunNb89e9bBoCLm
	kgQyOC+tFtfCKjbR1VeSMsA78meunghUOywYP3E5r+p2KFBpElBYCLgJ+Fnesk6aLK1LOpouSKE
	aSI9UUWmcyDPWpLkLRJPvwhmAjR/Nt6BguxsTj5MHddmhqaj/tB303Jup1tpu0yn4S
X-Received: by 2002:a05:6122:6603:b0:56c:ddbf:57e2 with SMTP id 71dfb90a1353d-56d2208a2bcmr3591285e0c.11.1774533938547;
        Thu, 26 Mar 2026 07:05:38 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951be1066fasm3544849241.1.2026.03.26.07.05.36
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:05:37 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a857578a8so454157e0c.3
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 07:05:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVedPbOE09Yug7U9SSRAp1kWiv4IrRduo9RA3tB1gHykPZfctBdQPfM3AyGor37eRPZ25zzVdH7DAc=@vger.kernel.org
X-Received: by 2002:a05:6122:2986:b0:566:341b:4dde with SMTP id
 71dfb90a1353d-56d21d0c273mr3553159e0c.0.1774533935389; Thu, 26 Mar 2026
 07:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304071732.5864-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260304071732.5864-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 15:05:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRn5v9c6=ge9vj_mFE7GQEX2GXbvEZxqeEvMtuXzM92Q@mail.gmail.com>
X-Gm-Features: AQROBzCl45J1B9gqwnevHhO41JWo1n_Q5hR4AHiytVtLIAcalXI_rirZOBLvto0
Message-ID: <CAMuHMdXRn5v9c6=ge9vj_mFE7GQEX2GXbvEZxqeEvMtuXzM92Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: renesas,riic: Document the R9A08G046 support
To: Biju <biju.das.au@gmail.com>
Cc: Chris Brandt <chris.brandt@renesas.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 08:17, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Document the Renesas RZ/G3L (R9A08G046) RIIC IP. This is compatible with
> the version available on Renesas RZ/V2H (R9A09G057).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
