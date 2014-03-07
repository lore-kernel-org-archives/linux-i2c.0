From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Fri, 07 Mar 2014 14:49:32 +0100
Message-ID: <5319CE6C.2020001@samsung.com>
References: <5305382E.9050902@gmail.com>
 <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
 <53073C51.5010401@samsung.com> <20140228060728.GB29849@sirena.org.uk>
 <5315BB34.8080803@samsung.com> <20140305011530.GN13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140305011530.GN13126-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 05/03/14 02:15, Mark Brown wrote:
> On Tue, Mar 04, 2014 at 12:38:28PM +0100, Sylwester Nawrocki wrote:
>> On 28/02/14 07:07, Mark Brown wrote:
>>> On Fri, Feb 21, 2014 at 12:45:21PM +0100, Sylwester Nawrocki wrote:
> 
>>>> The I2C bus driver with empty i2c_algorithm.master_xfer() helps WRT to
>>>> using standard DT binding and v4l2_subdev interface.
> 
>>> Wouldn't a platform device do just as well here if there's no actual
>>> control?
> 
>> Then the I2C client devices would have to be instantiated manually, 
>> I think it's more trouble.
> 
> I2C is not that much more enumerable than platform bus, I don't see the
> difference here?  To the extent I2C is enumerable a dummy adaptor isn't
> going to support that.

Yes, it won't be enumerable, I just meant allocating client devices 
would need to be taken care of, rather that having this handled entirely 
by, e.g. i2c-core. 

>> I could as well create custom I2C client drivers per ISP, but then the 
>> I2C devices would have to be represented somehow in DT, to pass stuff 
>> like voltage regulators and GPIOs. Anyway, it's not something could be 
>> done in mainline.
> 
> Why not?

Well, my concern was that existing sub-device drivers would need to be
extended to handle other bus types, like the platform bus.

And since that very same device could be controlled by the host CPU or
not, it just depends what host interface/SoC it is linked to, such
a complication may not be justified.  It's like introducing bridge/host 
details to the client drivers. In general the sub-devices should be
host-agnostic.

>> Even if there is no actual I2C communication on the host CPU side, the 
>> power up/down sequence is handled there. The intention is to keep this 
>> common per an I2C client, regardless of whether I2C communication is 
>> done by firmware or the host the CPU.
> 
> The way you're talking it sounds like your code is very hard coded to
> use I2C here.  What happens if someone uses SPI or some other bus to
> control an ISP?

The other busses, like SPI, are also handled the V4L2 subdev in 
a standard way.  The host just need to be aware on what control bus 
a subdev is located on, to get hold of it.

Let me add that for image sensors I2C is used as a control bus in 
majority of cases.  An I2C-compatible (CCI) bus is specified as 
a control bus by the MIPI CSI-2 specification. With newer version 
of the standard we may need to create a MIPI CSI (control) bus.
