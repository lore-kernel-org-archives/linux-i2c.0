From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Thu, 7 Aug 2014 05:28:51 +0000
Message-ID: <31f8f5504fc24d999f5af74338602bed@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
 <14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <14d042bbcfb04308bfb3a1db18e46bec-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>
Cc: "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Yuan Yao-B46683 Data: Wednesday, August 06, 2014 3:07 PM
>To: Duan Fugang-B38611; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org
>Cc: LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
>linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-
>i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596
>Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c
>driver
>
>Hi Fugang,
>
>Duan Fugang wrote:
>[...]
>>+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>>+	dma_sconfig.dst_maxburst = 1;
>> The maxburst is 1 cause very slow efficiency for DMA copy, which
>> system performance even is slower Than cpu mode.
>
>There is no FIFO for IMX i2c, so the maxburst shoud be 1 for hardware
>request.
>
Understand. Thanks.

>
>> >+	/* Waiting for Transfer complete. */
>> >+	while (timeout--) {
>> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>> >+		if (temp & I2SR_ICF)
>> >+			break;
>> >+		udelay(10);
>> >+	}
>> Whether there have better method like interrupt to avoid dead wait
>> here until timeout ?
>
>Can you give me more suggestion? We have discussed it with our team, It
>seems the short query wait is necessary.
>
At least, you can use schdule_timeout() instead of udelay() ?

>> >+
>> >+	if (!timeout)
>> >+		return -ETIMEDOUT;
>> >+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>> >+	temp &= ~I2CR_DMAEN;
>> >+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>> >+
>> >+	/* The last data byte must be transferred by the CPU. */
>> >+	imx_i2c_write_reg(msgs->buf[msgs->len-1],
>> >+				i2c_imx, IMX_I2C_I2DR);
>> >+	result = i2c_imx_trx_complete(i2c_imx);
>> >+	if (result)
>> >+		return result;
>> I don't understand why the last data need to be transmited by cpu. I
>> guess you want to get IIF interrupt ?
>
>Yes, we need the interrupt to do some mop-up.
>
>Also follow the hardware request as:
>
>The following flow diagram details exactly the operation for using a DMA
>controller to transmit "n" data bytes to a slave. The first byte (the
>slave calling address) is always transmitted by the CPU. All subsequent
>data bytes (apart from the last data byte) can be transferred by the DMA
>controller. The last data byte must be transferred by the CPU.
>
>> >+
>> >+	result = i2c_imx_acked(i2c_imx);
>> >+	if (result)
>> >+		return result;
>> >+
