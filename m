Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8743F1068;
	Fri, 28 Aug 2026 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880968; cv=none; b=ZZEEmSI2lHBDLaLeVtGxu92dKhU2m5FaBdC4nxG84VijwQUx5yMUKXiNVsxP2DXylG+ZCK9bWqXA1X8YNrFyTOIH1s32+Vn6JVG9ue4QXt7mAOmgLNFWXICln9KrDnedGgkQVeSV3RUKS0HOu+YaNLWRKTCfjMJoJgd2coqao5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880968; c=relaxed/simple;
	bh=cmD4IfNkIubo9LfEExdxT4qTNPowsijyfjrUxVjx41M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M65+CYcdqXhQ6I8pgpyKRSPf2fTesyEl9oCRcAQGhy2XPVUgYKlRmGJpy7uVLjbNxLyDWRU72KwX3zJ3upvVK2rOTa+XinzwO0DHIG5vSxByggk9SdLZj6HhB9QgNUAunu521uFKa5LGlC8K0eyHs0EmE3sugE/dWxQWBAgMVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ/wo0f9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ/wo0f9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DC71F000E9;
	Fri, 28 Aug 2026 01:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787880966;
	bh=SExHLqe19K9p1w4VWjQHYXiMs6eC/S5BMYQdZ7GA3XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EZ/wo0f9KUSOVbsg6+1SGPYVYi8JEI9pJONHq1lMYCLJ4mIbs48y36gGJS/Wmv6ky
	 wYjCo5/bejfzUXaVrsURuzrWAj0XJ7fEWWOzhT8RYWUo6gITZuF3ffWf4DtI9nz8LK
	 9QbVfhEUt1y3VmrIJKvRM1ytjdePPLcaKmY1mYZ4mJbkiy99lIWBfJAQKeB/1Gxl7x
	 usV+icCYfyBvY6dj0rOyQOR/6vX4Zc+zNtZSUUFMF03KsxB9L+BfHNPVaXHI9DrxzI
	 vKyt59CMt1i0V/pZFvRIEwd2VK08JRjf1iSSTfKyYCaayNEAsmisM3V4FRJ0KMtNUP
	 uQtm6VXqv1h9Q==
Date: Fri, 28 Aug 2026 03:36:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] i2c: ibm_iic: ioremap with platform pointer
Message-ID: <apDk6f_tCwURgNKW@zenone.zhora.eu>
References: <20260821230217.319418-1-rosenp@gmail.com>
 <20260821230217.319418-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821230217.319418-2-rosenp@gmail.com>

Hi Rosen,

On Fri, Aug 21, 2026 at 04:02:14PM -0700, Rosen Penev wrote:
> devm_platform_ioremap_resource only needs a platform_device pointer and
> calling it early allows handling potential -EPROBE_DEFER.

Please improve the commit message as suggested by Markus. Please
use the imperative form, it's not just a formality, but it helps
understand what you actually did (I'm using the imperative form
here sothat you clearly understand me).

Besides devm_platform_ioremap_resource() does not return
EPROBE_DEFER.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> @@ -751,9 +751,6 @@ static int iic_probe(struct platform_device *ofdev)
>  		free_irq(dev->irq, dev);
>  	}
>  
> -	if (dev->vaddr)
> -		iounmap(dev->vaddr);

I think now you can remove linux/of_address.h

Thanks,
Andi

> -
>  	kfree(dev);
>  	return ret;
>  }
> @@ -772,7 +769,6 @@ static void iic_remove(struct platform_device *ofdev)
>  		free_irq(dev->irq, dev);
>  	}
>  
> -	iounmap(dev->vaddr);
>  	kfree(dev);
>  }
>  
> -- 
> 2.55.0
> 
