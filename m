Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B554854E3
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076772; cv=pass; b=inWBfRoh6AZWhYFFMivrXhEJZcV/+Z+zZcmi3YbxJTZdJVVAj7sRrHF8ImyS92gpfFcu4AANpGaTRnIaqEQb/pDUxTChlSXGnRDcpP0CAvyYpvudijQhQV33PVnafpCGkBBAZX6M/w2zRSdUv3wyAL1TIjasaSaMcFHpPKYvWas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076772; c=relaxed/simple;
	bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkfeqcBkr6mx89+TWQ8iE3xeamLkYHsR9GYGVg/o3Oul4n4L7TDcugk+f5KsgHHQrLIArOkl7oGZBN+/jUuCa04DhbePWhKIgJqUiqrwqI8GQ/2YM3kYonJ6KAgk4joRTyEfagImMewg59pTAcGN99gZsDaNXVgnHOY0SWZI7Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI9EFXIq; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI9EFXIq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b015b2d792so191039e87.3
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787076769; cv=none;
        d=google.com; s=arc-20260327;
        b=ijS+Ajyp1gV7YIhO/VwMXAZ1pLYKrOu81hTARNXRdOHqCfsiMPBwhhtFS8Cp8XakTS
         BRse3Gw16Y4ifecYI0qUwm4APnq3d1xerCPBXu1SMFv/2yhuZoMl6Ixtbc1i2WZh8Lyi
         w2MLsteKOy4WHEEav6V3x6V3/yhz/i7DBa2rGIqJNjT1qLduEQmN/R1dTKdIIu9n1of8
         kJvIQ0iT/XcuV2OSeJ/1t9ofqiitFZKnPL1rgxm9kfQ3rK7Lep7OoTR+28q7cXqsvsYK
         80qH4761jdyy0uj3lyrusqSc6V3a7fKSNrUxI7jCZiGwZ4UEhxRulTsogv9DuisrAhBE
         zYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        fh=bKESGahqKlnMwHy5kxRNJE/5r51V3weO2V/kqD/49GI=;
        b=k2FI45WkkQobL1MlCG0hXrzHfr4vBIqqED4v0VakqwIis4TZi2uDbmbUC9Nzbtw3wm
         Qm3+52lIE/FF552BZ0eGBp/NVsAiMuVrC/T+cMRKkxW3u32GDNTtF3dAXRo7/yEL44f4
         dpmLaoz2tzwtXnB+K4JOcwmmDHYiLnIJ8qQrBPbpHRaGxIlFUSVvDXvB0xhsEaKuHBZ2
         7DZa3q9FaK52y9kf7imzW1XSn1LqLzWg1ebzC01SZuImTMcPsLWpGRCbCKlSNosS3Jg1
         kLWBAm7pzSrdB9ogrOQgy4Y60O9CRtPr8pH2NMwkGHiM3XYsbGBEXtNdi1rrgDd6h1Jm
         N1dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076769; x=1787681569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        b=cI9EFXIqLZtxOwbcPy1n/SwOyM97CkaCGCO32tIyKapOrco9zYL8GSxSqEz+0pdZGl
         eRdXau6DWUtlljJX5siu+Qa4bBcPCG2x78BsZc/yP3+b9T8627tXDp96yST3gpI5hvZj
         caDeUzz8f5mECkDvRl3hldBuC/OB7cRpdQoNHql5Kr6EiWVncMXq8di57OMtoeMBexNt
         YG9n/9LxlrQKTaFLS4JgSd+h3XKqo0PrpL9w6SClRm4TrP3HGB+bmyC5bInfa9fMZ/vg
         J8c1uHVEz2GO5NlDvOb6H4HpGMNfjXOhzQLinkPd0kTG5qQOn23C2UQ7MuzDFev2+ayU
         hdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076769; x=1787681569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        b=GOnDFt+4xBiJHl+xqM3tIZYuEK9Z1FrB5ymMYqt6jO0rIlh/2ofeds7t1N/GuwEzgZ
         4sRiutIqDDMxRls2SANdLMe/x5sqm9YWIOk0CyeOD+vC0mM/ycUoCJF2uETd7E3K7uJl
         hQWOQ/ldPRW3fDgTHYKFcpY92uLmgeNbdUIB5fB9zXe0yX8pkk5GB4LrKyafTTRblpnv
         V+hgpaRXzo7TD6uwiCjbT0EfjiqmV0+e0WUApGigyEsinVftJbj02tgiXRZmRepdwafm
         RxB6xylBwOc9LzpCKdxHNyQnGZDATSwlwnL+l85vzXff+MASSdrSsawEnFdsYrFtltKR
         0nOA==
