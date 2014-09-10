From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: Re: [PATCH] i2c-mxs: detect No Slave Ack on SELECT in PIO mode
Date: Wed, 10 Sep 2014 17:57:31 +0200
Message-ID: <541074EB.3060702@elproma.com.pl>
References: <1410362286-1785-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410362286-1785-1-git-send-email-j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marex-ynQEQJNshbs@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


W dniu 2014-09-10 17:18, Janusz Uzycki pisze:
> Reported problem:
> i2cdetect scanned i2c bus very slow if address was not occupied by any device.
>
> Solution:
> The patch adds to mxs_i2c_pio_wait_xfer_end() function
> NO_SLAVE_ACK_IRQ bit polling during wait loop (until timeout).
> If the bit is set the function immediately returns ENXIO error
> in order to break the loop and not reset I2C block (it is in idle state then).
> The function is called by mxs_i2c_pio_setup_xfer() to wait for complete xfer
> after sent SELECT, READ or WRITE command.
> If SELECT command is sent and selected slave address is unused by any device
> on the bus I2C block sets NO_SLAVE_ACK_IRQ flag and doesn't deassert CTRL0_RUN.
> Therefore we need to break the timeout loop when the flag is set,
> otherwise the loop continues until long timeout (1000ms).
> The change does not affect READ command because slave does not ack
> any byte then (only the master does ack / or not for the last read byte).
> According to i.MX28 reference manual (quoted below) it is not clear
> if the patch affects WRITE command. However when no acked bytes
> on WRITE command followed after address byte (SELECT command)
> STAT_GOT_A_NAK flag is set rather than NO_SLAVE_ACK_IRQ (no tested).
> Therefore clock stretching shouldn't be affected too.
> It has confirmation in FSL BSP 2.6.35 i2c implementation which
> completes xfer after NO_SLAVE_ACK_IRQ interrupt and scheduled work.
> Registers on NO_SLAVE_ACK_IRQ in PIO mode:
>
Some words of comment about clock stretching. In the patch
I meant clock stretching by master (RETAIN_CLOCK) during WRITE command.
This prevents to use the bus by other master (multimaster bus).
However there is also possible "clock low period stretching" by slave device
(I wrote about in threads before) to inform the master that clock is too 
fast
or slave is not ready. Then slave sets SCL line to low state.
The case is rather not supported by any i2c driver in Linux? The i2c 
clock freq. is fixed.
Therefore when SCL is hold by long time master treats it as NACK, show 
streching by slave
is probably handled directly by master's hardware if implemented.
Clock strechting by slave seems impossible when RETAIN_CLOCK set by master.
Clock stretching by master is not affected by the patch because the 
master decides
when ACK/NACK is received from slave during WRITE command.

best regards
Janusz
