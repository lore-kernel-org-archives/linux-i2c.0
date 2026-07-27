Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725C3E00A6
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139635; cv=none; b=C8WZ1RlqJnHK07ghE63cW9qrvQnVzWH7fIP2Y/iOs0yRBJ2sB5q0aKk6v4LdC1+/8T7ADxtmCUK/DCNEw1rQYWOWzJYMKids+ySo4QDXBPQf4dLcfyNRBBY2MiYikqfjz0T0sgfecJb+RnZH3+9ZKR151sCdlaql8gxKsPg58sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139635; c=relaxed/simple;
	bh=UJmeJhL3flGWN5uYemKyP1j4NhBrqfm9dVEYQIa1kr8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCQ0tpncGQCd97UMcCJgxN/dHQ8YcWe6chVSpjAQAQF2S5On3jBKu1Z19AWcASI9kxOMRy3nMom9+atByUbKOnCTnnXAiQFM3xHczTBJcVWOIs+/zldvhM7z/SeQRUt0D+yi7b5VNiTZD1DcmMaOUIFK2TjW77Xhzie/rGZOUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l5jyM9Jc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l5jyM9Jc"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495590dde14so25950075e9.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785139630; x=1785744430; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :organization:references:in-reply-to:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJmeJhL3flGWN5uYemKyP1j4NhBrqfm9dVEYQIa1kr8=;
        b=l5jyM9JcOmEpNM6/RGL2pTDoCJwRme5aetkZAPaaUjIQmnMccWcsZxipPS4u1i2Pkp
         GJ+97a5ZumFGem/AEe9AvdsEoV/oY3OwgYWORVurTMWDLDNfALDMbO5GTZQp/8OE/oYQ
         QuNo9qzGFMbGyVE2FDn0KNRnf2Ycs4cagxTZ+eCV5rsqgCdkY9Cycej2xL5g5W2yJBWF
         VREd31UFIxRWq+kbxCp0NbVK0TL3F062VNLm1gJO1PouaSTAwMxPZu6rRT2voT7LEJhW
         rq9sy2dS3FtMz3om33O3hANON0O/tf3C+vNrvwRRzTEa6R9QZ8sHdcaeznPby/v0zOel
         9mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139630; x=1785744430;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :organization:references:in-reply-to:date:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UJmeJhL3flGWN5uYemKyP1j4NhBrqfm9dVEYQIa1kr8=;
        b=Bcx5tjK1/UejNkU42qcCX/ps5SS+v75XjmXXc1SWnwqUgtCU+RSQFUD+GAgK5F1W+A
         cM2z3m2VGVDEbVPDTqREbB1yNjUgYeQUEeOw6ftguZGDM0e94eT5i+FKOwYi6IxSrdux
         bWzeQnYmyyiYj8YHqtdPdaehib01AIVyUIKBJl9RwYgWRU4XDzJEsmKFrDZzxP/rDqXA
         BhQjvPIO8HGUIb8JUWxyBcnKWGYwU6LMQNzrAxSHtFmOyvr2PEH97xTmDIqSbP3wlXVd
         6ejA3eGM7UK0eCRbFjDPD03KnP6GueRXHRMlLQNtZEzdNVJTYk4RxUVKy2vsX8PDBmcu
         diUA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7sbydKfCwciiw+2XSWxc+TEVTw603ynAyGld29UA3IrLOffrVl16nUz50oN7vLrkTydECpvkrOVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXM8N1DaGGcyU+emylJcPW04QbUabGt/FfXvR+4hGzkfFjoNIt
	uwAFGpIC7SyYMFZPSII5gS3aNeSdP/O3IVOHFsEUhCPmgAagRU2jNTpO/yqmx53sejQ=
X-Gm-Gg: AR+sD10zadzOZJPSl5rbHvFHQEzVflKQg/znVrfuQfdixYwtjuWdOg+4KN8fP226tfX
	lO2vkpYkkG792UKvAXmfEhVXi0CZoBoRe/XvYYuONg3wxV2lTeWb8X6qubZhyosg1mW6y3/HMbu
	XhgUdYDDwo2i/TjOL03AVoQ1SROmYjCzXRAztnLV5G5+riidKzC3gPOwHaen5IzUU7oIVYIOIAg
	MM56vsK2Y1VCQJrLO8/NTQp0AGtJcTMmassRjBtGSSdUKiQ2jwXT2vIQfs1l8Q9YIym7wlSgDOS
	FsH9ZNwe/Cp3ncYZRn1ujNseTeRwOG/TGk3XyYsBFYPHd+G8+AiUIXPSYP7CYcF9PAVULON8a6H
	Dy98WZ+M/U9zCGfh2XSrBEm9vdrC5o3QvLrjJRuK5qFMSxydm5XY/k489gM/9ZMk0i2ZV1XJrWO
	hmFU6veNrdn/vyCWniH/vwv9CK58u38GfT42MI0VtXWkw=
X-Received: by 2002:a05:600c:1c27:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-496b57257dbmr103541285e9.28.1785139630676;
        Mon, 27 Jul 2026 01:07:10 -0700 (PDT)
Received: from [10.246.179.73] (mob-176-247-78-218.net.vodafone.it. [176.247.78.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm45965701f8f.22.2026.07.27.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:07:10 -0700 (PDT)
Message-ID: <7d9d7bfac46269c1a66b6aff25a28d12354cc3c3.camel@baylibre.com>
Subject: Re: [PATCH v4] i2c: Add FTDI FT4222H USB I2C adapter
From: Francesco Lavra <flavra@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Date: Mon, 27 Jul 2026 10:07:08 +0200
In-Reply-To: <f5991c1e5c1c71746b543258ead46caac0e6ac6e.camel@baylibre.com>
References: <20260225112046.2394231-1-flavra@baylibre.com>
	 <f5991c1e5c1c71746b543258ead46caac0e6ac6e.camel@baylibre.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Another friendly ping

On Thu, 2026-04-30 at 17:40 +0200, Francesco Lavra wrote:
> Friendly ping
>=20
> On Wed, 2026-02-25 at 12:20 +0100, Francesco Lavra wrote:
> > FT4222H exports a USB interface to operate as I2C bus master when set
> > up
> > (via the DCNF pins) in configuration mode 0 or 3.
> > The USB communication protocol implemented by the FT4222 chip is not
> > publicly documented, therefore the name assigned to the various defines
> > used in the USB communication code is a semi-educated guess after
> > sniffing
> > USB traffic generated with the FTDI FT4222 userspace library.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20

