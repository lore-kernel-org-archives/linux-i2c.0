Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FC480327;
	Wed, 15 Jul 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129626; cv=none; b=GCi9Al6C+eS7IRhczthH9ato4FucgNIyLupx9+QfVeQQ7N8EyPii6IFkxcmuWJwkxQL8OQKq2KQIsMXoROZQJK20TX0IjigF56QtXpjNH76voO4uQwAzp3MAjN3lr9IC8/TLV3ghqKtWH/OLCooLMSlSsMPamfacJ9oT8V2cKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129626; c=relaxed/simple;
	bh=877oc9KthSIs1Vq4ao0Arfbx7rMfa6NTe/+1XkcL3So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkW521pExUGTvUGJjV1nwlu5I6Vtvnmrm9uEIxjlye57HNCpzWCjP5tJ2wiSOLQp/bH+oM+LteINEosDAiytl/RKED4sYS/BHpYltThpXvNb0Kn0lMrNkVpTbPY8o4CnNys1LSbdrtvJndEvnilR6RN+JPb5jSD/3DGULdfuAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS5aoRvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS5aoRvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346661F000E9;
	Wed, 15 Jul 2026 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129625;
	bh=Vpd+dJQWTkg5Ydqj8woGlViWdAiHeP+k3PYeviWupfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cS5aoRvuXcklt5WxtU9gUAmEQnLUaKI44BlyHKw7NKVf2XEhEAcaf6sJW/8OO4LOD
	 /ct9YxcrmumO4WSvFTGLCOZLJvZPtX/XD++vwFXi1FolVBU9ZAgDLxtxFilB5HgM4Z
	 X15oqS2Glm+V0lpAVO3LYMqTfCbOwsc7UrRyBcN6blM3kMO95PF+t1rUYM4u1oDUEs
	 4ud48a1UN7OmyPHfS+0Xb09Sj8ShjYmLK/EzJgRnu9kXxSptqDtls+XELjOAvmjVmm
	 qdER6UHD41vJYHr6ffEd22aEdR0Okb1f0B7JXuqXS8+N9OckCiE0EHfKb/D3VIMvqf
	 skM0CAMZ0GSzw==
Date: Wed, 15 Jul 2026 21:03:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	bjorn.andersson@oss.qualcomm.com
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
	quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
	agross@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	bartosz.golaszewski@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for
 multi-owner I2C transfers
Message-ID: <aleoVNavBOrF9r7O@vaman>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>

On 08-07-26, 10:40, Mukesh Kumar Savaliya wrote:

> +/**
> + * enum gpi_lock_action - request lock/unlock TRE sequencing
> + * @GPI_LOCK_NONE: No lock/unlock TRE requested for this transfer
> + * @GPI_LOCK_ACQUIRE: Emit a lock TRE before the transfer
> + * @GPI_LOCK_RELEASE: Emit an unlock TRE after the transfer
> + *
> + * Used by protocol drivers for multi-owner controller setups (e.g. when
> + * DeviceTree indicates the controller is shared via qcom,qup-multi-owner).
> + */
> +enum gpi_lock_action {
> +	GPI_LOCK_NONE = 0,
> +	GPI_LOCK_ACQUIRE,
> +	GPI_LOCK_RELEASE,

Can qualcomm people please align on LOCK/UNLOCK interface? This is
second interface I am seeing now. Can you folks align internally on how
clients should communicating lock/unlock across different qualcomm
dmaengine drivers

-- 
~Vinod
