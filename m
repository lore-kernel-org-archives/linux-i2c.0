From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 2/2] Input: cros_ec_keyb - Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 15:46:41 -0400
Message-ID: <2607f36e-ee56-98c8-ba7d-ec44a34dd512@osg.samsung.com>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-3-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:47422
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbcGYTqx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 15:46:53 -0400
In-Reply-To: <1469470451-111822-3-git-send-email-briannorris@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Hello Brian,

On 07/25/2016 02:14 PM, Brian Norris wrote:
> cros_ec_cmd_xfer returns success status if the command transport
> completes successfully, but the execution result is incorrectly ignored.
> In many cases, the execution result is assumed to be successful, leading
> to ignored errors and operating on uninitialized data.
> 
> We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
> problems. Let's use it.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
