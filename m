From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] i2c-dev: don't get i2c adapter via i2c_dev
Date: Thu, 7 Jul 2016 08:35:42 -0700
Message-ID: <20160707153542.GB3932@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
 <20160707151654.3d32741c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35991 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbcGGPfo (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Jul 2016 11:35:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id uj8so6999085pab.3
        for <linux-i2c@vger.kernel.org>; Thu, 07 Jul 2016 08:35:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160707151654.3d32741c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On 07-07-16, 15:16, Jean Delvare wrote:
> Anyway, this is a good cleanup/optimization on its own, on top of
> fixing a race condition, independently of what we decide for the rest
> of the problems being discussed in this thread. So:
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Tested-by: Jean Delvare <jdelvare@suse.de>

Thanks Jean.

-- 
viresh
