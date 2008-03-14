From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C driver for IMX
Date: Fri, 14 Mar 2008 12:13:46 +0200
Message-ID: <frdj89$pmd$1@ger.gmane.org>
References: <frbjjv$ndk$1@ger.gmane.org>
	<c166aa9f0803140300n75f6790enee3f28bdebeba945@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <c166aa9f0803140300n75f6790enee3f28bdebeba945-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Andrew Dyer wrote:
> Thu, Mar 13, 2008 at 11:07 AM, Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
>> Almost written from scratch - only small piece of code leaved from old
>>  driver, witch never was originally in vanilla kernel.
>>  SMB is NOT supported currently.
>>  Tested on the MXLADS v2.0 board with i2c client driver (driver for
>>  NT7651 LCD controller). All works fine, stable.
> 
> needs a signed-off-by line and --- separator
> 

thank you. I'll correct all errors. About clock setup at init time - 
I'll review this part in near future, because no time for this now.
I can remove this part from patch (set default clock 100khz) or leave 
all as is. What is better?


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
