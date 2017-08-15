From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/2] i2c: mux: pinctrl: remove platform_data and cleanup
Date: Tue, 15 Aug 2017 09:00:12 +0200
Message-ID: <a13a98c9-68ea-a709-c50b-a7953463aab2@axentia.se>
References: <20170802072728.24586-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802072728.24586-1-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2017-08-02 09:27, Peter Rosin wrote:
> Hi!
> 
> As previously discussed [1], the platform_data interface of the i2c mux
> pinctrl driver has never been used (upstream at least). Deleting code
> is always nice, so here are two patches that gets rid of some lines...

Both patches applied (with added tags) to my i2c-mux/for-next branch.

Cheers,
peda
