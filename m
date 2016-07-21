From: Phil Reid <preid@electromag.com.au>
Subject: RFI: I2c muxes I2C_MUX_LOCKED and interrupt support
Date: Thu, 21 Jul 2016 11:20:58 +0800
Message-ID: <4ea56ba2-ba2f-88f8-10f2-daee3f9ebdff@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:60680 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752015AbcGUDVB (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Jul 2016 23:21:01 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, peda@axentia.se, linux@roeck-us.net

G'day Peter,

I'm looking into modifying the i2c-mux-pca954x driver to add support for
the pca_9543 interrupt mux function.

So the first thing I need to add is a reg read function.
However based on the changes to the i2c mux code in the 4.6 series the
locking work around shouldn't be needed now if the mux is allocated with
I2C_MUX_LOCKED. Currently this driver is not doing this.
Also the same with the similar i2c-mux-pca9541 driver which does implement read.

So my question is should I change the driver to use I2C_MUX_LOCKED
or implement the read operation the same as the i2c-mux-pca9541?



-- 
Regards
Phil Reid
