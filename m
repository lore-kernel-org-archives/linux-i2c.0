Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1103C2B95;
	Thu, 27 Aug 2026 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875067; cv=none; b=ZvoYFJNgOk91PAa9eREYPAm5VQd3Y4cFb+gyQnzu4gNexExUvIXdF/HQgtS8OCMvU/OEh8B5xwyqM9DcnWYk5k+hqyDd79VtF0e62ra4FP3lp1oqODTnHS6D8+0yq/kSzPgd3cFxXPqQGkhubi5ldMO8iY9OENUggIM6tQBTcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875067; c=relaxed/simple;
	bh=AeXBOWxzTaJfYER35sQedV/BBWNAZINVKknSLEFgUEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8E9c/OEyD3RkTALrGLR7uB6DtedGmJD9xarDvYAV0QnpGiNeIKvKgrWYX36rFIhEcI5wUXdpBzvDW5COrJthQe8BCG6OiOy3DPPbwxmQv0L4T8Oc2cbM5S4bmU8GDrX6Hqz1DzsIttsG+4XEDHBpZKWm7TYvFJTVmIYvgCv45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK/WQdyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK/WQdyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F41F000E9;
	Thu, 27 Aug 2026 23:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787875065;
	bh=AeXBOWxzTaJfYER35sQedV/BBWNAZINVKknSLEFgUEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UK/WQdyfU+4JSZ+kiY2Jm+/Aonw2uuT2D7a29KnjbRdRW3G/Vx7wLGq6lChtcq/Rj
	 VV5YgATlCSSWcBeFT7Tp892635fhpcfRsjaEQT9R1hN2Qn1SuRboU9jaorsCx8d1zz
	 THTyfyuW4PymOVUsmjpwQjh+hpTeG+xUre92fZBG9LN7WR7fhYFuhyO/zeJefoSbP4
	 Itus9CdzgvqM9DFmw5fgFKYnJHW0f6fvzpto2y7h1iyVQBGfrWcxcfpSaAzeK0zGxU
	 dEPffqVzkug54Jf+EIVfa3vX8JO1hpRZHjtV621PHQgX2/NQ/XIpbfLdN7Ehe0iLW/
	 uVRQ1tN7avyug==
Date: Fri, 28 Aug 2026 01:57:42 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Alex Tran <alex.tran@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: busses: i2c-qcom-geni: Use resume and get pm
 runtime interface
Message-ID: <apDOtUKlsgKl71tv@zenone.zhora.eu>
References: <20260826-i2c-qcom-geni-pm-runtime-resume-get-v1-1-25ee55d1f0c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826-i2c-qcom-geni-pm-runtime-resume-get-v1-1-25ee55d1f0c8@oss.qualcomm.com>

Hi Alex,

I reworded a bit the title to:

i2c: busses: Use pm_runtime_resume_and_get()

It's more understandable.

On Wed, Aug 26, 2026 at 10:19:26AM -0700, Alex Tran wrote:
> Utilize the provided pm_runtime_resume_and_get api
> to increase the usage count and call the rpm resume
> callback. Upon failure, the function takes care of
> calling pm_runtime_put_noidle. Remove the explicit
> call to put no idle.

I added here Mukesh' suggestion.

> Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>

Merged to i2c/i2c.

Thanks,
Andi
