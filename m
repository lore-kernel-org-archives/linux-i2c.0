Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F33A7846
	for <linux-i2c@vger.kernel.org>; Mon,  9 Mar 2026 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057818; cv=none; b=KdUutMO6Exz4XI9TO2Bzg/k0WWQgcpCmMjiD7+6iEnqu+uEVBe7N40duU8NEjMmB7ggy547RfKxx+74eeQFJD6Yab5jVEiuFznCVm0EV+BAxjryP6K78IKr1dp6WzJDcFu5HRrreptPayYiVGawQseKzBvZn4pObZVpwFyeCj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057818; c=relaxed/simple;
	bh=+hiJpm3YftGfE33OUzF50t4ZBD/BIg26km8yb+O8QxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCVe1r0neWp6C9y9pswltFZk6NRCWEvtG+AfImX1et0KTfcml9DqlN8Oh7asTt76cdlnl1pLd7MW7VAZExh5dWNAUvzmiXVoVkp0VqB+Cy+JfdGU+tJcF5NY/BdqQjp8J3qo3jUEo05FSB7YorbQFAyQ7Khln2AqDLE/PcWEiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HdF/v0nm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HdF/v0nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1cF+
	mVn1g8M5HG5c2njHJf+HxsJUQ3pwqdg0TGLGVCg=; b=HdF/v0nm0Jh0ftb/f446
	HFnly41qTLH5qfdwmPNcNCrpt9xATJv3bhKrVsOkZUtjKxi94vxyKEMSF7TrQkrG
	ADaLXw8CW/dLsz2asiA8HRug8c9PY6d/julfB2y8WildbSsZlFIk4O0/Y/Qotlkm
	WNxJKDEOpx9rZhviiSN7E7+/YC7+ceqQZmWKV71WFjWvWzn1WdCUAw2Qg5Zm7WmU
	QGxMDsljrnzWNcyuIc2Z60NAEThga5aqf1Q6CLuujFMdz5QYVFrNhIx0ZL/8XNsg
	BHMyHUqyj8xq5rNO6QYGkD73vcKEiAigGECRGigGZa0ivrkF6iqvwoaw4vUnBwTV
	AA==
Received: (qmail 2765894 invoked from network); 9 Mar 2026 13:03:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Mar 2026 13:03:33 +0100
X-UD-Smtp-Session: l3s3148p1@cRAgMZZMyuMgAwDPXzF+ANZpdrMKUeLI
Date: Mon, 9 Mar 2026 13:03:33 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: robotfuzz-osif: drop redundant device reference
Message-ID: <aa63FfnTGzp3Xrew@shikoro>
References: <20260305102955.12340-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305102955.12340-1-johan@kernel.org>

On Thu, Mar 05, 2026 at 11:29:55AM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to for-next, thanks!

