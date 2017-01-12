From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: print correct device invalid address
Date: Thu, 12 Jan 2017 20:07:24 +0100
Message-ID: <20170112190724.5hqmqn7ir6d7j5wd@ninjato>
References: <1483700577-60130-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483700577-60130-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 06, 2017 at 07:02:57PM +0800, John Garry wrote:
> In of_i2c_register_device(), when the check for
> device address validity fails we print the info.addr,
> which has not been assigned properly.
> 
> Fix this by printing the actual invalid address.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied to for-current, thanks!
