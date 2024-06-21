Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2510A39;
	Fri, 21 Jun 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986219; cv=none; b=eoXR+cC/uiq6GnnNPTH0Yr/LBT8HT8qDeoVwi5MDhEL3wezdNXI4hoYqTkUWMPOX6d0c0svDq11nBhJUaRCWJBrq5Od6j5pqfskQXjiiPwXqRxR4HKUBdIbyRXDfmsloKd7v8ak7dw3FjOiAF8/Y5yKURRXo0H4ix6NjZU5WKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986219; c=relaxed/simple;
	bh=nTthL4g0whEpDYvlF1DWRH/8R14aeJ4rVDKJOPoi55s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dE6Hb4ImGKYgqZa5XCRqjoNEtgd4x1cfyrzxtJ7RWHIolbl4QGy4uBtV5IG6jM02Aq0iOetGA+KCHOtWBr/lhahHtwkAsd20g+rgrHmVB1Om33c/MYHjP4hJoVzg/qE+SNZjiyYdR5cbVNE5BuErXKBexUAdyGVG3rQ3v7X4hQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YeO5CQhh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YeO5CQhh"
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id F2DA520B7001;
	Fri, 21 Jun 2024 09:10:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2DA520B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718986217;
	bh=ndnQmVkIM4YZPt5KcPI2pLEhoVv/JSA/CLi6nqYYHEQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YeO5CQhhJu5okVVzHDspBfqFnT7wNCQwQCeOHfTQ9XPy0O7G2oZlcKbJ/9CSvKSQ/
	 BMtUHBnHU352Qbh6NnmKRnSF6wod+iIXYPkzf2Z+MPFZ2o6Aea7DfVGSnYN6OrBbsa
	 vwXT4IiqAmivMBExcVIeIs+hCgBWhE8jvfJ1ppSU=
Message-ID: <461d332e-966d-4906-b33c-8ea3391c9dea@linux.microsoft.com>
Date: Fri, 21 Jun 2024 09:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Andi Shyti <andi.shyti@kernel.org>,
 linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 5/6] docs: i2c: summary: document 'local' and 'remote'
 targets
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
References: <20240621073015.5443-1-wsa+renesas@sang-engineering.com>
 <20240621073015.5443-6-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240621073015.5443-6-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/2024 12:30 AM, Wolfram Sang wrote:
> Because Linux can be a target as well, add terminology to differentiate
> between Linux being the target and Linux accessing targets.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/i2c/summary.rst | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
