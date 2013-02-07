From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 37/77] i2c: convert to idr_alloc()
Date: Thu, 7 Feb 2013 15:28:31 +0000
Message-ID: <20130207152831.GA14797@sirena.org.uk>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
 <1360179649-22465-38-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360179649-22465-38-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 06, 2013 at 11:40:09AM -0800, Tejun Heo wrote:
> Convert to the much saner new idr interface.
> 
> Only compile tested.

This broke I2C for me in -next today, I saw a spinlock bad magic error
calling pm_runtime_enable().  
