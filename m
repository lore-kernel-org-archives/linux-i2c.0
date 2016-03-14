From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] i2c: immediately mark ourselves as registered
Date: Mon, 14 Mar 2016 19:49:03 +0530
Message-ID: <20160314141903.GB5699@sudip-laptop>
References: <1457949206-7226-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37617 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbcCNOTI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Mar 2016 10:19:08 -0400
Content-Disposition: inline
In-Reply-To: <1457949206-7226-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Mon, Mar 14, 2016 at 10:53:26AM +0100, Wolfram Sang wrote:
> Mark the i2c bus as registered right after the the bus_register call,
> not at the end of init. Otherwise, we can't register our own dummy
> driver.
> 
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Fixes: 95026658c46ea2 ("i2c: do not use internal data from driver core")
> ---

I think it should be:


diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f4726cd..065cd83 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2105,6 +2105,9 @@ static int __init i2c_init(void)
 	retval = bus_register(&i2c_bus_type);
 	if (retval)
 		return retval;
+
+	is_registered = true;
+
 #ifdef CONFIG_I2C_COMPAT
 	i2c_adapter_compat_class = class_compat_register("i2c-adapter");
 	if (!i2c_adapter_compat_class) {
@@ -2119,7 +2122,6 @@ static int __init i2c_init(void)
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
 
-	is_registered = true;
 	return 0;
 
 class_err:
@@ -2128,6 +2130,7 @@ class_err:
 bus_err:
 #endif
 	bus_unregister(&i2c_bus_type);
+	is_registered = false;
 	return retval;
 }
 

otherwise even if i2c bus fails to register the flag says that i2c is registered.
Sorry again for the previous patch.

regards
sudip
