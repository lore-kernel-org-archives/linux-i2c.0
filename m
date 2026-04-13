Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070439EF12
	for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066338; cv=none; b=WG+IsS2j4bFgu8hoE3uRKvxnfnGf7dsmYW2e+0ir3hxeXUepyrLSc0/vFHWY+2Zn7FzYXaKoLK6hXNNeZA/GW1xIwaNVKNtLp6IMfz23Bmspvv3PE/MoQj+iMcQUyucIOGf0FsX/ezvsr5mjdkmLBtVMoO9qXJkZ0Y+9F9Ec4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066338; c=relaxed/simple;
	bh=GQQ3SBHociFPwcQlzwIosHskRYiXTXq/HoT2kxRNfeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv5H3iZBcKBMZAPVkSdhQA5PVNFwcvtWa/2ztVwbxRuvhPFaWg4uV+8d87Sfq/3oyNzBuR3Fe1e/f3jMckUpBKLq10W3K58qJpQiAspz9HEOIGyHmX6/MzZ0jk7PGnmxuMmctBQlvaxtz5+CibIpVN36GYjcnrkhUpbtR8PLKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4W5WVBL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4W5WVBL"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2b636b944so4605897e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066335; x=1776671135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CPGB450BgNYljKUDXZxUQRXQWnX1iFE/RTDC2ASOQ6g=;
        b=a4W5WVBLrpBnH52QBpsgk0d/359LK2DVpB2rzUfvawfHCtZPELivaki9g3JguFLXV7
         iPikxold/n3ZO4NhygMBpsAIO/nLtT8wzEH1EQJOfnVkay7tD/AjmHs4qZ5MX1krCa1M
         hOb6Qo+2JhRnMQQSZRDxH1IdKNmL4d/9/WsxsC9wSqvWOyYtepmIgYskjljnJxKF0yj6
         RwVJPQkDwd/4FZhmL8LL4vLWHOwa6U6a7NitzTh+y3W3fSFgJUxGxvZCZcxMZMwlPnBc
         2Gm+752pQhUmM8wt4AwCGVfSrPPMyLaV8Hqf0kHsocQr/V+eDh5XDesHpTXcgUFRrDVc
         lk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066335; x=1776671135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPGB450BgNYljKUDXZxUQRXQWnX1iFE/RTDC2ASOQ6g=;
        b=D3J00++FVAIstoO7bwC7Ai5Z1ObSNh2xM1DZrdg6SwhQhJiKkfc2BIP9jeux/GMeVR
         1rLCbLhoxArvKY2dR1n/m0GAQh7LbKenXjGypgol4JamLnNNltoUAf27mEllgolgJsTJ
         j/ZnKtjilViXfzkIzPrfMP90/RuFahhBrgutjaoGexhi0m3ZDl6DhboW5+O7TApFwr/Q
         54f+zyYDerzm3JwWAFZgjIcziazLOS9yRvg1g4CFeZ52a8+tqlitSn2y37wKCo1oOPcF
         xVVo7nuUrpT/RsxfQRcP4UDWMN+HEouUv3t7TVCx1UZVURklc+PSM1PfqUb5w3tmgnnG
         pfFw==
X-Gm-Message-State: AOJu0YyVzgobE8wJJRbBl6bSsPdrFkLsdjRbnlYFsr3PjGt35WR71PQl
	Y7y7Qq2iDaCU41+IxQSZiYR4RhK1e3PjRVI6wSuIQKDbFY1CvCKHJfFz
X-Gm-Gg: AeBDiev01HN5V0uXVmNhuRKX199ELZBfAR5a8lGk5NDb60pWGqv0WXiPLxnEOp57zJs
	frJL1aol5p3DCLPfqOkDYXea1b8739eyrvMg1XmO7TJc01PVPLbNU2m+8LZhuNGPmrYvfy0Lfn+
	HdCZXCTbO+5Cso0pCwecI9Gu0KeDM1mYkvbC9hGvzHAAmAmVd3ReG3h3PBDXjK+dpkSPixQLOy9
	ZKPIKwjmT//c478v9lNwgYg9kSn6u+u9EKwj8MrUVtjmALKm19ipAxDHkpElNmEf9hfywvsYFZx
	qDw1GsN9MMfrC4WJXL7Lui9WneIwbOJ5UVCBSe8kCJoJ1Tsjs1RERfwO6Com3I9pXG2VQeArzU1
	InLwI6vjdeGozVWnuGYn745kFQzlMpULyiISTCzMZh4T8vd2YloBaNhunIXVnmNN51Rd1TSBC7n
	VOe7mxnON2+qOONJERxGsjvOlVPgNJ09FzUMstc6ixNvQx3caIdlbzGURkoiLS
X-Received: by 2002:a05:6512:3c87:b0:5a2:cacf:5b2 with SMTP id 2adb3069b0e04-5a3efb299demr4803771e87.22.1776066335061;
        Mon, 13 Apr 2026 00:45:35 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeefb849sm2411855e87.60.2026.04.13.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:34 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:45:31 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 0/5] I2C Mux per channel bus speed
Message-ID: <adyfG1jckNp3Sv2_@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>

On Tue, Mar 24, 2026 at 02:54:14PM +0100, Marcus Folkesson wrote:
> This was a RFC on how to implement a feature to have different bus
> speeds on different channels with an I2C multiplexer/switch.
> As no major complaints on the design came up during the review, I
> decided to submit the series without the RFC tag.
>=20
> The benefit with this feature is that you may group devices after
> the fastest bus speed they can handle.
> A real-world example is that you could have e.g. a display running @400kHz
> and a smart battery running @100kHz using the same I2C controller.
>=20
> There are many corner cases where this may cause a problem for some
> hardware topologies. I've tried to describe those I could think of
> in the documentation, see Patch #5.
>=20
> E.g. one risk is that if the mux driver does not disconnect channels
> when Idle, this may cause a higher frequency to "leak" through to
> devices that are supposed to run at lower bus speed.
> This is not only a "problem" for changing bus speed but could also be
> an issue for potential address conflicts.
>=20
> This patchset has been used and tested heavily the last months
> on a custom board based on a da850 (DaVinci) platform.
>=20
> The implementation is split up into several patches:
>=20
> Patch #1 Introduce a callback for the i2c controller to set bus speed
> Patch #2 Introduce functionality to adjust bus speed depending on mux
>          channel.
> Patch #3 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
> Parch #4 Implement set_clk_freq for the i2c-davinci driver
> Parch #5 Update documentation with this feature
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Any more feedback on this patchset is very welcome.

Thank you in advance,
Marcus
