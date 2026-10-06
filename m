Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6063750BC;
	Tue,  6 Oct 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278886; cv=none; b=EVjwrw/f/RbHOeZ5u77VPy+cQ52lhf/j3ZeqjO4x6PJW7OH4NzVj0NX4lFEk75RRhYQ8vkDVnP4xAtejE0IpizYes3vI/I+hlQ2lUPuVHuvuUxK2SEtONTDC8QmiDxQWAsBYx8ki2ogDhJRrgQFujgZVtYoO0cBq6PExl+P156A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278886; c=relaxed/simple;
	bh=+FDaVM+iN2S6d4LlhnhZFZtqkz2EVNDOZrfwx7Ivk3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGeDBPk6F/DZ4PuDPpx7N6kuwxbTIzpjaP9bNHL2sC4TlDJliT/0GHFpS4ODSHKnYcb3oOQT/RMDvpxw9kP7X/xIfkhWRrihOBN2pyExWUsDewU/I1dxyOTjFPjddWlS4QdYosfAQ4uQTQgW1FhGQaVLSuij1R9uThmD5tmdWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/g7hcLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/g7hcLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015361F00898;
	Tue,  6 Oct 2026 09:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278884;
	bh=aFfRik6ofX2MimsXUIjUnGQ1h4GtCfo0fIPNLZE0cwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/g7hcLT6/z2TxB/35QnTnfOF00uR0EMe5WoZajEwktcwzQbEpxxIgdQtxajOYw7r
	 bexZ0ALMvZs/7FP99hVteatwKpapTQg8LS4T6/y0NIBkFcm1cMWadCt6n2zrOpz2rU
	 jAl4cn4VpNJGLjSx0qqRSZSEhnlszt3fWTMRAn5fHh0fIOH9yrW/lL95PCekb7DRoy
	 2wdO8z/2DRsIfAPE+AtctbAYLZ9QjxsTtm5jspyM8xnsi2PRa1/a2vwZz341OEnx4y
	 kw94OsUK/Ka+7uAM4rHZyBd9ZoAWs9kELNwfuMRtbF8A/jCF5yd7ki66XMlwd5ysRj
	 U0C5dKPiZ7Epg==
Date: Tue, 6 Oct 2026 11:28:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] i2c: qcom-cci: Handle and report queue
 overflow/underflow interrupts
Message-ID: <asS-ppSQ3zHjjVBs@zenone.zhora.eu>
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
 <20261004-cci-imp-v1-2-227d12cb4829@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-cci-imp-v1-2-227d12cb4829@oss.qualcomm.com>

Hi Loic,

...

>  	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK)) {
> -		reset = CCI_RESET_CMD_M0_MASK;
> +		reset |= CCI_RESET_CMD_M0_MASK;
>  		ret = IRQ_HANDLED;
>  	}
>  
>  	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK)) {
> -		reset = CCI_RESET_CMD_M1_MASK;
> +		reset |= CCI_RESET_CMD_M1_MASK;

these changes are independent from the patch you sent. Can you
move them to another patch? Probably this part can also be
considered as a fix and if so it can be sent separately. Right?

Thanks,
Andi

>  		ret = IRQ_HANDLED;
>  	}
