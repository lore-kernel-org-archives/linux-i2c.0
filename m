From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 3/3] i2c: iproc: Support larger TX transfer
Date: Fri, 12 Feb 2016 11:33:53 -0800
Message-ID: <82574e4c-45b1-e312-4714-63712d7a4317@broadcom.com>
References: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
 <1453940842-9658-4-git-send-email-rjui@broadcom.com>
 <20160212193308.GS1520@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:5499 "EHLO
	mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbcBLTdy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 12 Feb 2016 14:33:54 -0500
In-Reply-To: <20160212193308.GS1520@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ray Jui <rjui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>



On 2/12/2016 11:33 AM, Wolfram Sang wrote:
>> @@ -293,7 +360,7 @@ static const struct i2c_algorithm bcm_iproc_algo = {
>>  static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
>>  	/* need to reserve one byte in the FIFO for the slave address */
>>  	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
>> -	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
>> +	.max_write_len = 65535,
>
> You can simply remove this line because len is u16 in the i2c core anyhow.
>

Okay will do. Thanks!

Ray
