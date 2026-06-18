Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4E800;
	Thu, 18 Jun 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781741471; cv=none; b=qPB/iURWzgK9h2T2HmXX0l6LZmebVHzRznjSLy6+bX4VVKvwc7nJAYngnb/wJm4umjzfpXD1Xo3hjZUoLFE18o9Ei4nuTlLliNtK01MC87nJggKrxkbLlGc51DoZ9kL0Qfvh1b1P3Z+jstrYGvEoZMiDQ0fAtfXs3+QnuELURJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781741471; c=relaxed/simple;
	bh=dzwf6C30U+S3XZlPHCXkMqhVx4umM5UNhj73oBkRKrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyZ92eWGoTVOXk1pt7HZCnV3wWKiUSmAGRnmxMeia2H7lGdzPlfg6o9VDWVypuzIwgeADmn5/oxga0bJYetK5z14W7WqOqziRTzpNswqi/I0u4DjMZdSFpNoQKPCq1i9sfydSQjl79RFokxMWNLYyLUsZxyczDgPdWXn7kunzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac+2uviU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac+2uviU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D0A1F000E9;
	Thu, 18 Jun 2026 00:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781741470;
	bh=BthPJgZpS1+N4wzOR0iD8v+QR4QpG3XPDyaK2/42WLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ac+2uviUL8lBCBMVEfaABvD4ML7bAXbfqi03SRHtS43JdZpuIdcBX7XSLu1DwOtbO
	 SSFvg6lQqWd9pGQojIeu7mWJxqMpegjbgEGXlJ8EEX/FSsDzsWzilhaxDscDuGWuz1
	 NwJi8qgEqOkYKbigdvZ+8P7HNvmzSAoT9uSkKxQXNmfm9erfYGwgUTB4SSD++n3ri2
	 Gaqccil4QlJqaUdG6bg118KJD+bZfi4FQlxkRHOiNE+dVhnrzrxzFZCQqXQgtFGCEy
	 +URqrzHA9EQLodhdLRZBMDOi4H9lV6P55Eno7Kn3/I0QAHr2eNKmGj0oV5ThZsCp3v
	 YxY0kliYWm3Pg==
Date: Thu, 18 Jun 2026 02:11:05 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: wsa@kernel.org, thor.thayer@linux.intel.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: convert altera i2c to dt-schema
Message-ID: <ajM3eOzcq7g_VGjF@zenone.zhora.eu>
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

Hi Chaitanya,

On Tue, May 05, 2026 at 11:02:01AM +0530, Chaitanya Sabnis wrote:
> Convert the Altera SoftIP I2C Controller bindings from legacy text
> format to modern dt-schema (YAML).
> 
> The hardware constraints and properties remain identical. The example
> node was updated to use a standard 32-bit address space to clear
> compilation warnings.
> 
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>

merged to i2c/i2c-for-7.2

Thanks,
Andi
