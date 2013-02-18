From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: i2c: Multiplexed I2C bus core support
Date: Mon, 18 Feb 2013 11:19:34 +0100
Message-ID: <51220036.4030508@gmx.de>
References: <4C36E6E2.1070307@gmx.de> <511BB2F8.9020300@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <511BB2F8.9020300-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am 13.02.2013 16:36, schrieb Gerlando Falauto:
> Hi everyone,
> 
> On 07/09/2010 11:07 AM, Michael Lawnick wrote:
>> Add multiplexed bus core support. I2C multiplexer and switches
>> like pca954x get instantiated as new adapters per port.
>>
>> Signed-off-by: Michael Lawnick<demx1175@wbit01lx.(none)>
>> Cc: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> 
> I noticed that when you have multiple muxes connected to the same 
> branch, implementation hides some information about the complete i2c 
> topology.
> 
> So for instance if I have something like (notice there are three 
> PCA9544's "in parallel", each with its own address, which I assume is a 
> bit unusual):
> 
> #  CPU (i2c-0)
> #  '--I2C Mux0 (PCA9547) @ 0x70
> #      +--Port0 (i2c-1)
> #      +--Port1 (i2c-2)
> #      +--Port2 (i2c-3)
> #      +--Port3 (i2c-4)
> #      +--Port4 (i2c-5)
> #      |   '--- I2C Mux1 (PCA9544) @ 0x74
> #      |   |     +--Port0 (i2c-9)
> #      |   |     +--Port1 (i2c-10)
> #      |   |     +--Port2 (i2c-11)
> #      |   |     '--Port3 (i2c-12)
> #      |   +--- I2C Mux2 (PCA9544) @ 0x71
> #      |   |     +--Port0 (i2c-13)
> #      |   |     +--Port1 (i2c-14)
> #      |   |     +--Port2 (i2c-15)
> #      |   |     '--Port3 (i2c-16)
...
> which only reveals i2c-9 is the bus segment connected to channel 0 of a 
> mux behind i2c-5, but since there's two of them, I have no way to tell 
> which one...
> 
> So I guess the easiest thing to do would be to add this information 
> within the .name attribute, though I fear this may somehow turn out not 
> as trivial at it looks.

Jean already detected this problem when mux code was brought into
kernel, but solution was postponed until someone gets enough pain ;-)
On my project I do no automatic i2c detection, but all is controlled via
user space. So I always know where and which devices and buses get
connected.

> 
> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-0(=>...i2c-9)
> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-1(=>...i2c-10)
> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-2(=>...i2c-11)
> devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-3(=>...i2c-12)

Introducing links to sub-buses, named with respective channel id sounds
good for me. Beside that your link example does not reflect your ASCII
graphics of course ;-)

-- 
KR
Michael
