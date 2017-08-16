From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF device ID table
Date: Wed, 16 Aug 2017 11:36:25 +0200
Message-ID: <1b2335bb-50e5-5664-0e01-38902cf717f1@redhat.com>
References: <20170809101256.31204-1-javierm@redhat.com>
 <20170814195236.4miomp2omul5qikt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdHPJg2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 16 Aug 2017 05:36:28 -0400
In-Reply-To: <20170814195236.4miomp2omul5qikt@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Luis Oliveira <Luis.Oliveira@synopsys.com>, linux-i2c@vger.kernel.org

Hello Wolfram,

On 08/14/2017 09:52 PM, Wolfram Sang wrote:
> On Wed, Aug 09, 2017 at 12:12:56PM +0200, Javier Martinez Canillas wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees as shown in the following DT binding doc:
>>
>> Documentation/devicetree/bindings/i2c/i2c-designware.txt
> 
> Uhhh, that needs to be fixed to something else! I don't think i2c slave
> functionality should be described in DT. The slave functionality is pure
> software, so IMO it doesn't match the "HW description" requirement.
>

Right, indeed.
 
>> But this works on the assumption that a I2C device registered via OF will
>> always match a legacy I2C device ID and that the MODALIAS reported will
>> always be of the form i2c:<device>.
>>
>> And this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for finding the issue, still NAK to this patch. Are you
> interested in updating the docs?
> 

What kind of change are you looking for? The example was introduced by commit
04606ccc84e3 ("i2c: designware: introducing I2C_SLAVE definitions") that says:

- A example was added to designware-core.txt Documentation that shows
  how the slave can be setup using DTS

So I could change this example to instead use a real EEPROM compatible (e.g:
"microchip,24c02") instead of "linux,slave-24c02". Would that be correct?

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
