Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6311EA73
	for <linux-i2c@vger.kernel.org>; Fri, 22 Dec 2023 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jc1gwCwy"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbb650ad59so1433115a34.0
        for <linux-i2c@vger.kernel.org>; Fri, 22 Dec 2023 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703284254; x=1703889054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwejgOu3CLIEy7WBg6DtMDhgjRDGncrbITb/o+9tVKM=;
        b=jc1gwCwyQC21YuJLxDsICmF8Dbjr0sHq5z+GvXy0tBzbhINVUHXoKTR0gSBjt4G+w8
         eDOeDBMbAgN9/1sDZrT6xsfOPHi9t9AWRVlSc2GGUBCLE3/GMmblVr2nA6eqkaKl4dop
         eKga4UW2c2Ia9GROQ/9shFmdwHRT9crzltIKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703284254; x=1703889054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwejgOu3CLIEy7WBg6DtMDhgjRDGncrbITb/o+9tVKM=;
        b=cyViyiUw4Hdi6v/IcSZEjdkxvi3USVZd20zW4tvTlVbwDEywHdbx+iYEYNugBgAlYl
         Krygfo90rYBxyPQ0A5Q7UiJlqvSJwaj+/gl2dySLERj8bLSIPlEBDOSi7SEK3/hsuk6l
         BSh0RGsG2/xaH/tr2dFiCMbMw7CKlfyo3UZkQD237kHC9CkhxIzdbeFiOWqmO8x9BUYf
         oFwXED3CCyN4GTtC0KaGDfCV7+u47lrFKwX9QldzGLqZUq/dmNrbPRenV022eqVLJR+U
         qPWblHdpvnzzgkEBQhG7pxedPg1aLDJLG9rfS3fRNuf3qhNWg40cE8eRd1uID4cOvKmV
         8jHg==
X-Gm-Message-State: AOJu0YybmWtYDtACbRMelcmvga4u4AyqSqeBWBieNAlCN1HwbKJCOwUP
	2+nOdaWFGokjYT17PJCskcYC0h/eM91kmh/xdl09OHYes9+t
X-Google-Smtp-Source: AGHT+IER1bh8jMPP1/3cXJs8YlZWz0DMEgd5cLDf4OrRRbTGp5gF9dbStw6xbzqvzSRoXTPBelayfBgYtrmw0We3VHY=
X-Received: by 2002:a05:6830:97:b0:6db:c040:b5e9 with SMTP id
 a23-20020a056830009700b006dbc040b5e9mr1589627oto.51.1703284254400; Fri, 22
 Dec 2023 14:30:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org> <ZYRAuY1LGdD8_u5K@smile.fi.intel.com>
In-Reply-To: <ZYRAuY1LGdD8_u5K@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 15:30:43 -0700
Message-ID: <CANg-bXDw+bYNTu-HFaNAPb4e+_oKt2ExR6PehWR_==vpboKGaw@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Improve IRQ wake capability reporting and update
 the cros_ec driver to use it
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, chrome-platform@lists.linux.dev, 
	cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Just wondering if you used --histogram diff algo when preparing patches.

Not knowingly. I use patman which uses 'git format-patch' under the
covers with some added options:
https://github.com/siemens/u-boot/blob/master/tools/patman/gitutil.py#L308
