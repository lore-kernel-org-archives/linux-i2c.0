Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283624677B;
	Thu, 28 May 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007747; cv=none; b=BugyUuzZ/tESWINviXluENnHOmRebGBZcWc2ZTqM19Hm1ukYe4h+vXOQPFuvc+YX4CibwwCV3XUCsfaP4mIsx682frpFy3qFj2NeCFqeAnZ+RH23YRRrqhQM0Ld5r2V7XBpEVVGoEFZaH4otM81hog1nzbjvVltrtwVKdRcpkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007747; c=relaxed/simple;
	bh=L2IXn7tokzDlv8zKzHfT7rQcYMUlHu8dS7WVQ8PiaXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo1//NDJRFMcg3pcFZ7Y0dJDOxY0vyP7zMG6l4hA0AzYLyhxBnMiTbn74wuD02pXEyljUfo5uX87qrjuzL1MVcVxdZySXFlzu140Imc5nwL3xPX9JkT+N359TOl/RAfU+z4UZAbmh4hZDCq/v8BDsI+dT05r4rsFuL63uy+Xs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD+52fTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD+52fTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C937E1F000E9;
	Thu, 28 May 2026 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780007745;
	bh=8kLBx4ckmbM0dMOnHMAVzp6zE5GX3IeNoPhLyXOA4VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SD+52fTbEX1WT4tWRpyMhXdSq+n+131KEEtso/qUJM3+jfvE6hrIUbmgHGbMPgUkO
	 K5deGNGOScSV/bF+pMr4zugPdCj0v4FIg+dc0qqOFalCUhInPDftbpu+h6tGoM0ruK
	 +WOfEz7fY3taIR8jaIZ24MUj665fyLpCLHLEd6hlaAA/En96IZWt7FiehVGdmD65ve
	 OMNkHFEuYXDqzdVkEQPP/5VptKA8rZkdO1At43tVcnohFaiM7xqhbAkD6iTZtFsJRZ
	 Lcy/iK0oWSJnECLnyYUZDN61sM7vxqjGPZl8z48RBCzej5XF8MYtfVuSulWR3PjxMt
	 AJJBNFi2M0Iqw==
Date: Fri, 29 May 2026 00:35:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Max Staudt <max@enpas.org>, 
	linux-i2c@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 4/8] i2c: icy:pick  Use named initializer for
 zorro_device_id arrays
Message-ID: <ahjDIH9UlDicPYLB@zenone.zhora.eu>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

On Tue, May 26, 2026 at 04:17:30PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
> 
> While touching this array, drop explicit zeros from the list terminator.
> 
> This change doesn't introduce changes to the compiled zorro_device_id
> array.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

just this patch merged to i2c/i2c-host.

Thanks,
Andi
