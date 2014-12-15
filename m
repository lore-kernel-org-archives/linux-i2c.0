From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] of: i2c: Add DT bindings for idle states to PCA954x mux
 driver
Date: Mon, 15 Dec 2014 13:08:39 +0100
Message-ID: <548ECF47.8030307@gmx.de>
References: <548E387E.2020502@nsn.com> <4262366.rJm0Aq2lpm@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4262366.rJm0Aq2lpm@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Laurent,

Am 15.12.2014 um 09:40 schrieb Laurent Pinchart:
> Hi Alexander,
>
> Thank you for the patch.
>
> On Monday 15 December 2014 02:25:18 Alexander Sverdlin wrote:
>> of: i2c: Add DT bindings for idle states to PCA954x mux driver
>>
>> Introduce two new device tree bindings to specify idle state of PCA954x
>> family of I2C multiplexors:
>>    - idle-state: specifies particular child bus to be selected in idle;
>>    - idle-disconnect: signals that mux should disconnect all child buses in
>> idle;
>
> Could you please briefly explain your use case(s) for those two properties ?

Rationale (which should be added) is:
If there are two or more multiplexers/switches connected to same bus 
unused ones need to be set to neutral/unconnected state, otherwise 
transactions to devices behind current multiplexer get visible to all 
buses lately addressed on the other multiplexers. This will lead to 
address conflicts for all devices with same address.

Usage of new bindings is xor.

KR
Michael
