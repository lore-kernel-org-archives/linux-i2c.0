From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v2] dts: keystone: Use new "ti,keystone-i2c" compatible
Date: Wed, 21 Oct 2015 09:42:25 -0700
Message-ID: <5627C071.5090108@oracle.com>
References: <55F68E36.2030609@nokia.com> <56276B3E.3020208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40442 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbJUQmv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 12:42:51 -0400
In-Reply-To: <56276B3E.3020208@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Sekhar Nori <nsekhar@ti.com>

On 10/21/15 3:38 AM, Grygorii Strashko wrote:
> On 09/14/2015 12:07 PM, Alexander Sverdlin wrote:
>> Now as "i2c-davinci" driver has special handling for Keystone it's
>> time to switch
>> the device tree to use new "compatible" property. Old one is left for
>> backwards-
>> compatibility.
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>> ---
>
Will pick it up. Thanks !!

Regards,
Santosh
