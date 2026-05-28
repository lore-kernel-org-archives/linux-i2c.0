Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD233546E8;
	Thu, 28 May 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955097; cv=none; b=fTM66Pho+RH7KlmJ6W4+FQP31N0OrlyIaPOvFSgBkMdIxJBcU1KjS9OYl4qrviyjsdM+1fmNwf4AF1cz8di6L96vzZDrkO2GPrZ7NxsWW4WilxXCmkOVFf+1dvS8jXH/wN5hQuuKweJcejgYSKTXwLmxmilmxNs5ttX2um+rpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955097; c=relaxed/simple;
	bh=a7FcghP76nzDvAxuPA6dh3/GFy/rn7Zu67eSgUFGCuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yj/i9xX5Rs5mcf6qn3xpcNAYKy0gDOPEx9U6z+aN0frA0Lkk1IwJDseCa4wNZaI02lu9arh5wRez6vwfDKnvT1uii5umMESAWLVyaKvssIRSl8uR+gxv9Pfc3pV/QpMHkRsP+khjRkZq2VxMXEzr7fEktHqx/CDudHy2Ff8riPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 216B4100E23;
	Thu, 28 May 2026 07:48:06 +0000 (UTC)
Message-ID: <93b098d6-ad38-4557-9089-3235f40f7d4e@enpas.org>
Date: Thu, 28 May 2026 16:48:05 +0900
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] i2c: icy:pick Use named initializer for
 zorro_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org,
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Max Staudt <max@enpas.org>
In-Reply-To: <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/26/26 11:17 PM, Uwe Kleine-König (The Capable Hub) wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
> 
> While touching this array, drop explicit zeros from the list terminator.
> 
> This change doesn't introduce changes to the compiled zorro_device_id
> array.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>


Thanks Uwe!

Reviewed-by: Max Staudt <max@enpas.org>

