Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A541FA272
	for <linux-i2c@vger.kernel.org>; Wed,  1 Apr 2026 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086405; cv=none; b=lKZruOqFHiu1ih1A8L/VxZw36WoQ1VuQgWjBp+VyO52m6jUynSCqeZnTsYeB5GtEZr+fr10+gdyxYtYCrgLXcA/O/1ee6JDCL1s8WHmzOTL07EKExx6WrpbOxTaXgXJQycE+CK56Ezq9k9Mdmas48bHeQ9aPOWW9U4Z4L+3LmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086405; c=relaxed/simple;
	bh=2qaX0Orz4HC84t756VAE53w12Cyg1WE0Vauzj2yYhf8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dFIdSFIuCB4bDzFwdI9cnW3mCLEqNXaHQdbo4iWxxm1jCyOq9D7JSmdOZh1urGLFjisl30PpPV7/eP+Fu0CxxNNCT6p+DMKFRD48Ff84j+5crtjvxQkdJbm0Cewa87xhhPQ4YCTCPkU2fchlhwlcAd1SbqySSNjSDgbxpvFdClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=H9fjXxV2; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="H9fjXxV2"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b6b0500e06so464255eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 01 Apr 2026 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1775086404; x=1775691204; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qaX0Orz4HC84t756VAE53w12Cyg1WE0Vauzj2yYhf8=;
        b=H9fjXxV21gYjLkwDpBuYXhyrBHPFrO2CvrzAPi+dsuvaenBt/2z/60X/SJp3sJZQCW
         Q/h0ehQ+pahv4WH/s/gr7Ii2jkv4nP2QlM1piK4rWhhsCpBnC0/BkvLqk0CKMf66YoGH
         KciDf+m26Y9CErQ91D/fJGzHezmiri8dC2K4SKqjJ9UVS7GXr7+FaMzeaEXRREkVnNda
         8qQeafAOCXUCqQrdj6rWz7y+51McjLaCyuX6B8ZMAcQBmGta4kgXtATfju2UTQPqFBQd
         oRQS3mjTiLUYqylc/TuybJVPZaRTqTOwibIRO/XzCZis02W/wAjM5aQAPCvwUb3E5OzC
         9WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775086404; x=1775691204;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qaX0Orz4HC84t756VAE53w12Cyg1WE0Vauzj2yYhf8=;
        b=pCvKstUOCzda+9lEcCu/2FhkVp/YscZBY1j/kT8ih+kfryRDYLIM9aCA6m/Paz4aIC
         2etoggUNglw1Byz1QUbvIn7cctI9EQAEnrkg28uUOnW6JJpHMlXMnj0AI74QXkx8j5+L
         jAhoKalXfkKij41UDZbRdqt3fx7psD7wQ6gZ10o7GkidOJiwbPA2XeRkUGZUwPpTAFKA
         xFJ7JDea9N5FBRRVDLo7tIPCWE0AWdqqdkPI812yDj9YfUZr+t1BCnZAavwicblr9uMn
         bh3K3tc0g4128fqkatr2N+VsKBWrCzoJCjBNGnk1Z4gB5A+R3DKP2hTiuMV5+484B7E4
         QLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNsv7YbPtho4w1lIccZ6AAbsqBm+hWL5czhzZSGa6/XK+fy1Pp31CWaDbYBLMHMZd8wZCXa1yJgV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvI0kAysSV4QFOwJRH6UeYGSVpX4eTyPVpl8UC6bDC+G0bLqSB
	klOvNyCpjUOVQH71hgOzklQZZmUuVzUZVuNmU4CHg1sGi7Nxbrh5AZ4z/GUEygsKnL1HJPtPfGa
	dmxefPYQ=
X-Gm-Gg: ATEYQzw7G8gx/konP6WFCCvQSzs1/KdjZ0c+m1Aq+E4WyICNo3hDy/KXnFphB1jK/BF
	addvt7oY67K751WInuKMg4dT7/ZsXaTD8/EnS054NuflwZFESsozQPIO6BBWH6okETeT7bsvc4V
	Ff2Z+TErk/qkFI0Zm4JPUaEJ9Jd5OYd+OuhPag6MGxRuZ5sk110JkzGppMmuJBuur1lA6hBrTT3
	BX1JOj3ns5lvlbQ8A2QSmPpiiPJM6N2BUk+DKoyk2oSL6ZUCB1aKu1C+Q1/Nxq9/e88gbLsLa9Y
	SNPU0zmPkxe8qPAWCoaejyz0ZWM4BJ6wAwFwOTS3lO/sUn9AmeuKvv6sZYETq+EoU86dAAvvKB9
	q9ZLOM5zxzUbWPh7RgRr4XY0UP/3TqRFWoBnzkOF0prAJFbRIwsd9JB9ypt3MhQ5Xlxi7jPUgfA
	D+YTZ4WkRcf31pRj1i1IpOAgcHC24jl7gTKF/SHKTLS8MnCab058rJGjQ1Q3Z9pg3B
X-Received: by 2002:a05:7301:fa12:b0:2b7:2664:ae9f with SMTP id 5a478bee46e88-2ca8d4889ffmr752846eec.1.1775086403885;
        Wed, 01 Apr 2026 16:33:23 -0700 (PDT)
Received: from localhost ([144.39.39.92])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm1104719eec.19.2026.04.01.16.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 16:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 17:33:21 -0600
Message-Id: <DHI7M3AVM0JL.C8F5I19CRT2P@brighamcampbell.com>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v2] i2c-tools: Allow passing device file paths
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, "Jean Delvare"
 <jdelvare@suse.de>, <linux-i2c@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260312081808.347978-1-me@brighamcampbell.com>
In-Reply-To: <20260312081808.347978-1-me@brighamcampbell.com>

Jean, Wolfram,

Have either of you had the opportunity to review these changes?

In hindsight, I should have split it into one patch to the code and
another to the documentation. If you'd like me to split it up for easier
reviewal and send out a v3, please let me know.

Thanks,
Brigham
