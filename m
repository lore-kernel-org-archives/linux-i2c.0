From: Gary Thomas <gary-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org>
Subject: Re: OF support for tsc2007
Date: Fri, 01 May 2009 09:49:00 -0600
Message-ID: <49FB19EC.20002@mlbassoc.com>
References: <49FB0FAE.3080609@mlbassoc.com> <9e4733910905010843u13c03eb5q9daef91842c1f08a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e4733910905010843u13c03eb5q9daef91842c1f08a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jon Smirl wrote:
> On Fri, May 1, 2009 at 11:05 AM, Gary Thomas <gary-kIKI1E8EpGZWk0Htik3J/w@public.gmane.org> wrote:
>> I'm trying to use the TSC2007 (actually TSC2003) on a PowerPC
>> based platform.  Sadly, the current driver (as of .30-rc4)
>> does not seem to be OF aware.
>>
>> Jon Smirl on the PPC list suggested I ask here.
> 
> I thought you said it was an old-style driver that hadn't been
> converted to new style?
> 
> i2c drivers don't need to be OF aware.  The code in
> drivers/of/of_i2c.c set things up for you.
> You need a driver tree entry like this:
> 
> 		i2c@3d40 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> 			cell-index = <1>;
> 			reg = <0x3d40 0x40>;
> 			interrupts = <0x2 0x10 0x0>;
> 			interrupt-parent = <&mpc5200_pic>;
> 			fsl5200-clocking;
> 
> 			rtc@51 {
> 				device_type = "rtc";
> 				compatible = "epson,rtc8564";
> 				reg = <0x51>;
> 			};
> 			eeprom@52 {
> 				compatible = "atmel,24c32", "eeprom";
> 				reg = <0x52>;
> 			};
> 		};
> 
> 
> 
> 
>> Any help or ideas?
>>
>> n.b. at the moment, I'm not subscribed to this list, so please
>> CC me on any replies.

My question remains; how do I provide the platform_data this
driver wants on an OF based platform?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
