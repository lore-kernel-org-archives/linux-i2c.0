Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885637F01A;
	Fri, 14 Aug 2026 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742396; cv=none; b=NwZBpMJKkaBVlqk3JJe+S+GDcBkd1kAMu/r2oJN1Ty1hSOCtxGWZifBpTrx7SiYOeiMCU/9jZP1Mq7fH9GHgJwP47W+JIPIzouYnDmdQ6ah1u+a0hq6q/MnaL0rF80vZ+W+edKJvVlODlOrxD11onU4YvhA67q3GmIeWHh0s2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742396; c=relaxed/simple;
	bh=iRAWwpqyHCsCEBig8Ggg6vWc3y0LM0HV+hjBv8vbQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEjt6LjebMWE9hSxYyBw4NiWZx+Ls0/uTgrqt/wMWqMd6D+kyu1RPjIyv/lXYjjdhkrTcJOyy9avt9TMva3otd2bg0x6dfGS9NM/pUVlpi8ZWqlsMWOYXZqeYMBYbUQ1P/uO/hh6dAQ+CXbPZxYpN8PZXu41SU7QbJR+lTWf8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW4i02dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW4i02dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01611F000E9;
	Fri, 14 Aug 2026 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786742394;
	bh=8xyewwSgf7Y2TJ9EZNTnjEdF4u56f4myYdpmZfysO44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kW4i02dhygVEUm0S604lBmWnhC78bEyEKtqnBskM2MZivHq955nsK8V0A/DHWyrS1
	 QxvDvQ9M6IPJb6JUx8ZtivmL3sfoBa1lsvGRphsHup3/7Wzi1nLpLGmrpv6olBXtnF
	 xQDjFfHgjDfyWy66vQfDxLKPnF4a9PATxaMMNZ4jQBP4lJZSiMYWWDHyXkip9hpCV5
	 W9pstcBcB0DUHyPc7q6rmoxkQnT5daaUG++eItaw83mnZFYc0gWukzx+oJGQB8QPZm
	 +LHpAmCYCcjIHX5DVBH1DoKBSwdil2j1sFG25fgfkB0vP5Qv5phV1Jn3d6RzCqmTrh
	 flW9RzjEUAmvQ==
Date: Fri, 14 Aug 2026 23:19:51 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com, linux@leemhuis.info, regressions@leemhuis.info, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
Message-ID: <an-GZpgfiPJj2JsV@zenone.zhora.eu>
References: <20260814100719.9548-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814100719.9548-1-hardikprakash.official@gmail.com>

Hi Hardik,

On Fri, Aug 14, 2026 at 03:37:19PM +0530, Hardik Prakash wrote:
> This reverts commit 0a4bb2abc3e56d7be6e69b050c88ba52c87e22bf.
> 
> The reverted commit causes a regression on ThinkPad T14s Gen 4 (AMD):
> the touchpad's I2C controller fails with lost arbitration errors,
> because it delays i2c-designware's probe by roughly 500ms, which
> shifts the touchpad's first HID descriptor fetch into a window where
> the platform's embedded controller is still acting as a secondary I2C
> bus master. Debug tracing confirms the GpioInt dependency check itself
> behaves correctly (it defers appropriately and confirms the GPIO
> controller is bound); the arbitration failure happens roughly a
> second after the check passes, when i2c_hid_acpi's own probe attempts
> its first transaction.
> 
> The original fix is still needed for the Lenovo Yoga 7 14AGP11
> touchscreen race the commit addressed, but a corrected version will
> be resubmitted once the EC bus-mastering interaction is understood
> and handled properly, rather than reintroducing a different
> regression on more widely-used ThinkPad hardware in the meantime.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info/
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>

merged to i2c/i2c-2.

Thanks,
Andi
