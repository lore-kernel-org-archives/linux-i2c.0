Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174152;
	b=s1UsT3xTWFHD2ZhgGYLz2Wx4kjTuXb8P839Et8bhAcsWf3VBeTn6GDwPF1lspCpYNf4a
	 GXfGwQ03vJ0fitq1kkp7GsnNASAm7JRojtYx+NjTblGsNB1PPucWyjfUhXVpEa57Oaq0A
	 t98higBX5v56DKcgL5jKD8ussGiNBesuSkAif8GfJ1HwVJlTFMyIpkIitc7yo3ml5re1w
	 nocgUVnvOP6fLKIWoNlmlRiTZYhITRCn2Lm2x/mnE92ifmW5uPGfJ/xJuu+2QDO1Q9gUp
	 d6tebRq0Bjncjk3Tyt3m0C/qk74RgXTdRpjN66omSpDmoGZmTwyJqLYU9bh807Iaqmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=H2Y/M+dNCf7NZhZYEFajE482Mp/N89Yl/EG9+klpX5E=;
	b=jU/l+gxAqke+LrXjQYHKAnpcWjZxeY9ntMCOm1q9ex2/Ne1aZvJeeeQT0tgpg74oi43j
	 sey27jCv5dQZDYhuK0juIBBulZMwWvnRiUuwQdR7alCEujuy0hUeF6lZ3aWxVv20gCpWa
	 wsLJNeOliZHRGlkBZSxC7UqEXtRVKJZuoOj+s1cNUGCS9m2JyHo71B3Ot2i8elRPySSNA
	 CO/fj1HUgU2c6QxyZfaGImIgA99tC0Ap/cMtb9WDRPirqaR3jWiv467VfsCfRFgeC+GRU
	 FIaSBCNP/qJGi4Zoi6Kac2HFANMNCP7KmIvzWJfB8HI+xnHc8c97C/y28j1PacKYL/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AfZM2/3R";
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D42606A326
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 11:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D42606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AfZM2/3R
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso564910e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 03:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795174151; x=1795778951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2Y/M+dNCf7NZhZYEFajE482Mp/N89Yl/EG9+klpX5E=;
        b=AfZM2/3RNZ29zxQPByoziHGRKOMClQenmiFL0HtRQqnRJm8YjZt5KhowLUD4NAVpxi
         VYtq6CDWVgLbZa8gLAVBue0s5772hxY9T1MHhb9HJNKvF/5E67IhK7XYJywbs8MfJTL9
         YC0aSjb73iUI/o2k9GGx5/TOc0yBrCF4OsIItWBdQxqPua+FahxNhIeK47QgBg3EEUpG
         Wc9Ex3WHodxqhlkxJjcNDR6Vh0saHmUeh8ZnmFjd1ThIUjHakqYU9eCvp6NVY+L0FW67
         O/zsy36PWX1QGc1iUfrH+P9WR5uvQYuavSw6dHeMwrECVfcF5xzls6nsX15RUYfFRnuU
         1+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174151; x=1795778951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H2Y/M+dNCf7NZhZYEFajE482Mp/N89Yl/EG9+klpX5E=;
        b=lEEh3TdD7QFakbGWAbWU12Xg1WPsg6xJLYW1wNszFc4php0PGOAjblbIWqEyrTMCJI
         8CyCHrGTuT21DdlGqHZMkW02CEJ1FLYK3bcTagwIXwqaDM36XRg1Zj0jv3LCNFWTcmNV
         gZYvqemOA7Hg25G2nozL4e9at28b7kQ9vODX5lA429pJ3fEND73C6VNSWlfwuORs//qK
         w9XIOQMlqm4aSDT62cGzAs/3Zyb5UxbB7wjNkHYGRxuWfr4kZOjOzJXd2DS8b9ho2Eek
         xqmESWUiWYr7yAhRZ2WUdQMJTO0r2i8qmbOUD/Kg7DlKjDHohBLXiza0kn7wWEHkMEKv
         Z3WA==
X-Gm-Message-State: APuU4Z9Cv6cKx2Q+g6cIxVXWxyhCIoi4wRCrkAQEheOGjvoXRvlCvqp6
	fBbmFowFK/5o+WMkBx+dQ1NZVenZF4UodzOrFLVtL43YAoei2XYzhU7KcZF+oUZM
X-Gm-Gg: AZFdTZeKbWZk3e9KcTvJ0l4gIFb8IQIoPfm6hPeldpjduH2tVPv/JSA0bwCd3w8P41Y
	GW8cg9aiauYuFw2RQeHCEr9hTx/KEz0VAJWlfjwnjspSUtxXiTWm72q3wt7ifERUoYBj8MqheEA
	StkdlSyulkX4UrWYHGppuSQFcHJHBPMY0MdVdGZIK+cC1pKydm11q4iLij0mXG+ebTLqUQqZqu3
	GqnQ2wLUhPc3ioLgXcS8F9OVtdZrA4MgSXJvMBfmWnOdlQY9N739+77NuPSGwKTPYOcmljTyrLa
	++ECelrpMwUqikflIMNGfFvIdX38VgdJJV10/RDJz//lzsJhreC4O6Rqtof1bX97ik9xrmkM5xc
	Xck14+KOyjyWQ7AiM1qosOrS062jk0wudjUx1S7XSfHA0QyXoTFEKkTpuDmAFc/ycNiH8E5mRoy
	JUVhtMpDU0pJ0J0Ve7QuVGsLkYikU37OVZvia58ayLBc0s3ZApXwNUYLm7oDRxmrqPxMED+kfkJ
	Gofqofbr3nMd+qR76dBHs1Y5sQ2Mzp1MxRqwLzSCItTtU3HDMi1NlVtevJIkWQ0CYIByAZxEqPY
	dmv0pilSqH8uxtinwntPQw9Xslvv4iQDx0HHXZqMl7BF2GecmZysSuvQ7BoKZc0mpmzNlmTItQ=
	=
X-Received: by 2002:a05:6512:ba6:b0:5c1:ac5a:52e6 with SMTP id 2adb3069b0e04-5c1bc865878mr898897e87.24.1795174150406;
        Fri, 20 Nov 2026 03:29:10 -0800 (PST)
Received: from gmail.com (78-71-189-157-no2450.tbcn.telia.com. [78.71.189.157])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0177f7sm491711e87.33.2026.11.20.03.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:29:08 -0800 (PST)
Date: Fri, 20 Nov 2026 12:29:07 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 0/8] I2C Mux per channel bus speed
Message-ID: <awAvA1rSGwh0RaIW@gmail.com>
References: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>

On Thu, Oct 15, 2026 at 01:01:47PM +0200, Marcus Folkesson wrote:
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

Gently ping on this series.

Thanks,
Marcus Folkesson
