From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/2] i2c-omap: Fix incorrect adapter id when booting from
 a device tree
Date: Fri, 31 Aug 2012 11:53:37 +0200
Message-ID: <504089A1.3030000@epfl.ch>
References: <1346399575-7285-1-git-send-email-florian.vaussard@epfl.ch> <1346399575-7285-2-git-send-email-florian.vaussard@epfl.ch> <5040806C.9080003@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <5040806C.9080003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>
List-Id: linux-i2c@vger.kernel.org

Hi Benoit,

> [    0.658843] omap_i2c i2c.15: bus -1 rev2.4.0 at 400 kHz
> [    0.760192] omap_i2c i2c.16: bus -1 rev2.4.0 at 400 kHz
> [    0.775817] omap_i2c i2c.17: bus -1 rev2.4.0 at 400 kHz
> [    0.791442] omap_i2c i2c.18: bus -1 rev2.4.0 at 400 kHz
>
> OK, it is true that the current log is not that nice with bus -1, but
> maybe we should just remove that.
>
> Or we can potentially retrieve the i2c adapter number assign later, and
> delay the log.
>
>>   	r = i2c_add_numbered_adapter(adap);
>>   	if (r) {
>>   		dev_err(dev->dev, "failure adding adapter\n");
I agree, we should defer the log if we want a nice print. I will send a 
new patch.

Regards,
Florian
