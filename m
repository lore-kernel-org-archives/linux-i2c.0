From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] V4L/DVB: Use custom I2C probing function mechanism
Date: Mon, 5 Apr 2010 23:06:16 +0200
Message-ID: <20100405230616.443792ac@hyperion.delvare>
References: <20100404161454.0f99cc06@hyperion.delvare>
	<4BBA2B58.4000007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BBA2B58.4000007-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LMML <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mauro,

On Mon, 05 Apr 2010 15:26:32 -0300, Mauro Carvalho Chehab wrote:
> Jean Delvare wrote:
> > Now that i2c-core offers the possibility to provide custom probing
> > function for I2C devices, let's make use of it.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> > I wasn't too sure where to put the custom probe function: in each driver,
> > in the ir-common module or in the v4l2-common module. I went for the
> > second option as a middle ground, but am ready to discuss it if anyone
> > objects.
> 
> Please, don't add new things at ir-common module. It basically contains the
> decoding functions for RC5 and pulse/distance, plus several IR keymaps. With
> the IR rework I'm doing, this module will go away, after having all the current 
> IR decoders implemented via ir-raw-input binding. 
> 
> The keymaps were already removed from it, on my experimental tree 
> (http://git.linuxtv.org/mchehab/ir.git), and rc5 decoder is already written
> (but still needs a few fixes). 
> 
> The new ir-core is creating an abstract way to deal with Remote Controllers,
> meant to be used not only by IR's, but also for other types of RC, like, 
> bluetooth and USB HID. It will also export a raw event interface, for use
> with lirc. As this is the core of the RC subsystem, a i2c-specific binding
> method also doesn't seem to belong there. SO, IMO, the better place is to add 
> it as a static inline function at ir-kbd-i2c.h.

Ever tried to pass the address of an inline function as another
function's parameter? :)

-- 
Jean Delvare
