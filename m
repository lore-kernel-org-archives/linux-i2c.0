From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 08:35:22 -0700
Message-ID: <20160706153522.GM2671@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <415dcaa7-8ad9-492e-5c5c-605173bc4345@axentia.se>
 <20160706143323.GK2671@ubuntu>
 <577D1907.20002@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <577D1907.20002@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On 06-07-16, 16:43, Lars-Peter Clausen wrote:
> There is no guarantee that the address will be different. While it is
> unlikely the memory allocated might give out the same address for the second
> adapter if the first one has been freed.

Oh yeah, thanks for correcting me :)

-- 
viresh
