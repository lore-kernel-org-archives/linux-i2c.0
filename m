From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 08:37:03 -0700
Message-ID: <20160706153703.GN2671@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <415dcaa7-8ad9-492e-5c5c-605173bc4345@axentia.se>
 <20160706143323.GK2671@ubuntu>
 <577D1907.20002@metafoo.de>
 <a65124df-0d47-41a8-b90f-0d6e3fd9ce4f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a65124df-0d47-41a8-b90f-0d6e3fd9ce4f@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On 06-07-16, 17:04, Peter Rosin wrote:
> Exactly, so the stored address had better be correct, and in

No.

> that case there is no need for the new adapter_nr in every
> client, you could just go with client->adapter->nr instead.

client->adapter may be a dangling pointer at this point if the adapter
is freed, so we can't use that blindly for sure.

> Which just shows that the whole thing is fishy and that the
> adapter has to remain alive. BTW, is there any guarantee that
> adapter numbers will not get reused?

We are allocating them from idr and that will reuse them once they get
freed.

-- 
viresh
