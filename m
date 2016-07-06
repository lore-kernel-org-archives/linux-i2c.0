From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 06:50:57 -0700
Message-ID: <20160706135057.GI2671@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <20160706065523.GA1439@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35534 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbcGFNu7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 09:50:59 -0400
Received: by mail-pf0-f174.google.com with SMTP id c2so80185039pfa.2
        for <linux-i2c@vger.kernel.org>; Wed, 06 Jul 2016 06:50:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160706065523.GA1439@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On 06-07-16, 15:55, Wolfram Sang wrote:
> Adding something to *every* i2c_client for this corner case sounds
> pretty expensive to me.

I agree with you on that. I wanted to avoid it, but I couldn't :(

Lets see how Jean suggests to handle it.

-- 
viresh
