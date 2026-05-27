Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200F30C154
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887827; cv=none; b=rTB6G6tcmuWuJNd+GQpbilHPraMjQcDAaMvundLyA62IWhGt7RCfOodUDJsFTcvIQRR0CnTnxGHdpWvjCWi+15AZiLqlWl9KZAv0mC34DH/gA4ZefJqDqUdcZgRlt4QsfPP+dpru6rwBOy9Kxm6xCz/cIJu2Ukl8PXcdMneEbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887827; c=relaxed/simple;
	bh=hv1GNsCnVa8DXglzqcuOUo6o8VWT3L3pNEV00Qf+PWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPgruOpGFsyYdzEhQXpWFe/jgzkvFPwGsdBoXwmRT0w/qx2VRt6lFKKLOiXAKWLSZcbI1ae1go8Q9Hf9hSzH+wzPaiAn97kVesCusVy1/PymOXqo0JgjXaXdVIdJPI/mPMrnfRFF4hfRBt2QlkMm3Vl9uftRC0APjbUkGzBEERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-95cd8b71105so7423284241.1
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887825; x=1780492625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gkd1L4zxlfImornmUbtbRVRrm+vdeTTXymd/+9j5P54=;
        b=pVE2NQWPxBjLSt0yCcFDKQb/IqiG11SE5nVBoAx4nO1IWzhiia/ksOI303RhPjPmOb
         7/oAh1bSsQ0ElUcJy1aH+ZJMF8SJJc3CufWVOhVw+ZYjxmX1nyAQ/AJDk+75lzXFfFTE
         TymSOguqKVWiiogxXPb0DUk2zlf1hKxHGMHc22we4/qvXjoFFk59P1h8roGA3c9kCcPh
         BKBuVrO6dDtqExcec/UNEaUgRiP8q8ATYIObpoj2LPOqCyGbNfdyE1O147NSTjJC85lP
         +tjbgBlfqaV1EfqjxZ7B7wwHs0G3vOzMCgEbVzEV5Z6aApW528Z5PhhUXlwa15vftBK5
         9+7A==
X-Forwarded-Encrypted: i=1; AFNElJ8MVnmo1Ht5Ti0ER4YoKqL+wlY6fAGkOVWGlmllOf9on4K+UgK+M1h2kbXWE05LGpLSJvWjvM71xFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PVsD2i98peng6hk3A7cePpCcodfje9cEJEVohz3cmwTZd1Qz
	5wb8ahOvsytOFruTotH92Hb4WwEB3texSlQY+sPawhL6aVqk9A3jYPC7MIJlBRZrG68=
X-Gm-Gg: Acq92OEYHw2YyC5fO42N/tMzsJ4rZoTDGzkeUlhY6UNx8QXbvQDA2QKiJFNksYgjARN
	+WTX+MmUPm9l1AIw4BcpOCqKXwV8X+TmBNYZl1uNTMbz7vDdKi9bxYN6TDTkPuY6SCby5sazL1h
	UL/JSt0CkbPrVeKmZqlO8vVXzS+4Zrk6XvZLlo0cADy2L+gFUnmvtqmjWYRj/IE6cqKkr5pf7+m
	c4uKGiu6rDFM8hxyIl2zHklF0Iea6/oyOm10R/5v61ktcIcTyuRGtrzB1t8tL7Xx9Ih84VAfViJ
	/DlZTAnK2ZaX+/Y8vFd22YNXRiCh6XJtuJAIZxyR3VTGD88h7IcWBOu8NaJa9pRE407TgMC8EiI
	spw2rGMVbLsvmWVylD7VHu19t11KRDOrT/Ho1O+Bo6r8BXtuzV6yUKSvDGxU/edrTvxXEeWfEk6
	kuXBCBKhwC4vY04irfdqJp0zGNYjOmlyqR6b4PUtVD22Rl3zWKpHAuHBp7WFPdOJLQpcZFoRlu7
	Xk=
X-Received: by 2002:a05:6122:4d10:b0:572:353f:be2d with SMTP id 71dfb90a1353d-58663a5c46amr12507575e0c.13.1779887824760;
        Wed, 27 May 2026 06:17:04 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f37281e7sm20112666e0c.7.2026.05.27.06.17.03
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:17:03 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-575267e3398so9505008e0c.1
        for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 06:17:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+rLABg385BkCPOhPDBqjRiiv97zITgh8I16K0ataMtFQMu4ORICpDNVOlm23aFeHS2eyF4AIgU80U=@vger.kernel.org
X-Received: by 2002:a05:6122:4b14:b0:575:3b1b:ef01 with SMTP id
 71dfb90a1353d-58662aba6edmr12654435e0c.9.1779887822714; Wed, 27 May 2026
 06:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:16:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXC0stRLvApkr6g8toxu25yWa7N1=t4sdOJqAkbVFQyXQ@mail.gmail.com>
X-Gm-Features: AVHnY4I_rTDkVOOEISI30dYmOvsLT-ZXG0Ldql2WE6NFUnqw2e3rb4bM9Hxqiw0
Message-ID: <CAMuHMdXC0stRLvApkr6g8toxu25yWa7N1=t4sdOJqAkbVFQyXQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] i2c: icy:pick Use named initializer for
 zorro_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Max Staudt <max@enpas.org>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
>
> While touching this array, drop explicit zeros from the list terminator.
>
> This change doesn't introduce changes to the compiled zorro_device_id
> array.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
