From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: RE: [PATCH] i2c: Move I2C_EG20T option to the right place.
Date: Wed, 25 Jan 2012 15:50:16 +0000
Message-ID: <1EDB558E5F5FA14BB548E8397D4DD80901E6D8@hqmbx01.netlogicmicro.com>
References: <1327321889-6393-1-git-send-email-jayachandranc@netlogicmicro.com>,<20120125153842.GC8852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120125153842.GC8852-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang [w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org] wrote:

>On Mon, Jan 23, 2012 at 06:01:29PM +0530, Jayachandran C. wrote:
>> From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
>>
>> Move Kconfig option for I2C_EG20T to the correct position and keep
>> the options sorted.
>>
>> Also, use tabs in Makefile and move the I2C_EG20T entry to its
>> position.
>>
>> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
>
> What is this based on?

It is based on the i2c XLR patch I had sent before.  I will send an updated
version  of that based on your comments later today.

This patch is dependent on XLR because they modify the same area in
Kconfig.

JC.--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
