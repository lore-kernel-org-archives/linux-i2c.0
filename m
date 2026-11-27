Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775670;
	b=EutOetdh4AnqSmNskHbKqqNLaBf+smQHPEiYeZqRPmK9Ylo1v9YIRC7OCuN8DoEP4MzN
	 WLebpXrf1F9+EZUNMjO0yUspBKc824QTxXEFofbr9uNDztKLn9a3NYxfH48kxSJsycC3d
	 MImjz68M6qzdo/4vWK/J8kjHkKi233f0KchvCuHCcNo6TZJECscNimaFjUHkd40cPgk85
	 NFtxXzJ0x9tl3ttWmFkToHajMgXgPqlC++cKinGjgX01Ry5yqRN3QnlFdfq9iGRWs/bEe
	 N0j0PcQgnGHCC5xyqqvOSoPzvqbnrzvagUu2xK4IOWsz9p7x9P1SzRxm/Q5U1AIjB2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=co9eLkSrnIUrHAnR3EUmN2aodN2BuyJV+xq959NB99s=;
	b=cWQGWRq/2GiwcaS+Jx2+8J00E1Kfj2J1QX+3tsSzXKx4V1Xb+bimR5jj1LFxBAEkiFUP
	 3U+I2oz8hvjS57k4i3KYujKWIj9wC3d7cS8PQ717WMjWOj8uaRC1sQoKfLxLo5bUdf0R9
	 70mx1bQDGt2zUlIiH80jneIzRLruZjuU5xdMwD8s9QU7WQXYkP1agxvhRPBbsXfTTexGC
	 HmABpJFsz1pz2nrEYxxwUHbxaIZT0xz1CdZr8V96NfsXvlGhFBzPtFZcWFHbROj6dDgCX
	 EzTHQy3PKSRgtStB5UEUKLKpHFRTHsJVgBpTiKXuwl5apD2zjkDlt3y83Z9pB8TPO7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeVDyE5D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B4606A32D;
	Fri, 27 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeVDyE5D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75BA1F0089B;
	Fri, 27 Nov 2026 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775670;
	bh=co9eLkSrnIUrHAnR3EUmN2aodN2BuyJV+xq959NB99s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OeVDyE5DJxwJpe6DoaS8zgioyPviWAUDoEXvCQg3v7BjHyZgAWYuynvyV4a8xJyMj
	 vFeb33aJxbD/qVE0UPCMdq+QWokQtb2IKqInklfCBB6iUy0bygK2TOaebVUZ67+yjz
	 OUVC4l7QWaG5ZYXhVfXyGagyK13m98M9/LiB65UAsqP1fYapDC1JkDvsWXCSkmJ8VQ
	 MxuC0R0d5Znc0zihcKX22IvrBfJ2rkOm1yezvXz35xhidHbpqNWNcd66NlIoZv+bOD
	 lMH7/6+2v2fSGnyx83S6HJN4SLO38sBiODIpOq9HGJTh1be/gMBVxPfVE2JaL6MP5y
	 pe0A79svOHjuw==
Date: Fri, 27 Nov 2026 11:34:27 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Werner Gartner <Werner.Gartner@congatec.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v6 10/10] i2c: cgbc: Register known I2C devices on the bus
Message-ID: <awlcNer9mC8TlZ7d@zenone.zhora.eu>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-10-bb070ad3e9aa@bootlin.com>
 <awhwiHGeUFnTvxzg@zenone.zhora.eu>
 <2f73988d-95b2-40ed-bcd9-c93640d1b296@bootlin.com>
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
In-Reply-To: <2f73988d-95b2-40ed-bcd9-c93640d1b296@bootlin.com>

Hi Thomas,

On Thu, Nov 26, 2026 at 06:53:09PM +0100, Thomas Richard wrote:
> On 11/26/26 6:47 PM, Andi Shyti wrote:
> > Hi Thomas,
> > 
> > ...
> > 
> >> @@ -385,7 +385,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		return dev_err_probe(i2c->dev, ret, "Failed to get I2C bus frequency");
> >>  
> >> -	return i2c_add_numbered_adapter(&i2c->adap);
> >> +	ret = i2c_add_numbered_adapter(&i2c->adap);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Add known devices to the bus */
> >> +	for (i = 0; i < pdata->nb_devices; i++)
> >> +		i2c_new_client_device(&i2c->adap, pdata->devices + i);
> > 
> > Please handle return values here.
> > 
> Should the adapter probe return an error if we fail to add a new device
> to the bus?

yes, if we want to use it, we should exit probe with error if the
device instantiation fails.

Thanks,
Andi
