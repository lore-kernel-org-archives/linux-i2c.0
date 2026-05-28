Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312678F2B;
	Thu, 28 May 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008361; cv=none; b=TTboD/M24W7QoR3TF/uvG9ljIU08q5k7uJOT4hw3IQVKcbm5zrNsnfehacNvKGEURyLy0Zwp6w972wmymBd7cPsSjkyQCtk+ho5L9Be3QF495RniWTKU328P0/G3eEhCg5Lb1o0C3pM6BBnWjubX0PzrgZ4T2qlT655JPKXtU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008361; c=relaxed/simple;
	bh=hkihv+d43sjKHyEFpdPKlA5Mbx/FC5erPmXN6WBkUts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAvJlKF5Bh8UQ3y4yXruUOT6oVsm3H3XIb4eGNWymm3dPsddOanLXeeADi0mRpa7Pg4boGsbuDXbz0Vk3lOQH8wWzAzTLQqlC2LAnsNmACgIN9isCJlVrSmYanppohzRZ+G1ZSD67zGCMRi+ueFexTtLviKwVmz7Wwvi2qWDYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMdYUAdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMdYUAdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588831F000E9;
	Thu, 28 May 2026 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780008360;
	bh=jlJoKOltavehQ7cQbTGNbPwCki1/IAgARQIsgfocnZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMdYUAdh0dPWZxRNA4Bian5gonJAO1kU2ck32nTBFBjZwdE4VntwjLWxBnqdg3Gn2
	 TAl9Z6MfPGN2VKl5kEwXoL2vSASpe0RooON2OU6c6bKYUJBXoh1jWgxnOfMgXgpyNQ
	 IgBL3WhBQy47MsMgsJch2ZbN5Y/IcENa89/kb1htftOxP+19LbU7b/M3MqxvH8S/cZ
	 htGdRllGyqKzzMR+wzoqlyTJUqFPQvk/vIz6Ww4Hv1OptE5XfqA2y0Ea4JbsLKOYA1
	 Ctfaws7i/12EeWT61vRft5ZzmkfFd0P5HsoA2tgCrTAdJLLma0Q4GqfJS8xBH5/HQh
	 DrTPN+eEDpUKA==
Date: Fri, 29 May 2026 00:45:55 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 0/4] i2c: designware: Improve device disable
 handling
Message-ID: <ahjFhU0ig8U0Gp-3@zenone.zhora.eu>
References: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-dw-i2c-v5-0-3483057f8d67@wkennington.com>

Hi William,

> William A. Kennington III (4):
>       i2c: designware: Introduce shutdown exported function
>       i2c: designware: Convert PCI driver to use shutdown hook
>       i2c: designware: Convert platform driver to use shutdown hook
>       i2c: designware: Handle active target cleanly

merged to i2c/i2c-host.

Thanks,
Andi
