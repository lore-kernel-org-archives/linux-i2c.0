Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD67218AB9
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582044; cv=none; b=fBXUuB+Q11WZUNVIoLUiBvsuGpwR6GBEquPt6Qhpg/fNJTjlvQJqmPN+E5CbWwvJtVjckt7WZHfhWawEzSHQC9pASkR9aLCLwnGi8wX2Ld/2R9LZqGEXtWUoaU1stEU70BJnNds69XVdWn+/KGszuNV0/1O350+56y+F6wH7f2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582044; c=relaxed/simple;
	bh=nr0JbzfBqGevMUFWP5WeE8p+Mj3rdk2zYt8M2x9Q7UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbTlpjUuer7RWtzEBLpT+86UoVz8W5Ut4yNesPeLyKzBNB8EuVD4vjlfArRfil69CRBCUTMxijo/pso+HJv/visVtcy1WeQI/k5pB7IHzHfx7FyZeko1yHq7ujjGAlJyJ1c+d53TtaR44wiGoHfc3NVNuonNgvag587/pYq7lFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGV/t7bJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGV/t7bJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cca0c5799eso19864475ad.0
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786582042; x=1787186842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9BsxTIcePTgkc+qhqyMPuO3rIwVn2+yc4KgD+VvA3wo=;
        b=tGV/t7bJ1m6xuT9Av+sWqexA+KMjlot80kyUJJqzedbilJiVR5C/sd2H0JCSYaEqUR
         O9LiJZXyT8wY+mDfw+l3Edwf1v7vdqqNXjsiBP2s0KhsnnO8giSDr3VXeY5hpTF21w6N
         6wgQbWxsDIBxEmswikLmylSjE2QTEtPYwOeUH0DuZ2fRVbxmHUW+UL1lm41PTRrhhI5+
         /SwOSZnzhvAEQG1LurT0hOOxFgUGqtree34gF70nf0ulpnMqml4PDLgTDipVKbFjz0PX
         XEY+2gLsMPLkaOC9tTVGDoAX8xrbvMCCGkC9PXu1pnfl+UAhM3wNW6KIM3bKraoM/gOa
         ZAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786582042; x=1787186842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BsxTIcePTgkc+qhqyMPuO3rIwVn2+yc4KgD+VvA3wo=;
        b=KvUrSPBmznpNcvLajCksOn//u9VeWBcgVMpHYUdAce0C2v6EE4qTLR4GHT3QGIoPZw
         OIjle0BVY6Y4OO5mZpc5nDJRcfxPOzdO1Td5r3gOC4FW2wcdwlQ38p1v/44/ux6Ai3yn
         dlN6wuQE4G7Nlm2kjf8UYKUpaRfd8C4n4a5koLOxwVu6PzXjfz6mjCmR2zO5WFF/tXkY
         khrp8gc4nw1vIpKCYonYFtOr/Rn2hUkLKUlpT3NnOzYYrLWlIFzJZfICGMSvsu9Gn8/Y
         G5DFrkz3VZWDDqu62Ay01la+IBGDUygev1KBIVdQld8n2zf8ij8oS0sKSYAS9PbP2lL7
         Js0g==
X-Forwarded-Encrypted: i=1; AHgh+RqAiMeKGOyaiBspDrNs2v/c3QbB0TLYF6glS3g+2es6zw4D717WEwmj/DX8sW9O+n4bv3FLO+5xiRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0x8gSGRGESg3z4+o4lLuZg6y8dkp2NPVkoKaBfWlrkyoPu0aK
	M4XhxdhZH4582WDfJbtMx6eo0yCm0mZAgM0qOChG3TDa5O1iBc64+x8q
X-Gm-Gg: AR+sD11OdDtw+BTuk7DEkg3g4am9ogabpBS+qVpDttqyJxhpZ4HE/0pc29PcXxWWYWW
	Abv6xuzQLZbRycdDkDDKhOy5Yf+2Pz4uZBpF546eMGDF/FhsepdETsRk9jKcrvwuTPcSiIFn1K8
	T3LKzGcVf6m9btWC/YMCMyxW7W/VFmtN44YTfhCtOfLHjbZgBvNxFGbZ3wqSXcl+WIDMMptCA2r
	i6Gjbgvd3ta3bkcK0voU8ZRJU6IiJdNxxNUMZfXqpNydb8dBNsY8yeITBarhpacaV8Y6rBf2bKL
	1l63jAkfMq/7Wk1Ft7P0pm+o8ckU8hVxtIACZOZYgVwNl84MlVRex9i24gmlrweTQ+/s0RINm4X
	Td8Gqxqk1Y1lBIV8jETQ/RMwCtVmPcRRWSVkpOapdObO7FArlH3ImGfxQdikguxRPIrJR5l4d+x
	co8P5l/WNEV27KHDnAclRSZUTBKMeJGvJwln04IXiadYapFl/fkp9x4LwKzM2ELI/oBGbuwD1Z0
	l+DtHGkT6uN8h7kI1yTlsGmthzhCA==
X-Received: by 2002:a17:90b:4b92:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3931e079c22mr1944443a91.6.1786582042327;
        Wed, 12 Aug 2026 17:47:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8656:b5a6:1038:61b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf732166sm1762331eec.18.2026.08.12.17.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:47:21 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:47:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/9] Input: elan_i2c - sort include statements
Message-ID: <an0UEY6gigYTWFLW@google.com>
References: <20260811122011.3539250-1-wenst@chromium.org>
 <20260811122011.3539250-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811122011.3539250-3-wenst@chromium.org>

On Tue, Aug 11, 2026 at 08:20:02PM +0800, Chen-Yu Tsai wrote:
> Sort the include statements before adding new ones in the next change.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thank you.

-- 
Dmitry
