From: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming - solved
Date: Thu, 12 Mar 2015 11:49:48 -0700
Message-ID: <5501DFCC.6010408@rafresearch.com>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com> <1426136151.37151.YahooMailNeo@web181506.mail.ne1.yahoo.com> <20150312094423.GB4225@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312094423.GB4225@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 3/12/2015 2:44 AM, Wolfram Sang wrote:
> On Wed, Mar 11, 2015 at 09:55:51PM -0700, Bob Feretich wrote:
>
>> I tried some random things and setting aliases in the dtsi file solved
>> the problem.
>
> Good.
>
>> The use of an alias to set the name of an i2c bus should
>> be documented somewhere!
>
> Well, send a patch adding some documentation where you would have liked
> to see it.
>
> Thanks,
>
>     Wolfram
>
The first two places I looked for information were:
* 
https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-mux.txt 

   This is where I found the info on specifying the multiplexer without
   aliases. It would seem logical to add the description of "how to
   explicitly name child buses" here.
* https://www.kernel.org/doc/Documentation/i2c/muxes/i2c-mux-gpio
   Even though this file is for gpio controlled multiplexers, it seemed
   like a good spot to look for information on how to specify i2c
   multiplexers in general. It only describes the board.c method of
   registering adapters. (I don't know which  gpio_i2cmux_platform_data
   fields would be the equivalent of specifying the device tree aliases.)
   Perhaps a cross-reference to the above documentation is appropriate,
   since use of customized board.c files is being discouraged.

Note that once device trees become dynamic and support hot plugging, the
alias bus naming solution becomes ineffective, unless there is a way to 
specify a hierarchical alias that references the bus/adapter id of the 
multiplexer.

Thanks,
Bob
