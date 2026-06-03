Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89880410D36;
	Wed,  3 Jun 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474533; cv=none; b=Vt52hO/B8DkMlrJy9lsi1yjGSpXesVqsaq8mNwJVsqG+NAp6XE88xVrvPlTTSHx/r1p+pegtrshzXM3QXItKi64GZRl2Ot6RtnTT6sHcw/50vdSSnL19N7bvs6pB/DSuPKWznoCYiWbtEh3jG8ED8S+FGN2+BC08e2emkeajRJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474533; c=relaxed/simple;
	bh=dbSzZ55ZNjIW/Mxofkm1oAf1jM6k08zQHRirwnispIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ezk94Pg/lnw1g6GX/cEB78ax5okLtb91duNyO+HtTNJicNyvRvvCg9JxZk0rYFRDXHH7LJ4OWyQdwEGwVkxXYadAT4wFGYXwGkEJrFzXTdb+0txfjc48r/sd3bskC8RVTn9+glPAx5wJX7QxQncwukMDLucu77+VEbzTlpZ1Snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEQsHp3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEQsHp3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50991F00893;
	Wed,  3 Jun 2026 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474530;
	bh=lTFK3xrb6w+CvNIaXMSpk6JN3iYDcj4BnaLUm3TXqfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MEQsHp3YWYuieNCwCStPEzDNHh4TczfpHBEsh5j9K/U9keE7tcPuiYwQPAuCa1ybn
	 8oBrvz/mS4idxb/1kN18x1pFZ/lQDcI8QeV1p/9kC8iGyQPWweyESdU1PkCzTeLXCP
	 Rmc24B5mXEIqn4qOwyShNkNZlW6fkwciyrI0U2GsbGoqXPrKcBcE8PpiG5I0/hU/Ul
	 316DiBVfz9nXE8WMwhyEIEpSkck2rihWqiF/996L7VGXsOks6xnmjxtMbihPe7LXDE
	 vWro23+6XSwJZfeQnhGrWWQPPulUZfu4C/pGlNrI4eXxXEx8X6aoqR0+wm7am0iUgM
	 Dt+P0YagdZ0bQ==
Message-ID: <63476872-b3be-4564-a748-74757130c50a@kernel.org>
Date: Wed, 3 Jun 2026 10:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: cpm: Use platform_get_irq() to retrieve interrupt
To: Rosen Penev <rosenp@gmail.com>, linux-i2c@vger.kernel.org
Cc: Jochen Friedrich <jochen@scram.de>, Andi Shyti <andi.shyti@kernel.org>,
 "open list:FREESCALE I2C CPM DRIVER" <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260603005455.226882-1-rosenp@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260603005455.226882-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/06/2026 à 02:54, Rosen Penev a écrit :
> Replace irq_of_parse_and_map() with platform_get_irq() as recommended
> for device-managed IRQ lookup. Properly propagate any errors returned
> from platform_get_irq(). irq_of_parse_and_map() requires
> ire_dispose_mapping(), which is missing.

irq_of_parse_and_map() and platform_get_irq() look pretty different, can 
you give more details on how one can replace the other ? (I don't mean 
this is wrong, just I don't have enough details).

> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/i2c/busses/i2c-cpm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index 2cb6a233d313..23679c192edc 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -434,9 +434,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
>   
>   	init_waitqueue_head(&cpm->i2c_wait);
>   
> -	cpm->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> -	if (!cpm->irq)
> -		return -EINVAL;
> +	cpm->irq = platform_get_irq(ofdev, 0);
> +	if (cpm->irq < 0)
> +		return cpm->irq;
>   
>   	/* Install interrupt handler. */
>   	ret = request_irq(cpm->irq, cpm_i2c_interrupt, 0, "cpm_i2c",

