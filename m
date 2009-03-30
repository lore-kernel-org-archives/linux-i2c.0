From: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Mon, 30 Mar 2009 12:07:41 +0300
Message-ID: <49D08BDD.50509@gmail.com>
References: <49C89E13.7040801@gmail.com> <20090324094215.GA3471@pengutronix.de> <49C8ABE5.40408@gmail.com> <20090325092625.GA3029@pengutronix.de> <49CA017D.20005@gmail.com> <20090325104357.GB3029@pengutronix.de> <Pine.LNX.4.64.0903282207480.9903@axis700.grange> <20090330092402.GA31781@sirena.org.uk> <Pine.LNX.4.64.0903301128540.4455@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903301128540.4455-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <public-g.liakhovetski-Mmb7MZpHnFY-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
Cc: Mark Brown <public-broonie-GFdadSzt00ze9xe1eoZjHA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, Wolfram Sang <public-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, Darius Augulis <public-augulis.darius-Re5JQEeQqe8AvxtiuMwx3w-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>, public-linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org, public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org, Sascha Hauer <public-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ-z5DuStaUktnZ+VzJOa5vwg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



Guennadi Liakhovetski wrote:
> On Mon, 30 Mar 2009, Mark Brown wrote:
> 
>> On Sat, Mar 28, 2009 at 10:36:50PM +0100, Guennadi Liakhovetski wrote:
>>> different drivers, and I really hoped its new version will work 
>>> out-of-the-box in my setup (pcm037 with a mt9t031 camera). Unfortunately, 
>>> it didn't. I've spent more than a full working day trying to get it to 
>>> work, but I didn't succeed so far. It works with the on-board rtc, but it 
>>> doesn't work with the camera, connected over a flex cable.
>> What problems are you experiencing?  I've been using versions of Darius'
>> driver for a while now with no problems on my system.
> 
> I couldn't read camera ID register during probing. As I mentioned, the 
> camera is connected over a, hm, limited-quality self-soldered (by 
> professionals) cable, and I have to reduce bus clock to 20kHz. Has anyone 
> tested this driver with lower frequencies?

yes, I tested this with low frequencies (tens of kHz) and high freq. (400kHz).

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
