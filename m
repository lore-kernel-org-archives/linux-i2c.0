From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: i2c: add bindings for nxp,pca9541
Date: Wed, 6 Jul 2016 08:12:08 -0700
Message-ID: <577D1FC8.2080801@roeck-us.net>
References: <1467022282-21062-1-git-send-email-peda@axentia.se>
 <57712770.3040204@roeck-us.net>
 <d7476000-e50c-b840-00a5-7eab1a0823fb@axentia.se>
 <20160701012044.GA5619@rob-hp-laptop>
 <38896151-6ba8-75a8-56c2-19bddbf5b75a@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59750 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbcGFPMX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 11:12:23 -0400
In-Reply-To: <38896151-6ba8-75a8-56c2-19bddbf5b75a@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 07/06/2016 03:12 AM, Peter Rosin wrote:
> On 2016-07-01 03:20, Rob Herring wrote:
>> On Mon, Jun 27, 2016 at 06:27:21PM +0200, Peter Rosin wrote:
>>> On 2016-06-27 15:17, Guenter Roeck wrote:
>>>> On 06/27/2016 03:11 AM, Peter Rosin wrote:
>>>>> Fill the gap for this pre-existing driver.
>>>>>
>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>> ---
>>>>>    .../devicetree/bindings/i2c/i2c-arb-pca9541.txt    | 33 ++++++++++++++++++++++
>>>>>    MAINTAINERS                                        |  1 +
>>>>>    2 files changed, 34 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
>>>>>
>>>>> Hi!
>>>>>
>>>>> I'm wondering about this driver. It is not a trivial device, and yet it
>>>>> has historically relied on the i2c core matching the chip w/o vendor
>>>>> prefix. This is not ideal. But what to do about the driver implementing
>>>>> this in terms of an i2c-mux, somthing which the chip is not; It is an
>>>>> i2c arbitrator. It just happens to rely on the i2c mux core also handling
>>>>> i2c gates and i2c arbitrators. But that seems like a Linux detail. So I
>>>>> don't know what to do here?
>>>>>
>>>>
>>>> The concept of arbitrators didn't exist when I wrote the driver. I would not
>>>> have a problem with renaming the file if that is what you are asking for.
>>>
>>> No, that was not my issue, I just wanted to document bindings for pca9541,
>>> and I didn't like how it turned out.
>>>
>>> I don't really care if the bindings doc is named i2c-mux-pca9541.txt (that
>>> would match the name of the driver, but it still wouldn't make the chip a mux).
>>
>> So name it i2c-pca9541.txt or the somewhat standard nxp,pca9541.txt
>> following the compatible.
>>
>>>
>>>>> That is, the patch - as is - describes something that would be trivial to
>>>>> support today, but at the same time it seems to be too tied to Linux.
>>>>>
>>>>> The problem is that the i2c@0 intermediate node is not really needed, but
>>>>> at the same time removing it would cause a disruption for the driver since
>>>>> it can't really use the i2c mux core if that node isn't there. I don't
>>>>> see a simple way to fix that in the i2c mux core either (but admittedly
>>>>> haven't given it too much thought).
>>>>>
>>>>
>>>> The gpio arbitrator uses the same principle as well. Why not just leave it
>>>> alone ? Besides, I think it is a good idea to have it, since it groups
>>>> the i2c devices behind the chip together. I would not consider that to be
>>>> a Linuxism, but a design choice.
>>>
>>> The grouping argument would make sense if there was anything outside the
>>> group. Also, the required reg property and the extra #address-cells and
>>> #size-cells doesn't add anything and just gets in the way, and is indeed
>>> the result of Linuxisms leaking back into device trees.
>>>
>>> If there were no muxes and this was a new driver, the example bindings
>>> would almost certainly have been something like:
>>>
>>> 	i2c-arbitrator@74 {
>>> 		compatible = "nxp,pca9541";
>>> 		reg = <0x74>;
>>>
>>> 		#address-cells = <1>;
>>> 		#size-cells = <0>;
>>>
>>> 		eeprom@54 {
>>> 			compatible = "at,24c08";
>>> 			reg = <0x54>;
>>> 		};
>>> 	};
>>>
>>> which I find much nicer.
>>
>> Yes.
>>
>>> But, I can't find a way to implement that and keep backwards compatibility
>>> with old existing device trees.
>>
>> I don't see any in the kernel tree nor is it documented, so there is not
>> compatibility to worry about.
>
> Why do you not care about pre-existing device trees not submitted
> to mainline? Is there some statement that DTs are not covered by the
> no-regressions-rule?
>
> So, if I instead had submitted the device tree for my boring
> one-off-ish hardware that few people will ever use, which uses the
> currently working (i.e. as written in my patch) syntax of configuring
> the pca9541 in a device tree, then there would be a "user", things
> would be set in stone and the DT patch as proposed would be
> acceptable?
>
> That is just silly, as I assume you do not want the churn of the
> device trees for all kinds of strange one-off devices? Or do you?
>
> We also have to consider the fact that Guenter (who authored the
> driver) thinks it's a design choice to have the extra DT level...
>

I don't see the point, I think it hurts readability, and I preferred
to have i2c properties clearly separated from arbiter properties.
Given that the current properties are not broken, I think it is just
a change for the sake of a change. I dislike the notion that changes for
the sake of changes are ok as long as there are no in-kernel uses (after all,
this can go both ways). In short, I don't like it, but then I don't have
to like or approve it either, so that doesn't mean much.

I assume this will be changed for all arbiters, to have a consistent set
of bindings for the same type of devices ? Or will i2c-arb-gpio-challenge
be unmodified since it _does_ have an in-kernel users, and it will be up
to each arbiter to define and implement its own devicetree bindings model ?

Guenter
