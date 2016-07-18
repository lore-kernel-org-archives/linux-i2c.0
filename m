From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: i2c-smbus: fix i2c_handle_smbus_host_notify
 documentation
Date: Mon, 18 Jul 2016 17:01:03 +0200
Message-ID: <20160718150103.GP4663@mail.corp.redhat.com>
References: <1468676723.17822.3.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51487 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbcGRPBO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Jul 2016 11:01:14 -0400
Content-Disposition: inline
In-Reply-To: <1468676723.17822.3.camel@chaos.suse>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Jul 16 2016 or thereabouts, Jean Delvare wrote:
> The parameter description is from a previous implementation, update
> it to describe the actual implementation.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---

Good catch, thanks for fixing it.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/i2c/i2c-smbus.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -302,8 +302,8 @@ EXPORT_SYMBOL_GPL(i2c_setup_smbus_host_n
>   * i2c_handle_smbus_host_notify - Forward a Host Notify event to the correct
>   * I2C client.
>   * @host_notify: the struct host_notify attached to the relevant adapter
> - * @data: the Host Notify data which contains the payload and address of the
> - * client
> + * @addr: the I2C address of the notifying device
> + * @data: the payload of the notification
>   * Context: can't sleep
>   *
>   * Helper function to be called from an I2C bus driver's interrupt
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 
