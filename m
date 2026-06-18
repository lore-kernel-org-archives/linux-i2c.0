Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646352EC083;
	Thu, 18 Jun 2026 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792305; cv=none; b=Ap7ItEZp6yG4H/XsZ3zUX0BxjH6laDmpbwgrPM4eE8NhNkq/Yxbqe7XB61G3hZp+6kO2I/3JjDC8pwk5QcOeUsn5QHTOvcCnd+sz2udva4uVxF7vMq3eUI8odA7YVtvA7ULwsNNZlVeZ6YgFlbt49ADJleokTZOKZhbOiCp4Pbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792305; c=relaxed/simple;
	bh=29AaSbquiQW4bhrxOb936/pl0BSeblAxNUSPIE/7teE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjjSJsdK9tfQPSinO7DxskYA/LcLVmfoxBc2h/WxZq+91cU0koAjOzcCcqk25yLlQo0TpahUR6bPx9yLtXakgh0PCR2nbTtM70W8Z4nzq+tTyUyqoOq/NcvMgwji+XZlg2sKOyi9msQKIEvr2+ct+Jv/VWVRTHjXz2/mDgaWJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSzMhfYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSzMhfYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995CD1F000E9;
	Thu, 18 Jun 2026 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781792304;
	bh=B9/WqKiPlxZ3KbAMk6MkH7ISdU03zyV5M7zpBSYlKOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSzMhfYyNuUjxzJyS+aKXpz0jGZ18AMKCkX5n4NcfnN5g8+LSt5Hy4k/a5+9JrY0L
	 gYrqUuw3Fh7Tc5dmwJ1HzPZvfYfd5q+kk9AHGo4txstoAykQji9pR/KLvNuREcQvDd
	 EA+D2kcxPD/B2Wu+Us6QjMkQRlwqcEdpB9RZpov+Fezr7Fdmxz+CQuc9ntb3jXHiHP
	 IQo2Smu+hSdFAmWV6Jd6vO6rht1sptxn4qWc/CgFWUCFlqklibYILRGO8OZV5j6L9z
	 04voOWT5XzUzAh/cj1Fa0m+2Dd09qClgPZxgjx9WMV2E/29hIMvIRsdwdkXCI8g7RN
	 c+M8Bm801kx2A==
Date: Thu, 18 Jun 2026 16:18:19 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: pxa: Use named initializers for the
 platform_device_id array
Message-ID: <ajP9xC3HrSRgM9-b@zenone.zhora.eu>
References: <827657abb02edb39bc90f7336194f614d383770e.1781688767.git.u.kleine-koenig@baylibre.com>
 <ajPSo2zjDvq7CflO@zenone.zhora.eu>
 <ajPjJbYrtZJ09rDW@monoceros>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajPjJbYrtZJ09rDW@monoceros>

Hi Uwe,

On Thu, Jun 18, 2026 at 02:24:25PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> On Thu, Jun 18, 2026 at 01:14:04PM +0200, Andi Shyti wrote:
> > On Wed, Jun 17, 2026 at 11:37:36AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > Named initializers are better readable and more robust to changes of the
> > > struct definition. This robustness is relevant for a planned change to
> > > struct platform_device_id replacing .driver_data by an anonymous union.
> > > 
> > > Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> > 
> > I had decided not to take any patch anymore for this cycle, but
> > because this is part of a bigger work you've done, I will squeeze
> > it in.
> > 
> > Merged to i2c/i2c-host.
> 
> Thanks. If you want to rethink that's fine. There are still so many
> patches pending (to be applied and to be sent) that there is little
> sense in rushing in that one. I'm happy if you take it now, but if you
> reschedule it to the next merge window, that's fine for me, too.

It's OK, I will keep it, it makes sense to add it to the similar
patche that have been merged already.

Andi
