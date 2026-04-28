Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37530CDB6
	for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363611; cv=none; b=K7wWxNFQF9TTOBip3ngKmRfS7KgiU2SZvmijkjHYv8C6wjQDe9ig9/sj9yay2cpm7aIiQGcS5cKIo/J4nWAsKD0hpnx0piBWLAx5HEt9angk4GCTNZDBgxdweCWa/iRqZa6gOmQzIm6VhG3Py6sWieTM5r7Dv2BrRY3qkTuRgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363611; c=relaxed/simple;
	bh=ZDA8d3gNgiUtPzMmZx/qyYCLHLlMH5wOeZ/Eg7ZY/tw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXa9IDpxA+b8zOmRYse/w28iNIeEvEeUWZ3ILBlMimFV5e5sExUBtCJ3PhW/tmp+ljyIog+wkZ3QvPJPZ+zpjrL00Pv1L9Yo/EiZJ9cyXDl8CFeCy3aZ0vNYmPDDzphJdORDnpljPXYslV5ZNPA4iYB/J2xWc8S5L/DAQWBmYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDxq41bk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDxq41bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8AEC2BCB8
	for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363611;
	bh=ZDA8d3gNgiUtPzMmZx/qyYCLHLlMH5wOeZ/Eg7ZY/tw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=VDxq41bk+5oz4SvrdXxS/FV1BTMazSlqDzOkLC1U2ZkXHQXB9BEpwQJojtd0/XFOA
	 FwrAWOvOzkmw40zCTpvCHJljeO/NWR4+Sz3/J1U2DyyJkscPy6uCuUFAt1WBKTkWAQ
	 Y7JH22mN3HglGogOZkRllqHiAsJtKMHSiK0vyw2IB/r16CTyY9josgK5+m9lrE/Ahy
	 UvHpyyPMRoGYjXYvzzsvPypdVlGrJT0l0lfsK5OM3VWa5wBawIP50r9SR2YC/6z7Wf
	 yjiP5qPM5+9noyvd3+NHAMH4fRmUWPN/uaRI/cuyaeWq/sFPObOHY2BuErJsO2LUiI
	 ZRMxMqMjsAAuQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso10959258e87.0
        for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 01:06:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/an0NSfg4kMaifv1HlqmJPCA31V6GYIsEZwp16aUc1Nh+tCFK3ZKGPquXW8Q9ucd1eA9jjFTlRlGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAfcOWfhEZdqky+H96ca+jg6Sr0Wh7megUx8s6NUzW+BlBkipD
	cav6fuIIkvh5vImHrqvG7TpxDGakqQqQYa/L2ovCP5RAvdPp2p3q/3d78QevwehtAqwS/gXLpVg
	BSF8ZM8DiPdx8MBk2P26NhYhy+5fFDnbDrsdw9SzE7g==
X-Received: by 2002:a05:6512:1247:b0:5a1:1de6:bc66 with SMTP id
 2adb3069b0e04-5a7471287d0mr528462e87.18.1777363610049; Tue, 28 Apr 2026
 01:06:50 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:06:49 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:06:49 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427152003.26778-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427152003.26778-1-marex@nabladev.com>
Date: Tue, 28 Apr 2026 01:06:49 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcq0OX87jwRVtq5vrnWvt-DC5trY0uSAL329SJENwhu8Q@mail.gmail.com>
X-Gm-Features: AVHnY4KaOfkQP59M7p91oxim5tZnU_qREt-VIP5EikFBQrbvUZuWOPqd6MgOtQI
Message-ID: <CAMRc=Mcq0OX87jwRVtq5vrnWvt-DC5trY0uSAL329SJENwhu8Q@mail.gmail.com>
Subject: Re: [PATCH v3] nvmem: core: Default to read-only if wp-gpios present
To: Marek Vasut <marex@nabladev.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 17:19:29 +0200, Marek Vasut <marex@nabladev.com> said:
> In case the nvmem DT node contains "wp-gpios" DT property, the device
> currently defaults to read-write and the force_ro sysfs attribute reads
> 0. Switch to the default read-only, which is both safer, and aligned
> with eMMC HW BOOT partition force_ro sysfs attribute behavior, which
> also defaults to read-only.
>
> The adjustment of nvmem->read_only value to read-only in case wp-gpios
> DT property is present must be done only after the device_add() got
> called because device_add() does internally call nvmem_bin_attr_get_umode(),
> which configures the permissions of 'nvmem' bin attr based on the value
> of nvmem->read_only that is only parsed from DT property 'read-only',
> without any adjustment. This way, if DT property 'read-only' is present,
> the 'nvmem' attribute is always read-only. Otherwise, if the device is
> writeable, then 'nvmem' attribute is writeable, and nvmem->read_only
> defaults to read-only, but can be switched to read-write at runtime via
> the 'force_ro' attribute.

This slightly changes the behavior for user-space but I'm willing to give it
a go and see if anyone complains.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Bart
