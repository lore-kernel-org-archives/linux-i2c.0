Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C137EFE5;
	Thu, 30 Jul 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403976; cv=none; b=f4i744TqxXCG6NShyj8u+3P1KZZNE9ko/+pH204UPFwP3YTDwYSL/7XYkV7b4OVXK/UByNpoa8np0WwiPQh42/KFuwG2DTUAe4K7fIXtaXviQxp5Q1h3qYcxhCcVJ4GJtsVQJGAHwMJuUQ89CJFvuxNfXIML6GgKPOdKpJWC5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403976; c=relaxed/simple;
	bh=KY8wq7dyLWyX8HNaHxfyyx1ZRFLvDavuKJDRo7nAwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awCuqxLZMWdqAAsRMt87SkLNdIGYz6B/lROzK8Fn73XHR4y5PomNPB9Ry9Ix1C5braYV2koPZ3qwrH01WB8/U7RAi4U5xtQ3oy1RlJgD+/t7xKJ/+Agtu33+cz4/6yq51I+bnbKmx+Ej00A2tuahqJQmxTOWaYFLa0QvXgutdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHo3ahTf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHo3ahTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD671F000E9;
	Thu, 30 Jul 2026 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785403975;
	bh=KY8wq7dyLWyX8HNaHxfyyx1ZRFLvDavuKJDRo7nAwsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LHo3ahTfwqzZ2IRXpAAHrhrggELSvwiUMrK9DlcRLuMq1VCFOCJkeXzZn7bxRFhIU
	 TYel4H0fCu2Ex9xY7AIj5QC2uTRY/wvceqiXVUjIwSgj0juMUrRoBOWzqCzjmxHp4d
	 et+0vF31TxObQ7JLl0LSjygih4rUGjOwcedQ+J/iaKus0ykZF0/LRYJD4hAlZm8ZIg
	 sXoFyOd8diuJQt2kAbqn6QlNlwOh0b1F6e/SQcl1BeE0NLm2P4Xxr7pGFbT3r5ch5o
	 IPzzN2m+QiI2HHWFbRPYXZsAhIs+XVLMg4tpAeguodXajRohigkHpF+J8hkkLbIgam
	 qsu21t2qiJXoA==
Date: Thu, 30 Jul 2026 11:32:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "Jie I. Li (Nokia)" <jie.i.li@nokia.com>
Cc: Jie Li <lj29312931@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] i2c: core: support recovery for single-ended GPIOs
Message-ID: <amsZ7o58e2ZzPUeO@zenone.zhora.eu>
References: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
 <20260511113726.49041-1-jie.i.li@nokia.com>
 <20260511113726.49041-3-jie.i.li@nokia.com>
 <amp0b2jpiV9VO9Pe@zenone.zhora.eu>
 <AMDPR07MB11191AB1C5459FFB55CA4B612DDC92@AMDPR07MB11191.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AMDPR07MB11191AB1C5459FFB55CA4B612DDC92@AMDPR07MB11191.eurprd07.prod.outlook.com>

Hi Jie,

> This is my first time contributing code to the Linux community, and seeing it finally merged means a lot to me. I truly appreciate your patience, help, and time in guiding me through this.

Thank you and welcome to the community. It's also nice to see
patches from Nokia :-)

Andi
