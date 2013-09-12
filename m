From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 5/9] drivers/misc: convert existing I2C clients driver
 to use I2C core runtime PM
Date: Thu, 12 Sep 2013 14:29:20 -0700
Message-ID: <20130912212920.GA11384@kroah.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-6-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378913560-2752-6-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 11, 2013 at 06:32:36PM +0300, Mika Westerberg wrote:
> The I2C core now prepares runtime PM on behalf of the I2C client device, so
> only thing the driver needs to do is to call pm_runtime_put() at the end of
> its ->probe().
> 
> This patch converts I2C client drivers under drivers/misc to use this
> model.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
