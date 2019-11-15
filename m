From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] i2c: of: Populate fwnode in of_i2c_get_board_info()
Date: Fri, 15 Nov 2019 13:32:01 +0800
Message-ID: <20191115053201.GA800105@kroah.com>
References: <20191115045049.261104-1-saravanak@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191115045049.261104-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <saravanak@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, kernel-team@android.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 14, 2019 at 08:50:48PM -0800, Saravana Kannan wrote:
> This allows the of_devlink feature to work across i2c devices too. This
> avoid unnecessary probe deferrals of i2c devices, defers consumers of
> i2c devices till the i2c devices probe, and allows i2c drivers to
> implement sync_state() callbacks.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> The of_devlink feature is present in driver-core-next branch. It started
> off with [1] but it has been improving since then.
> 
> [1] -- https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
> 
>  drivers/i2c/i2c-core-of.c | 1 +
>  1 file changed, 1 insertion(+)

Wolfram, I can take this through my tree now if you have no objections
to this.

thanks,

greg k-h
