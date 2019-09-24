From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v1 1/1] i2c: iproc: Add i2c repeated start capability
Date: Tue, 24 Sep 2019 15:23:57 -0700
Message-ID: <e00520d8-5367-83a5-9c17-d2d8b0c983c3@broadcom.com>
References: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190830125626.GC2870@ninjato>
 <3e70fa7e-de13-4edd-2e17-b7c56e91d220@broadcom.com>
 <20190831094940.GA1138@kunai>
 <540c4e2d-0dd5-5260-30b2-e1589b279d71@broadcom.com>
 <20190904213745.GG23608@ninjato>
 <5ab79d0e-eb54-8fe1-1ca3-e763a17c6426@broadcom.com>
 <20190924185757.GA1538@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924185757.GA1538@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Lori Hikichi <lori.hikichi@broadcom.com>, Icarus Chau <icarus.chau@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 9/24/19 11:57 AM, Wolfram Sang wrote:
> 
>> In my opinion, it's probably better to continue to support master_xfer in
>> our driver (with obvious limitations), in order to allow i2ctransfer (or any
>> apps that use I2C RDWR) to continue to work.
>>
>> What do you think?
> 
> Yes, don't break it for users. We should have paid more attention to it
> in the beginning. But, while not ideal, it is not such a big deal to
> keep it like this.
> 
> Thanks for your investigations!
> 

Thanks, Wolfram.

Let's please continue with the review process on the current patch then?

Note the patch was already internally reviewed by me.

Please help to review it and let us know if there's any change that 
needs to be made?

Regards,

Ray
