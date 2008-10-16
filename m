From: Jordan Crouse <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Thu, 16 Oct 2008 15:25:37 -0600
Message-ID: <20081016212537.GB21476@cosmic.amd.com>
References: <48F2A270.8060307@leipzig.freifunk.net>
	<20081013092548.3d58a320@hyperion.delvare>
	<gd3fe5$11e$1@ger.gmane.org>
	<20081015101736.34e1c11e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081015101736.34e1c11e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 15/10/08 10:17 +0200, Jean Delvare wrote:
> Hi Andreas,
> 
> On Wed, 15 Oct 2008 03:01:56 +0200, Andreas Seidler wrote:
> > Jean Delvare schrieb:
> > > Hi Andreas,
> > > 
> > > On Mon, 13 Oct 2008 03:20:48 +0200, Andreas Seidler wrote:
> > >> I want to connect a MAX1236 (ADC) [1] to a I2C/SMBus in a
> > >> PC-Engines/ALIX board to monitor some voltages.
> > >> This board have a AMD geode CPU with an an I2C companion (scx200_acb.c).
> > >>
> > >>[...]
> > >> but i cant access the MAX1236 on slave address 0x34.
> > >> (0x4c is the onbard LM90)
> > > 
> > > Maybe it's not wired properly?
> > 
> > I can access this ADC wired to a i2c-ibm_iic (build-in IBM PPC_P405)
> 
> That's not the question. Maybe the chip was wired properly on that
> system and not on the CS5563 system.
> 
> You can also try i2cdetect -r and see if it makes a difference.
> 
> > > If it is wired properly, then another possibility is that the MAX1236
> > > is doing clock stretching beyond what the CS5536 supports...

Its possible, but that would be a first - I haven't yet seen a 
well behaving chip that the 5536 can't understand.

> > and this is my second problem: i cant read the A/D-converted values from
> > userspace (eg. with i2cget) without spezial code or kernel module?
> 
> I'm not sure if i2cget can work with this device. The transactions used
> by the MAX1236 are raw reads and writes which aren't too
> SMBus-friendly, but it you don't care too much about performance,
> i2cget may still work depending on how you read the datasheet. I
> suggest that you give it a try on the IBM PPC system where you know the
> chip is properly wired.
> 
> i2cget 0 0x34 0x81 w
> 
> should give you the raw value of the 1st ADC channel. You'll have to
> byte-swap it because SMBus specifies that words go on the wire LSB
> first.
> 
> i2cget 0 0x34 0x83 w
> 
> should give the value of the 2nd ADC channel, and so on. Check the
> datasheet for details on the configuration byte format.
> 
> > >> Does "I2C no" means the CS5536 is a plain smbus without i2c support?
> > > 
> > > Yes and no. It means that the scx200_acb driver runs the CS5536 in
> > > SMBus mode without plain I2C support. But there is also the scx200_i2c
> > > driver (which I would love to see go away in favor of i2c-gpio but
> > > that's another story) which can use the same pins as GPIO to do plain
> > > I2C. 

> > Thank you for this info!
> > Know i found "the story" in this thread too (http://lkml.org/lkml/2007/4/14/59)
> > with more infos.
> > 
> > now i tested scx200_i2c:
> > root@OpenWrt:/# insmod scx200_gpio
> > scx200_gpio: no SCx200 gpio present
> > root@OpenWrt:/# insmod scx200_i2c
> > scx200_i2c: no SCx200 gpio pins available
> > 
> > (i hope thats no problem of the openwrt-distro...)
> 
> Hmm, I think I incorrectly assumed that scx200_i2c supported the same
> devices as scx200_acb, but probably the former only supports the SCx200
> CPUs and not the CS553x companion chips, sorry.

I think thats right.

> > are SCx200 GPIO pins supported by i2c_gpio?
> > (http://lkml.org/lkml/2007/4/19/22)
> >
> > should it work with my Geode/LX800 companion?
> 
> Last time I checked the answer was no, I don't know if things have
> changed since then.

No - I don't think this will work.  Not because it can't, but because
nobody has made the code changes.  Access to the GPIO pins is trivial,
so typically one would be able to make this go pretty quickly.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
