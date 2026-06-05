Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3404C77B1;
	Fri,  5 Jun 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650937; cv=none; b=S/0dBhp2ab0tS/Y12doZ1qxKU3s110xh/ocKyvCZ6D694xGMpwOCh22xKb9zKBLo0hOPgQ7xOrHI769YX/XkT6ZdgUVecrBhMD4drfEteMlBs09jgKfDIH1MWnSTB1kGVAkapaoOl+Tb8tVDYZftANe/NauzF7Ep/H9UFBpcIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650937; c=relaxed/simple;
	bh=KRbZa4yH9SD5oC00vvBSsN4H15VKW/BBINcxhBiwbDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svvYVVRI/zM3NwIiDUdZQstwCqYLNlPhuWidqw6BU8FM+2f0s+d8nKWVROuHqSipJ6g3KdxYM8qnh2+MHVp2TamiYxGd69RcNs9jF7PFlRhcZD9iC2SUQgVbF/bVIBoYwz8sGp1FI2VMXylSmNl29y6+ILHBOYrlm79d0Zvyh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr/7eR4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr/7eR4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654561F00899;
	Fri,  5 Jun 2026 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780650936;
	bh=KRbZa4yH9SD5oC00vvBSsN4H15VKW/BBINcxhBiwbDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xr/7eR4FHFeVm/KiiQc65+cj13HnmMsHTNwzlHRrAdR25oNAAiwTpqp2qER4FIGKW
	 dPhnDLHRLzc4QYZyZ4TDyZO9RAPgT/3ENrggbVyuqi11t0TipDTBtwnTbgOfoPAuEM
	 AJePO1eNtA+evMRgUbNjXXEZzjfTfWdCEVYKvDhL5LNDgoc8T8lWsaVols9F4lT255
	 K5nhV+71mWP0jJN1sPD0lUl+U1brmu8xOzIAez5hIhYJSX5aKO24WFXHBPXzAVGX9v
	 uZ7J/akRTDI4S7VgHrLhAEcqbXlUgnpqHN0ZswNvkkqIdRlf13jfF6vypyVM69br8v
	 LIwGHd+sXWIRA==
Date: Fri, 5 Jun 2026 11:15:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Subject: Re: [GIT PULL] Immutable branch between the GPIO and I2C trees for
 v7.2-rc1
Message-ID: <aiKTSrD7GYCwrVDX@zenone.zhora.eu>
References: <20260511123042.64315-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511123042.64315-1-bartosz.golaszewski@oss.qualcomm.com>

Hi Bartosz,

> Please pull the following changes adding the gpiod_is_single_ended() helper
> for v7.2-rc1.

merged to i2c/i2c-host. Thanks!

> ----------------------------------------------------------------
> Immutable branch betweeb the GPIO and I2C trees for v7.2-rc1

/betweeb/between/

> - add the gpiod_is_single_ended() helper function

...

BTW, your signature in kernel.org doesn't contain your Qualcomm
e-mail.

Andi
