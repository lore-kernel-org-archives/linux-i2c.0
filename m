Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794F4F55A5
	for <linux-i2c@vger.kernel.org>; Wed,  9 Sep 2026 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979913; cv=none; b=NMZPrMOw/woG8fpnZLX9VviuVnxZWjNYFoJY4eKcIuOX3QuyLdWzG25WgtHg4n52RwcRLTwVg2XSBbGk6sFlau3FdvWammaNqEHU51zhkRerINV0S+LX6l0v15eLDMLQx5wKTsuXZBc+QhsXPvPYq3sptfEd2yl8KFZzsIOG4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979913; c=relaxed/simple;
	bh=WYM63RP/6qIs4Sb9Jj4o5ZhHuFQddVi5q4PJ8caVcwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gysZRbRv9w0e1YgbLrjgFKmO8T5dZ5qlNlMfkI++71u7RMwDEmIC1k8HixjlgtidMqkJWxt4KMZqZrSbpvAYfaissbP+9Vc2BqwqHgwIgzXq1uUetbeJxxlPJ8j2B+IxUce9G5Vsh/+QpqNffCipLyK8wdRV3ns7+HU1kuXFlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e9af41731so466242241.3
        for <linux-i2c@vger.kernel.org>; Wed, 09 Sep 2026 11:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979910; x=1789584710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HGn4boZ5W+dK4Lr50YdWTU0/URer8oxrazbRXftF9gU=;
        b=JN2m0/tD1DFvVSPK3tDqVVBDj22qIpzuh8x00pYT4NxFKcZwrArMyDNz46b30rtxqH
         rdvL97w0fLiYtXkUJRvVtDKGACsFllj/gImJa/8PHkhcoG/kCuNPRxj7cft5mHmf4v4E
         lrOVq0wGtNB10/bg0xobbTdxMd8etqjd1ZXkwEmZZXD0egUzWAxOd+P1N7n9hoZmCjQm
         HduGs6DT6Il6BU1YrC/q2gtZlfeV8mYrsOF91rJakFQUkB0hqQ40ETurtYoBQmnbzFWQ
         FJ7YpHhfQ53zhFN9WrPdacYsIjkBHnOXiT5Ciz93Llgqi7mClhrpGKyTD4p68xyodfR3
         ZyGg==
X-Forwarded-Encrypted: i=1; AKwUvBw0i1Qjdhhyzn0QmEdf38aem6JhAznw38ot9DJHILjI6eVz5AdvjS7wKnPlPfFvzzjpC1OuCXWod3c=@vger.kernel.org
X-Gm-Message-State: AFuF++nO/daurS3Pu5m8jTAdT4/yhku8gqT7tgvWEuKyFaM4UdHb2gsG
	uzWUwkrc3Vja6jgD3hNS6Qc3Nw96zL5eUUWvGecS+MEmA063Tl2ShMJfi4qRzp3BWd0=
X-Gm-Gg: AYBFou0PINog3rE1V3LPuBT2bpG54INLIVPAtuPrhR68z6cDIrbqDSOHrBlXSZ5Yb+z
	eMbrTDAoPxNNJgRf6bprav4xry/yJ9NvOTd00D2TjNC/ISmCm+OLOo9V6tF/CsKKAY4TvnQNEQT
	1gWX/E+GtidOK60Mc9E29FRN5GXEckWdsIXdLk2acoPdlnitM7x45B2tKIYGnanideNqsBYCwCr
	PHk6BAfQM+kAa3+9hxvoheCZhFx3GUfbF+MvxxtRQJLCbFJGeLWrdQWDIMHCXi1Xwuody4P9mkz
	3OywbDHqjfD6O7h5Y9glRwlmLme/LBNIX3tZgJMXibTxV+5qvkDaCeTvL+/VOqCazlcIv3w9sAG
	iRvXVTJ+pY8cieXUVLQNf8wJw0bdXwEHfSpuIbU7RCNkWG7If0uSIWPNwdBFeHUrAmTEjfn5CyH
	stR3vXj7EXGJg2BXNaNZ8tOYFwWRkpMIvBJNGh+C9OPcwjd8UZ96e4Ntyk/SvHAFboGK1EzWojx
	QbYU+4NKLETaK3X7AML0D0QLWKIUwd7OFxo
X-Received: by 2002:a05:6102:2c83:b0:784:b6e7:cee0 with SMTP id ada2fe7eead31-78f7380dab6mr3314706137.3.1788979910021;
        Wed, 09 Sep 2026 11:51:50 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808e98a9b3sm12879925241.0.2026.09.09.11.51.49
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 11:51:49 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso516562e0c.3
        for <linux-i2c@vger.kernel.org>; Wed, 09 Sep 2026 11:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwPanxqYcXlOV/65mmTVK5x6QfnNgSErkXROPZjnNKn9WCjYDsK2oCS1d4YEUL8ZITwoMXgNs9tCy4=@vger.kernel.org
X-Received: by 2002:a05:6102:5789:b0:785:d308:cc0c with SMTP id
 ada2fe7eead31-78f7423f6b2mr3129457137.5.1788979908893; Wed, 09 Sep 2026
 11:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Sep 2026 20:51:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW585F3vRqpKxgCM2EAG=H-y18o-6uOVU2ff4qAdS5+SA@mail.gmail.com>
X-Gm-Features: AcwNN1UDLjSSsn8pxc82wy-nfmiOus1jbwsmbeQd2feYUj1SY0-1MOOdJjYeqTE
Message-ID: <CAMuHMdW585F3vRqpKxgCM2EAG=H-y18o-6uOVU2ff4qAdS5+SA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sept 2026 at 20:42, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> R-Car Gen5 can make use of it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since v2:
>
> - dropped extra limits for Gen3/4 based on a discussion with Geert[1].
>   I dropped Conor's ack because of this being a bigger change. If
>   Sashiko complains again, we will ignore it
>
> - not a a change, but after an internal discussion with Geert, we
>   concluded that his suggestion of raising to 8 is not fully backed
>   with current documentation and we keep it 6 (for now)
>
> [1] https://lore.kernel.org/r/CAMuHMdXj04QoxituCF3wRcyzN7qZrVBn7-ukNkKDd0OfhB8zOQ@mail.gmail.com

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
