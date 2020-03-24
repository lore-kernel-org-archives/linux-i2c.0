From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: A bit confused on i2c communication between modules
Date: Tue, 24 Mar 2020 10:49:55 +0000
Message-ID: <7d82a76f-5165-5e7c-bcde-552f527da0d2@ideasonboard.com>
References: <55204992-9060-6008-31c7-c2855f712e70@gmail.com>
 <20200324082236.2c4d2ae4@coco.lan>
 <bc91be3d-802c-a58c-bd27-740e15516180@ideasonboard.com>
 <20200324095810.GC1134@ninjato>
 <63742e62-d0b6-9d7a-b491-d7969f8ea7e2@ideasonboard.com>
 <20200324102704.GD1134@ninjato>
Reply-To: kieran.bingham@ideasonboard.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:42438 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCXKuB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Mar 2020 06:50:01 -0400
In-Reply-To: <20200324102704.GD1134@ninjato>
Content-Language: en-GB
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, sean@mess.org, Shuah Khan <skhan@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

+cc: linux-i2c@vger.kernel.org
Moving /this/ to the linux-i2c list ;-)

Thanks Wolfram,

On 24/03/2020 10:27, Wolfram Sang wrote:
> 
>> Maybe we should have a whole virtual I2C bus for virtual devices :-)
>>
>> (Hrm, that started out as a joke, and now I'm not sure if it's a real
>> option or not...)
> 
> Just one final thought: I think this is actually the best option. Zero
> chance of address collisions (which could happen if you have a not
> perfectly-described real HW bus). No RPM mangling of real and virtual
> devices. A clear seperation what is real and what is virtual. Plus, you
> can implement it right away, no need to wait for the dynamic address
> assignment.

Agreed - even better all round! But I presume we don't yet have a
'virtual' i2c bus? So it's a patch-set to do first? Or is it already
feasible?

I see references to 'i2c-virtual.c' and 'i2c-virt.c', but I can't find
those files or any config options themselves...

-- 
Regards
