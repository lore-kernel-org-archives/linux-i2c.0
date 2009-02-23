From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Finding 'orphaned' i2c drivers
Date: Mon, 23 Feb 2009 10:16:01 -0500
Message-ID: <9e4733910902230716t39994927i454bceb641c650ed@mail.gmail.com>
References: <20090223110052.GE15722@buzzloop.caiaq.de>
	 <9e4733910902230638w262cd027pba4b65509e2e8a41@mail.gmail.com>
	 <20090223144300.GA18378@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090223144300.GA18378-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 23, 2009 at 9:43 AM, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> Hi,
>
> On Mon, Feb 23, 2009 at 09:38:45AM -0500, Jon Smirl wrote:
>> On Mon, Feb 23, 2009 at 6:00 AM, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
>> > what's the suggested way of implementing an i2c drver which does not
>> > have any other interfaces to the outside world than just the i2c device
>> > it is communicating with? More specifically, I implemented a driver for a
>> > Maxim clock generator and would like to use a proprietary interface with
>> > it from a alsa-soc module. I just can't find a sane way to access the
>> > driver's instance from there. It does exist somewhere in the linux
>> > device tree, but is there a simple function that iterates over it and
>> > returns it to me by name? Reading include/linux/device.h didn't point me
>> > to anything that could fit.
>>
>> The max9485? Which codec are you using it with? I tried submitting the
>> attached driver for the chip but Jean said it was too simple of a
>> driver.
>
> Yes, it's the same one.
>
>> I use it like this:
>>
>> static int dspeak01_fabric_hw_params(struct snd_pcm_substream
>> *substream, struct snd_pcm_hw_params *params)
>> {
>>       uint rate, select;
>>       int ret;
>>       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>     struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
>>
>>       printk("dspeak01_fabric_hw_params\n");
>>
>>       switch (params_rate(params)) {
>>       case 11025:
>>       case 22050:
>>       case 44100:
>>       case 88200:
>>       case 176400:
>>               rate = 22579200;
>>               select = MAX9485_225792;
>>               break;
>>       default:
>>               rate = 24576000;
>>               select = MAX9485_245760;
>>               break;
>>       }
>>       max9485_set(fabric.clock, select | MAX9485_CLK_OUT_2);
>
> I still don't see where you got the pointer from you are using here, and
> that's my whole question.

I'm on PowerPC, we have device tree.

		i2c@3d00 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
			cell-index = <0>;
			reg = <0x3d00 0x40>;
			interrupts = <0x2 0xf 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			fsl5200-clocking;

			tas0:codec@1b {
				compatible = "ti,tas5504";
				reg = <0x1b>;
			};
			clock0:clock@68 {
				compatible = "maxim,max9485";
				reg = <0x68>;
			};
		};

		fabric { /* audio fabric hardware */
			compatible = "dspeak01-fabric";
			clock-handle = <&clock0>;
		};


>
> Your driver looks very much like the one I wrote, though ;)
>
> Daniel
>
>



-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
