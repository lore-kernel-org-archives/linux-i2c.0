Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50037F755;
	Fri, 28 Aug 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936949; cv=none; b=CIne7OAFQMe7NAOeAvG0oBquR/RRWpiSB/TBu10xrzrn727q6BvggUSI0hHFkHYyC6Os6be07S90k3ZVydd2zU55eBlxpS6v8cCryar7DtsIe9TaGu/81Dm+tBSBVRav8RLSRbaVJZRn3hsM/QGCmW7Rxtm5gsu4ZSPAORYpF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936949; c=relaxed/simple;
	bh=ZPPVJx+rjhjdeQNkwIhkAC1XkBqfOo7fnWfZ6wkhniA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0mgod8vbs97MKgYVMBAZGlENe78DzsIHurXKWbajPTLLCRjf8P659F7pRkrADR+1NIAM0IUOXARiY4fIGzCqIZ8lVgC2yTAX6x9B2TOx9nU6T01dgct/Xo1udVfy+fWdZgtnaERWx4AoAM1wGx1FAwp0cuhw+BpYskwCjjuWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k53IRseC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k53IRseC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF081F000E9;
	Fri, 28 Aug 2026 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936947;
	bh=VfZpoKWHrwxWbdJxanGsvlN6gvN6ixXx5/O2N/Zzwfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k53IRseCXTW2U3uxW+gry8+/Cu3jmqzgHtf+cqYaA7z/PAr7OjKBvZdkzU09koUVQ
	 kEFNrMYeVVXxZ0yaBkXLScVvNKhcGWq6vFzuU8ETWQHCL7QsxcnMy4WejZYS1jRMrY
	 ambVjp9E5P5AzOXLXV7KK3QhaGlcM7mzpg17rnjA78/pdyx4659BHBTj4wh3lUdHQ4
	 menR5v5hTYWNqnKiWLbvOG6zq3IJsYa4T3bEt/rKFPNEt5gqEwziCQFx+qS9fsapKW
	 Du/rTV6QaixTNdkuh8Qo+ZK9m1M7Th6GZ3w6TCMhv45Qz07w3uJd7KhdO7E0t/TCe1
	 o1ykrInSOHeRA==
Date: Fri, 28 Aug 2026 19:09:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: bence98@sch.bme.hu, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
Message-ID: <apG_qiYtTQvt9s-y@zenone.zhora.eu>
References: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
 <20260818111703.19604-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818111703.19604-1-triet.hoang.dev@gmail.com>

Hi Triet,

thank you for your patch.

On Tue, Aug 18, 2026 at 11:17:01AM +0000, Triet Hoang wrote:
> Check the result of kzalloc_obj() and return -ENOMEM
> when the allocation fails instead of passing a NULL pointer
> to the message initialization helpers, which would return -EINVAL.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
> Changes in v2:
> - Clarify the commit message to describe the actual behavior change.
> - Fix coding style regression

Next time please don't send your v2 as in reply to v1. It
confuses me.

> ---
>  drivers/i2c/busses/i2c-cp2615.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
> index 951de6249834..c1275fcad636 100644
> --- a/drivers/i2c/busses/i2c-cp2615.c
> +++ b/drivers/i2c/busses/i2c-cp2615.c
> @@ -128,6 +128,9 @@ cp2615_i2c_send(struct usb_interface *usbif, struct cp2615_i2c_transfer *i2c_w)
>  	struct usb_device *usbdev = interface_to_usbdev(usbif);
>  	int res = cp2615_init_i2c_msg(msg, i2c_w);
>  
> +	if (!msg)
> +		return -ENOMEM;
> +

Your patch looks good, but, as you are at it, can I ask you here
a little effort? Personally I don't like and I find unreadable
the form:

	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
	...

	if (!msg)
		return -ENOMEM.

Important assignments, like kzalloc_*(), shouldn't be made during
declaration. I prefer the form:

	
	struct cp2615_iop_msg *msg;
	...

	msg = kzalloc_obj(*msg);
	if (!msg)
		return -ENOMEM.

Works for you? Do you mind updating in v3?

Thanks,
Andi

>  	if (!res)
>  		res = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, IOP_EP_OUT),
>  				   msg, ntohs(msg->length), NULL, 0);
