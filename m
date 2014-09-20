From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices addresses
Date: Sat, 20 Sep 2014 21:50:51 +0200
Message-ID: <541DDA9B.40904@metafoo.de>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com> <20140920164858.GA2260@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140920164858.GA2260@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/20/2014 06:49 PM, Wolfram Sang wrote:
> On Fri, Sep 05, 2014 at 04:02:19PM +0200, Jean-Michel Hautbois wrote:
>> Some I2C devices have multiple addresses assigned, for example each address
>> corresponding to a different internal register map page of the device.
>> So far drivers which need support for this have handled this with a driver
>> specific and non-generic implementation, e.g. passing the additional address
>> via platform data.
>
> This raises the first question for me: Are the additional addresses
> configurable? Sadly, I can't find good documentation for the adv7604.
> Otherwise, if I know I have a adv7604 and know its addresses, this
> information should go into the driver and not the DT.
>

They are. The current driver hard codes the other addresses, but that's not 
working when you have multiple adv7604s on the same I2C bus.

- Lars
