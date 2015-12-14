From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Date: Mon, 14 Dec 2015 13:02:27 +0100
Message-ID: <15285750.UWXWiNJ6YU@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com> <2157023.1Ftpc9ZciN@wuerfel> <20151213090959.GB1570@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64467 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbLNMDF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Dec 2015 07:03:05 -0500
In-Reply-To: <20151213090959.GB1570@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Sunday 13 December 2015 10:09:59 Wolfram Sang wrote:
> 
> What about not ifdeffing the inline function and keep the build error
> whenever someone uses it without I2C_SLAVE being selected?

The inline function is only added there for the case that I2C_SLAVE is
disabled, so that would be pointless.

However, what we could do is move the extern declaration outside of
the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
check should then ensure that it never actually gets called, and we
get a link error if some driver gets it wrong.

	Arnd
