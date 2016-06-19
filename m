From: Shardar Mohammed <smohammed@nvidia.com>
Subject: RE: [PATCH v8 1/3] i2c: tegra: use readx_poll_timeout after
 config_load reg programmed
Date: Sun, 19 Jun 2016 18:21:18 +0000
Message-ID: <6d21b4bd199844e3a359cc52823045db@bgmail102.nvidia.com>
References: <1464356224-10339-1-git-send-email-smohammed@nvidia.com>
 <20160619172136.GE2933@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8905 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcFSSVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 19 Jun 2016 14:21:32 -0400
In-Reply-To: <20160619172136.GE2933@tetsubishi>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "gnurou@gmail.com" <gnurou@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> Subject: Re: [PATCH v8 1/3] i2c: tegra: use readx_poll_timeout after
> config_load reg programmed
> 
> * PGP Signed by an unknown key
> 
> 
> > +		err = readx_poll_timeout(readl, i2c_dev->base + reg_offset,
> > +					 val, val == 0, 1000,
> > +					 I2C_CONFIG_LOAD_TIMEOUT);
> 
> Any reason we can't use readl_poll_timeout() here?
[Shardar] Can be used, will change and push the new patchset.

> 
> 
> * Unknown Key
> * 0x14A029B6
