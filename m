From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Mon, 16 Mar 2015 21:15:29 +0100
Message-ID: <550739E1.4010607@gmail.com>
References: <1425039885-5137-2-git-send-email-sebastian.hesselbarth@gmail.com> <1425903665-19343-1-git-send-email-sebastian.hesselbarth@gmail.com> <54FF1BAA.3060409@wwwdotorg.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54FF1BAA.3060409-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10.03.2015 17:28, Stephen Warren wrote:
> On 03/09/2015 06:21 AM, Sebastian Hesselbarth wrote:
>> I2C mux pinctrl driver currently determines the number of sub-busses by
>> counting available pinctrl-names. Unfortunately, this requires each
>> incarnation of the devicetree node with different available sub-busses
>> to be rewritten.
>>
>> This patch reworks i2c-mux-pinctrl driver to count the number of
>> available sub-nodes instead. The rework should be compatible to the old
>> way of probing for sub-busses and additionally allows to disable unused
>> sub-busses with standard DT property status = "disabled".
>>
>> This also amends the corresponding devicetree binding documentation to
>> reflect the new functionality to disable unused sub-nodes. While at it,
>> also fix two references to binding documentation files that miss an
>> "i2c-"
>> prefix.
>
> The DT binding changes at least,
> Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Wolfram,

are you going to pick this patch through your tree now that Stephen
ack'ed the binding documentation change, too?

I can also split the patch up into driver/doc changes if you prefer.

Sebastian
