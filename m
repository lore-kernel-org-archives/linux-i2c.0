From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 0/3] i2c: Hookup typec power-negotation to the PMIC and
 charger
Date: Thu, 19 Oct 2017 16:54:27 +0200
Message-ID: <4f00b1f8-2574-b924-f1e6-f6e7a2ee66f8@redhat.com>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <CAHp75VeqskRsmedvA3eAx27o8WeZzH44880T=Q=+1mD+1nSSAg@mail.gmail.com>
 <e875d3d3-d62c-7363-e596-9c0dbeadce5d@redhat.com>
 <20171019144251.hmvkaijwbgamaqoo@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753633AbdJSOyb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 19 Oct 2017 10:54:31 -0400
In-Reply-To: <20171019144251.hmvkaijwbgamaqoo@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>

Hi,

On 19-10-17 16:42, Wolfram Sang wrote:
> 
>> The first patch, although it is an i2c-core change, is really
>> quite simple. I believe anyone can review it. But it does need
>> someone other then me to take a proper look (and not just do
>> a code only review) because it is a core change. Maybe there
>> is another way to solve the problem (persistent / predictable
>> device-names for i2c devices instantiated through board-data),
>> but I don't think so.
> 
> My plan is to hopefully meet Mark Brown (SPI and regulator maintainer)
> at ELCE next week and have a chat with him about this series. If all
> goes well, I'll merge it for v4.15.

Great, thank you for looking into this.

Regards,

Hans
