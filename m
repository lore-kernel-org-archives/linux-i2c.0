From: Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: I2C host adapter slave support
Date: Sat, 05 Jan 2008 11:41:06 -0600
Message-ID: <477FC132.9070906@gmail.com>
References: <200801051713.m05HDElg011590@dbdp31.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801051713.m05HDElg011590-5Y3xciNRgV4YBkLn7j66hwC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Chandra shekhar <x0044955-l0cyMroinI0@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Chandra shekhar wrote:
>  
>   
>> one thread of interest is:
>> http://lists.lm-sensors.org/pipermail/i2c/2007-April/001027.html
>>     
>
> This is more related to opearting speed for i2c devices sitting on a common bus.
>
>   
True, there is a side discussion on slave support
> Precisely,  this is my question. If we were to support slave mode there should be
> Some callback or hooks to trigger upper layer app. after receive operations, which 
> Ideally should be part of i2c-core I think. 
> I am yet to look at i2c-pxa code.
You have not been reading too detailed in to the thread and not looked 
at the code:
"http://lists.lm-sensors.org/pipermail/i2c/2007-April/001049.html:
:) this driver is compile time slave/master. Now, I have an i2c 
controller which is capable of master /slave - ofcourse only one at a 
time for one controller instance. But, I have n instances of the same. 
Each capable of being slave or master based on board. The framework wont 
let me do it unless I create two drivers - one for slave and other for 
master - define separate adapters for them.. Not exactly efficient, but 
could work. Can we do this with a cleaner support from i2c-core(like 
able to write a single adapter driver which can be used as both 
slave/master based ofcourse on board defns)? Maybe a seperate thread of 
discussion?
"
So I guess this is that thread of discussion.

Gist:
a) you can implement i2c slave adapter support today with the existing 
framework
b) my conjecture at the time of discussion was that "to have the same 
driver to handle master and slave in a build might need further changes"

Regards,
Nishanth Menon


Regards,
Nishanth Menon
