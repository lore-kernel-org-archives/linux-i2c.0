Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582022D29C8;
	Mon, 20 Apr 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698231; cv=none; b=iY/B5tnxA7PQ59qRK30ID9AId3Tbf80CSlH9yGBxbvUM5Bnjjdd2Sz+txt3C84SaBYlfkoPMj36yUWbAiDi8W3HalvswohYPLuQ1exJMG3XReEqqlPigSWI97cuvZi0fhEsh/FwPPWfWYuJQ3xgCh2f474477yURU9jBSpYkAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698231; c=relaxed/simple;
	bh=cMrO7NSOqWkd+iv/Hx6l1/mpbAt5aUoGtRjgH7qq52k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPhoWHtG9JiDH7tfR/bv6luJVj8mSbK+9p6RX2jUG1Naa1ZLAfDkaC5dFCQNmsZ6rKOOFI7QfdFsfw9IkRU9QETahBZ3TJGfUIVt6mNfFICA6C9+kpO1Jaz0Vs5D0uFmBYxDJ7cLixCnWUN+pgBPTI8hsVPmY/aNlvlf27drPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP9WzLkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP9WzLkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D607C19425;
	Mon, 20 Apr 2026 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776698231;
	bh=cMrO7NSOqWkd+iv/Hx6l1/mpbAt5aUoGtRjgH7qq52k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP9WzLkRwHItnvFWE6kA+xZ0czeUgTHGnrglr/HHwumCbD4g9KPrk/aOBUwcQP/fj
	 07ESS70W4BYNtK8+BIBMs5+7/dZEYYnNCd90OWZDFtfTihF8HkY2bdVDox4uI/Xsv7
	 QMXuJxYqAxcCiA9nuuJiYzPotsW2zN/agG5LCyx5H/8ZhF/4gCe2nrbeCaOH+vHtrv
	 S+fgYtCSSYg0wl623PudJQw7gquJFlHHi3/xrc2ZIR2O/oacmHU5q8v8JAQg9IvNxz
	 eC6CRahlN5SwkZxlIOdPGLp5O8fEhSu63J7dHX/gstynOs2HMrrrTUDGsEUQbiLgcL
	 LYC8ugjG9zx1w==
Date: Mon, 20 Apr 2026 17:17:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	jsd@semihalf.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: Use
 PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Message-ID: <aeZDTVCQ9XYWHDzj@zenone.zhora.eu>
References: <20260417075451.5435-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417075451.5435-1-luoxueqin@kylinos.cn>

Hi Xueqin,

On Fri, Apr 17, 2026 at 03:54:51PM +0800, Xueqin Luo wrote:
> Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
> to make the code look more straightforward.
> 
> No intentional functional impact.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>

merged to i2c/i2c-host-v7.1.

Thanks,
Andi
