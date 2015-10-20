From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] dts: keystone: Use new "ti,keystone-i2c" compatible
Date: Tue, 20 Oct 2015 19:10:57 +0300
Message-ID: <56266791.5000805@ti.com>
References: <55F68E36.2030609@nokia.com> <20151020150614.GG5379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38211 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbJTQLU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 12:11:20 -0400
In-Reply-To: <20151020150614.GG5379@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Sekhar Nori <nsekhar@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On 10/20/2015 06:06 PM, Wolfram Sang wrote:
> On Mon, Sep 14, 2015 at 11:07:02AM +0200, Alexander Sverdlin wrote:
>> Now as "i2c-davinci" driver has special handling for Keystone it's time to switch
>> the device tree to use new "compatible" property. Old one is left for backwards-
>> compatibility.
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
> Shall I take this one or shall it go via the davinci tree?
>

To: Sekhar

-- 
regards,
-grygorii
