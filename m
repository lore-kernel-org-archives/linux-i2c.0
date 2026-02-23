Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192821BBBE5
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838636; cv=none; b=KQvI8fFGt34uuyVdFmqJJZDrKrDmh79nTmwY44ekxr2i3m9wpwAuKEppoD2z3QjBYZEyrQaj2TTYcBrELXu+UWuKTC0m3WNDvrmowIHFTwKDHyD59q/mX5io+vy4Fd8Z8ZslcGpzolZDN/WIvfGCo2PCTsmPChAaFOXbH7U6IBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838636; c=relaxed/simple;
	bh=J6N4KxcoDhhDYEAyq4h9XkHiHxllB9loPUXvQ5cEsXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iI4NBc6X+7U2vFkSCtIV9zqIJtWoK/wDxPzFuTdc45xpoMqqX7ygnLCbiD+Avvn4SVxpcoyklgNCkQ559JU2vPMlFbCWBhaXgnI0PmLdBlQXG2P6GhqPyjspwywFwQfjJI1v24gNqDxpN0xv5L+ddV70QJyVnT5pZdVVbF5jaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNTUNxZv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNTUNxZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEBFC116C6
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771838635;
	bh=J6N4KxcoDhhDYEAyq4h9XkHiHxllB9loPUXvQ5cEsXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XNTUNxZvUB22dZMssbqwvAfkeVKJes2z9+w6GOGIZFa7gXS88r2nUQIymoNv3Jyxo
	 V/4YKl633zbG9UUDq37621PWSawwz2/viUOzBfM68hQ7cfi3LxoyNwhxy160fr4xZy
	 X5XUSFYjkQYuCMVhbiupsxG44oo8Jjb3fn2f2MqBMxiFwlFSprYL2WBpe7+i2jHMtv
	 1JJavnXW9gGz+19RBhtkdIvQmVCg1W5hTsFf6AuRTYVJedZYZ8yPzBJ4Enh8PLthyf
	 wlpSjBUQwSYd2DoY65AC/NRGjsCCLztGBzSQqYbsNQPC+9ca6NJkS5ajCI5Eji7xwe
	 xWrJTvXoRsQJg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-385cfc572f1so31828641fa.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:23:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbMHVSQtkWpsbemmg4N1rUO4X3v/PpSS6gvnie8luvb7LIAKerXdxqNmJdJcByvwM4NDCGBTQahRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFQyHOh8GH8gU2AjwhWRGtiJMdh3nGUJy90mnRw5vNOpElm3g
	0mi8LTsqlZmBYpG+YlqOUzvByrYnnvYHrj6RYKbhrTT7V6iFT+pN2+A665JjdkRvh/WTGPG8yuC
	CWeZukNDXcqhO1jX4ribXTCEEZEFyeX9TkgQF8HWbxw==
X-Received: by 2002:a05:651c:211a:b0:386:9653:5d6e with SMTP id
 38308e7fff4ca-389a5e6e093mr27978651fa.34.1771838634370; Mon, 23 Feb 2026
 01:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
 <20260223-i2c-adapter-dev-wrapper-v2-4-d02946569773@oss.qualcomm.com> <aZwaV8LdexyU5jil@smile.fi.intel.com>
In-Reply-To: <aZwaV8LdexyU5jil@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 23 Feb 2026 10:23:40 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mfebg2+o_wUGQaSv+yUNgYJgcJMA_Z4_K0NKEi-cvfWvA@mail.gmail.com>
X-Gm-Features: AaiRm50hqFTn_wQ-AS99oYlYnLIOJFFjUCDzWq-nthCucdMeN0Zoo1JoZaAVJi0
Message-ID: <CAMRc=Mfebg2+o_wUGQaSv+yUNgYJgcJMA_Z4_K0NKEi-cvfWvA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] i2c: mv64xxx: use i2c_adapter_dev()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>, 
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, Hans Hu <hanshu@zhaoxin.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 10:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 10:02:52AM +0100, Bartosz Golaszewski wrote:
> > Use i2c_adapter_dev() where applicable in order to avoid direct
> > dereferencing of struct device embedded within struct i2c_adapter.
>
> ...
>
> > mv64xxx_i2c_xfer_core(struct i2c_adapter *adap, struct i2c_msg msgs[], =
int num)
>
> >       struct mv64xxx_i2c_data *drv_data =3D i2c_get_adapdata(adap);
> >       int rc, ret =3D num;
> >
> > -     rc =3D pm_runtime_resume_and_get(&adap->dev);
> > +     rc =3D pm_runtime_resume_and_get(i2c_adapter_dev(adap));
> >       if (rc)
> >               return rc;
>
> ...
>
> >       drv_data->num_msgs =3D 0;
> >       drv_data->msgs =3D NULL;
> >
> > -     pm_runtime_put_autosuspend(&adap->dev);
> > +     pm_runtime_put_autosuspend(i2c_adapter_dev(adap));
> >
> >       return ret;
>
> These two changes are in the same function, perhaps temporary variable
> would be better?
>

If all else is fine, maybe let's do it in a follow-up?

Bart
