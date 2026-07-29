Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161A2FB969;
	Wed, 29 Jul 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356459; cv=none; b=DDRtI5PBu5ymlQhY23kd9vxpid2VDR0wHfEp3BlhUPZ8spKoRiqXAOz72bK0y51PoAM0mLe+QKTJA7xUGt0LtkXDzFRgShvnuwDP/VAHSFsvZNVaeKK+1rWjdPautMEx9QKtU+ex5Dqze5YXEKwYXEfJ0pjsu0IdprSqkiwB8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356459; c=relaxed/simple;
	bh=N1j3k0mSua3fila/qEZNljaWOQpbTb3U3gHYqwUP7mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8iVT+guQqYAReFdu7atyePKItvXAaUAbMv2jQWK+UW4egx+Z5Jqhur8yG611AdoGQv5a0OYMbEmyuxR+JYBhHYO0St9K7IyVQ970yVh6KJTmlFogtXqnljBe5l88rHgYWhEJ1WqrF6Kmjmze6wlT/ulygKL7vrxG9tNJpzoHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeNTGgZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeNTGgZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03BC1F000E9;
	Wed, 29 Jul 2026 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785356457;
	bh=/aHV5Trwsz5ndMq9V474cyQlopxgVp3cZEvNn4Vu9vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BeNTGgZ+UYplmzOUKliU0StSxlWvwHCYJKkSCV8IarR1em5Ae59UcqyYRmvaYYq0U
	 xZGNfGbFQc5sOQYUvh9F8cpsWJwPc5A5IS1q7wwSI0s0Sz4MSOk0BReYM8soVCMQ/K
	 G5TBmz1YMeDS+6lQKlskp6sMIfrEkkx8AmcUTrf4wMEM4NDMlvOfp9YD0yRr4xFYal
	 nIZdjGxLzRvOpgrpixPaIbxdM3weHNHhNAUtc/bc6UFVl6E7u+/HVHe+T6cxAXBOne
	 bi3tkNvriOdi7kfEW8Y0NfGu3MddlC1388xvaHJZbKLwcKKF+vi8AJh8RmAjHzb8Yp
	 oYsHpxVnJytDw==
Date: Wed, 29 Jul 2026 22:20:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, viken.dadhaniya@oss.qualcomm.com, 
	dmitry.baryshkov@oss.qualcomm.com, zhengxingda@iscas.ac.cn, kees@kernel.org, 
	quic_jseerapu@quicinc.com, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, bjorn.andersson@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, Aniket Randive <aniketrandive@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/2] i2c: qcom-geni: Handle runtime PM disabled state
 during early resume
Message-ID: <ampZkhgF-3wk8hu6@zenone.zhora.eu>
References: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
 <20260709134623.1724212-2-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709134623.1724212-2-mukesh.savaliya@oss.qualcomm.com>

Hi Mukesh,

...

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 96dbf04138be..4bc00922cd97 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -917,6 +917,10 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>  	gi2c->err = 0;
>  	reinit_completion(&gi2c->done);
>  	ret = pm_runtime_get_sync(gi2c->se.dev);
> +	if (ret == -EACCES) {
> +		dev_warn(gi2c->se.dev, "Runtime PM is disabled:%d\n", ret);
> +		ret = 0;
> +	}

I have to agree with Praveen here. Ignoring -EACCES is not safe:
geni_i2c_runtime_resume() is not guaranteed to have run in that
case.

Also, pm_runtime_force_resume() already re-enables runtime PM
before returning, so the additional pm_runtime_enable() is
unnecessary.

>  	if (ret < 0) {
>  		dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
>  		pm_runtime_put_noidle(gi2c->se.dev);
> @@ -1115,7 +1119,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* Keep interrupts disabled initially to allow for low-power modes */
> -	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
> +	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq,
> +			       IRQF_NO_AUTOEN | IRQF_NO_SUSPEND | IRQF_EARLY_RESUME,
>  			       dev_name(dev), gi2c);

IRQF_EARLY_RESUME and IRQF_NO_SUSPEND are reundant. Perhaps for
this use case we should leave only IRQF_EARLY_RESUME?

Thanks,
Andi

>  	if (ret)
>  		return dev_err_probe(dev, ret,