X-Forwarded-Encrypted: i=1; AHgh+RpOC73ejpxQ3wGTMQBSk5/pO7s2xMTSaFti90CPobbtrWOjX1/jt3BjlTUyjzvKqSj3Am+mUf79u5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/LWp5vhlWGsEgPUFt5ozHaFGRNXD9SM+HhAIY8FmE5/RLp98
	qIauyDmrXIt2ii/WdFLll4oG6DO4QzY2ada4eq6SzYOH7/3QxigIcyuO435EWFxxy+SJGa+Xj6p
	NB3oO95SKit0CN9AVcrHhs7cHVlHJ8gI=
X-Gm-Gg: AR+sD10pAPp5Id5T6BwYGD+YBS1b3xaBxNG7bEpVO0SP/xKOlzsXUa+VJ+COdbUXXlS
	XBsWk3B1bDsnATRwMIW8SOQ5kkV2laoLjqVrKEb16qlSrnSXjTSmCnOEAO+ZidXcCzKTQtYxnDq
	TGMibgzm5FhnlxpOnNd2o4D6pb1E9gVVF/PwH4A0nrrB0kOt+quNoAxF0f1LCljQiMHkZL5N4pB
	C1vp+sJIi/WeI0AdmJ/gO6sUuj5F1h2kEmhjkqSKTFsKGRIGfrE9LbzzsWqOP1epSGn1VufWc9H
	fxyLQxsruCg3699tLzqXXxKITuDJGMtjJzJrfIBkHx6YSYlNGzcqNRd5tqANkAd//5MeIJPLgi+
	+InVnzuW0yK/E+aGq5vg5xXRAbw==
X-Received: by 2002:a05:6512:10d6:b0:5b1:5ab5:ea09 with SMTP id
 2adb3069b0e04-5b477c6091emr111830e87.0.1787076768577; Tue, 18 Aug 2026
 11:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <20260818095654.5357db1d@kernel.org>
In-Reply-To: <20260818095654.5357db1d@kernel.org>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Tue, 18 Aug 2026 11:12:35 -0700
X-Gm-Features: AcwNN1VFdbc7wToCDqu6OVpR2tD_blBihPQ30U0mvdmP813mFMsjtyFeEMH6kL0
Message-ID: <CAOQiBWM57ZBafMcj9MaegHBuM21313O5PqAAGXdHfvmHxHp48g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] ptp: ocp: Add R4006 and V9 I2C peripheral support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

These RGB LEDs have been part of the Time Card hardware since the
original design, beside the four SMA connectors and the GNSS inputs.
We never had the opportunity to add Linux driver support, so they have
remained unused under Linux.

There is recurring confusion about which logical SMA number
corresponds to which physical connector and how each connector is
configured. The LEDs address a similar operational need to ethtool -p:
they help an operator correlate a logical interface with the physical
connector. Their colors can also represent the SMA input/output
configuration and timing status, together with GNSS fix or lock
status.

This series exposes the LEDs through the standard LED class, avoiding
board-specific raw I2C commands. The generic LED controller driver
provides the standard interface, while the board-specific status
policy remains outside that driver. The second GNSS LED supports the
card variant with a second receiver.

I should have stated this existing hardware and end-user use case
explicitly in the cover letter. I will add it to the next revision.

On Tue, Aug 18, 2026 at 9:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 16:10:48 -0700 Ahmad Byagowi wrote:
> > Add the generic LED and I2C-mux support needed to describe peripherals
> > behind the FPGA I2C controller, then use it to instantiate the R4006 an=
d
> > Time Card V9 board topologies from software nodes.
>
> Ahmad, could you explain why? What are you going to do with these LEDs
> as a end user?
>
> The influx of the LLM generated patches has a hugely negative impact on
> the community.



--=20
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
