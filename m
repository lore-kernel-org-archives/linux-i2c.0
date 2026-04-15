Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FA1DE3B7;
	Wed, 15 Apr 2026 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289530; cv=none; b=KvPKBN+TD8skcLk6uodFILy3BQv7Tw2ya3ErN7roUL3ZdfJ22il+oNrxH2sLn0/3wBzktSoyaqbrpNu63ge7N7GE+DnSj1IZitl+Q8/HKEfKHV6fkrxW8mr1HB1nduAAlv0KFEDdDI4hWcxB8QYLaQY8A99jGiZmynIIWE9gkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289530; c=relaxed/simple;
	bh=TloyhXzq1/puv4FlbKe8Oz8xg8FNU3IYMfZDWHPrV/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1KRQwwNPXq6Cmnr2FHygmLm7VguY22jdGklcY10vjfIeECYFqBkab2Q0gyZHNzeD6gv/e4w2rLAieAxvZKv6bXQ2+FplYUPzLPhv7rUY7cNxYwuhVN8FWiWASOramic4JbMEH6ddtrM6h0VsdOysE6xUUKdJ0a0oEC4t9p/jYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKJesj/Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKJesj/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCBFC19424;
	Wed, 15 Apr 2026 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289530;
	bh=TloyhXzq1/puv4FlbKe8Oz8xg8FNU3IYMfZDWHPrV/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKJesj/YNj66howsILU57gfaa+CNkRtkBgDHXdB1Z/vtuf9mw7D1Px3axPT6PwRq6
	 D2YjuY0Xw0o2cpF9meweSpZE+KUYX/nWHk17SCgaCPVAKuLomhhVSMSIAtypAS72I5
	 ZRWLfJqkE5ULI+XVpb+19BezYq9OE2owfQpVtRPvl+kvMOqK4WjA6KhUyj8ydwqIeW
	 J5teVddQ0Ea960NdadH0OUHiAkj4XSTI/BXbG/YVvjn7l7D7SNUjHUHrNrd4f+C9ZP
	 s7YuZb7aA8huA+Z17TIVwB7HOZURSTr9B42fQDffnhjPdIgGHSeDRyOIHpXe9BDuWP
	 8mDOjTi02pg+Q==
Date: Wed, 15 Apr 2026 23:45:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
Cc: Qii Wang <qii.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 1/1] i2c: mediatek: add bus regulator control for
 power saving
Message-ID: <aeAGeh-tXDLL-Kr_@zenone.zhora.eu>
References: <20260415125833.2579133-1-adlavinitha.reddy@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415125833.2579133-1-adlavinitha.reddy@mediatek.com>

> Thank you for your guidance on formatting and submission rules. I will study
> the documentation carefully and ensure I properly send patches in the future.
> 
> Regarding the multiple submissions, I sincerely apologize for the confusion.
> As an intern here, I encountered some unexpected internal email permission
> issues when trying to send the patch. In an attempt to double-check whether
> the email successfully went through the server, I mistakenly re-sent it a
> couple of times. I will be much more careful next time.

No worries Adlavinitha your patch got in anyway.

Have fun in the kernel community :-)

Andi
