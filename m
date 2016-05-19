From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 2/2] i2c: qup: support SMBus block read
Date: Thu, 19 May 2016 15:21:48 -0500
Message-ID: <573E205C.9080701@codeaurora.org>
References: <1463006736-24652-1-git-send-email-nkaje@codeaurora.org>
 <1463006736-24652-2-git-send-email-nkaje@codeaurora.org>
 <000d01d1b0d3$d70e1f30$852a5d90$@codeaurora.org>
 <757c18e2-562a-9f43-0fb6-ab3e7ac3af88@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47669 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbcESUVv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 May 2016 16:21:51 -0400
In-Reply-To: <757c18e2-562a-9f43-0fb6-ab3e7ac3af88@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Naveen Kaje <nkaje@codeaurora.org>, Sricharan <sricharan@codeaurora.org>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, rruigrok@codeaurora.org, cov@codeaurora.org, austinwc@codeaurora.org, linux-arm-kernel@lists.infradead.org

Naveen Kaje wrote:
>>>
>>> +        tags[len++] = QUP_TAG_V2_DATARD;
>>> +        /* 0 implies 256 bytes */
>>> +        if (data_len == QUP_READ_LIMIT)
>>> +            tags[len++] = 0;
>>> +        else
>>> +            tags[len++] = data_len;
>>> +    }
>>         Even data_len will always be '1' right ?
> Yes, but here preferably we use a variable than a number without a context.

Actually, I would say the opposite.  I would rather see a constant with 
a comment explaining it, than a variable that we know will always 
contain only one number.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
