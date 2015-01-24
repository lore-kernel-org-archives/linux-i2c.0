From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: I2C slave support
Date: Sat, 24 Jan 2015 21:08:25 +0100
Message-ID: <20150124210825.521bf923@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

I find it confusing that I2C slave support is included even when
CONFIG_I2C_SLAVE is not set. I don't know if this was discussed before?
Most systems don't need this code so including it unconditionally seems
suboptimal.

I am considering adding ifdefs around the code to only include it when
CONFIG_I2C_SLAVE is set. Alternatively the code could be moved to a
separate module altogether. What do you think?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
