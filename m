From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Thu, 1 Dec 2016 14:23:46 +0200
Message-ID: <f50333f5-906b-fe9a-3e5b-e74522472d06@mleia.com>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
 <d31d7cd0-4b00-4db0-2a51-cf3e553e6df8@mleia.com>
 <1480514806.2258.68.camel@pengutronix.de>
 <f259bd4b-788c-0bc2-25b8-7e0a735af859@mleia.com>
 <1480586832.17003.28.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:35284 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933717AbcLAMcn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 07:32:43 -0500
In-Reply-To: <1480586832.17003.28.camel@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On 12/01/2016 12:07 PM, Lucas Stach wrote:
> Am Mittwoch, den 30.11.2016, 22:18 +0200 schrieb Vladimir Zapolskiy:
>> On 11/30/2016 04:06 PM, Lucas Stach wrote:
>>> Am Mittwoch, den 30.11.2016, 15:54 +0200 schrieb Vladimir Zapolskiy:
>>>> Hello Lucas,
>>>>
>>>> On 11/30/2016 01:50 PM, Lucas Stach wrote:
>>>>> DDC buses are manually managed by their consumers to communicate
>>>>> with the display. There is no need to try to populate OF childs.
>>>>>
>>>>> This gets rid of the device create failed warning caused by the
>>>>> core trying to populate a DDC bus below a OF device, which has
>>>>> other childs nodes, that aren't i2c devices.
>>>>
>>>> what kind of devices on a DDC bus represended by children nodes
>>>> do you reference here?
>>>
>>> None. The device registering the DDC i2c adapter might have an of_node.
>>> The children of this device are not i2c devices, but for example port
>>> nodes for the of_graph binding.
>>
>> Port node shall not be a child of any DDC bus device node, otherwise it
>> contradicts to the hierarchy of hardware blocks. It is a common practice
>> to describe port nodes and DDC bus adapter as siblings (devices which
>> share the same display controller / encoder device). Do I miss something?
>>
>>> The same issue can be worked around if we make it explicit by placing an
>>> "i2c-bus" subnode with no children into the parent device OF node. But
>>> as the OF probing of devices on a DDC bus just doesn't make sense I
>>> figured it would be good to just skip all this.
>>>
>>
>> Right, as a micro optimization the change makes sense (*), but the second
>> paragraph in the commit message is questionable.
>>
>> In my opinion it makes sense to include the change, and the warning
>> you mention in the commit message needs its own attention as an indicator
>> of potentially wrongly chosen representation of the device hierarchy.
>>
> Okay to get away from the purely theoretical speaking here: the issue
> this patch fixes is seen with the tc358767 parallel-to-eDP bridge.
> (Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.txt)
> 
> The bridge itself is represented in the DT, so it has a OF node. It then
> goes on to register the i2c over DP AUX channel i2c adapter with its own
> device node, which is what all consumers of the i2c_add_adapter() API so
> AFAICS.
> The i2c adapter has no own representation in the DT, as it's a pure
> software construct, after all it's just an emulated i2c bus over DP,
> there are no physical i2c wires.
> 
> The i2c adapter then tries to populate the bridges children as if they
> were i2c devices, which is clearly wrong. We could fix this by creating
> an own device for the i2c adapter, but that's not how things are handled
> today and would require changes to all consumers of this API.
> 

Is it correct to register dpaux device node as an I2C bus controller device
node, what is the purpose? If it is has to be done, then bindings/i2c/i2c.txt
documentation must be updated to remove #address-cells and #size-cells
properties from the list of required properties for DDC class adapters.

Shallow review of DTS files and dpaux drivers let me say that the change
below has no regressions (the change is untested):

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 3e6fe82..f91ade1 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1020,7 +1020,6 @@ int drm_dp_aux_register(struct drm_dp_aux *aux)
 	aux->ddc.class = I2C_CLASS_DDC;
 	aux->ddc.owner = THIS_MODULE;
 	aux->ddc.dev.parent = aux->dev;
-	aux->ddc.dev.of_node = aux->dev->of_node;
 
 	strlcpy(aux->ddc.name, aux->name ? aux->name : dev_name(aux->dev),
 		sizeof(aux->ddc.name));


--
With best wishes,
Vladimir
