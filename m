Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558E32AABD;
	Wed, 25 Mar 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458658; cv=none; b=hh3oNfRR50IM+DVgDev+wm9LB0ad9gUGQcwE+xbPUU5H8ngBRlvFwhd+X/PHV0tf7ayUtZjRDz0ZreOLwzSuEAaHeqrVgN+d1BVO7x0Mpjfhf3I6W54T9Y2Bmtuu1fmOgyXVEUw7vrou+Rs5c3j39oIovF+hMEHRnm/PHzfWDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458658; c=relaxed/simple;
	bh=J+Fixd0f//mIuFaOL58NS0MH0mJ6VNSO3vzD3qkldRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9cLasObwciJYwGZ25MBb0vUgxbyD5sxImRmcfWa3bYYbKpjYpyX+X0zjqQxiAZADZ/uCaze2S/u/2guv8QGxBr+TYz7XmsPW0e3NQPkzqHURzsv3kUaC5ShT4kxxB8nYWJYrZNc8dVlSlBId07n0LbKSz/s2b9jSJbme7LLmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/XxSy7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/XxSy7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6056EC4CEF7;
	Wed, 25 Mar 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774458658;
	bh=J+Fixd0f//mIuFaOL58NS0MH0mJ6VNSO3vzD3qkldRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/XxSy7yiwi6qFJSeCZh3XxrBMcvVic+FhJJZ9QBYdnEtdhE6PuBBxYuo4kI5U2IR
	 n+AwZ4kFbA3DNnCnYbiBVhm0tr2vKhFkCgfPNlWFhOFduz+ScdzaqAqQ0YpxzHEnE1
	 eeBs2SXLbb1eBvsX63X6k+gxtpMkyI3L02k8UXdVewnZdzHJ4NF/GQ9P6oA85c3iuz
	 pz/h5z7KfVXVvXqeROXwzscBsfmCUo+WHw+jfv2a0xa9p23HriEynaQIDIEyTk2/qY
	 h4mzVKYKCVj4JOgn2fdvT8IW3ikZjsb643cjEwaUlXJFekpp8R10s6SREGUk4sV4fW
	 5LtHZGrGzIaZQ==
Date: Wed, 25 Mar 2026 18:10:53 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 1/1] dt-bindings: i2c: dw: Remove unused bindings
Message-ID: <acQWy8e_Eqm6ANI2@zenone.zhora.eu>
References: <20260224115210.3499191-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224115210.3499191-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Tue, Feb 24, 2026 at 12:52:10PM +0100, Andy Shevchenko wrote:
> As stated in the d70f60ad964d ("i2c: designware: Remove
> not-going-to-be-supported code for Baikal SoC") the Baikal
> platforms are not supported and the respective driver code
> was removed. Remove the currently unused bindings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

merged to i2c/i2c-host.

Thanks,
Andi
