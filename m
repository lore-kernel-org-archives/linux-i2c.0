From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: i2c: Multiplexed I2C bus core support
Date: Wed, 13 Feb 2013 16:36:24 +0100
Message-ID: <511BB2F8.9020300@keymile.com>
References: <4C36E6E2.1070307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C36E6E2.1070307-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

On 07/09/2010 11:07 AM, Michael Lawnick wrote:
> Add multiplexed bus core support. I2C multiplexer and switches
> like pca954x get instantiated as new adapters per port.
>
> Signed-off-by: Michael Lawnick<demx1175@wbit01lx.(none)>
> Cc: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>

I noticed that when you have multiple muxes connected to the same 
branch, implementation hides some information about the complete i2c 
topology.

So for instance if I have something like (notice there are three 
PCA9544's "in parallel", each with its own address, which I assume is a 
bit unusual):

#  CPU (i2c-0)
#  '--I2C Mux0 (PCA9547) @ 0x70
#      +--Port0 (i2c-1)
#      +--Port1 (i2c-2)
#      +--Port2 (i2c-3)
#      +--Port3 (i2c-4)
#      +--Port4 (i2c-5)
#      |   '--- I2C Mux1 (PCA9544) @ 0x74
#      |   |     +--Port0 (i2c-9)
#      |   |     +--Port1 (i2c-10)
#      |   |     +--Port2 (i2c-11)
#      |   |     '--Port3 (i2c-12)
#      |   +--- I2C Mux2 (PCA9544) @ 0x71
#      |   |     +--Port0 (i2c-13)
#      |   |     +--Port1 (i2c-14)
#      |   |     +--Port2 (i2c-15)
#      |   |     '--Port3 (i2c-16)
#      |   '--- I2C Mux3 (PCA9544) @ 0x72
#      |         +--Port0 (i2c-17)
#      |         +--Port1 (i2c-18)
#      |         +--Port2 (i2c-19)
#      |         '--Port3 (i2c-20)
#      +--Port5 (i2c-6)
#      +--Port6 (i2c-7)
#      '--Port7 (i2c-8)


under /sys/bus/i2c/devices/ I get:

0-0010 -> ../../../devices/platform/i2c-gpio/i2c-0/0-0010
0-0011 -> ../../../devices/platform/i2c-gpio/i2c-0/0-0011
0-0070 -> ../../../devices/platform/i2c-gpio/i2c-0/0-0070
5-0071 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/5-0071
5-0072 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/5-0072
5-0074 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/5-0074
|2c-0 -> ../../../devices/platform/i2c-gpio/i2c-0
i2c-1 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-1
i2c-2 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-2
i2c-3 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-3
i2c-4 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-4
i2c-5 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5
i2c-6 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-6
i2c-7 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-7
i2c-8 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-8
i2c-9 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-9
i2c-10 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-10
i2c-11 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-11
i2c-12 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-12
i2c-13 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-13
i2c-14 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-14
i2c-15 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-15
i2c-16 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-16
i2c-17 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-17
i2c-18 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-18
i2c-19 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-19
i2c-20 -> ../../../devices/platform/i2c-gpio/i2c-0/i2c-5/i2c-20

So I have no way of telling that:

  i2c-{9,10,11,12} are connected to mux1 at address 0x74 of i2c-5
  i2c-{13,14,15,16} are connected to mux2 at address 0x71 of i2c-5
  i2c-{17,18,19,20} are connected to mux3 at address 0x72 of i2c-5

because I get:

# cat /sys/bus/i2c/devices/i2c-9/name
i2c-5-mux (chan_id 0)
# cat /sys/bus/i2c/devices/i2c-13/name
i2c-5-mux (chan_id 0)

which only reveals i2c-9 is the bus segment connected to channel 0 of a 
mux behind i2c-5, but since there's two of them, I have no way to tell 
which one...

So I guess the easiest thing to do would be to add this information 
within the .name attribute, though I fear this may somehow turn out not 
as trivial at it looks.

What I'd like most though would be to get some hierarchy as follows:

devices/platform/i2c-gpio/i2c-0/0-0070/i2c-5/5-0071/i2c-9
devices/platform/i2c-gpio/i2c-0/0-0070/i2c-5/5-0071/i2c-10
devices/platform/i2c-gpio/i2c-0/0-0070/i2c-5/5-0071/i2c-11
devices/platform/i2c-gpio/i2c-0/0-0070/i2c-5/5-0071/i2c-12

or even something like:

devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-0(=>...i2c-9)
devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-1(=>...i2c-10)
devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-2(=>...i2c-11)
devices/platform/i2c-gpio/i2c-0/0-0070/chan-4(=>...i2c-5)/5-0071/chan-3(=>...i2c-12)

Would the above seem reasonable?

Thanks!
Gerlando
