Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38271C07F3;
	Thu, 24 Oct 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767551; cv=none; b=iKevdoMNq3W5ZtyPTE8jw4iHrE21+wjldFjf0reUqYMgOUv1lrNAiOck/QQe/GJyrmKRkdEaRTbvy2Dbayx9AarSjM/sfWKY6IGV5fcjpiaSvZtVp6+dWQ6+mtU/KSFscyghx/P48vX7AaMA51jCGE1mhqqBQ7G/1TnxcOECtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767551; c=relaxed/simple;
	bh=2SBR+T4K0WZt4+JORbA7vaUGCrx/PZpiNCVGUWyW6mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvuiioTU1X3YcAEQpmVFfVrLahtPqZOcXwQE9HPKJcr0zwJfMbD0anL6RMs86rBYycyURlxmd7scV9Ym2HOcDM4nJJun6LwXUXespV1ss9ZAi+0ww1oUzqXwKki4IQmMhNX/LVfoXK9yv3phPKc2RrlPLnfZUqmNRTCpHohjHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY7R9J5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY7R9J5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73468C4CEC7;
	Thu, 24 Oct 2024 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767550;
	bh=2SBR+T4K0WZt4+JORbA7vaUGCrx/PZpiNCVGUWyW6mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CY7R9J5QptNxkXkfSuh5WHIfXGDVwlgSgPum1CyjXaNhNRcx/wV/HNwTzLD45QsQE
	 x2iWEyuWQWhWqP+pHLpbt9QYv6UCzOGCJGYTjDiVA2GYmfUBz9g9HEQi/cNx+zQRmR
	 IiLmHqKGOXU1xOzpNPn0lBdFY/udabO7kbvzNuiPeyBznSt69/61+x9ZC9BtbxjNMV
	 +CDo1OfMzXewvbONTQPMH/mgpJp6rJiccd4z7WXYr/9gOL2fSbQAH4kSBCkyi7zN4s
	 Bf8MIQf4lFwGLgg9YTjjO3VMnizRucynb1hAJNlUpy2CAesy4atCMye+WuJGG/Ak+F
	 9rwhffnwuUblQ==
Date: Thu, 24 Oct 2024 12:59:06 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wojciech Siudy <wojciech.siudy@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, peda@axentia.se, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 2/2] pca954x: Reset if channel select fails
Message-ID: <rvgcp3h4jedrug3nfodbvu7sk4lxqen3tcpwk3zgkf5alidbly@4j6haxpk3vao>
References: <20241018100338.19420-1-wojciech.siudy@nokia.com>
 <20241018100338.19420-3-wojciech.siudy@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018100338.19420-3-wojciech.siudy@nokia.com>

Hi Wojciech,

> +	if (device_property_read_bool(dev, "i2c-mux-timeout-reset"))
> +		data->timeout_reset = 1;
> +	else
> +		data->timeout_reset = 0;
> +

For as much as I would like this patch to be in, I can't take it
if we don't sort it out in the binding.

I agree with the suggestion that Krzysztof has provided there and
I'm aligned with his comments.

Thanks,
Andi
