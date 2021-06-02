Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C54DC47083
	for <linux-i2c@archiver.kernel.org>; Wed,  2 Jun 2021 11:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C60613AE
	for <linux-i2c@archiver.kernel.org>; Wed,  2 Jun 2021 11:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFBLSz (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:18:55 -0400
Received: from phobos.denx.de ([85.214.62.61]:51344 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhFBLSz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 2 Jun 2021 07:18:55 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C031A81E53;
        Wed,  2 Jun 2021 13:17:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1622632631;
        bh=FbYl3x0iYrkU3O1k6gmPtvghVGh3IcnhZHoAhRCxpQ4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eXgz6pNwFZyRpn+Mhr0bhydxXnQMt1vYI9mZCzHLh91dcvpHEF7nvr8NgcCyPZpqP
         ywHtUZxG3qVKFHs5XyYUXJoxERHpd9EfQsT6Ute66bIgHmdx+MnyWna0dAXSO06Oxx
         OrrbOFmUG0mIa1OWs3A8pNuioCEqV8xmAiZ2wnWhYo9xfQjB8raNzrFo1KO6UQ+WEM
         0vJoFB1q2i46CYox75uQBEG5Xggt690tfUszpp3e9D0EfEgWoorpVQ2kPtcoKHSZ8/
         sB0JO56EuWmpqOwYKrnPGyN77j9b3ulhMA7fzkI7dNo4FVLAVJ6ktsL9p6SF4cyVLo
         oWzjN5rIDPpGg==
Subject: Re: [PATCH 02/10] i2c: xiic: Add standard mode support for > 255 byte
 read transfers
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        linux-i2c@vger.kernel.org, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <20210531131948.19477-1-raviteja.narayanam@xilinx.com>
 <20210531131948.19477-3-raviteja.narayanam@xilinx.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <0f167c21-6bc7-0806-a536-55658a199a5b@denx.de>
Date:   Wed, 2 Jun 2021 13:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210531131948.19477-3-raviteja.narayanam@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 5/31/21 3:19 PM, Raviteja Narayanam wrote:

[...]

> +	if (i2c->dynamic) {
> +		u8 bytes;
> +		u16 val;
> +
> +		/* Clear and enable Rx full interrupt. */
> +		xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK |
> +				XIIC_INTR_TX_ERROR_MASK);
> +
> +		/*
> +		 * We want to get all but last byte, because the TX_ERROR IRQ
> +		 * is used to indicate error ACK on the address, and
> +		 * negative ack on the last received byte, so to not mix
> +		 * them receive all but last.
> +		 * In the case where there is only one byte to receive
> +		 * we can check if ERROR and RX full is set at the same time
> +		 */
> +		rx_watermark = msg->len;
> +		bytes = min_t(u8, rx_watermark, IIC_RX_FIFO_DEPTH);
> +		bytes--;
> +
> +		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, bytes);
> +
> +		local_irq_save(flags);
> +		if (!(msg->flags & I2C_M_NOSTART))
> +			/* write the address */
> +			xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
> +				      i2c_8bit_addr_from_msg(msg) |
> +				      XIIC_TX_DYN_START_MASK);
> +
> +		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
> +
> +		/* If last message, include dynamic stop bit with length */
> +		val = (i2c->nmsgs == 1) ? XIIC_TX_DYN_STOP_MASK : 0;
> +		val |= msg->len;
> +
> +		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, val);
> +		local_irq_restore(flags);

Is local_irq_save()/local_irq_restore() used here to prevent concurrent 
access to the XIIC ?

[...]
