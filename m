From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Tue, 31 Mar 2009 14:02:52 +0300
Message-ID: <49D1F85C.8040703@gmail.com>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de> <49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de> <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de> <Pine.LNX.4.64.0903282207480.9903@axis700.grange> <20090330003012.GM19758@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090330003012.GM19758-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Sat, Mar 28, 2009 at 10:36:50PM +0100, Guennadi Liakhovetski wrote:
>   
>> On Wed, 25 Mar 2009, Wolfram Sang wrote:
>>
>>     
>>>> Because I hurry to submit this, because merge window is open.
>>>>         
>> Ok, I waited for this driver, I really did, and I really prefer having one 
>> driver for as many hardware (SoC) variants as possible instead of having 
>> different drivers, and I really hoped its new version will work 
>> out-of-the-box in my setup (pcm037 with a mt9t031 camera). Unfortunately, 
>> it didn't. I've spent more than a full working day trying to get it to 
>> work, but I didn't succeed so far. It works with the on-board rtc, but it 
>> doesn't work with the camera, connected over a flex cable.
>>
>> Attached to this email is a version of the i2c driver for i.mx31 that I've 
>> been using with my setup for about half a year now. I adjusted it slightly 
>> to accept the same platform data, so, it is really a drop-in replacement 
>> for i2c-imx.c. Of course, you have to adjust or extend the Makefile. I 
>> actually added a new Kconfig entry for this driver, so I could easily 
>> compare them during the tests.
>>
>> The source of "my" version does look more logical and more clean to me on 
>> quite a few occasions. So, maybe someone could give it a quick spin on 
>> other *mx* SoCs and see if we can use this one instead? You might have to 
>> replace {read,write}w with readb and writeb, so, it might be a good idea 
>> to abstract them into inlines or macros. Otherwise, I think, it might work 
>> for other CPUs straight away.
>>
>> I just would like to avoid committing a driver and having to spend hours 
>> or days fixing it afterwards when a possibly more mature version exists.
>>     
>
> I'm going to hold off pushing my current tree until this/tommorow
> evening so that people have some time to get back to me on what is
> the best way to proceed.
>  
>   

Hi Ben,

Jean already requested Linus to pull I2C updates, how about imx-i2c?
Should we have this in rc1?

Darius.
