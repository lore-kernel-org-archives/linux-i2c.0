Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24643A3E60;
	Sat, 30 May 2026 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780143914; cv=none; b=HQTa5Ii4ZpBJPSDWPZqemLzfB6cPsF77bCnxM4LnnoX/DQJpb8T36EEdMWThJpaEd6WHCRt7aDK3+5Wxcp9laCkZq6prwbFJM+5TKsirKY8rGXvzV5ZmBG8d9sVqCs6uF7mrSW8LHUAU6r5zpTd+lghfIoEdCMZpbnj7Xgzcr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780143914; c=relaxed/simple;
	bh=pCreY5BDYs1VNX0h53/4/qHnUcuVUDcBBLsNhrnNWYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8kDsw1MeSM04fQp3yRyL27rYSb8FMOmOYv4pu2crCQUxlV6udHIpiN4BadGhWe3WvaEEdg+n6RriS5ERXdiXkM1iElFDmQukeR6glXXoYHAhk+d7iWgUkJ5xoIzTJVRIEmnaXI29Emy38ymsP8ySJZ/nE8Tvs157NjWrYHK27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg+2TAog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg+2TAog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCBC1F00893;
	Sat, 30 May 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780143913;
	bh=4vAmlWChkww+ThKj48uG4WHYxFxUr47oPHdKT+VoLcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qg+2TAoghTA1etK+/s5cZBdaXQtWVODYA4IiO60Nv+ZCp+fBEhchllHe8xtqKAFiK
	 UDD/ClnVWgkP8Olx8cHtvAVX+QpyMKC8JUL5LpXrNhYPTRTlf4jDQ2zF/vtKs3015n
	 oLGEa+TYMKP0Ge2EheAWPLq0vzJQWt0UAS8o8JnaVcjlTLtMzAYcmVKYfccVz3jZvi
	 InOgvf3Blw9Dsk/Y1vlzhm9XlGA2nNXGptqbK7e6CBFrKb6CHbAGKhAH3g0bMhfdGi
	 qXr0LZqnAcLFxDvsC3LUV04ujOYUTRTwwVXA1MSxkoti1NkeIlvUGIistufApuzvQ6
	 S7bO73/HXwIXA==
Date: Sat, 30 May 2026 14:25:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Suresh Vankadara <svankada@qti.qualcomm.com>, Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Subject: Re: [PATCH 5/6] media: qcom: camss: enable vfe for Glymur
Message-ID: <20260530-undetectable-caribou-of-development-2b1241@quoll>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>

On Fri, May 29, 2026 at 08:07:25PM +0530, Vikram Sharma wrote:
> From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
> 
> Extend vfe_src_pad_code() and vfe_bpl_align() for Glymur.

Why is this a separate patch? You already added Glymur support at
previous commits, so WHY you are doing more work? Where is it explained?
Your commit msg must explain WHY you are doing this, not what you did.

Best regards,
Krzysztof

