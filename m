Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608138643B
	for <linux-i2c@vger.kernel.org>; Tue,  3 Mar 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529253; cv=none; b=kV9QVcrKHHLufFW8cKbSlvEEb3acPrlauz1v1VzwMQ49stfmRP0Xr0uTlSn/nDsodFbQ9jAsSTRk8le85F0KFEM4/BKs7hvtfRe5uStJ4DEZXiGxlId/u/PE4+UeAh44Pveih5gAuTYB+3SleqXh7QwNZwVrbqt7fzR0lFGqqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529253; c=relaxed/simple;
	bh=5l2Kz22xEk2Atptg+7LjAz1lULYa/VgXF4E1315Awb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNZ+KgGkwJ/Ug2mmhIPCCIdvvlBvcRNB+H4MzAdCr+c4cNVMAOHSaNfTvRoDpbNqDl49yqUD/aIShj9XFkjaY47jGm6O32Axh7DUWZC/WgqyxDMzIWBVanrLycD4VKIq6dpO9i/KcJlqlBGAc1R3mTiPYIrN8aGwRsEhcJ5Urg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Rs8yJu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Rs8yJu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1241183f8f.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Mar 2026 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529251; x=1773134051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfdnRKMwt4rIrADe9QK97cFlPrIqJK1YbAhHvdHHa88=;
        b=F/Rs8yJuofb4sXHSHuzg05ArbJjFka4RwLh6G/bTVBcMgAGQ5G1ftRF3H03wCI5ji+
         kRAIH/lMyJ/Hv2rPxFLkKc0Kh2QGZtTLUq/kcjz4QYGSwJeLMEzaNZW7i6A32eVS0zMO
         kxm90cDq4qBxXQuLxrgpEkGayTjGRDDPlYhD8v9fEHAYy1w/B9IIykgXwrkq1yd8mHnF
         WRfzxKvhGOZD4+WdCi9dHAK05rPgdHYCUVwGfzKRNgoMXAHeBVuA3pviGIy+k6JFB0x/
         uEUINUaOxYXM68bqV6hGFPV2B0eT7RgX/UFTG4Fu0aVeF9hEqVHYwWQHbKDgXp95DXpn
         NSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529251; x=1773134051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfdnRKMwt4rIrADe9QK97cFlPrIqJK1YbAhHvdHHa88=;
        b=XUrRpEzNjhYIskyNPsbj6SDeWaGWPMCgjjatW9/Zl5WTq7jHb3W83Z3MWzjfAYuaYN
         oeHwfbCsOvsE1pvsYvprdiD8LSMWCyxLT5ZO4b4FFCD0vVeOC+gmC+r9Z+w8Hd4vWCa2
         wUzCAQWBjeW2VMpUtE8ube3blYqaR7CucN7HvKystsWraQaFB0qBuDabZpslB01TPYGE
         zvL1xfynTxVktJpmhMwhXJD0fuzWvO3KKlNob5XrNZV8FUy510uUacv6arHxxXb/pFt6
         vgTqAQ/GNCj9lk5W0+lr8C2XuQaMqepfeczAxvka0CHZXuj5pNC7BEynbAOsUFdeTifn
         JNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNP8IkEcVmxEg+6vl9PxmX6QO5WqsOMsCbhEdHzy7YtU7GkxSajyl60BuZAEREBiXKW/F2qOGA3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCuK9clOYUUPmZihWQ2q/HOH/1MhZ4zF1dimLnDxzHdIaIAoZ
	4kdz1ppmSUN5vJjluqTGLJgDOyP/xlsHeYSUxU/7rnoR/hLl/89drctVAiBwEAQ1Y9M=
X-Gm-Gg: ATEYQzz/g1d6C+H0lHez1eA2F2iO83dEF0b6a2U8B8V8kqLDq5zyN90bDP1zJdfiNCb
	dNCRbYMRTvXLFcKtLaFQ8QMA9JwUn56D1K3V08KjP1B/MU2J7ofe0tMpEeCNFeLLLbjULiYTvIt
	8LBsW4d9Kyqg/zrqAD3Rsm52uHDgUotKN6Xjgvjbb6E8dVOiJxNsNTRdshkF2dbecdK9Yy5WO/Z
	7SVOG5eVUEHWh3F4eXVkFfxymvTDRo8O7EU9YZcj5HlxH1c7Xur5QlhFjAImpNvzn8CcV7CZzT1
	LHAS/h/n4Cph8B5bNmWkJkr0DJ9V3QI3KAQ9HVMzqR4608YyVBdySyDbflGZUIF1Y5hU0Re9aNk
	f81e80gs9y+B49iO58ERCstBOYSJHdWE3uv4j3Ty/6FNGbgHc0skY1xeKdcOS7tuDdGnhpseBxC
	6ey/NwTHUzMSNOt02dZcG6s/I=
X-Received: by 2002:a05:600c:a16:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-483c9bfb2f2mr273658985e9.19.1772529250689;
        Tue, 03 Mar 2026 01:14:10 -0800 (PST)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm376259165e9.4.2026.03.03.01.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:14:10 -0800 (PST)
Date: Tue, 3 Mar 2026 10:14:08 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Message-ID: <aaamYByn9dZEIBWb@eichest-laptop>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
 <aZXq4gn4xhInQQlq@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXq4gn4xhInQQlq@eichest-laptop>

Hi Frank,

On Wed, Feb 18, 2026 at 05:37:54PM +0100, Stefan Eichenberger wrote:
> Hi Frank,
> 
> On Wed, Feb 18, 2026 at 11:26:52AM -0500, Frank Li wrote:
> > On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >
> > > When reading from the I2DR register, right after releasing the bus by
> > > clearing MSTA and MTX, the I2C controller might still generate an
> > > additional clock cycle which can cause devices to misbehave. Ensure to
> > 
> > Do you means SCL have additional toggle? You capture waveform?
> > 
> 
> Yes exactly. We were able to capture the waveform when the issue
> happens. It doesn't always happen though, it depends on how much time
> passes between clearing MSTA and MTX and reading from I2DR.
> 
> If you want to see the waveform, I uploaded it to our server:
> https://share.toradex.com/dwnhcrl6b9toib6
> You can see the additional clock at the right end, after "0x17 + NAK".

Have you had a chance to look at the waveform? Do you have any concerns
about the proposed solution?

Best regards,
Stefan
