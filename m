Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CD27FB37
	for <linux-i2c@vger.kernel.org>; Wed, 27 May 2026 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862172; cv=none; b=tQddgw8c/IbOZHLFL5LERiqK2SXNbTW6mhwRAyfoapK+pwdpWsstAppLKQnPdYmY1aAgVb1KCDACEidbJWkndoJfiJ9hNosNbbgQxmxRuV3mnQaewq5uwLXIFkKDYPeFV5v/oII4S0jkVxZEPFeyVLX9a5MRRyOeKjxnsKk7MTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862172; c=relaxed/simple;
	bh=1oPAEY4P1oAyeLrqjETJkhe6tc2Oh4ssBnp0ZYasgNI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fQyj/DtD3xYIVqsi8K7yIQ+x/M6OMlvdLxNUpvcDGSpAnzrHAXoQAwHl14MwdUBUKO7ROHQiCysd+LBTEOgVLMXh4QdQlniEXss7jE54Z9nnzfv5+7TEyeYgbWlLGHToPk/+DC2G+4gV43v9VYkkG8pWKJyoGuUxBt8IBVWo5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=h78+OZNX; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="h78+OZNX"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-132c338a537so7593683c88.0
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 23:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1779862170; x=1780466970; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oPAEY4P1oAyeLrqjETJkhe6tc2Oh4ssBnp0ZYasgNI=;
        b=h78+OZNX7xbgGq1+UZ+z0W9LAyEs51lub+MbxTboF7mqjy3L1DEMTrR+LM3vlBveRR
         429/dFZqpPufx1Rl38VXwPINt3TRl72FiyHgdyMHp3kHmXp3UIDsPZUV8MufG/v5Lh1k
         Oj0vLOm0WrqglfeOGvUWFt5f8qfT0Jv/DGir0EEpTfP3/u4oc3ZFXm7N2jxn6jJjL2Nt
         xzyIoqjHRBplXCRr+flDCk84lFhEgfBoqEjYMeN7KyiFkQFDqs6fpChGb2ef0QZynpNL
         SL1mJydJyWTjHhyhufECEFAfRgd4KYalloQPJIUc+SDlavG8mbuD9jxjDiBiIr75xP51
         Z/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779862170; x=1780466970;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oPAEY4P1oAyeLrqjETJkhe6tc2Oh4ssBnp0ZYasgNI=;
        b=j3OWk1Q7oZYzqhTqmdOKjEPbEL2Uc4ghN+/jV5nqdsRr8OgtDeb5OyM6+6AaZsGTF7
         wzJ8Hw2kyMRNR37KPyXRoXGzsCDBOp5k9CjHEFQtLWuHU6LISXwu6ySjsOofTv1mHvDU
         ic04ZsFgoWVUHeFliZxFtkIn66rLZIhJ5EMEuFNjlK/n+4YRFej9vwM++r8Q3/Cf6zFh
         aq2DAhSd+1HtJpldZTYWX8cNhCkPmF+rLaMgT20VjpDjzfbDzOCPEij9+6mFHmeK4+5F
         2qns7evm/7AT0jZcAVnj0iviV8yMBS6h349ZwGBku4kxD0MB1EnMO0ipuO41nWjtvelU
         DjVw==
X-Forwarded-Encrypted: i=1; AFNElJ/B2Kjlc+wke2Pny6Z6KuMMqEC9TIam5eF+2BxN6eItGRgOsUKytdH2KRuMne0U6WSWe7eOuywoUsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMUDTRgvbGxxa0K88hoXpg3eU3370m5J8pQV0fdlPhLaS7IdF
	/tafn+mc1RQKOrLft1ae2vSP1/0Ru2uK2OL9S3SA0oD4AhRpjecav7Ot6leh6cLmfJ8=
X-Gm-Gg: Acq92OEEhHRMkbOEzAgo10v/Day14bIxPskTUIOOhrpaOv/89Y/velcDZB30E88qgLU
	qQFtndmESVZG1R54h+al32LwbxMTunqELa7b3IkqHHYb3RTNpSec86QR0/pTyvBZV6XRkuTVyZU
	B1FF78+c0TUNgUnd3uUwaWEl3noaZiCJ5jA88lquqdDl+EVa/gw93hKR+yeClPM7q/ocpPp5Xq0
	5j4RwKvAwWPAlOPNTMDEdJKS6WrpOsw5LTiEDFKbgN87e7PlABXWV0EM2RMIo1a85+d2nFgVT7A
	1SKngcfO5NdDQrStUX29BM9crOhC6+5zq850gzPl0I0jPk23rAvoML0iCrUVBS8gvUUK7B5yK3S
	KcI2q4+Qyir9gpW3Oe+tSqj9iunM/7GDpRwzjyj4cl0+yMm5zgfw6cCFoLgc3gOZkS00XpK7oVr
	GlE+K63a8uxQYpwdY+Pq1IWbuBoT5yMh4Jno06TmA4S0muAeTKHlTH4IqlyvRNWcRHtAApi6B0q
	fbZ
X-Received: by 2002:a05:7022:c8e:b0:12d:de3e:86b0 with SMTP id a92af1059eb24-136616e5eaamr4781936c88.19.1779862169570;
        Tue, 26 May 2026 23:09:29 -0700 (PDT)
Received: from localhost ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm12454864c88.3.2026.05.26.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 23:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 00:09:40 -0600
Message-Id: <DIT8HHYY12ME.3IGXT8OU1CGZ8@brighamcampbell.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>,
 "Brigham Campbell" <me@brighamcampbell.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260312081808.347978-1-me@brighamcampbell.com>
 <DI4RFLES1MXN.31HXMQMGXAXF7@sevenlab.de>
In-Reply-To: <DI4RFLES1MXN.31HXMQMGXAXF7@sevenlab.de>

Hi Gero,

On Tue Apr 28, 2026 at 5:43 AM MDT, Gero Schw=C3=A4ricke wrote:
> I see that you're struggling to find a good way to pass the device
> information between lookup_i2c_bus() and open_i2c_dev(). How about we
> lookup and open the device in one go? Exit paths will have to close the
> file, but the rest should stay the same. It's worth to take a look at
> how libgpio does the same, see gpiod_chip_open_lookup().

I had worried that doing the device path lookup and opening in one go
would be overly invasive. Of course, if I can make that work, then it
would address the concerns that I brought up in my previous email. It
may be worth the extra effort to avoid the ugly variant struct I
introduced in this v2.

I'll take a look at libgpio. Thanks.

> Also, to keep things backward compatible, we should presumably do the
> path lookup only after bus number parsing and bus name lookup failed.

This makes sense. In the strange (but totally plausible) case of
conflicts between bus number, bus name, and bus file/symlink path, the
order of precedence should be as follows to maintain backwards
compatibility:

bus number -> bus name -> bus device path

I'll fix this in the next revision.

> Symlink support would be welcome as well.

As a matter of fact, this patch already supports symlinks. Passing
symlinks generated by udev to i2c{get,set} is the use case I'd like this
patch to support.

Thanks,
Brigham
