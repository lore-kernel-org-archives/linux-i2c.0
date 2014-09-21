From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices addresses
Date: Sun, 21 Sep 2014 21:23:25 +0200
Message-ID: <541F25AD.7030204@metafoo.de>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com> <20140920164858.GA2260@katana> <541DDA9B.40904@metafoo.de> <20140921174902.GA1479@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140921174902.GA1479@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/21/2014 07:49 PM, Wolfram Sang wrote:
>
>>> This raises the first question for me: Are the additional addresses
>>> configurable? Sadly, I can't find good documentation for the adv7604.
>>> Otherwise, if I know I have a adv7604 and know its addresses, this
>>> information should go into the driver and not the DT.
>>>
>>
>> They are. The current driver hard codes the other addresses, but that's not
>> working when you have multiple adv7604s on the same I2C bus.
>
> How is this configured? I can't imagine every address has its own
> setting, but rather some 1-3 pins which select a certain block of
> addresses?
>

Every secondary address has its own register and can be set to any valid I2C 
address.

- Lars
