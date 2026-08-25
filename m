Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182F470EA9
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663862; cv=none; b=IhVsq8dS6z0I25FVuJTQ3KS8OsQC4eRHEVw8LWRndaZZP6HxtT71LbOCxO+5uWctUdrr1zNV0MtGIQtUJYhuzChZnhy9RM192v1ymS4ouqkgtNZ1fPe5xqNS33UkclJcV89ZAzsKyUf5U83zwBVtKsJJqVVDv2dtixRz79Qhd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663862; c=relaxed/simple;
	bh=g2sHAATEnIjD9gAOcncDmOdMf0+ZUwevuRsByoswNfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPdHjoxgxr3F3qn0gxfFhHnjSau0QI88PdyKhJfuFkdr93nVtW+Ftr76U0EC+SUQ68algl5lXvRhcvY8RVal8qWcIOPHh8erLZZH3gJ2E+Gl26Tw3oYJzrqaIBSuyhGBsiR9iqCKdVYMB33tG99GNhmEVI1SupejhuY6IVRygxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so1586907a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663859; x=1788268659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IJm+4jafzibqolHerE78hJ1wHg6O5UxVoBQiVXfM3qo=;
        b=m7xNdXvRySjH15YaGx8PWGzBYmxJ7NcKSK0fhSngODsMEKI3gj00yMIRYhMFyBjnPT
         vr6DOgHH0Het9TherbT/tjctVbIQjNRvGmF1VKXrRWq01BXLNzyMVpJp1CVm8i9eDW7R
         kxMSZEEGnDD8djVmf6R79TK+KqbhqpY7/ndZaLJsk4D3hdSuActQv7H5zBcUtHVTu+jW
         7jB/ASvRpRDqev475v8P01YI/IVvyXRxFl3sw4FrCmVObW3Jq/BfGg/Jbfs0GI1EJyMq
         TgBxl3Ua/LS6NhcDT/TQqiATxRjGc7QcresHflyyKwSJxsnCuF2J/Rz3+q3AX+yl7ThK
         Fedw==
X-Forwarded-Encrypted: i=1; AHgh+RoQeTcGo2YPOQCX4XHLiqF8ZzzNsjtBBEn/D8VpR3heGOcfDOacBurJyiPRrLkL/Yep5ikhK2dHF2A=@vger.kernel.org
X-Gm-Message-State: AFuF++kdkTKj9OjZhNNXLASuMueI/H5ERqkuyVDdZNF1YZrLOdnBJTJq
	ZVFXUUcCiDZVy5hr9isQLSR3UXZzN7CIk8Gi5tpovfAJJNZhkSgM5YnuNEmUhu84/B0=
X-Gm-Gg: AR+sD139l973tlrBd52Z4FcpMBZdCabwXXUDTQpIp9A7YqTp0h9k5L/9cz5IqSEh6yG
	8Ub7pqQwowmzN5XEDAfooEyiTDebsroZ5/wWaOg3wI80EH15M7ah6Vl9kijnEr152GH+RJPqfgi
	UE2C6aCQ8rt06BC2bouIQM+N5+QxakXkJjrh7hGJhBGSSFGYED84X0g+J64chwDUTpNj2xah+sS
	1S/LMPyQN5fXZ1+/WzwJ9ma9pSlIjPCEkPLHgxRi9fM9VAPqUmnclaHvN1ZvEIv+Ps9dvY6jBQn
	X5vkW6kFHbxkHLzkc32dS5WmARYt0gDodOBti91ngaLRqyXnKqRhfUKAR7NuJH3c33WzNcf2/+5
	dhomS21wvXmfTB4Fgsy0weA2UmmYvc1MPNKlQ3wwp+8i5K7ZXz2bY5gnSpkODEVe6HEU8GBTbUq
	1zZ452x1ysnLmCC9xVrFrU+8zgISVyHnQBHsXUNC0U0hLtywc9+U15L9hOznPKLL4BSJJNioZ03
	F5DGPAv26js+f5+8DqDnT0nT9JJjHTxZtLY
X-Received: by 2002:a17:906:6a1d:b0:c15:c323:36e5 with SMTP id a640c23a62f3a-c24e2d2b08amr698260366b.10.1787663858888;
        Tue, 25 Aug 2026 06:17:38 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249689fa1dsm1686031166b.56.2026.08.25.06.17.38
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:17:38 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so1745849a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 06:17:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoiU/3SEBdRXgxvfFXYWZg62YL7mja8SePECrexU05TW4BA20dMqZ+a2dxSz4qk/fSqaL78Ey9DhlE=@vger.kernel.org
X-Received: by 2002:a05:6402:a50b:10b0:6a1:8b83:8f3f with SMTP id
 4fb4d7f45d1cf-6a5c3f70aa3mr5115739a12.10.1787663857968; Tue, 25 Aug 2026
 06:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520131206.932050-1-claudiu.beznea@kernel.org> <20260520131206.932050-3-claudiu.beznea@kernel.org>
In-Reply-To: <20260520131206.932050-3-claudiu.beznea@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 15:17:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+Rw9PqTRRY3+YGL5hOncJMfEUaMeQhrj1VB1trFDbyg@mail.gmail.com>
X-Gm-Features: AcwNN1Vz9bqZXB4KhkMlpFM4f-6nIsbwp7DHyGg8Z1SbeCLuh5Z7l-sMB_cn8NM
Message-ID: <CAMuHMdU+Rw9PqTRRY3+YGL5hOncJMfEUaMeQhrj1VB1trFDbyg@mail.gmail.com>
Subject: Re: [PATCH 2/4] i2c: riic: Use the "dev_name:irq_name" format for the
 interrupt name
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, wsa@sang-engineering.com, 
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Wed, 20 May 2026 at 15:14, Claudiu Beznea <claudiu.beznea@kernel.org> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Use the "dev_name:irq_name" format for the interrupt names. This makes it
> easier to identify interrupts in systems where multiple devices may request
> interrupts with the same name.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Output looks much better now (on RZA2MEVB)

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
