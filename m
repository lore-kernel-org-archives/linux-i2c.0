From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Fri, 10 Jun 2016 13:07:03 +0100
Message-ID: <575AAD67.5070804@bingham.xyz>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <20160609191513.GB23522@katana>
 <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
 <20160609200405.GE23522@katana> <575A9082.9060804@bingham.xyz>
 <20160610110027.GA1626@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36308 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcFJMHH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Jun 2016 08:07:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so17414650wme.3
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jun 2016 05:07:06 -0700 (PDT)
In-Reply-To: <20160610110027.GA1626@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Hi Wolfram,

On 10/06/16 12:00, Wolfram Sang wrote:
> 
>> Is this what you were looking for?
> 
> Mostly, thanks. This verifies that the old way still works. Good!
> 
> The new way (no i2c_device_ids, just compatibles) will need Javier's
> patch to work with module auto loading, I know. But what about userspace
> instantiation with built-in driver? I didn't understand if this was
> tested using the new way. And do you need then the full-compatible or
> the vendor-stripped string?

When I reported :

> * new_device (built-in, and external module)
> echo ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
> cat /sys/class/rtc/rtc0/date
> 
> - Both of those worked fine.

That was *without* Javier's patch, but hopefully obviously *with* Lee's
patchset.

Do you need this testing *with* Javiers patch as well?
I have not tested this combination.

I've already switched my dev board environment back to the Salvator-X
for $DAYJOB and switching back now will have to wait to the weekend.


> Thanks,
> 
>    Wolfram
> 

-- 
Regards

Kieran Bingham
