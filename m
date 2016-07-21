From: Peter Rosin <peda@axentia.se>
Subject: Re: RFI: I2c muxes I2C_MUX_LOCKED and interrupt support
Date: Thu, 21 Jul 2016 08:52:31 +0200
Message-ID: <5790712F.2050300@axentia.se>
References: <4ea56ba2-ba2f-88f8-10f2-daee3f9ebdff@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0134.outbound.protection.outlook.com ([104.47.2.134]:42048
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751432AbcGUH0q (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Jul 2016 03:26:46 -0400
In-Reply-To: <4ea56ba2-ba2f-88f8-10f2-daee3f9ebdff@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux@roeck-us.net

Hi Phil,

On 2016-07-21 05:20, Phil Reid wrote:
> G'day Peter,
> 
> I'm looking into modifying the i2c-mux-pca954x driver to add support for
> the pca_9543 interrupt mux function.
> 
> So the first thing I need to add is a reg read function.
> However based on the changes to the i2c mux code in the 4.6 series the
> locking work around shouldn't be needed now if the mux is allocated with
> I2C_MUX_LOCKED. Currently this driver is not doing this.
> Also the same with the similar i2c-mux-pca9541 driver which does implement read.
> 
> So my question is should I change the driver to use I2C_MUX_LOCKED
> or implement the read operation the same as the i2c-mux-pca9541?

Good question. I didn't dare changing the pca9541/pca954x drivers to
be mux locked. Maybe I am too conservative?

The issue is that if you have a multi-level hierarchy of muxes, the rules
are more relaxed for mux locked muxed compared to adapter locked muxes.

I.e.
             mux3
            /
        mux1
       /    \
   root      mux4
       \
        mux2

accesses to devices on e.g. mux3 and mux2 may interleave if all muxes are
mux-locked, that will never happen for adapter-locked muxes.

Building complex hierarchies feels more likely with pca954x that with the
other muxing options. But I don't know that, and maybe none exist at all?

Anyway, the safe option is to do it like in pca9541...

Cheers,
Peter
