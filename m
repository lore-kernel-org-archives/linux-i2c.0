Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5018FDBD;
	Tue, 25 Aug 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637000; cv=none; b=mluxE+SUMyoeRey1x8dRdnFPnB+sNJw2d1il20/JTDerGcooH60ZNoOQTSiON0H71oHJwoiVVO9cttlWQDOjUp5lE2UCBVdCsBRjfe5GhFAgWcANBr6NyA4lb59UjvS30kVAGH5ii8ctqjLn48Wn+VM5MD0MSAb5ACIrIvdZHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637000; c=relaxed/simple;
	bh=OuzvMdlrUtoMM+BL9SQjO7RKKd/SGpKHd+7+Vt8MbI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaZoAehQeTilLPiESEd8UmSU2RNswtTqnQwnH5/C5AKHFBX3y8+gaey5DezqdT91/7LejxMuO5AyjZiUVMMjpoplh3mkNhcslzbFab5jDFU3yKpTuWU/fdM2u63tcxzzCSJHVVGKjGDEVucca9R/B/ffvs3SnfHtOy3OKhyDHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=J9tNaAU2; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=J9tNaAU2; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="J9tNaAU2";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="J9tNaAU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787636987;
	bh=OuzvMdlrUtoMM+BL9SQjO7RKKd/SGpKHd+7+Vt8MbI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9tNaAU2SbCyiniUxuAYzwXcmnzHd3t8S/jmMows50lbAOfAnw7cKpad27tnI+3mR
	 5+fhwOimjqw3xlGYO+aSoXtkGBs8z3To56oe6jsXSeHeAs4C4T4w8AyP0A2zmR+hTQ
	 fWxFvDRushd5YPFTlr24nIppDtlBx3cKkvC/R7WNTy4mJfVUC0xNCvGVbGbH1yzu4H
	 5rXJbWqbREPiOYJYMW153FMsgd1ZW40SA2fwsoJo5cZaTwjXvDlhnplk7xTWzHa1mB
	 E5rD5b+NTG9UzhpmbY2EB01C/0JECO0CvSH0310YeO8/otspYeJVasFP3VHWDbyPlk
	 rgokrEE4RRl8w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 753C014E33;
	Tue, 25 Aug 2026 07:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787636987;
	bh=OuzvMdlrUtoMM+BL9SQjO7RKKd/SGpKHd+7+Vt8MbI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9tNaAU2SbCyiniUxuAYzwXcmnzHd3t8S/jmMows50lbAOfAnw7cKpad27tnI+3mR
	 5+fhwOimjqw3xlGYO+aSoXtkGBs8z3To56oe6jsXSeHeAs4C4T4w8AyP0A2zmR+hTQ
	 fWxFvDRushd5YPFTlr24nIppDtlBx3cKkvC/R7WNTy4mJfVUC0xNCvGVbGbH1yzu4H
	 5rXJbWqbREPiOYJYMW153FMsgd1ZW40SA2fwsoJo5cZaTwjXvDlhnplk7xTWzHa1mB
	 E5rD5b+NTG9UzhpmbY2EB01C/0JECO0CvSH0310YeO8/otspYeJVasFP3VHWDbyPlk
	 rgokrEE4RRl8w==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 2948514F0C;
	Tue, 25 Aug 2026 07:49:47 +0200 (CEST)
Date: Tue, 25 Aug 2026 07:49:45 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] i2c: mux: Fix channel node leak on adapter add
 failure
Message-ID: <ao0s-aS8iPx-ofLn@gryt>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <b3e46bbee781b3cb4029aca9a71316cc5e36dc17.1787502619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e46bbee781b3cb4029aca9a71316cc5e36dc17.1787502619.git.ahmadexp@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

Den Sun, Aug 23, 2026 at 09:34:36AM -0700, skrev Ahmad Byagowi:
> i2c_mux_add_adapter() takes a reference to the Device Tree channel node
> before registering the new adapter. If adapter registration fails, the
> error path frees the private data without dropping that reference.
> 
> Release the channel node before freeing the private data.
> 
> Fixes: bc45449b1444 ("i2c/of: Automatically populate i2c mux busses from device tree data.")
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>

Acked-by: Peter Rosin <peda@lysator.liu.se>

Cheers,
Peter

> ---
>  drivers/i2c/i2c-mux.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 681a201c239b..68a4c34b5987 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -408,6 +408,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	return 0;
>  
>  err_free_priv:
> +	of_node_put(priv->adap.dev.of_node);
>  	kfree(priv);
>  	return ret;
>  }
> -- 
> 2.50.1 (Apple Git-155)
> 
