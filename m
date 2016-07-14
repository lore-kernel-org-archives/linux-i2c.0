From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RESEND][PATCH 1/2] i2c: versatile: Allow compile test build
Date: Thu, 14 Jul 2016 11:51:14 +0100
Message-ID: <57876EA2.5000106@arm.com>
References: <1468042283.21863.2.camel@ingics.com>
 <20160711084457.GI8609@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41956 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbcGNKvS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 06:51:18 -0400
In-Reply-To: <20160711084457.GI8609@e106497-lin.cambridge.arm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Liviu Dudau <liviu.dudau@arm.com>, Axel Lin <axel.lin@ingics.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-i2c@vger.kernel.org



On 11/07/16 09:44, Liviu Dudau wrote:
> On Sat, Jul 09, 2016 at 01:31:23PM +0800, Axel Lin wrote:
>> There is no build dependency for this driver, so enable COMPILE_TEST to get
>> better build coverage.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> For the whole series:
>
> Tested-and-acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Thanks Liviu for testing them. Since these are cleanup patches, they
need to wait for v4.9, PR for v4.8 already sent and pulled.

-- 
Regards,
Sudeep
