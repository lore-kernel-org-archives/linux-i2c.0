Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1535F8C5;
	Thu,  7 May 2026 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155125; cv=none; b=tVMm8VFximKe73yPQBOHUq+9e+IUmDQYJYGkorl4IlkOi1cvipEOcKDaTUBvw6wx6DD6JPYtr/e3wEA3NV6pvsG6MV3ojdXlb+uUpPM1uiVUY4ZlYRloaLq4/pM/fWhjCCb+MKWg0HvM9iy/touMTTRlhWHJn78XAs2lYoSUlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155125; c=relaxed/simple;
	bh=vUIsPIYMAJAOvlRzXuXapUvmiBeujdGmTnJXfJmTsq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw8WPT/dvCYYp8kJGrk3fkKg79aiAUZawbmfAz0mn56bj2EOsRlpBr7xSJcX3zcpjtLlfm2mkZ90TMTMqZFYcvSTJcvezka0NvirxNfV9zBUKx0uNKbOFkvkZ/x8eDC75SSy1Yo52qiUCXkLJMHQhBqKy0a3YBUC6JuUWiikNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK84PsMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK84PsMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4030CC2BCB2;
	Thu,  7 May 2026 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778155125;
	bh=vUIsPIYMAJAOvlRzXuXapUvmiBeujdGmTnJXfJmTsq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aK84PsMD1OrE/h4S28KeZWVduIJoJq3YHDnh30OO+WoguHh2GGwRTrtwFij048hSX
	 BNkGkIIQUp4Kto5o1+/uRtgjS7tpOxm0NdXhShGEzvsEHH+G1h/38SnKWt02447Vov
	 qbRb2IVKIxHtICvnSLy9LfnBo6WLAsShGQBXYidbD+5vo2nD+i4rHG9zZ8m+6x2ILL
	 ze2Tt9OGyR6X5TwDe/psLcYvE8lLY8imOc+q6pvjgaXqe9dGhY/jQzPTHS6qdvWjnw
	 rjEpVyqhMOXiaC8CDgIH4r4b77dJV50o+WIKhMOiwsIyahGrPi22DlQc4mVwsxYUaU
	 4Lx3X5wCUxOOQ==
Date: Thu, 7 May 2026 06:58:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	thor.thayer@linux.intel.com, wsa@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: convert altera i2c to dt-schema
Message-ID: <177815512250.1119572.9279436421990255678.robh@kernel.org>
References: <20260505053201.5795-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505053201.5795-1-chaitanya.msabnis@gmail.com>


On Tue, 05 May 2026 11:02:01 +0530, Chaitanya Sabnis wrote:
> Convert the Altera SoftIP I2C Controller bindings from legacy text
> format to modern dt-schema (YAML).
> 
> The hardware constraints and properties remain identical. The example
> node was updated to use a standard 32-bit address space to clear
> compilation warnings.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> ---
>  .../bindings/i2c/altr,softip-i2c-v1.0.yaml    | 62 +++++++++++++++++++
>  .../devicetree/bindings/i2c/i2c-altera.txt    | 39 ------------
>  2 files changed, 62 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

