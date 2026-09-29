Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA03C3C0E;
	Tue, 29 Sep 2026 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664669; cv=none; b=hqruFCVClamoYS9Pt+mxl0IpyneMvCNpR0G+n8jDGLJKbSG58p83qNkbIW51e3BY/ApFZd7vcRm3AKKKKsi2L1MBaL/nFQHblI80YAzg+B1uynk9p6emF0hnDVf7xtHMMnV2gXujpaYfIIw4yjs1lPLzUCiuYyEAJFYaJzy6+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664669; c=relaxed/simple;
	bh=vXpHRvu70Ka+FE2fOwV9HdPnPUEKtWkGB4XtB/8FEo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu5wEAnK8Ylj3L5hnYLCBqx208TfugSLgtVkf8ip1pmOc6ELEoFCzfST7iR6rNGx6GZswQLHHgoXzG8FPNoFXtNNXiwChO99rY6KHumdMIkoVumWqN/XT4c5NQOLzxOAUByjRXsJjD+xeR8jhrsTrySQ0ayRsv+U/i53ijO/iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK4Q0Msa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK4Q0Msa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CAF1F000FF;
	Tue, 29 Sep 2026 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664667;
	bh=uBQRORZwHEdmDKq1aBSs+AkkjqUUpybWWiuScQR7bwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dK4Q0MsaxmSDmjcQs8sCFAxvTEUG7S3FXhDNZQf9GefTsogTih7JUqnXu0cAffPcu
	 L5QqnLuqKXFA3SUTKWfP6rVpJiVmQHGS8Wh+GQU7hvQRL9i6YIPhcsa4HdEo4nRjik
	 92bFeGw+JAuuKIOu1bXjBI7ErWOk45Eer0EihbZEyd083t1J9CwVWwhE6fe0C3rqCP
	 AAd6KjeD9E52qva8SohIigEl+fAm1pLrNqDs2/6CIDuB9s4XAJY/pbFkwf8f4//S1f
	 zjbpenCujxGbzauGLzjDQMuxAOsC0BMMXfZOgSImEIRkkxkgDxG6NkyCRPR03WNBd1
	 5pWz092oV4oiQ==
Date: Tue, 29 Sep 2026 08:51:02 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
Message-ID: <arsBbE0UXtGKQQqS@zenone.zhora.eu>
References: <20260920-i2c-qcom-slave-v4-0-f7e1020f3bb4@oss.qualcomm.com>
 <20260920-i2c-qcom-slave-v4-2-f7e1020f3bb4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-i2c-qcom-slave-v4-2-f7e1020f3bb4@oss.qualcomm.com>

Hi Viken,

...

> +static void qcom_i2c_target_write_requested(struct qcom_i2c_target *target)
> +{
> +	u8 val = 0;
> +
> +	if (!test_and_set_bit(WRITE_IN_PROGRESS, &target->status)) {
> +		dev_dbg(target->dev, "Write phase started\n");
> +		i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED, &val);

It's the second time in two days that I'm reviewing this:
slave_event can fail and when it fails we need to nack the next
write requests (check slave-interface.rst).

> +	}
> +}

...

> +static int qcom_i2c_target_reg_slave(struct i2c_client *slave)

Please, use the inclusive name:

master -> adapter
slave  -> target

> +{
> +	struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
> +
> +	if (target->slave)
> +		return -EBUSY;

...

> +static int qcom_i2c_target_icc_init(struct qcom_i2c_target *target)
> +{
> +	int ret;
> +
> +	target->icc_path = devm_of_icc_get(target->dev, NULL);
> +	if (IS_ERR(target->icc_path))
> +		return dev_err_probe(target->dev, PTR_ERR(target->icc_path),
> +				     "failed to get ICC path\n");
> +
> +	/*
> +	 * The controller only needs interconnect bandwidth while it is
> +	 * powered. The vote is placed here and across resume with
> +	 * icc_set_bw(), and dropped with icc_set_bw(path, 0, 0) on suspend
> +	 * and remove, so the vote and unvote are always symmetric.
> +	 */
> +	ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
> +			 APPS_PROC_TO_I2C_TARGET_VOTE);

TARGET_VOTE is in bytes per second, while icc_set_bw expects
kilobytes per second.

Thanks,
Andi

> +	if (ret)
> +		return dev_err_probe(target->dev, ret, "icc_set_bw failed\n");
> +
> +	return 0;
> +}
