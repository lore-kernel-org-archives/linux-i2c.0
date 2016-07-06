From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] i2c-dev: Don't let userspace block adapter
Date: Wed, 6 Jul 2016 16:41:25 +0200
Message-ID: <577D1895.3060202@metafoo.de>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50345 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbcGFOlc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 10:41:32 -0400
In-Reply-To: <cover.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On 07/06/2016 04:57 AM, Viresh Kumar wrote:
> Hi Wolfram/Jean,
> 
> I am part of the kernel team for Google's projectara [1], where we are
> building a module smart phone.
> 
> This series tries to fix one of the problems we hit on our system as we
> are required to hotplug pretty much every thing on the phone and so this
> fixes hotplug issues with i2c-dev.
> 
> As described in the second patch, the current implementation of i2c-dev
> file operations doesn't let the modules (hardware attached to the phone)
> eject from the phone as the cleanup path for the module hasn't finished
> yet (i2c adapter not removed).
> 
> We can't let the userspace block the kernel devices forever in such
> cases.
> 
> I was able to test them on the ARA phone with kernel 3.10 only and not
> mainline.

This sounds like you want hot-unplug. This is currently not support by the
I2C framework for adapters. A better approach compared to this series might
be to implement full hot-unplug support for I2C adapters. This will probably
also be useful for additional usecases.
