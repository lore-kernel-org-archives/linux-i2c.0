From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH 1/3] i2c: iproc: Add recovery mechanism in error case
Date: Fri, 12 Feb 2016 11:32:53 -0800
Message-ID: <00a4c0fe-962c-3e76-fb53-1c5eadb95af9@broadcom.com>
References: <1453940842-9658-1-git-send-email-rjui@broadcom.com>
 <1453940842-9658-2-git-send-email-rjui@broadcom.com>
 <20160212193119.GR1520@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:49031
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751210AbcBLTcz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 12 Feb 2016 14:32:55 -0500
In-Reply-To: <20160212193119.GR1520@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ray Jui <rjui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>



On 2/12/2016 11:31 AM, Wolfram Sang wrote:
>> +static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c);
>> +static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
>> +					 bool enable);
>
> Can't we move these functions instead of having the extra declarations?
>

I had the same opinion during our internal review, :)

I'll do that in the next revision of this patch set.

Thanks,

Ray
